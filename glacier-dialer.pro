# The name of your application
TARGET = glacier-dialer
QT += qml quick dbus
SOURCES += src/glacier-dialer.cpp \
    src/dbusadaptor.cpp

HEADERS += src/dbusadaptor.h

OTHER_FILES += qml/glacier-dialer.qml \
    qml/pages/FirstPage.qml \
    rpm/glacier-dialer.spec \
    glacier-dialer.desktop \
    qml/pages/DialerButton.qml \
    org.glacier.voicecall.ui.service \
    qml/pages/CallLogPage.qml \
    qml/pages/LogDelegate.qml \
    qml/pages/CallView.qml \
    qml/pages/DialerPage.qml

target.path = /usr/bin

desktop.files = glacier-dialer.desktop
desktop.path = /usr/share/applications

qml.files = qml/glacier-dialer.qml
qml.path = /usr/share/glacier-dialer/qml

pages.files = qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    qml/pages/DialerButton.qml \
    qml/pages/CallLogPage.qml \
    qml/pages/LogDelegate.qml \
    qml/pages/CallView.qml \
    qml/pages/DialerPage.qml
pages.path = /usr/share/glacier-dialer/qml/pages

systemd_dbus_service.path = $${INSTALL_ROOT}/usr/share/dbus-1/services
systemd_dbus_service.files = org.glacier.voicecall.ui.service

systemd_ui_prestart_service.path = $${INSTALL_ROOT}/usr/lib/systemd/user
systemd_ui_prestart_service.files = voicecall-ui-prestart.service

INSTALLS += target desktop qml pages systemd_dbus_service systemd_ui_prestart_service
