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
        anchors.topMargin: 30

        RowLayout {
            spacing: 20
            TextEdit {
                Layout.fillWidth: true
                Layout.preferredWidth: 240
                Layout.preferredHeight: 40
                font.pointSize: 52
                color: "steelblue"
                id: dialedNumber
            }
            Button {
                id: clearer
                text: "Clear"
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                onClicked: {
                    dialedNumber.text = ""
                }
            }
        }
        RowLayout {
            Label {
                id: callLabel
                Layout.fillHeight: true
            }
        }

        RowLayout {
            Button {
                id: callLogBtn
                text: "Call log"
                Layout.fillWidth: true
                onClicked: {
                    pageItem.pageStack.push({item: Qt.resolvedUrl("CallLogPage.qml"), properties: {telephone: telephone}})
                }
            }
        }

        GridLayout {
            width: rootColumn.width
            anchors {
                leftMargin: 10
                rightMargin: 10
                topMargin: 5
                bottomMargin: 10
            }

            columnSpacing: 20
            rowSpacing: 20
            columns: 3
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
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "Call / Answer"
                onClicked: {
                    var normalizedNumber = Person.normalizePhoneNumber(dialedNumber.text)

                    if (!telephone.activeVoiceCall) {
                        telephone.dial(telephone.defaultProviderId, normalizedNumber)
                    } else {
                        telephone.activeVoiceCall.answer()
                    }
                }
            }
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
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


