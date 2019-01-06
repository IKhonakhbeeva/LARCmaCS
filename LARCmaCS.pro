#-------------------------------------------------
#
# Project created
#
#-------------------------------------------------

#read the global configuration file
include(config.pri)

#personal info
include(personal.pri)

#check personal info
msvc {
  isEmpty(VCPKG_DIR): error("To use MSVC, you need to specify the path to VCPKG_DIR!")
}
mingw {
  isEmpty(MSYS_DIR): error("To use MINGW, you need to specify the path to MSYS_DIR!")
}
isEmpty(MATLAB_DIR): error("You need to specify the path to MATLAB_DIR!")

#generate and include proto-files
include(proto/proto.pri)
CONFIG += protobuf

SHARED_DIR = macsCommon

include (LARCmaCS/LARCmaCS.pri)

#Need this???
#where to place built objects
OBJECTS_DIR = build/LARCmaCS/obj$${SUFFIX_STR}

#where to place temporary moc sources
MOC_DIR = build/LARCmaCS/moc

#where to place auto-generated UI files
UI_DIR = build/LARCmaCS/ui

#where to place intermediate resource files
RCC_DIR = build/LARCmaCS/resources


DLLS += \
  $$[QT_INSTALL_BINS]/Qt5Core.dll \
  $$[QT_INSTALL_BINS]/Qt5Widgets.dll \
  $$[QT_INSTALL_BINS]/Qt5Network.dll \
  $$[QT_INSTALL_BINS]/Qt5Gui.dll \

defineTest(copyToDestdir) {
    files = $$1

    for(FILE, files) {
        DDIR = $$DESTDIR

        # Replace slashes in paths with backslashes for Windows
        win32:FILE ~= s,/,\\,g
        win32:DDIR ~= s,/,\\,g
        QMAKE_POST_LINK += $$QMAKE_COPY $$quote($$FILE) $$quote($$DDIR) $$escape_expand(\\n\\t)
    }

    export(QMAKE_POST_LINK)
}
msvc: copyToDestdir($$DLLS)
!exists($$OUT_PWD/bin/LARCmaCS.cnf){
  INIT_FILES = \
    $$PWD/bin/LARCmaCS.cnf \
    $$PWD/bin/LARCmaCS.exe.embed.manifest \
    $$PWD/bin/gamepads.txt
  copyToDestdir($$INIT_FILES)
}

