#!/bin/bash

WORKSPACE=$(pwd)/output

rm -rf */build

export CMAKE_PREFIX_PATH=${WORKSPACE}/usr

mkdir -p liba/build
pushd liba/build
cmake .. -DCMAKE_INSTALL_PREFIX=${WORKSPACE}/usr
make
make install
popd

mkdir -p libb/build
pushd libb/build
cmake .. -DCMAKE_INSTALL_PREFIX=${WORKSPACE}/usr
make
make install
popd

#mkdir -p libc/build
#pushd libc/build
#cmake .. -DCMAKE_INSTALL_PREFIX=${WORKSPACE}/usr
#make
#make install
#popd

mkdir -p exec/build
pushd exec/build
cmake ..
make clean
make VERBOSE=1
popd