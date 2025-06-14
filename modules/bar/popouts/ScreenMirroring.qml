pragma ComponentBehavior: Bound

import "root:/widgets"
import "root:/services"
import "root:/config"
import QtQuick

Column {
    id: root

    spacing: Appearance.spacing.normal
    width: BarConfig.sizes.screenMirroringWidth

    StyledRect {
        id: screenMirroring

        property string current: {
            if (ScreenMirroring.mirroring) {
                return mirror.icon;
            } else {
                return extend.icon;
            }
        }

        anchors.horizontalCenter: parent.horizontalCenter

        implicitWidth: extend.implicitHeight + mirror.implicitHeight + Appearance.padding.normal * 2
        implicitHeight: Math.max(extend.implicitHeight, mirror.implicitHeight) + Appearance.padding.small * 2

        color: Colours.palette.m3surfaceContainer
        radius: Appearance.rounding.full

        StyledRect {
            id: screenMirrorIndicator

            color: Colours.palette.m3primary
            radius: Appearance.rounding.full
            state: screenMirroring.current

            states: [
                State {
                    name: extend.icon

                    Fill {
                        item: extend
                        targetRect: screenMirrorIndicator
                    }
                },
                State {
                    name: mirror.icon

                    Fill {
                        item: mirror
                        targetRect: screenMirrorIndicator
                    }
                }
            ]

            transitions: Transition {
                AnchorAnimation {
                    duration: Appearance.anim.durations.normal
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Appearance.anim.curves.emphasized
                }
            }
        }

        ToggleItem {
            id: extend

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: Appearance.padding.small

            setMirroring: false
            icon: "screenshot_monitor"
        }

        ToggleItem {
            id: mirror

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: Appearance.padding.small

            setMirroring: true
            icon: "screen_share"
        }
    }

    component Fill: AnchorChanges {
        required property Item item
        required property StyledRect targetRect

        target: targetRect
        anchors.left: item.left
        anchors.right: item.right
        anchors.top: item.top
        anchors.bottom: item.bottom
    }

    component ToggleItem: Item {
        required property string icon
        required property bool setMirroring

        implicitWidth: icon.implicitHeight + Appearance.padding.small * 2
        implicitHeight: icon.implicitHeight + Appearance.padding.small * 2

        StateLayer {
            radius: Appearance.rounding.full
            color: screenMirroring.current === parent.icon ? Colours.palette.m3onPrimary : Colours.palette.m3onSurface

            function onClicked(): void {
                ScreenMirroring.mirroring = parent.setMirroring;
            }
        }

        MaterialIcon {
            id: icon

            anchors.centerIn: parent

            text: parent.icon
            font.pointSize: Appearance.font.size.large
            color: screenMirroring.current === text ? Colours.palette.m3onPrimary : Colours.palette.m3onSurface
            fill: screenMirroring.current === text ? 1 : 0

            Behavior on fill {
                NumberAnimation {
                    duration: Appearance.anim.durations.normal
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Appearance.anim.curves.standard
                }
            }
        }
    }
}
