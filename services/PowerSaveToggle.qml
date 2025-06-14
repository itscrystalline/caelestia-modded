pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property bool on: false

    Process {
        id: setOn
        command: ["sh", "-c", "hyprctl --batch 'keyword decoration:blur:enabled false; keyword decoration:shadow:enabled false; keyword monitor eDP-1, 1920x1080@60, 0x0, 1;'; brightnessctl set 70% -q"]
    }
    Process {
        id: setOff
        command: ["sh", "-c", "hyprctl --batch 'keyword decoration:blur:enabled true; keyword decoration:shadow:enabled true; keyword monitor eDP-1, 1920x1080@144, 0x0, 1;'; brightnessctl set 100% -q"]
    }

    onOnChanged: {
        if (on) {
            setOn.running = true;
        } else {
            setOff.running = true;
        }
    }
}
