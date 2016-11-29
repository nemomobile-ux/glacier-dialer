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

Page {
    id: contactdetails
    property Person person
    headerTools: HeaderToolsLayout { showBackButton: true; title: person.displayLabel}
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
    Flickable {
        anchors.fill: parent
        contentHeight: rootColumn.height
        ColumnLayout {
            id: rootColumn
            anchors.fill: parent
            spacing: 20
            Image {
                id: contactImage
                Layout.preferredHeight: 240
                Layout.preferredWidth: 240
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Label {
                text: qsTr("First name")
            }
            TextField {
                text: person.firstName
            }
            Label {
                text: qsTr("Last name")
            }
            TextField {
                text: person.lastName
            }
            Label {
                text: qsTr("Phone number")
            }
            TextField {
                text: person.phoneDetails[0].normalizedNumber
            }
        }
    }
}
