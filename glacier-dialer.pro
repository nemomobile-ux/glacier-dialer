# The name of your application
TARGET = glacier-dialer
QT += qml quick dbus
SOURCES += src/glacier-dialer.cpp \
    src/dbusadaptor.cpp

LIBS += -lglacierapp

HEADERS += src/dbusadaptor.h

OTHER_FILES += qml/glacier-dialer.qml \
    qml/pages/CallLogPage.qml \
    qml/pages/CallView.qml \
    qml/pages/ContactsPage.qml \
    qml/pages/ContactDelegate.qml \
    qml/pages/ContactDetails.qml \
    qml/pages/DialerPage.qml \
    qml/pages/FirstPage.qml \
    qml/components/SearchBox.qml \
    qml/components/DialerButton.qml \
    qml/components/VoicecallService.qml \
    rpm/glacier-dialer.spec \
    glacier-dialer.desktop \
    org.glacier.voicecall.ui.service \
    com.nokia.telephony.callhistory.service

target.path = /usr/bin

desktop.files = glacier-dialer.desktop
desktop.path = /usr/share/applications

qml.files = qml/glacier-dialer.qml
qml.path = /usr/share/glacier-dialer/qml

pages.files = qml
pages.path = /usr/share/glacier-dialer/

systemd_dbus_service.path = $${INSTALL_ROOT}/usr/share/dbus-1/services
systemd_dbus_service.files = org.glacier.voicecall.ui.service \
                             com.nokia.telephony.callhistory.service

systemd_ui_prestart_service.path = $${INSTALL_ROOT}/usr/lib/systemd/user
systemd_ui_prestart_service.files = voicecall-ui-prestart.service

INSTALLS += target desktop qml pages systemd_dbus_service systemd_ui_prestart_service

CONFIG += link_pkgconfig
PKGCONFIG += glacierapp
