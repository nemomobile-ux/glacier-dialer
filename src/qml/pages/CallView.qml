/*
 * Copyright 2014 Aleksi Suomalainen <suomalainen.aleksi@gmail.com>
 * Copyright 2018-2021 Chupligin Sergey <neochapay@gmail.com>
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

import org.nemomobile.contacts 1.0
import org.nemomobile.commhistory 1.0

Page {
    id: call
    headerTools: HeaderToolsLayout {
        id: tools
        title: call.state == "incoming" ? qsTr("Incoming call") : qsTr("Call")
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

    Column {
        width: parent.width
        height: parent.heigh - buttonRow.height

        spacing: 30

        Text {
            id:tLineId
            width: parent.width;
            height: Theme.itemHeightLarge

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            font.pointSize: Theme.fontSizeLarge
            color: Theme.textColor

            text: main.activeVoiceCallPerson
                  ? main.activeVoiceCallPerson.displayLabel
                  : (telephone.activeVoiceCall ? telephone.activeVoiceCall.lineId : '');
        }


        Image {
            id: avatar
            anchors.horizontalCenter: parent.horizontalCenter
            source: main.activeVoiceCallPerson
                    ? main.activeVoiceCallPerson.avatarPath
                    : 'image://theme/user';
        }


        Text {
            id:tVoiceCallDuration
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: Theme.fontSizeMedium
            color: Theme.textColor
            visible: call.state == "active"
            text: telephone.activeVoiceCall ? main.secondsToTimeString(telephone.activeVoiceCall.duration) : '00:00:00'
        }
    }

    Item {
        id: buttonRow
        width: parent.width
        height: Theme.itemHeightHuge

        anchors{
            bottom: parent.bottom
        }

        Button {
            id: answerButton
            width: visible ? buttonRow.width/2-Theme.itemSpacingHuge*2 : 0
            text: qsTr("Answer")
            onClicked: if (telephone.activeVoiceCall) telephone.activeVoiceCall.answer()
            visible: call.state == "incoming"

            anchors{
                right: parent.horizontalCenter
                rightMargin: Theme.itemSpacingHuge
            }
        }

        Button {
            id: hangUpButton
            width: answerButton.visible ? buttonRow.width/2-Theme.itemSpacingHuge*2 : buttonRow.width-Theme.itemSpacingHuge*2
            text: qsTr("Hang up")

            anchors{
                left: answerButton.visible ? parent.horizontalCenter : undefined
                leftMargin: answerButton.visible ? Theme.itemSpacingHuge : undefined
                horizontalCenter: answerButton.visible ? undefined : parent.horizontalCenter
            }

            onClicked: {
                if(telephone.activeVoiceCall) {
                    telephone.activeVoiceCall.hangup();
                }
            }
        }
    }
}

