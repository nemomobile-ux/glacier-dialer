set(SRC glacier-dialer.cpp
    dbusadaptor.cpp
)

add_executable(glacier-dialer ${SRC})

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -fvisibility=hidden -fvisibility-inlines-hidden")
set(CMAKE_EXE_LINKER_FLAGS "-pie -rdynamic")

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
