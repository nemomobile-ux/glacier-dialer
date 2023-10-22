/*
 * Copyright 2015 Aleksi Suomalainen <suomalainen.aleksi@gmail.com>
 * Copyright (C) 2022-2023 Chupligin Sergey <neochapay@gmail.com>
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

import org.nemomobile.contacts 1.0
import org.nemomobile.qmlcontacts 1.0

import "../components"

Page {
    id: contactsPage

    signal selectContact(string number)

    headerTools: HeaderToolsLayout {
        id: tools
        title: qsTr("Contacts")
        showBackButton: true;
    }

    PeopleModel {
        id: contactsModel
    }

    SearchBox {
        id: searchbox
        placeHolderText: qsTr("Search")
        anchors.top: parent.top
        width: parent.width
        onSearchTextChanged: {
            contactsModel.search(searchbox.searchText);
        }
        visible: contactsModel.count != 0
    }

    ContactListWidget {
        id: contactsList

        anchors.top: searchbox.bottom
        width: parent.width
        anchors.bottom: parent.bottom
        clip: true

        model: contactsModel
        delegate: ContactListDelegate {
             showNext: false
             onClicked: {
                 selectContact(model.person.phoneDetails[0].number)
             }
        }
    }
}
