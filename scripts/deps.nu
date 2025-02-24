const LUA_VERSION = "3.13.5"
const LUA_LANGUAGE_SERVER_ARCHIVE = $"lua-language-server-($LUA_VERSION)-linux-x64.tar.gz"
const LUA_LANGUAGE_SERVER = $"https://github.com/LuaLS/lua-language-server/releases/download/($LUA_VERSION)/($LUA_LANGUAGE_SERVER_ARCHIVE)"

const TINYMIST_REMOTE = "https://github.com/Myriad-Dreamin/tinymist"
const TINYMIST_VERSION = "v0.12.18"

def main [lua_dest: path] {
    const UPSTREAM = "https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0"
    const ARCHIVE = "clang+llvm-11.0.0-x86_64-linux-gnu-ubuntu-20.04"

    http get $"($UPSTREAM)/($ARCHIVE).tar.xz" | save --force --progress $"/tmp/($ARCHIVE).tar.xz"
    tar xvf $"/tmp/($ARCHIVE).tar.xz" --directory /tmp
    mkdir ~/.local/bin
    cp $"/tmp/($ARCHIVE)/bin/clangd" ~/.local/bin/clangd
    cp $"/tmp/($ARCHIVE)/bin/clang-format" ~/.local/bin/clang-format

    let dest = $lua_dest | path expand
    let temp = mktemp --tmpdir lua-language-server.XXXXXXX
    http get $LUA_LANGUAGE_SERVER | save --force --progress $temp
    mkdir $dest
    tar xvf $temp --directory $dest

    cargo install ...[
        --git $TINYMIST_REMOTE
        --locked tinymist
        --tag $TINYMIST_VERSION
    ]
}
