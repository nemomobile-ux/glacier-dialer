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

import QtQuick 2.6
import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

import org.nemomobile.contacts 1.0

Item{
    id: btnCanvas

    property int index

    Rectangle {
        id: btn
        width: height
        height: btnCanvas.height

        anchors.centerIn: parent

        color: dialerButtonMouse.pressed ? Theme.accentColor : "transparent"
        radius: height/2

        property string text: {
            if (btnCanvas.index <= 8) {
                return "" + (btnCanvas.index + 1)
            }

            if (btnCanvas.index > 8) {
                switch(btnCanvas.index) {
                case 9: return "*";
                case 10: return "0";
                case 11: return "#";
                }
            }
        }

        Text {
            id: numberText
            color: Theme.textColor
            font.pixelSize: btn.height*0.8
            anchors.centerIn: parent
            text: btn.text
        }

        MouseArea {
            id: dialerButtonMouse
            anchors.fill: parent
            onPressed: {
                dialedNumber.insert(dialedNumber.text.length ,btn.text)
            }
        }
    }
}
