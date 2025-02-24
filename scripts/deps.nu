const CACHE = "~/.local/share/nvim/cache/" | path expand

def main [] {
    let dependencies = open deps.nuon

    mkdir $CACHE

    for k in ($dependencies | columns) {
        print $k

        let v = $dependencies | get $k
        if not ($v.enabled? | default true) {
            continue
        }

        let url = $v.upstream | str replace --all '{{VERSION}}' $v.version
        let tmp = mktemp --tmpdir $"nvim-($k).XXXXXXX"
        http get $url | save --force --progress $tmp

        let dest = $CACHE | path join $k
        mkdir $dest
        tar xvf $tmp --directory $dest

        let tarball = $v.tarball? | default "" | str replace --all '{{VERSION}}' $v.version

        for f in $v.files {
            let src = $dest | path join $tarball $f
            let dest = $nu.home-path | path join ".local" "bin" ($f | path basename)
            ln --force --symbolic $src $dest
        }
    }
}
