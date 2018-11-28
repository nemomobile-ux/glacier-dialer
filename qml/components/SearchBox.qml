/****************************************************************************
 **
 ** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
 ** Copyright (C) 2012 Robin Burchell <robin+mer@viroteck.net>
 ** Copyright (C) 2018 Chupligin Sergey <neochapay@gmail.com>
 **
 ** $QT_BEGIN_LICENSE:BSD$
 ** You may use this file under the terms of the BSD license as follows:
 **
 ** "Redistribution and use in source and binary forms, with or without
 ** modification, are permitted provided that the following conditions are
 ** met:
 **   * Redistributions of source code must retain the above copyright
 **     notice, this list of conditions and the following disclaimer.
 **   * Redistributions in binary form must reproduce the above copyright
 **     notice, this list of conditions and the following disclaimer in
 **     the documentation and/or other materials provided with the
 **     distribution.
 **   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
 **     the names of its contributors may be used to endorse or promote
 **     products derived from this software without specific prior written
 **     permission.
 **
 ** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 ** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 ** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 ** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 ** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 ** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 ** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 ** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 ** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 ** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 ** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
 ** $QT_END_LICENSE$
 **
 ****************************************************************************/

import QtQuick 2.6

import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

Item {
    id: root

    // Declared properties
    property alias searchText: searchTextInput.text
    property alias placeHolderText: searchTextInput.placeholderText
    property alias maximumLength: searchTextInput.maximumLength

    // Signals & functions
    signal backClicked

    // Attribute definitions
    width: parent ? parent.width : 0
    height: Theme.itemHeightLarge

    TextField {
        id: searchTextInput
        height: parent.height

        inputMethodHints: Qt.ImhNoPredictiveText

        anchors {
            left: parent.left
            right: searchIcon.left
            verticalCenter: parent.verticalCenter
            margins: Theme.itemSpacingMedium
        }

        font.pixelSize: Theme.fontSizeLarge
    }
    // Search icon, just for styling the SearchBox a bit.
    Image {
        id: searchIcon

        height: parent.height*0.8
        width: height

        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            margins: Theme.itemSpacingMedium
        }

        fillMode: Image.PreserveAspectFit
        source: "image://theme/search"
    }

    // A trash can image, clicking it allows the user to quickly
    // remove the typed text.
    Image {
        id: clearTextIcon

        height: parent.height*0.8
        width: height

        source: "image://theme/chevron-left"

        anchors {
            right: searchTextInput.right
            verticalCenter: parent.verticalCenter
            margins: Theme.itemSpacingMedium
        }

        visible: searchTextInput.text.length > 0

        MouseArea {
            anchors.fill: parent
            onClicked: {
                searchTextInput.text = ""
                searchTextInput.forceActiveFocus()
            }
        }
    }
}
