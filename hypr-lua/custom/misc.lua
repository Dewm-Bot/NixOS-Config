hl.on("hyprland.start", function ()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE")
end)

hl.config({
    cursor = {
        no_hardware_cursors = 1,
    }
});
