#!/bin/bash
NDK=/Users/$USER/android-ndk-r16b
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
API=19
SYSROOT=$NDK/platforms/android-$API/arch-arm/


function build_android
{
    echo "Compiling FFmpeg for $CPU"
    ./configure \
    --prefix=$PREFIX \
    --disable-hwaccels \
    --disable-gpl \
    --disable-postproc \
    --enable-jni \
    --disable-doc \
    --disable-htmlpages \
    --disable-manpages \
    --disable-podpages \
    --disable-txtpages \
    --disable-ffplay \
    --disable-ffprobe \
    --disable-avdevice \
    --disable-doc \
    --disable-symver \
    --disable-iconv \
    --disable-x86asm \
    --cc=$TOOLCHAIN/bin/arm-linux-androideabi-gcc \
    --cross-prefix=$CROSS_PREFIX \
    --target-os=android \
    --arch=$ARCH \
    --cpu=$CPU \
    --enable-cross-compile \
    --sysroot=$SYSROOT \
    --extra-cflags="-Os -fpic $OPTIMIZE_CFLAGS" \
    --extra-ldflags="$ADDI_LDFLAGS" \
    $ADDITIONAL_CONFIGURE_FLAG

    make clean
    make -j8
    make install

    $TOOLCHAIN/bin/arm-linux-androideabi-ld \
    -rpath-link=$SYSROOT/usr/lib \
    -L$SYSROOT/usr/lib \
    -soname libffmpeg.so \
    -shared -nostdlib  \
    -Bsymbolic \
    --whole-archive --no-undefined \
    -o $PREFIX/libffmpeg.so \
    $PREFIX/lib/libavcodec.a \
    $PREFIX/lib/libavfilter.a \
    $PREFIX/lib/libswresample.a \
    $PREFIX/lib/libavformat.a \
    $PREFIX/lib/libavutil.a \
    $PREFIX/lib/libswscale.a \
    -lc -lm -lz -ldl -llog \
    $TOOLCHAIN/lib/gcc/arm-linux-androideabi/4.9.x/libgcc.a

    $TOOLCHAIN/bin/arm-linux-androideabi-strip --strip-unneeded $PREFIX/libffmpeg.so

    echo "The Compilation of FFmpeg for $CPU is completed"
}

# #armv8-a
# ARCH=arm64
# CPU=armv8-a
# CC=$TOOLCHAIN/bin/aarch64-linux-android$API-clang
# CXX=$TOOLCHAIN/bin/aarch64-linux-android$API-clang++
# SYSROOT=$NDK/toolchains/llvm/prebuilt/darwin-x86_64/sysroot
# CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android-
# PREFIX=$(pwd)/android/$CPU
# OPTIMIZE_CFLAGS="-march=$CPU"
# build_android

#armv7-a
ARCH=arm
CPU=armv7-a
CROSS_PREFIX=$TOOLCHAIN/bin/arm-linux-androideabi-
PREFIX=$(pwd)/android/$CPU
OPTIMIZE_CFLAGS="-mfloat-abi=softfp -mfpu=vfp -marm -march=$CPU "
build_android

# #x86
# ARCH=x86
# CPU=x86
# CC=$TOOLCHAIN/bin/i686-linux-android$API-clang
# CXX=$TOOLCHAIN/bin/i686-linux-android$API-clang++
# SYSROOT=$NDK/toolchains/llvm/prebuilt/darwin-x86_64/sysroot
# CROSS_PREFIX=$TOOLCHAIN/bin/i686-linux-android-
# PREFIX=$(pwd)/android/$CPU
# OPTIMIZE_CFLAGS="-march=i686 -mtune=intel -mssse3 -mfpmath=sse -m32"
# build_android

# #x86_64
# ARCH=x86_64
# CPU=x86-64
# CC=$TOOLCHAIN/bin/x86_64-linux-android$API-clang
# CXX=$TOOLCHAIN/bin/x86_64-linux-android$API-clang++
# SYSROOT=$NDK/toolchains/llvm/prebuilt/darwin-x86_64/sysroot
# CROSS_PREFIX=$TOOLCHAIN/bin/x86_64-linux-android-
# PREFIX=$(pwd)/android/$CPU
# OPTIMIZE_CFLAGS="-march=$CPU -msse4.2 -mpopcnt -m64 -mtune=intel"
# build_android
