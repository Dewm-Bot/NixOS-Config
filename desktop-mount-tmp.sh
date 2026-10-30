[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"
mkdir -p /run/media/LoopSpinner/Nix-Build/fake-tmp
chmod 1777 /run/media/LoopSpinner/Nix-Build/fake-tmp
if ! findmnt -M /tmp | grep -q "LoopSpinner"; then
    mount --bind /run/media/LoopSpinner/Nix-Build/fake-tmp /tmp
fi
systemctl daemon-reload
systemctl restart nix-daemon

