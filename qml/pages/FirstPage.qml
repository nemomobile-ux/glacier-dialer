/*
 * Copyright 2014 Aleksi Suomalainen <suomalainen.aleksi@gmail.com>
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

import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0
import QtQuick.Layouts 1.0
import org.nemomobile.voicecall 1.0
import MeeGo.QOfono 0.2
import org.nemomobile.contacts 1.0

Page {
    id: page
    headerTools: HeaderToolsLayout {
        id: tools
        title: "Glacier Dialer"
    }
    property string modemPath: manager.modems.length > 0 ? manager.modems[0] : ""

    OfonoModem {
        id: ofonoModem
        modemPath: modemPath
    }
    OfonoManager {
        id: manager
    }

    OfonoVoiceCallManager {
        id: telephony
        modemPath: modemPath
    }
    VoiceCallManager {
        id: telephone
    }

    ColumnLayout {
        spacing: 20
        anchors.centerIn: parent
        anchors.fill: parent

        RowLayout {
            spacing: 20
            Layout.maximumWidth: 80
            TextField {
                id: dialedNumber
            }
            Button {
                id: clearer
                text: "Clear"
                onClicked: {
                    dialedNumber.text = ""
                }
            }
        }

        GridLayout {
            columnSpacing: 20
            rowSpacing: 20
            columns: 3
            Layout.maximumWidth: 40
            DialerButton {
                text: "1"
            }
            DialerButton {
                text: "2"
            }
            DialerButton {
                text: "3"
            }
            DialerButton {
                text: "4"
            }
            DialerButton {
                text: "5"
            }
            DialerButton {
                text: "6"
            }
            DialerButton {
                text: "7"
            }
            DialerButton {
                text: "8"
            }
            DialerButton {
                text: "9"
            }
            DialerButton {
                text: "+"
            }
            DialerButton {
                text: "0"
            }
            DialerButton {
                text: "#"
            }
        }
        RowLayout {
            spacing: 20
            Layout.maximumWidth: 80
            Button {
                text: "Call"
                onClicked: {
                    console.log("Providers: " + telephone.providers)
                    console.log("Modems: " + manager.modems[0])
                    var normalizedNumber = Person.normalizePhoneNumber(dialedNumber.text)
                    console.log("Calling: " + normalizedNumber)
                    telephone.dial(telephone.defaultProviderId, normalizedNumber)
                }
            }
            Button {
                text: "Hang up"
                onClicked: {
                    telephone.hangupAll()
                }
            }
        }
    }
}


