/*
 * Copyright 2014 Aleksi Suomalainen <suomalainen.aleksi@gmail.com>
 * Copyright 2018-2023 Chupligin Sergey <neochapay@gmail.com>
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
import QtQuick
import QtQuick.Controls

import Nemo
import Nemo.Controls

import org.nemomobile.contacts 1.0
import org.nemomobile.commhistory 1.0

import "../components"

Page {
    id: call
    headerTools: HeaderToolsLayout {
        id: tools
        title: call.state === "incoming" ? qsTr("Incoming call") : qsTr("Call")
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

    property var telephone
    property string lineId: (telephone && telephone.activeVoiceCall) ? telephone.activeVoiceCall.lineId : ""
    onLineIdChanged: {
        main.activeVoiceCallPerson = peopleModel.personByPhoneNumber(lineId, true);
    }

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
            asynchronous: true
            fillMode: Image.PreserveAspectCrop
            width: (avatar.implicitWidth < Theme.itemWidthMedium) ? avatar.implicitWidth : Theme.itemWidthMedium
            height: width
            horizontalAlignment: Image.AlignHCenter
            verticalAlignment: Image.AlignVCenter

            sourceSize.width: 1024
            sourceSize.height: 1024

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
            text: telephone.activeVoiceCall ? main.secondsToTimeString(telephone.activeVoiceCall.duration/1000) : '00:00:00'
        }

        Rectangle {
            // add some space
            width: parent.width
            color: "transparent"
            height:  Theme.itemHeightLarge
        }

        Row {
            anchors.left: parent.left;
            anchors.right: parent.right;
            anchors.margins:  Theme.itemSpacingLarge
            spacing: Theme.itemSpacingMedium
            leftPadding: (width - (3 * Theme.itemHeightMedium ) - 2* spacing) / 2

            NemoIconButton {
                source: telephone.isSpeakerMuted ? "image://theme/volume-mute" : "image://theme/volume-up"
                width: Theme.itemHeightMedium
                height: width
                onClicked: {
                    telephone.isSpeakerMuted = !telephone.isSpeakerMuted;
                }
            }
            NemoIconButton {
                source: telephone.isMicrophoneMuted ? "image://theme/microphone-alt-slash" : "image://theme/microphone-alt"
                width: Theme.itemHeightMedium
                height: width
                onClicked: {
                    telephone.isMicrophoneMuted = !telephone.isMicrophoneMuted;
                }

            }
            NemoIconButton {
                source: "image://theme/keyboard"
                width: Theme.itemHeightMedium
                height: width
                onClicked: {
                    console.log("TODO")
                }
            }

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

