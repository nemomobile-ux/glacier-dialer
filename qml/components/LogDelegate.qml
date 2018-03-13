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
import org.nemomobile.commhistory 1.0


Item {
    id: root
    width: parent.width
    height: Theme.itemHeightExtraLarge
    property Person contact

    Image{
        id: callRoute
        width: parent.height*0.8
        height: width
        source: "image://theme/phone"
        anchors{
            left: parent.left
            leftMargin: parent.height*0.1
            top: parent.top
            topMargin: parent.height*0.1
        }
    }

    /*Label {
        id: directionLabel
        Layout.fillWidth: true
        Layout.fillHeight: true
        text: model.isMissedCall ? qsTr('missed') : (model.direction == CommCallModel.Inbound ? qsTr('received') : qsTr('initiated'))
    }*/

    Label {
        id: contactLabel
        text: contact ? contact.displayLabel.substring(0,10): model.remoteUid
        anchors{
            left: callRoute.right
            leftMargin: parent.height*0.1
            verticalCenter: parent.verticalCenter
        }
        width: parent.width-callRoute.width-dateLabel.width-parent.height*0.4
    }
    Label {
        id: dateLabel
        text: refreshTimestamp(model.startTime)
        anchors{
            right: parent.right
            leftMargin: parent.height*0.1
            verticalCenter: parent.verticalCenter
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            telephone.dial(telephone.defaultProviderId, model.remoteUid)
        }
        onPressAndHold: {
            commCallModel.deleteAt(model.index)
        }
    }

    function refreshTimestamp(time) {
        var timeAgo;

        var seconds = Math.floor((new Date() - time) / 1000)
        var years = Math.floor(seconds / (365*24*60*60))
        var months = Math.floor(seconds / (30*24*60*60))
        var days = Math.floor(seconds / (24*60*60))
        var hours = Math.floor(seconds / (60*60))
        var minutes = Math.floor(seconds / 60)

        if (months >= 1) {
            timeAgo =  qsTr("long time ago")
        }else if (days >= 1) {
            if (days > 1) {
                timeAgo =  days + " " + qsTr("days ago")
            } else {
                timeAgo =  days + " " + qsTr("day ago")
            }
        }else if (hours >= 1) {
            if (hours > 1) {
                timeAgo =  hours + " " + qsTr("hours ago")
            } else {
                timeAgo =  hours + " " + qsTr("hour ago")
            }
        } else if (minutes >= 1) {
            timeAgo =  minutes + " " + qsTr("min ago")

        } else {
            timeAgo = qsTr("Just now")
        }
        return timeAgo;
    }
}
