#! /bin/bash

if [ -z $NDK ]; then
    echo "ERROR: \$NDK must be set to the path to the Android NDK."
    exit 1
fi

echo Using NDK at $NDK.

NDK_MAKE=$NDK/prebuilt/windows-x86_64/bin/make.exe

cmake \
    -G "Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_MAKE_PROGRAM=$NDK_MAKE \
    -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=armeabi-v7a \
    -DANDROID_ARM_MODE=arm \
    -DANDROID_ARM_NEON=TRUE \
    -DANDROID_PLATFORM=16 \
    -DANDROID_STL=c++_static \
    -DDISABLE_DYNAMIC_CODE=FALSE \
    -DENABLE_VFP=FALSE \
    -DENABLE_NEON=TRUE \
    -DENABLE_STATIC=TRUE \
    ../..

$NDK_MAKE ffts_static
