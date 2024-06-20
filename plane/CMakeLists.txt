cmake_minimum_required(VERSION 3.29)

project(
  plane
  VERSION 0.1
  LANGUAGES CXX)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appplane main.cpp)

qt_add_qml_module(
  appplane
  URI
  plane
  VERSION
  1.0
  QML_FILES
  Window.qml
  SOURCES
  QML_FILES
  Actions.qml
  QML_FILES
  Content.qml
  QML_FILES
  Dialogs.qml
  RESOURCES
  images/bg1.jpg
  images/bg2.jpg
  images/bg3.jpg
  images/plane1.png
  images/plane2.png
  images/plane3.png
  images/plane4.png
  images/plane5.png
  images/plane6.png
  RESOURCES
  RESOURCES
  images/logo.png
  RESOURCES
  images/victory.png
  RESOURCES
  images/defeat.png
  RESOURCES
  images/enemy1.png
  images/enemy2.png
  images/enemy3.png
  QML_FILES Myplane.qml
  QML_FILES Map.qml
  RESOURCES images/map1.png)
set_target_properties(
  appplane
  PROPERTIES AUTORCC TRUE
             MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
             MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
             MACOSX_BUNDLE_SHORT_VERSION_STRING
             ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
             MACOSX_BUNDLE TRUE
             WIN32_EXECUTABLE TRUE)

target_link_libraries(appplane PRIVATE Qt6::Quick)

include(GNUInstallDirs)
install(
  TARGETS appplane
  BUNDLE DESTINATION .
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

# qt_add_executable(plane)  //Creates and finalizes an application target of a
# platform-specific type. This command performs the following tasks: 1. Create a
# CMake target of the appropriate type for the target platform. 2. Link the
# target to the Qt::Core library. 3. Handle finalization of the CMake target.

# qt_standard_project_setup()     #set(CMAKE_AUTOUIC ON)  set(CMAKE_AUTOMOC ON)

# @if %{HasTranslation} find_package(Qt6 REQUIRED COMPONENTS Core Quick
# LinguistTools) @else find_package(Qt6 REQUIRED COMPONENTS Core Quick) @endif

# target_sources(appplane PRIVATE main.cpp qml.qrc @if %{HasTranslation}
# %{TsFileName} @endif
#
# PUBLIC
#
# )

# qt_import_qml_plugins(plane)

# cmake_minimum_required(VERSION 3.16)
#
# project(plane VERSION 0.1 LANGUAGES CXX)
#
# @if !true set(CMAKE_AUTOMOC ON) @endif set(CMAKE_CXX_STANDARD_REQUIRED ON)
#
# find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)
#
# @if true @if false qt_standard_project_setup(REQUIRES 6.5) @else
# qt_standard_project_setup() @endif @endif
#
# qt_add_executable(appplane main.cpp )
#
# qt_add_qml_module(appplane URI plane VERSION 1.0 QML_FILES Main.qml )
#
# # Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1. #
# If you are developing for iOS or macOS you should consider setting an #
# explicit, fixed bundle identifier manually though.
# set_target_properties(appplane PROPERTIES #    MACOSX_BUNDLE_GUI_IDENTIFIER
# com.example.appplane MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
# MACOSX_BUNDLE_SHORT_VERSION_STRING
# ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR} MACOSX_BUNDLE TRUE
# WIN32_EXECUTABLE TRUE )
#
# target_link_libraries(appplane PRIVATE Qt6::Quick )
#
# include(GNUInstallDirs) install(TARGETS appplane BUNDLE DESTINATION . LIBRARY
# DESTINATION ${CMAKE_INSTALL_LIBDIR} RUNTIME DESTINATION
# ${CMAKE_INSTALL_BINDIR} )
