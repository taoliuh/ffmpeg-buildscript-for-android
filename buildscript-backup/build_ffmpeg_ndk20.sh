#!/bin/bash
NDK=/Users/$USER/android-ndk-r20b
TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/darwin-x86_64
API=19

function build_android
{
    echo "Compiling FFmpeg for $CPU"
    ./configure \
    --prefix=$PREFIX \
	--cross-prefix=$CROSS_PREFIX \
    --target-os=android \
    --arch=$ARCH \
    --cpu=$CPU \
    --cc=$CC \
    --cxx=$CXX \
    --enable-cross-compile \
    --sysroot=$SYSROOT \
    --extra-cflags="-Os -fpic $OPTIMIZE_CFLAGS" \
    --enable-cross-compile \
	--disable-runtime-cpudetect \
	--disable-asm \
	--enable-gpl \
	--enable-shared \
	--disable-static \
	--enable-version3 \
	--enable-pthreads \
	--enable-small \
	--disable-iconv \
	--disable-encoders \
	--enable-neon \
	--enable-yasm \
	--enable-encoder=mjpeg \
	--enable-encoder=png \
	--enable-nonfree \
	--enable-muxers \
	--enable-muxer=mov \
	--enable-muxer=mp4 \
	--enable-muxer=h264 \
	--enable-muxer=avi \
	--disable-decoders \
	--enable-decoder=aac \
	--enable-decoder=aac_latm \
	--enable-decoder=h264 \
	--enable-decoder=mpeg4 \
	--enable-decoder=mjpeg \
	--enable-decoder=png \
	--disable-demuxers \
	--enable-demuxer=image2 \
	--enable-demuxer=h264 \
	--enable-demuxer=aac \
	--enable-demuxer=avi \
	--enable-demuxer=mpc \
	--enable-demuxer=mov \
	--enable-demuxer=mpegts \
	--disable-parsers \
	--enable-parser=aac \
	--enable-parser=ac3 \
	--enable-parser=h264 \
	--enable-protocols \
	--enable-zlib \
	--enable-avfilter \
	--disable-outdevs \
	--disable-ffprobe \
	--disable-ffplay \
	--disable-ffmpeg \
	--disable-debug \
	--disable-ffprobe \
	--disable-ffplay \
	--disable-ffmpeg \
	--disable-postproc \
	--disable-avdevice \
	--disable-symver \
	--disable-stripping \

    make clean
    make -j8
    make install

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
CC=$TOOLCHAIN/bin/armv7a-linux-androideabi$API-clang
CXX=$TOOLCHAIN/bin/armv7a-linux-androideabi$API-clang++
SYSROOT=$NDK/toolchains/llvm/prebuilt/darwin-x86_64/sysroot
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
