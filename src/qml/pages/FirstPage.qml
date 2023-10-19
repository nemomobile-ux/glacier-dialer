/*
 * Copyright 2014 Aleksi Suomalainen <suomalainen.aleksi@gmail.com>
 * Copyright (C) 2023 Chupligin Sergey <neochapay@gmail.com>
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

import QtQuick
import QtQuick.Controls

import Nemo
import Nemo.Controls

import org.nemomobile.voicecall 1.0
import org.nemomobile.contacts 1.0

import QOfono 0.2

Page {
    id: first
    headerTools: HeaderToolsLayout {
        id: tools
        title: qsTr("Dialer")
        tools: [
            ToolButton {
                iconSource: "image://theme/history"
                onClicked: {
                    main.push(Qt.resolvedUrl("CallLogPage.qml"));
                }
            },
            ToolButton {
                iconSource: "image://theme/search"
                onClicked: {
                    main.push(Qt.resolvedUrl("ContactsPage.qml"));
                }
            }
        ]
    }

    DialerPage {
        id: dialer_page
    }
}


