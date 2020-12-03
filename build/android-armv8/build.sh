#! /bin/bash

if [ -z $NDK ]; then
    echo "ERROR: \$NDK must be set to the path to the Android NDK."
    exit 1
fi

echo Using NDK at $NDK.

NDK_MAKE=$NDK/prebuilt/windows-x86_64/bin/make.exe

FFTS_CMAKE_BUILD_TYPE=Release
if [[ "$FFTS_BUILD_DEBUG" == "true" ]]; then
    FFTS_CMAKE_BUILD_TYPE=Debug
fi

FFTS_ENABLE_STATIC=TRUE
FFTS_ENABLE_SHARED=FALSE
FFTS_TARGET=ffts_static
if [[ "$FFTS_BUILD_SHARED" == "true" ]]; then
    FFTS_ENABLE_STATIC=FALSE
    FFTS_ENABLE_SHARED=TRUE
    FFTS_TARGET=ffts_shared
fi

cmake \
    -G "Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=$FFTS_CMAKE_BUILD_TYPE \
    -DCMAKE_MAKE_PROGRAM=$NDK_MAKE \
    -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=arm64-v8a \
    -DANDROID_PLATFORM=21 \
    -DANDROID_STL=c++_static \
    -DDISABLE_DYNAMIC_CODE=TRUE \
    -DENABLE_VFP=FALSE \
    -DENABLE_NEON=FALSE \
    -DENABLE_STATIC=$FFTS_ENABLE_STATIC \
    -DENABLE_SHARED=$FFTS_ENABLE_SHARED \
    ../..

$NDK_MAKE $FFTS_TARGET
