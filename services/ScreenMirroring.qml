pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property bool mirroring: false

    Process {
        id: setMirroring
        command: ["sh", "-c", "hyprctl --batch 'keyword monitor HDMI-A-1, preferred, auto, 1, mirror, eDP-1;'"]
        onRunningChanged: {
            console.log("setMirroring: " + running);
        }
        stdout: SplitParser {
            onRead: data => console.log(data)
        }
    }
    Process {
        id: setExtend
        command: ["sh", "-c", "hyprctl --batch 'keyword monitor HDMI-A-1, 1920x1080@100, 1920x0, 1, vrr, 1;workspace 11, monitor:HDMI-A-1, default:true; workspace 12, monitor:HDMI-A-1, default:true;workspace 13, monitor:HDMI-A-1, default:true;workspace 14, monitor:HDMI-A-1, default:true;workspace 15, monitor:HDMI-A-1, default:true;workspace 16, monitor:HDMI-A-1, default:true;workspace 17, monitor:HDMI-A-1, default:true;workspace 18, monitor:HDMI-A-1, default:true;workspace 19, monitor:HDMI-A-1, default:true;workspace 20, monitor:HDMI-A-1, default:true;'"]
        onRunningChanged: {
            console.log("setExtend: " + running);
        }
        stdout: SplitParser {
            onRead: data => console.log(data)
        }
    }

    onMirroringChanged: {
        console.log("mirroring: " + mirroring);
        if (mirroring) {
            setMirroring.running = true;
        } else {
            setExtend.running = true;
        }
    }
}
