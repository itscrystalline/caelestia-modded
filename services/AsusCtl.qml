pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property string profile
    property list<string> profiles: []

    Process {
        command: ["sh", "-c", "asusctl profile --list | jq -nRc '[inputs][1:4]'"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                root.profiles = JSON.parse(data);
            }
        }
    }

    Process {
        id: currentProfile
        command: ["sh", "-c", "asusctl profile -p | jq -nRc '[inputs][1]' | awk '{split($0, array, \" \"); print substr(array[4], 0, length(array[4]) - 1)}'"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                root.profile = data;
            }
        }
    }

    Process {
        id: newProfile
        property string nextProfile
        command: ["sh", "-c", "asusctl profile -P '" + nextProfile + "'"]
    }

    onProfileChanged: {
        setProfile(root.profile);
    }

    function setProfile(prof: string): void {
        newProfile.nextProfile = prof === "LowPower" ? 'low-power' : prof;
        newProfile.running = true;
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: currentProfile.running = true
    }
}
