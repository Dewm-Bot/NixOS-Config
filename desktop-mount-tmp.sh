[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"
sudo mount --bind /run/media/LoopSpinner/Nix-Build/fake-tmp /tmp
sudo systemctl daemon-reload
sudo systemctl restart nix-daemon
