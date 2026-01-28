CAELESTIA_START_COMMAND="caelestia shell -d"
CAELESTIA_KILL_COMMAND="caelestia-shell kill"

HYPRPANEL_KILL_COMMAND="pkill $HYPRPANEL_NAME"

# Message that indicates caelestia-shell was ALREADY running
RUNNING_MESSAGE="An instance of this configuration is already running."

echo "--- Toggling Panel State ---"

#Check the output of running "caelestia shell -d" to see if it's running or not.
#We just compare what the output is to the string we have above
echo "  -> Executing check/start command: $CAELESTIA_START_COMMAND"
STATUS_OUTPUT=$($CAELESTIA_START_COMMAND 2>&1)

#Check if the output is the same (We pray they don't change this :^)
if echo "$STATUS_OUTPUT" | grep -q "$RUNNING_MESSAGE"; then

    echo "Status: caelestia-shell was running. Switching to HyprPanel."

    echo " -> Killing Caelestia violently first:"
    caelestia-shell kill

    # 2. Start hyprpanel and run it in the background
    echo " -> Starting HyprPanel"
    hyprpanel &

else
    #If it ain't running, we kill HyprPanel and run Caelestia

    echo "Status: caelestia-shell wasn't running, starting it up now."
    echo "  -> Shooting HyprPanel"

    echo "  -> Executing kill command:"
    pkill hyprpanel 2>/dev/null
fi

echo "--- Toggle complete. ---"
