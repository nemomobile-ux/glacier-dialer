/*
 * Copyright 2014 Aleksi Suomalainen <suomalainen.aleksi@gmail.com>
 * Copyright (C) 2023 Chupligin Sergey <neochapay@gmail.com>
 *
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
import QOfono 0.2
import Nemo.Dialogs 1.0

import "../components"

Item {
    id: dialer
    anchors.fill: parent

    property alias dialerNumber: dialedNumber.text

    OfonoManager {
        id: ofonoManager;
    }

    OfonoSupplementaryServices {
        id: ussd
        modemPath: ofonoManager.defaultModem
        onUssdResponse: {
            console.log("response " + response )
            ussdDialog.headingText = response
            ussdDialog.open();
        }
        onNotificationReceived: {
            console.log("message" + message )
        }
        onRequestReceived: {
            console.log("message" + message )
        }

        onStateChanged: {
            console.log("supplemetary services state " + state)
        }

    }

    Dialog {
        id: ussdDialog
        acceptText: qsTr("Ok")
        inline: true
        onAccepted: {
            close()
            dialedNumber.text = ""
        }
    }


    Item {
        id: numForDialing
        height: Theme.itemHeightLarge
        width: parent.width

        TextEdit {
            id: dialedNumber
            width: dialer.width-dialedNumber.height
            height: Theme.itemHeightLarge
            font.pixelSize: numForDialing.height*0.85
            color: Theme.accentColor
            horizontalAlignment: TextEdit.AlignRight
            onTextChanged: {
                if ((text.length > 2) && (text[text.length-1] === "#")) {
                    console.log("ussd.initiate("+text+")")
                    ussd.initiate(text)
                }
            }
        }

        NemoIcon {
            width: dialedNumber.height
            height: width
            source: "image://theme/angle-right"
            color: dialedNumberBackspaceMouse.pressed ? Theme.accentColor : Theme.textColor

            anchors{
                left: dialedNumber.right
                verticalCenter: dialedNumber.verticalCenter
            }

            MouseArea{
                id: dialedNumberBackspaceMouse
                anchors.fill: parent
                onClicked: {
                    dialedNumber.text = dialedNumber.text.substring(0, dialedNumber.text.length - 1)
                }
                onPressAndHold: {
                    dialedNumber.text = "";
                }
            }
        }
    }

    Grid {
        id: dialerButtons
        width: parent.width
        height: Theme.itemHeightExtraLarge*4 + Theme.itemSpacingLarge*3
        anchors {
            bottom: dimmer.top
            bottomMargin: Theme.itemSpacingLarge
        }
        spacing: Theme.itemSpacingLarge

        columns: 3
        rows: 4

        ListModel {
            id: buttonsModel
            ListElement { number: "1"; letters: ""; }
            ListElement { number: "2"; letters: "ABC"; }
            ListElement { number: "3"; letters: "DEF"; }
            ListElement { number: "4"; letters: "GHI"; }
            ListElement { number: "5"; letters: "JKL"; }
            ListElement { number: "6"; letters: "MNO"; }
            ListElement { number: "7"; letters: "PQRS"; }
            ListElement { number: "8"; letters: "TUV"; }
            ListElement { number: "9"; letters: "WXYZ"; }
            ListElement { number: "*"; letters: ""; }
            ListElement { number: "0"; letters: "+"; }
            ListElement { number: "#"; letters: ""; }
        }

        Repeater {
            model: buttonsModel
            delegate: DialerButton {
                width: (dialerButtons.width - Theme.itemSpacingLarge*3) /3
                height: Theme.itemHeightExtraLarge
                text: model.number
                subText: model.letters
                onPressed: {
                    telephone.startDtmfTone(model.number);
                    dialedNumber.insert(dialedNumber.text.length,model.number)
                }
                onPressAndHold: {
                    if (model.number === "0") {
                        dialedNumber.text = dialedNumber.text.replace(/0$/,"+") // replace last 0 with +
                    }
                }
                onReleased: {
                    telephone.stopDtmfTone();
                }

            }
        }
    }

    Rectangle {
        id: dimmer

        height: Theme.itemHeightLarge+Theme.itemSpacingLarge
        width: parent.width-Theme.itemSpacingLarge*2
        color: dimmerMouse.pressed ? Theme.fillDarkColor : "transparent"
        radius: Theme.itemSpacingSmall

        anchors{
            bottom: parent.bottom
            bottomMargin: Theme.itemSpacingLarge
            left: parent.left
            leftMargin: Theme.itemSpacingLarge
        }

        NemoIcon {
            id: callIconBtn
            height: Theme.itemHeightLarge
            width: height
            source: "image://theme/phone"
            anchors.centerIn: parent
            color: Theme.accentColor
        }

        MouseArea {
            id: dimmerMouse
            anchors.fill: parent
            onClicked: {
                var normalizedNumber = Person.normalizePhoneNumber(dialedNumber.text)
                telephone.dial(telephone.defaultProviderId, normalizedNumber)
            }
        }

    }
}

