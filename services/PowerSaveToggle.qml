pragma Singleton

import "root:/services"
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property bool on: false

    property real brightnessPercentOn: 0.70
    property real brightnessPercentOff: 1.00

    Process {
        id: setOn
        command: ["sh", "-c", "hyprctl --batch 'keyword decoration:blur:enabled false; keyword decoration:shadow:enabled false; keyword monitor eDP-1, 1920x1080@60, 0x0, 1;'"]
    }
    Process {
        id: setOff
        command: ["sh", "-c", "hyprctl --batch 'keyword decoration:blur:enabled true; keyword decoration:shadow:enabled true; keyword monitor eDP-1, 1920x1080@144, 0x0, 1;'"]
    }

    function setBrightness(perc: real): void {
        if (on) {
            brightnessPercentOn = perc;
        } else {
            brightnessPercentOff = perc;
        }
    }

    onOnChanged: {
        const mon = Brightness.getMonitorForScreenName("eDP-1");
        if (on) {
            setOn.running = true;
            mon.setBrightness(brightnessPercentOn);
        } else {
            setOff.running = true;
            mon.setBrightness(brightnessPercentOff);
        }
    }
}
