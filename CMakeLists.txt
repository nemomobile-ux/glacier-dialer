cmake_minimum_required(VERSION 3.13.0)

project(glacier-dialer
	VERSION 0.2.1
	DESCRIPTION "The Glacier dialer")

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_INSTALL_PREFIX /usr)

include(FeatureSummary)
include(GNUInstallDirs)

set(QT_MIN_VERSION "5.6.0")
find_package(Qt5 COMPONENTS Gui Qml Quick DBus LinguistTools REQUIRED)
find_package(Glacier COMPONENTS App REQUIRED)

add_subdirectory(src)

# Translations
file(GLOB TS_FILES translations/*.ts)
qt5_add_translation(QM_FILES ${TS_FILES})
add_custom_target(translations DEPENDS ${QM_FILES})
add_dependencies(glacier-dialer translations)

install(FILES voicecall-ui-prestart.service
        DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/systemd/user/)

install(FILES com.nokia.telephony.callhistory.service org.glacier.voicecall.ui.service
        DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/dbus-1/services)

install(FILES ${QM_FILES}
        DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-dialer/translations)

install(FILES glacier-dialer.desktop
        DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/applications)

install(DIRECTORY images
        DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-dialer)
