set(SRC glacier-dialer.cpp
    dbusadaptor.cpp
)

add_executable(glacier-dialer ${SRC})

target_link_libraries(glacier-dialer
	Qt5::Gui
	Qt5::Qml
	Qt5::Quick
	Qt5::DBus
	Glacier::App)

install(TARGETS glacier-dialer RUNTIME
	DESTINATION ${CMAKE_INSTALL_BINDIR})
install(DIRECTORY qml
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-dialer)
