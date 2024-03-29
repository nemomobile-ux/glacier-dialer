set(SRC glacier-dialer.cpp
    dbusadaptor.cpp
)

if(!QML_DEBUG)
    qt_add_resources(RESOURCES qml/glacier-dialer.qrc)
endif()

add_executable(glacier-dialer ${SRC} ${RESOURCES})

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -fvisibility=hidden -fvisibility-inlines-hidden")
set(CMAKE_EXE_LINKER_FLAGS "-pie -rdynamic")

target_link_libraries(glacier-dialer
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::DBus
    Glacier::App)


install(TARGETS glacier-dialer RUNTIME
    DESTINATION ${CMAKE_INSTALL_BINDIR})
install(DIRECTORY qml
    DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-dialer)
if(QML_DEBUG)
    install(DIRECTORY qml
        DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-dialer)
endif()
