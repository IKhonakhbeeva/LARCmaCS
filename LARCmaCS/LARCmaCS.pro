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

gcc {
  #add google protocol buffers
  LIBS += -lprotobuf

  win32:LIBS += -lws2_32
  unix { #add opengl support
  LIBS += -lGL -lGLU
 }
}

include(../macsCommon/macsCommon.pri)

win32 {
  !gcc {
  #add libs
  LIBS += -L$$PWD/../larcmacs-protobuf/lib_x86/ -llibprotobuf$${SUFFIX_STR}
  }

  LIBS += -L$${MATLAB_DIR}/lib/win32/microsoft/ -llibeng \
          -L$${MATLAB_DIR}/lib/win32/microsoft/ -llibmat \
          -L$${MATLAB_DIR}/lib/win32/microsoft/ -llibmx


}

QT       += core gui
QT       += network

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = LARCmaCS
TEMPLATE = app


#directories of sources of the vision client

INCLUDEPATH += \
  $${SHARED_DIR}/net \
  $${PROTO_DIR}/generated \
  $${SHARED_DIR}/util \
  $${SHARED_DIR}/rfprotocol \
  $${MATLAB_DIR}/include \
  $${SHARED_DIR}/vartypes

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
  LIST = $$system(dir /B ..\\larcmacs-protobuf\\generated\\*.pb.cc)
  for(item, LIST) {
    SOURCES += $${PROTO_DIR}/generated/$${item}
  }

  LIST = $$system(dir /B ..\\larcmacs-protobuf\\generated\\*.pb.h)
  for(item, LIST) {
    HEADERS += $${PROTO_DIR}/generated/$${item}
  }

FORMS    += larcmacs.ui \
    remotecontrol.ui \
    ipdialog.ui \
    reference.ui \
