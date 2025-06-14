pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property Sizes sizes: Sizes {}
    readonly property Workspaces workspaces: Workspaces {}

    component Sizes: QtObject {
        property int innerHeight: 24
        property int windowPreviewSize: 400
        property int trayMenuWidth: 300
        property int batteryWidth: 250
        property int screenMirroringWidth: 100
    }

    component Workspaces: QtObject {
        property int shown: 10
        property bool rounded: true
        property bool activeIndicator: true
        property bool occupiedBg: false
        property bool showWindows: false
        property bool activeTrail: false
        property string label: "  "
        property string occupiedLabel: "󰮯 "
        property string activeLabel: "󰮯 "
    }
}
