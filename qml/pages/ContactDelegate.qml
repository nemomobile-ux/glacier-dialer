/*
 * Copyright 2015 Aleksi Suomalainen <suomalainen.aleksi@gmail.com>
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

Item {
    height: 145
    width: parent.width
    property alias person: row.person
    RowLayout {
        id: row
        spacing: 15
        anchors.fill: parent
        property Person person
        onPersonChanged: {
            person.avatarPathChanged.connect(avatarPotentiallyChanged)
            avatarPotentiallyChanged()
        }
        function avatarPotentiallyChanged() {
            if (person == null || person.avatarPath == "image://theme/icon-m-telephony-contact-avatar")
                contactImage.source = "image://theme/icon-m-telephony-contact-avatar"
            else
                contactImage.source = person.avatarPath
        }
        Image {
            id: contactImage
            Layout.preferredHeight: 140
            Layout.preferredWidth: 140
        }
        Label {
            text: model.displayLabel
            Layout.fillWidth: true
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                telephone.dial(telephone.defaultProviderId, person.phoneDetails[0].normalizedNumber)
            }
            onPressAndHold: {
                var comp = Qt.createComponent("ContactDetails.qml")
                if (comp.status === Component.Ready) {
                    first.pageStack.push({
                                         "item": comp,
                                         "properties": {
                                             "person": person
                                         },
                                         "destroyOnPop": true
                                     })
                }
            }
        }
    }
}
