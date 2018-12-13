#define path to directories with protobuf headers and libs
PROTO_64_DIR = $${VCPKG_DIR}/installed/x64-windows
PROTO_32_DIR = $${VCPKG_DIR}/installed/x86-windows
PROTO_GCC_DIR = $${MSYS_DIR}/usr
#gcc {
  PROTO_DIR = $${PROTO_GCC_DIR}
#} else {
#  !amd64: PROTO_DIR = $${PROTO_32_DIR}
#  amd64: PROTO_DIR = $${PROTO_64_DIR}
#}
#gcc:
LIBS += -L$${MSYS_DIR}/mingw$${BIT}/lib/ -lprotobuf.dll
#!gcc: LIBS += -L$${PROTO_DIR}/$${PREFIX_STR}lib/ -llibprotobuf$${SUFFIX_STR}

INCLUDEPATH += $${PROTO_DIR}/include

PROTOC_DIR = $${MSYS_DIR}/mingw$${BIT}/bin/

#build the protocol buffer code
#message(Compiling Protocol Buffer CPP Sources from .proto Files...)
LIST = $$system(dir /B proto\*.proto)
for(item, LIST) {
  message ($${PROTOC_DIR}protoc.exe)
  PROTO_ERR+=$$system($${PROTOC_DIR}protoc.exe --cpp_out=$$PWD --proto_path=$$PWD/proto $${item})
  message ($$PROTO_ERR)
}
!isEmpty(PROTO_ERR) {
  error(Failure building proto-buffer sources. Is the google protocol buffer compiler 'protoc' installed?)
}

#messages defined through google protocol buffers (as compiled by protoc)
LIST = $$system(dir /B *.pb.cc)
for(item, LIST) {
  SOURCES += $$PWD/$${item}
}

LIST = $$system(dir /B *.pb.h)
for(item, LIST) {
  HEADERS += $$PWD/$${item}
}
