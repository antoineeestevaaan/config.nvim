const CACHE = "~/.local/share/nvim/cache/" | path expand
const DEP_FILE = "deps.nuon"

def check-dep-file [dependencies: any] {
    let t = $dependencies | describe --detailed
    if $t.type != "record" {
        print --stderr $"in ($DEP_FILE): expected $. to be a record, got '($t.type)'"
        exit 1
    }
    $t.columns | items { |k, v|
        if $v.type != "record" {
            print --stderr $"in ($DEP_FILE): expected $.($k) to be a record, got '($v.type)'"
            exit 1
        }

        const TYPES = [
            [name,     type,                         required];
            [enabled,  bool,                         false   ],
            [version,  string,                       true    ],
            [upstream, string,                       true    ],
            [tarball,  string,                       false   ],
            [files,    {type: list, values: [string]}, true    ],
        ]

        for t in $TYPES {
            let type = $v.columns | get --ignore-errors $t.name
            if $type == null {
                if $t.required {
                    print --stderr $"in ($DEP_FILE): $.($k).($t.name) is required but missing"
                    exit 1
                } else {
                    continue
                }
            }

            if $t.type in ["bool", "string"] {
                if $type != $t.type {
                    print --stderr $"in ($DEP_FILE): expected $.($k).($t.name) to be a ($t.type), got '($type)'"
                    exit 1
                }
            } else {
                if $type.length == 0 {
                    print --stderr $"in ($DEP_FILE): expected $.($k).($t.name) to be a non empty list, got '[]'"
                    exit 1
                }
                let type = $type | update values { uniq } | reject length
                if $type != $t.type {
                    print --stderr $"in ($DEP_FILE): expected $.($k).($t.name) to be a ($t.type), got '($type)'"
                    exit 1
                }

            }
        }
    }
}

# deps.nuon: a NUON record where
#   - k: string
#   - v: record<enabled: bool, version: string, upstream: string, tarball?: string, files: list<string>>
def main [] {
    let dependencies = open $DEP_FILE

    check-dep-file $dependencies

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
