# --- Configuration ---
SHADER_DIR="$HOME/.config/hypr/shaders"
STATE_DIR="$HOME/.config/hypr/scripts/states"
TARGET_CONF="$HOME/.config/hypr/current-shader.conf"
PID_FILE="$STATE_DIR/oled_loop.pid"

mkdir -p "$STATE_DIR"

# --- 1. THE "CLEAN" KILL ---
if [ -f "$PID_FILE" ]; then
    OLD_PID=$(cat "$PID_FILE")
    # Kill the entire process group leader
    kill -9 -"$OLD_PID" 2>/dev/null
    pkill -f "oled_loop_process" 2>/dev/null
    rm "$PID_FILE"
fi

# --- 2. SELECTION ---
SHADERS=$(find "$SHADER_DIR" -maxdepth 1 -name "*.frag" -printf "%f\n")
CHOICE=$(echo -e "OFF\nOLED_PROTECT\n$SHADERS" | rofi -dmenu -p "Shader Menu:" -i)

# --- 3. LOGIC ---
if [ "$CHOICE" == "OFF" ]; then
    echo "decoration:screen_shader =" > "$TARGET_CONF"
    notify-send "Shaders" "Disabled"

elif [ "$CHOICE" == "OLED_PROTECT" ]; then
    INTENSITY=$(echo -e "0.0\n0.1\n0.2\n0.3\n0.5" | rofi -dmenu -p "Off-Pixel Brightness:" -i)
    [ -z "$INTENSITY" ] && INTENSITY=0.0

    # Generate Shaders
    for p in 0 1; do
        cat <<EOF > "$STATE_DIR/oled_$p.frag"
#version 300 es
precision highp float;
in vec2 v_texcoord;
out vec4 fragColor;
uniform sampler2D tex;
void main(){
    vec4 orig = texture(tex, v_texcoord);
    float chk = mod(floor(gl_FragCoord.x) + floor(gl_FragCoord.y), 2.0);
    vec4 dimCol = vec4(orig.rgb * $INTENSITY, orig.a);
    if ($p == 0) { fragColor = (chk == 0.0) ? orig : dimCol; }
    else { fragColor = (chk == 0.0) ? dimCol : orig; }
}
EOF
    done

    # --- THE SECRET SAUCE: Named Background Process ---
    # We use 'exec -a' to name the process so pkill can definitely find it
    # We use 'setsid' to make it a group leader
    setsid bash -c "exec -a oled_loop_process bash -c '
        echo \$\$ > \"$PID_FILE\"
        while true; do
            echo \"decoration:screen_shader = $STATE_DIR/oled_0.frag\" > \"$TARGET_CONF\"
            sleep 10
            echo \"decoration:screen_shader = $STATE_DIR/oled_1.frag\" > \"$TARGET_CONF\"
            sleep 10
        done' " &

    notify-send "OLED Shield" "Active (Intensity: $INTENSITY)"

elif [ -n "$CHOICE" ]; then
    echo "decoration:screen_shader = $SHADER_DIR/$CHOICE" > "$TARGET_CONF"
    notify-send "Applied" "$CHOICE"
fi
