import QtQuick 2.6
import org.nemomobile.dbus 2.0

DBusAdaptor {
    id: callhistoryAdaptor
    service: "com.nokia.telephony.callhistory"
    path: "/org/maemo/m"
    iface: "com.nokia.MApplicationIf"

    xml: '  <interface name="com.nokia.MApplicationIf">\n' +
         '    <method name="launch" />\n' +
         '        <arg name="type" type="s" direction="in"/>\n' +
         '    </method>\n' +
         '  </interface>\n'

    signal openCallHistory

    function launch(type) {
        if(type === "callHistory") {
            openCallHistory()
        }
    }
}
