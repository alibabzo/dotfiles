function v
    set -lx NVIM_LISTEN_ADDRESS (mktemp -u "/tmp/nvimsocket-XXXXXXX")
    nvim $argv
end
