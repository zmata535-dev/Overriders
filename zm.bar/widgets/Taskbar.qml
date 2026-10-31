import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "zm.taskbar"

  property string home: Quickshell.env("HOME")
  property var configData: ({
    position: "bottom",
    showIcon: true,
    showCircle: false,
    showLabel: true,
    autohide: true,
    maxWidth: 180
  })

  FileView {
    path: root.home + "/.config/omarchy/taskbar.json"
    watchChanges: true
    printErrors: false
    onFileChanged: loadConfig()
    Component.onCompleted: loadConfig()
    function loadConfig() {
      try {
        var parsed = JSON.parse(text())
        if (parsed) root.configData = parsed
      } catch (e) {}
    }
  }

  property var clientList: []

  Process {
    id: clientsProc
    running: true
    command: ["hyprctl", "-j", "clients"]
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: {
        try {
          var arr = JSON.parse(text)
          if (Array.isArray(arr)) {
            arr.sort(function(a, b) {
              if (a.workspace.id !== b.workspace.id) {
                return a.workspace.id - b.workspace.id
              }
              return a.at[0] - b.at[0]
            })
            root.clientList = arr
          }
        } catch (e) {}
      }
    }
  }

  Timer {
    interval: 600
    running: true
    repeat: true
    onTriggered: clientsProc.running = true
  }

  readonly property int activeWsId: Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id : 1
  readonly property var workspaceClients: {
    var list = []
    for (var i = 0; i < clientList.length; i++) {
      var c = clientList[i]
      if (c.workspace && c.workspace.id === activeWsId) {
        list.push(c)
      }
    }
    return list
  }

  implicitWidth: rowLayout.implicitWidth
  implicitHeight: barSize

  RowLayout {
    id: rowLayout
    anchors.fill: parent
    spacing: 4

    Repeater {
      model: root.workspaceClients

      WidgetButton {
        required property var modelData

        readonly property var client: modelData
        readonly property bool focused: client.class === Hyprland.focusedClient?.class

        bar: root.bar
        fixedHeight: root.barSize
        horizontalMargin: 8
        verticalPadding: 4

        contentItem: RowLayout {
          spacing: 6

          Rectangle {
            visible: root.configData.showCircle === true
            width: 6
            height: 6
            radius: 3
            color: focused ? Color.accent : Color.bar.text
            opacity: focused ? 1.0 : 0.5
          }

          Text {
            visible: root.configData.showLabel === true
            text: client.title || client.class || "App"
            color: root.bar ? root.bar.barForeground : Color.foreground
            font.family: root.bar ? root.bar.fontFamily : Style.font.family
            font.pixelSize: Style.font.body
            elide: Text.ElideRight
            Layout.maximumWidth: Number(root.configData.maxWidth || 180)
            opacity: focused ? 1.0 : 0.7
          }
        }

        onPressed: function(button) {
          if (button === Qt.MiddleButton) {
            root.bar.run("hyprctl dispatch closewindow address:" + client.address)
          } else {
            root.bar.run("hyprctl dispatch focuswindow address:" + client.address)
          }
        }
      }
    }
  }
}
