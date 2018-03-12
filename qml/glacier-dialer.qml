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
import QtQuick.Window 2.1
import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0
import org.nemomobile.voicecall 1.0
import org.nemomobile.contacts 1.0
import org.nemomobile.commhistory 1.0

import "pages"

ApplicationWindow
{
    id: main
    initialPage: FirstPage {
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
                main.activeVoiceCallPerson = peopleModel.personByPhoneNumber(activeVoiceCall.lineId, true);
                console.error(JSON.stringify(main.activeVoiceCallPerson))
                pageItem.pageStack.push({
                                            "item": Qt.resolvedUrl("pages/CallView.qml"),
                                            "properties": {
                                                "main": main,
                                                "telephone": telephone
                                            },
                                            "immediate": true
                                        })
                __window.setTitle("Dialer")
                if(!__window.visible)
                {
                    console.log("SHOW ME!!!")
                    main.activationReason = "activeVoiceCallChanged"
                    __window.showFullScreen()
                } else {
                    __window.raise()
                }
            } else {
                pageItem.pageStack.pop({"immediate":true})
                main.activeVoiceCallPerson = null
                if (main.activationReason != "invoked") {
                    main.activationReason = "invoked"
                    __window.close()
                }
            }
        }
    }
    function secondsToTimeString(seconds) {
        var h = Math.floor(seconds / 3600);
        var m = Math.floor((seconds - (h * 3600)) / 60);
        var s = seconds - h * 3600 - m * 60;
        if(h < 10) h = '0' + h;
        if(m < 10) m = '0' + m;
        if(s < 10) s = '0' + s;
        return '' + h + ':' + m + ':' + s;
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
}


