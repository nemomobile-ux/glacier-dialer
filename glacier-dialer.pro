# The name of your application
TARGET = glacier-dialer
QT += qml quick
SOURCES += src/glacier-dialer.cpp

OTHER_FILES += qml/glacier-dialer.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/glacier-dialer.spec \
    glacier-dialer.desktop \
    qml/pages/DialerButton.qml

target.path = /usr/bin

desktop.files = glacier-dialer.desktop
desktop.path = /usr/share/applications

qml.files = qml/glacier-dialer.qml
qml.path = /usr/share/glacier-dialer/qml

pages.files = qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    qml/pages/DialerButton.qml
pages.path = /usr/share/glacier-dialer/qml/pages

INSTALLS += target desktop qml pages
