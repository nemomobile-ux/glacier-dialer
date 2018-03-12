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
import QtQuick.Layouts 1.0

import org.nemomobile.voicecall 1.0
import org.nemomobile.contacts 1.0

import MeeGo.QOfono 0.2

Page {
    id: first
    headerTools: HeaderToolsLayout {
        id: tools
        title: qsTr("Glacier Dialer")
        tools: [
            ToolButton {
                iconSource: "image://theme/icon-m-toolbar-callhistory-white"
                onClicked: {
                    dialer_page.visible = false
                    call_log_page.visible = true
                    contacts_page.visible = false
                }
            },
            ToolButton {
                iconSource: "image://theme/icon-m-toolbar-view-menu-white-selected"
                onClicked: {
                    call_log_page.visible = false
                    dialer_page.visible = true
                    contacts_page.visible = false
                }
            },
            ToolButton {
                iconSource: "image://theme/icon-m-telephony-contact-avatar"
                onClicked: {
                    call_log_page.visible = false
                    dialer_page.visible = false
                    contacts_page.visible = true
                }
            }
        ]
        drawerLevels: [
            Button {
                visible: dialer_page.visible
                text: qsTr("Edit speed dial")
                onClicked: {
                    main.speedDialEditor = true
                }
            },
            Button {
                visible: call_log_page.visible
                text: qsTr("Mark all as read")
                onClicked: {
                    commCallModel.markAllRead()
                }
            }

        ]
    }
    CallLogPage {
        id: call_log_page
        visible: false
    }
    DialerPage {
        id: dialer_page
        visible: false
    }
    ContactsPage {
        id: contacts_page
        visible: false
    }

    Component.onCompleted: {
        dialer_page.visible = true
    }
}


