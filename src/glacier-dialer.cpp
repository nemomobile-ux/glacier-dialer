/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif
#include <QtGui/QGuiApplication>
#include "declarativeview.h"

#include <QtQml>
#include <QtQuick/QQuickView>
#include <QtCore/QString>
#include <QScreen>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QScreen* sc = app.primaryScreen();
    if(sc){
        sc->setOrientationUpdateMask(Qt::LandscapeOrientation
                             | Qt::PortraitOrientation
                             | Qt::InvertedLandscapeOrientation
                             | Qt::InvertedPortraitOrientation);
    }
    QQmlApplicationEngine* engine = new QQmlApplicationEngine(QUrl("/usr/share/glacier-dialer/qml/glacier-dialer.qml"));
    QObject *topLevel = engine->rootObjects().value(0);
    QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);
    setenv("QT_QUICK_CONTROLS_STYLE", "Nemo", 1);
    DeclarativeView view(engine, window);
    view.setSource(QUrl::fromLocalFile("/usr/share/glacier-dialer/qml/pages/FirstPage.qml"));
    if ( !window ) {
        qWarning("Error: Your root item has to be a Window.");
        return -1;
    }
    if (!app.arguments().contains("-prestart")) {
        view.showFullScreen();
    }
    return app.exec();
}

