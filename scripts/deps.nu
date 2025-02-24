const DEPENDENCIES = {
    lua: {
        version: "3.13.5",
        upstream: "https://github.com/LuaLS/lua-language-server/releases/download/{{VERSION}}/lua-language-server-{{VERSION}}-linux-x64.tar.gz",
        type: "get",
        files: [ "bin/lua-language-server" ],
    },
    tinymist: {
        version: "v0.12.18",
        upstream: "https://github.com/Myriad-Dreamin/tinymist",
        type: "cargo",
    },
    clang: {
        version: "11.0.0",
        upstream: "https://github.com/llvm/llvm-project/releases/download/llvmorg-{{VERSION}}/clang+llvm-{{VERSION}}-x86_64-linux-gnu-ubuntu-20.04",
        type: "get",
        files: [ "bin/clangd", "bin/clang-format" ],
    }
}

def main [] {
    const CACHE = "~/.local/share/nvim/cache/" | path expand

    mkdir $CACHE

    let _ = $DEPENDENCIES | items { |k, v|
        print $k
        match $v.type {
            "cargo" => {
                cargo install --root $CACHE --git $v.upstream --locked $k --tag $v.version
            },
            "get" => {
                let url = $v.upstream | str replace --all '{{VERSION}}' $v.version
                let tmp = mktemp --tmpdir $"nvim-($k).XXXXXXX"
                http get $url | save --force --progress $tmp

                let dest = $CACHE | path join $k
                mkdir $dest
                tar xvf $tmp --directory $dest

                for f in $v.files {
                    let src = $CACHE | path join $k $f
                    let dest = $"~/.local/bin/($f | path basename)" | path expand
                    ln --symbolic $src $dest
                }
            },
            _ => { error make --unspanned {
                msg: $"unknown dependency type (ansi red_bold)'($v.type)'(ansi reset)"
            } },
        }
    }
}
