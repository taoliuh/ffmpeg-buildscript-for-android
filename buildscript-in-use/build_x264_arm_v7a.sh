NDK=/Users/$USER/android-ndk-r14b

PLATFORM=$NDK/platforms/android-14/arch-arm
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
PREFIX=./android/arm-v7a

function build_android
{
	./configure \
	--prefix=$PREFIX \
	--disable-shared \
	--enable-static \
	--disable-asm \
	--enable-pic \
	--enable-strip \
	--host=arm-linux \
	--cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
	--sysroot=$PLATFORM \
	--extra-cflags="-Os -fpic" \
	--extra-ldflags="" 

	make clean
	make -j16
	make install
}
build_android
