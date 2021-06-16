/*
 * Copyright 2014 Aleksi Suomalainen <suomalainen.aleksi@gmail.com>
 * Copyright 2018 Chupligin Sergey <neochapay@gmail.com>
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public License
 * along with this library; see the file COPYING.LIB.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
*/
import QtQuick 2.6
import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0
import QtQuick.Layouts 1.0
import org.nemomobile.contacts 1.0
import org.nemomobile.commhistory 1.0

Page {
    id: call
    headerTools: HeaderToolsLayout {
        id: tools
        title: qsTr("Call")
    }
    state: telephone.activeVoiceCall ? telephone.activeVoiceCall.statusText : 'disconnected'
    states: [
        State {name:'active'},
        State {name:'held'},
        State {name:'dialing'},
        State {name:'alerting'},
        State {name:'incoming'},
        State {name:'waiting'},
        State {name:'disconnected'}
    ]
    ColumnLayout {
        anchors.fill: parent
        spacing: 30
        Image {
            id: avatar
            anchors.horizontalCenter: parent.horizontalCenter
            source: main.activeVoiceCallPerson
                    ? main.activeVoiceCallPerson.avatarPath
                    : 'image://theme/user';
            Layout.fillWidth: false
            Layout.fillHeight: false
            Layout.preferredHeight: 280
            Layout.preferredWidth: 280
        }
        Text {
            id:tLineId
            width:parent.width; height:paintedHeight
            horizontalAlignment: Text.Center
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: Theme.fontWeightLarge
            color: Theme.textColor

            text: main.activeVoiceCallPerson
                 ? main.activeVoiceCallPerson.displayLabel
                 : (telephone.activeVoiceCall ? telephone.activeVoiceCall.lineId : '');

            onTextChanged: resizeText();

            Component.onCompleted: resizeText();

            function resizeText() {
                if(paintedWidth < 0 || paintedHeight < 0) return;
                while(paintedWidth > width)
                    if(--font.pixelSize <= 0) break;

                while(paintedWidth < width)
                    if(++font.pixelSize >= 38) break;
            }
        }
        Text {
            id:tVoiceCallDuration
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: Theme.fontWeightLarge
            color: "white"
            visible: call.state == "active"
            text: telephone.activeVoiceCall ? main.secondsToTimeString(telephone.activeVoiceCall.duration) : '00:00:00'
        }
        RowLayout {
            spacing: Theme.itemSpacingHuge
            anchors.horizontalCenter: parent.horizontalCenter
            Button {
                text: qsTr("Answer")
                Layout.fillWidth: true
                Layout.fillHeight: false
                onClicked: if (telephone.activeVoiceCall) telephone.activeVoiceCall.answer()
                visible: call.state == "incoming"
            }
            Button {
                text: qsTr("Hang up")
                Layout.fillWidth: true
                Layout.fillHeight: false
                onClicked: {
                    if(telephone.activeVoiceCall) {
                        telephone.activeVoiceCall.hangup();
                    }
                }
            }
        }
    }
}
