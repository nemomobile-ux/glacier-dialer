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
import QtQuick.Layouts 1.0

Item {
    id: root
    width: parent.width
    height: 72
    property Person contact
    RowLayout {
        anchors.fill: parent
        spacing: 10
        Label {
            id: directionLabel
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: model.isMissedCall ? qsTr('missed') : (model.direction == CommCallModel.Inbound ? qsTr('received') : qsTr('initiated'))
        }
        Label {
            id: contactLabel
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: contact ? contact.displayLabel.substring(0,10): model.remoteUid
        }
        Label {
            id: dateLabel
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: Qt.formatDateTime(model.startTime, Qt.DefaultLocaleShortDate)
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
}
