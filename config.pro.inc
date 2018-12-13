CONFIG -= warn_off
CONFIG += debug_and_release build_all
CONFIG += qt thread
CONFIG += console

DEBUG_SUFFIX        = 
RELEASE_SUFFIX      = 

LARC_TARGET_PLATFORM =
#win32:!mingw {PROTOC_BIN_DIR=$${VCPKG_DIR}/bin/}
#PROTOC_VER=$$system($${PROTOC_BIN_DIR}protoc --version)
#message("Compiler:$$QMAKE_CXX from $$(PATH) with protoc $$PROTOC_VER")

!contains(QT_ARCH, i386):CONFIG += amd64
mingw {
  amd64 { message("Mingw64") }
  else  { message("Mingw32") }
} else: win32 {
  amd64 {  message("MSVC 64") }
  else  { message("MSVC 32") }
} else  {
  error($$CONFIG)
}


win32 {
  DEBUG_SUFFIX      = d
  DEBUG_PREFIX      = debug/
}

CONFIG(debug, debug|release) {
  SUFFIX_STR = $${DEBUG_SUFFIX}
  PREFIX_STR = $${DEBUG_PREFIX}
}
else {
  SUFFIX_STR = $${RELEASE_SUFFIX}
  PREFIX_STR = $${RELEASE_PREFIX}
}

SHARED_DIR = ../macsCommon
LIB_DIR =
#LIB_DIR = ../lib
DESTDIR = ../bin$${SUFFIX_STR}
# ----------PERSONAL-----------
#MATLAB_DIR = d:/Work)/MATLAB/R2012b_x86/extern/

!amd64: MATLAB_DIR = 'C:/Program Files (x86)/MATLAB/R2015b/extern/'
amd64: MATLAB_DIR = 'C:/Program Files/MATLAB/R2015b/extern/'

VCPKG_DIR = C:/Users/Irina/Desktop/pb/vcpkg
MSYS_DIR = C:/tools/msys64
# -----------------------------

PROTO_64_DIR = $${VCPKG_DIR}/installed/x64-windows
PROTO_32_DIR = $${VCPKG_DIR}/installed/x86-windows
PROTO_GCC_DIR = $${MSYS_DIR}/usr
gcc {
  PROTO_DIR = $${PROTO_GCC_DIR}
} else {
  !amd64: PROTO_DIR = $${PROTO_32_DIR}
  amd64: PROTO_DIR = $${PROTO_64_DIR}
}

#INCLUDEPATH += ../inc

unix {
  DEFINES+=UNIX
  DEFINES+=LINUX
  DEFINES+=_GNU_SOURCE

#profiling:
#  CONFIG += debug
#  QMAKE_CFLAGS+=-pg
#  QMAKE_CXXFLAGS+=-pg
#  QMAKE_LFLAGS+=-pg

}

win32:!gcc {
  DEFINES += _CRT_SECURE_NO_WARNINGS
  DEFINES += WIN32_LEAN_AND_MEAN
  DEFINES += NOMINMAX

  QMAKE_CXXFLAGS += /wd4250
  QMAKE_CXXFLAGS += /Fd$(IntDir)
  QMAKE_CXXFLAGS += /D__STDC_LIMIT_MACROS

  #enable SSE2
  #QMAKE_CXXFLAGS += /arch:SSE2

  #use multithread (non-debug) dll runtime
  #QMAKE_CXXFLAGS_DEBUG += /MD

  #enable debugging in release build
  #QMAKE_CXXFLAGS_RELEASE += /Zi
  #QMAKE_LFLAGS_RELEASE += /DEBUG
  QMAKE_CXX_FLAGS += /MP
}else {
  QMAKE_CXXFLAGS += -Wno-unused-parameter -Wno-format
}




