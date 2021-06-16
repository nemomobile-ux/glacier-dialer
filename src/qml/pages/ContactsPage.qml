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

import QtQuick 2.6
import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0
import QtQuick.Layouts 1.0

import org.nemomobile.contacts 1.0
import org.nemomobile.qmlcontacts 1.0

import "../components"

Page {
    id: contacts

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
            app.contactListModel.search(searchbox.searchText);
        }
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
                 console.log(model.person.phoneDetails[0].number)
                 selectContact(model.person.phoneDetails[0].number)
             }
        }
    }
}
