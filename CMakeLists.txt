cmake_minimum_required(VERSION 3.16)

project(sufur VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appsufur
    main.cpp
    myclass.h
    myclass.cpp
)

qt_add_qml_module(appsufur
    URI sufur
    VERSION 1.0
    QML_FILES Main.qml
)

find_library(LIBSUFUR_LIBRARY sufur HINTS ${CMAKE_SOURCE_DIR}/libsufur/buildDir)

if(NOT LIBSUFUR_LIBRARY)
    message(FATAL_ERROR "libsufur not found")
endif()

set_target_properties(appsufur PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appsufur
       PRIVATE ${LIBSUFUR_LIBRARY}
    PRIVATE Qt6::Quick
)

install(TARGETS appsufur
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
