import QtQuick
import QtQuick.Controls

import Nemo
import Nemo.Controls


NemoIcon {
    signal clicked()

    color: mouse.pressed ? Theme.accentColor : Theme.textColor

    MouseArea {
        id: mouse

        anchors.fill: parent
        onClicked: {
            parent.clicked();
        }
    }

}
