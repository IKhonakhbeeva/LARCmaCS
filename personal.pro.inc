# ----------PERSONAL-----------
#!amd64: MATLAB_DIR = 'C:/Program Files (x86)/MATLAB/R2015b/extern/'
#amd64: MATLAB_DIR = 'C:/Program Files/MATLAB/R2015b/extern/'

#VCPKG_DIR = 'C:/vcpkg'
#MSYS_DIR = 'C:/tools/msys64'
# -----------------------------


equals(COMPILER_ARCH,"MSVC32")|equals(COMPILER_ARCH,"MSVC64"){
  isEmpty(VCPKG_DIR): error("To use MSVC, you need to specify the path to VCPKG_DIR!")
}
equals(COMPILER_ARCH,"MINGW32")|equals(COMPILER_ARCH,"MINGW64"){
  isEmpty(MSYS_DIR): error("To use MINGW, you need to specify the path to MSYS_DIR!")
}
isEmpty(MATLAB_DIR): error("You need to specify the path to MATLAB_DIR!")

