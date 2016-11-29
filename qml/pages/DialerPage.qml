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
import org.nemomobile.contacts 1.0

Page {
    id: dialer
    ColumnLayout {
        id: rootColumn
        spacing: 5
        anchors.centerIn: parent
        anchors.fill: parent
        anchors.topMargin: 15

        RowLayout {
            spacing: 20

            TextEdit {
                id: dialedNumber
                Layout.fillWidth: true
                Layout.preferredWidth: 240
                font.pointSize: 52
                color: "steelblue"
                horizontalAlignment: TextEdit.AlignRight
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

            columnSpacing: 0
            rowSpacing: 0
            columns: 3
            Repeater {
                model: [0,1,2,3,4,5,6,7,8,9,10,11]
                delegate: DialerButton {
                    index: model.index
                    person: {
                        if (model.index < peopleModel.count) {
                            return peopleModel.personByRow(index)
                        } else {
                            return null
                        }
                    }
                }
            }
        }
        Rectangle {
            id: dimmer
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 35
            height: 35
            width: parent.width
            color: "green"

            gradient: Gradient {
                GradientStop { position: 0; color: "green" }
                GradientStop { position: 1.0; color: "transparent" }
            }
            Text {
                color: "white"
                text: qsTr("Call")
                font.pointSize: 32
                anchors.right: parent.right
                anchors.bottom: parent.bottom
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    var normalizedNumber = Person.normalizePhoneNumber(dialedNumber.text)
                    telephone.dial(telephone.defaultProviderId, normalizedNumber)
                }
            }
        }
    }
}
