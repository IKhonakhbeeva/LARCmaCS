#define path to directories with protobuf headers and libs

equals(COMPILER_ARCH,"MINGW32")|equals(COMPILER_ARCH,"MINGW64"){
  PROTO_DIR = $${MSYS_DIR}/usr
  LIBS += -lprotobuf
  PROTOC_DIR =
}
equals(COMPILER_ARCH,"MSVC32"): PROTO_DIR = $${VCPKG_DIR}/installed/x86-windows
equals(COMPILER_ARCH,"MSVC64"): PROTO_DIR = $${VCPKG_DIR}/installed/x64-windows
equals(COMPILER_ARCH,"MSVC32")|equals(COMPILER_ARCH,"MSVC64"){
  LIBS += -L$${PROTO_DIR}/$${PREFIX_STR}lib/ -llibprotobuf$${SUFFIX_STR}
  PROTOC_DIR = $${PROTO_DIR}/tools/protobuf/
}

INCLUDEPATH += $${PROTO_DIR}/include

#Check if 'protoc' is available
PROTOC_VER = $$system($${PROTOC_DIR}protoc --version)
equals(PROTOC_VER,"") {
  error(Is the google protocol buffer compiler 'protoc' installed?)
}

#build the protocol buffer code
#message(Compiling Protocol Buffer CPP Sources from .proto Files...)
LIST = $$system(dir /B proto\*.proto)
for(item, LIST) {
  $$system($${PROTOC_DIR}protoc.exe --cpp_out=$$PWD --proto_path=$$PWD/proto $${item}))
}



#messages defined through google protocol buffers (as compiled by protoc)
LIST = $$system(dir /B *.pb.cc)
for(item, LIST) {
  SOURCES += $${PWD}/$${item}
}

LIST = $$system(dir /B *.pb.h)
for(item, LIST) {
  HEADERS += $${PWD}/$${item}
}
