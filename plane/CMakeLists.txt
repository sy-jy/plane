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
  images/map2.png
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
  RESOURCES
  images/start.png
  QML_FILES
  Myplane.qml
  QML_FILES
  Map.qml
  RESOURCES
  images/map1.png
  QML_FILES
  Bullet.qml
  RESOURCES
  images/bullet_1.png
  QML_FILES
  Bgm.qml
  RESOURCES
  wav/boom.wav
  wav/exploBig.wav
  wav/exploPop.wav
  wav/exploStd.wav
  wav/life_add.wav
  wav/life_lose.wav
  wav/music_game.wav
  wav/music_menu.wav
  wav/power.wav
  RESOURCES
  images/heroSuper.png
  RESOURCES
  images/boss1.png
  images/boss2.png
  images/enemy4.png
  images/warm.png
  QML_FILES
  Enemy.qml
  QML_FILES
  Items.qml
  RESOURCES
  images/powerUpShield.png
  images/powerUpAmmo.png
  RESOURCES
  wav/defeat.mp3
  RESOURCES
  images/powerUpShield.png
  images/powerUpAmmo.png
  RESOURCES
  images/map3.png
  RESOURCES
  images/powerUpSpeed.png
  images/increaseHp.png
  RESOURCES
  images/bullet_mid.png
  RESOURCES
  images/enemy_bullet1.png
  RESOURCES
  images/powerUpSpeed.png
  images/increaseHp.png
  RESOURCES
  images/bullet_mid.png
  RESOURCES
  images/random.png
  RESOURCES
  wav/shoot.mp3
  RESOURCES
  wav/volume.mp3
  RESOURCES
  wav/focus.mp3
  RESOURCES
  images/Bossboom.png
  RESOURCES
  images/enemyboom.png
  QML_FILES
  Boom.qml
  RESOURCES
  images/boss_bullet1.png
  RESOURCES
  wav/victory.mp3
  RESOURCES
  images/superBomb.png
  RESOURCES
  images/Bossboom2.png
  RESOURCES
  wav/victory.mp3
  RESOURCES
  images/boss_2.png
  RESOURCES
  images/logo2.png
  RESOURCES
  images/enemy_bullet2.png
  RESOURCES
  wav/backgroundmusic.mp3
  RESOURCES
  images/enemy_bullet2.png
  RESOURCES
  images/boss3.png
  images/bossAmmo.png
  images/bossAmmoNormal.png
  RESOURCES
  images/target.png
  RESOURCES
  images/track_bullet.png
  RESOURCES
  images/money.png
  RESOURCES
  images/life.png
  RESOURCES wav/bossboom.mp3)
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
