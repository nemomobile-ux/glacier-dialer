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

Rectangle {
    id: btn
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.preferredHeight: 140
    Layout.preferredWidth: 140
    color: "transparent"
    property int index
    property string text: {
        if (index <= 8) {
            return "" + (index + 1)
        }

        if (index > 8) {
            switch(index) {
            case 9: return "+";
            case 10: return "0";
            case 11: return "*";
            }
        }
    }
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
        anchors.fill: parent
    }

    Text {
        id: numberText
        color: "steelblue"
        font.pointSize: 72
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        font.bold: true
        text: btn.text
        style: Text.Outline
        styleColor : "black"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            dialedNumber.insert(dialedNumber.cursorPosition,btn.text)
        }
        onPressAndHold: {
            var normalizedNumber = person.phoneDetails[0].normalizedNumber
            telephone.dial(telephone.defaultProviderId, normalizedNumber)
        }
    }
}
