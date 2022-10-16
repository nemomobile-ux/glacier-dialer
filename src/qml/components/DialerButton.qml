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


Rectangle {
    id: btn
    width: height
    height: btnCanvas.height

    color: dialerButtonMouse.pressed ? Theme.fillColor : "transparent"
//    color: "transparent";
    radius: height/2

    property alias text: numberText.text
    property alias subText: letterText.text

    Text {
        id: numberText
        color: dialerButtonMouse.pressed ? Theme.accentColor : Theme.textColor
        font.pixelSize: btn.height*0.8
        font.family: Theme.fontFamily
        font.weight: Theme.fontWeightMedium
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -btn.width*0.15
        //            text: btn.text
    }
    Text {
        id: letterText
        color: Theme.fillColor
        font.pixelSize: numberText.font.pixelSize * 0.4
        font.family: Theme.fontFamily
        font.weight: Theme.fontWeightMedium
        anchors.left: numberText.right
        anchors.leftMargin: Theme.itemSpacingSmall
        anchors.baseline: numberText.baseline
    }

    MouseArea {
        id: dialerButtonMouse
        anchors.fill: parent
        onPressed: {
            dialedNumber.insert(dialedNumber.text.length ,btn.text)
        }
        onPressAndHold: {
            if (btn.text == "0") {
                dialedNumber.text = dialedNumber.text.replace(/0$/,"+") // replace last 0 with +
            }
        }
    }

}
