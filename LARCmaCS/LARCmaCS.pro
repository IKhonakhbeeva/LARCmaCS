#-------------------------------------------------
#
# Project created
#
#-------------------------------------------------

#read the global configuration file
include( ../config.pro.inc )

#where to place built objects
OBJECTS_DIR = ../build/LARCmaCS/obj$${SUFFIX_STR}

#where to place temporary moc sources
MOC_DIR = ../build/LARCmaCS/moc

#where to place auto-generated UI files
UI_DIR = ../build/LARCmaCS/ui

#where to place intermediate resource files
RCC_DIR = ../build/LARCmaCS/resources


unix {
  #add google protocol buffers
  LIBS += -lprotobuf

  LIBS += -lGL -lGLU

}

gcc: include(../macsCommon/macsCommon.pri)

win32 {
  #add libs
  LIBS += -lws2_32
#  gcc : LIB+=-lprotobuf
  gcc: LIBS += -lprotobuf.dll
  !gcc: LIBS += -L$${PROTO_DIR}/$${PREFIX_STR}lib/ -llibprotobuf$${SUFFIX_STR}
  !amd32: WIN_BIT = win32
  amd64: WIN_BIT = win64
  LIBS += -L$${MATLAB_DIR}/lib/$${WIN_BIT}/microsoft/ -llibeng \
          -L$${MATLAB_DIR}/lib/$${WIN_BIT}/microsoft/ -llibmat \
          -L$${MATLAB_DIR}/lib/$${WIN_BIT}/microsoft/ -llibmx
}

QT       += core gui
QT       += network

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = LARCmaCS
TEMPLATE = app


#directories of sources of the vision client

INCLUDEPATH += \
  $${SHARED_DIR}/net \
  ../proto-generated \
  $${SHARED_DIR}/util \
  $${SHARED_DIR}/rfprotocol \
  $${MATLAB_DIR}/include \
  $${SHARED_DIR}/vartypes
#INCLUDEPATH += $${PROTO_DIR}/include

INCLUDEPATH += $${PROTO_DIR}/include

SOURCES += main.cpp\
  $${SHARED_DIR}/net/netraw.cpp \
  $${SHARED_DIR}/net/robocup_ssl_client.cpp \

SOURCES += \
        larcmacs.cpp \
    fieldScene.cpp \
    sceneView.cpp \
    receiver.cpp \
    mainAlg.cpp \
    mlData.cpp \
    connector.cpp \
    remotecontrol.cpp \
    message.cpp \
    ipdialog.cpp \
    client.cpp \
    reference.cpp \

HEADERS  += \
  $${SHARED_DIR}/net/netraw.h \
  $${SHARED_DIR}/net/robocup_ssl_client.h \
  $${SHARED_DIR}/net/Pipe.h \
  $${SHARED_DIR}/util/timer.h \
  $${SHARED_DIR}/util/field.h \
  $${SHARED_DIR}/util/field_default_constants.h \
  $${SHARED_DIR}/rfprotocol/rfprotocol.h \
        larcmacs.h \
    fieldScene.h \
    sceneView.h \
    packetSSL.h \
    receiver.h \
    mainAlg.h \
    mlData.h \
    connector.h \
    remotecontrol.h \
    message.h \
    ipdialog.h \
    client.h \
    reference.h \

  #messages defined through google protocol buffers (as compiled by protoc)
  LIST = $$system(dir /B ..\proto-generated\*.pb.cc)
  for(item, LIST) {
    SOURCES += ../proto-generated/$${item}
  }

  LIST = $$system(dir /B ..\proto-generated\*.pb.h)
  for(item, LIST) {
    HEADERS += ../proto-generated/$${item}
  }

FORMS    += larcmacs.ui \
    remotecontrol.ui \
    ipdialog.ui \
    reference.ui \

DISTFILES +=
