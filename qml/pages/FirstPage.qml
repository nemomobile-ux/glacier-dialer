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
    headerTools: HeaderToolsLayout {
        id: tools
        title: "Glacier Dialer"
    }
    property alias callLabel: callLabel
    ColumnLayout {
        id: rootColumn
        spacing: 20
        anchors.centerIn: parent
        anchors.fill: parent

        RowLayout {
            spacing: 20
            TextField {
                Layout.fillWidth: false
                id: dialedNumber
            }
            Button {
                id: clearer
                text: "Clear"
                Layout.fillWidth: false
                onClicked: {
                    dialedNumber.text = ""
                }
            }
        }
        RowLayout {
            Label {
                id: callLabel
                Layout.fillWidth: false
            }
            Button {
                id: callLogBtn
                text: "Call log"
                Layout.fillWidth: false
                onClicked: {
                    console.log("Resolving to: " + Qt.resolvedUrl("CallLogPage.qml"))
                    pageItem.pageStack.push({item: Qt.resolvedUrl("CallLogPage.qml"), properties: {telephone: telephone}})
                }
            }
        }

        GridLayout {
            width: rootColumn.width
            columnSpacing: 20
            rowSpacing: 20
            columns: 3
            DialerButton {
                Layout.fillWidth: false
                text: "1"
            }
            DialerButton {
                Layout.fillWidth: false
                text: "2"
            }
            DialerButton {
                Layout.fillWidth: false
                text: "3"
            }
            DialerButton {
                Layout.fillWidth: false
                text: "4"
            }
            DialerButton {
                Layout.fillWidth: false
                text: "5"
            }
            DialerButton {
                Layout.fillWidth: false
                text: "6"
            }
            DialerButton {
                Layout.fillWidth: false
                text: "7"
            }
            DialerButton {
                Layout.fillWidth: false
                text: "8"
            }
            DialerButton {
                Layout.fillWidth: false
                text: "9"
            }
            DialerButton {
                Layout.fillWidth: false
                text: "+"
            }
            DialerButton {
                Layout.fillWidth: false
                text: "0"
            }
            DialerButton {
                Layout.fillWidth: false
                text: "#"
            }
        }
        RowLayout {
            spacing: 20
            Button {
                Layout.fillWidth: false
                text: "Call / Answer"
                onClicked: {
                    console.log("Providers: " + telephone.providers)
                    var normalizedNumber = Person.normalizePhoneNumber(dialedNumber.text)
                    console.log("Calling: " + normalizedNumber)

                    if (!telephone.activeVoiceCall) {
                        telephone.dial(telephone.defaultProviderId, normalizedNumber)
                    } else {
                        console.log("Answering to call from: " + telephone.activeVoiceCall.lineId)
                        telephone.activeVoiceCall.answer()
                    }
                }
            }
            Button {
                Layout.fillWidth: false
                text: "Hang up"
                onClicked: {
                    if (telephone.activeVoiceCall) {
                        telephone.activeVoiceCall.hangup()
                    }
                }
            }
        }
    }
}


