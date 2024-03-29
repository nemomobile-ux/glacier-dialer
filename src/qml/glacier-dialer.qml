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
import QtQuick.Window

import Nemo
import Nemo.Controls

import org.nemomobile.voicecall 1.0
import org.nemomobile.contacts 1.0
import org.nemomobile.commhistory 1.0

import "pages"
import "components"

ApplicationWindow
{
    id: main
    initialPage: DialerPage {
        id: pageItem
    }

    contentOrientation: Screen.orientation
    property Person activeVoiceCallPerson
    property string activationReason: 'invoked'
    property bool speedDialEditor: false
    property alias page: pageItem

    VoiceCallManager {
        id: telephone
        onActiveVoiceCallChanged: {
            if(activeVoiceCall) {
                main.push(Qt.resolvedUrl("pages/CallView.qml"),{"telephone": telephone, "immediate": true})
                if(!main.visible)
                {
                    main.activationReason = "activeVoiceCallChanged"
                    main.showFullScreen()
                } else {
                    main.raise()
                }
            } else {
                main.pageStack.pop()
                main.activeVoiceCallPerson = null
                main.hide();
            }
        }
    }

    function secondsToTimeString(seconds) {
        var h = Math.floor(seconds / 3600);
        var m = Math.floor((seconds - (h * 3600)) / 60);
        var s = Math.floor(seconds - h * 3600 - m * 60);
        if (h < 10) h = '0' + h;
        if (m < 10) m = '0' + m;
        if (s < 10) s = '0' + s;
        return h + ':' + m + ':' + s;
    }
    PeopleModel {
        id: peopleModel
        filterType: PeopleModel.FilterAll
    }
    CommCallModel {
        id: commCallModel
        groupBy: CommCallModel.GroupByContact
        resolveContacts: true
    }

    VoicecallService{
        id: voicecallService

        onOpenCallHistory: {
            main.push(Qt.resolvedUrl("pages/CallLogPage.qml"))
            main.raise()
        }
    }
}


