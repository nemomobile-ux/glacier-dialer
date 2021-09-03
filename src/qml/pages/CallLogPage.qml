/*
 * Copyright 2014 Aleksi Suomalainen <suomalainen.aleksi@gmail.com>
 * Copyright 2018 Chupligin Sergey <neochapay@gmail.com>
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
import QtQuick.Layouts 1.0
import org.nemomobile.contacts 1.0
import org.nemomobile.commhistory 1.0

import "../components"

Page {
    id: callLogPage
    headerTools: HeaderToolsLayout {
        id: tools
        title: qsTr("Call log")
        showBackButton: true;

        tools: [
            ToolButton {
                iconSource: "image://theme/check"
                onClicked: {
                    commCallModel.markAllRead()
                }
                visible: historyList.count != 0
            }
        ]
    }

    ListView {
        id: historyList
        anchors.fill: parent
        anchors.topMargin: 20
        clip: true
        model: commCallModel
        delegate: ListViewItemWithActions {
            property Person contact

            showNext: false

            contact: model.contactIds.length ? peopleModel.personById(model.contactIds[0]) : null
            label: contact ? contact.displayLabel : model.remoteUid
            description: refreshTimestamp(model.startTime)
            icon: "image://theme/phone"

            onClicked: {
                telephone.dial(telephone.defaultProviderId, model.remoteUid)
            }
        }
    }

    Label{
        id: emptyHistory
        text: qsTr("Call journal empty")
        anchors.centerIn: parent
        visible: historyList.count == 0
    }

    function refreshTimestamp(time) {
        var timeAgo;

        var seconds = Math.floor((new Date() - time) / 1000)
        var years = Math.floor(seconds / (365*24*60*60))
        var months = Math.floor(seconds / (30*24*60*60))
        var days = Math.floor(seconds / (24*60*60))
        var hours = Math.floor(seconds / (60*60))
        var minutes = Math.floor(seconds / 60)

        if (years >= 1) {
            timeAgo = qsTr("%n year(s) ago", "refreshTimestamp", years)
        }else if (months >= 1) {
            timeAgo = qsTr("%n months(s) ago", "refreshTimestamp", months)
        }else if (days >= 1) {
            timeAgo = qsTr("%n day(s) ago", "refreshTimestamp", days)
        }else if (hours >= 1) {
            timeAgo = qsTr("%n hours(s) ago", "refreshTimestamp", hours)
        } else if (minutes >= 1) {
            timeAgo = qsTr("%n minutes(s) ago", "refreshTimestamp", minutes)
        } else {
            timeAgo = qsTr("Just now")
        }
        return timeAgo;
    }
}
