# 编译ffmpeg, fdk-aac, x264
## 1. 准备工作
下载ffmpeg,fdk-aac,x264源码

1)ffmpeg:
https://www.ffmpeg.org/releases/ffmpeg-3.4.7.tar.bz2

2)fdk-aac:
https://github.com/mstorsjo/fdk-aac/archive/v0.1.6.tar.gz

3)x264
https://code.videolan.org/videolan/x264/-/archive/master/x264-master.tar.bz2

ndk版本号为14b

我在编译的过程中，先后用ndk 20b编译成功过4.2.2版本的ffmpeg, 但是编译x264报错。编译过程中出现过许多问题，有较高版本的ndk无法编译较低版本的ffmpeg, 有较低版本的ndk无法编译较高版本的ffmpeg或者x264. 所以不再折腾，认准上面的NDK版本和其它软件的版本肯定能编译通过。

## 2. 编译x264
解压并拷贝build_x264_arm_v7a.sh文件到x264源码目录。

$ chmod a+x build_x264_arm_v7a.sh

$ ./build_x264_arm_v7a.sh
生成产出到android目录

## 3. 编译fdk-aac
由于没有configure文件，需要运行autogen.sh生成。你可能需要安装automake软件：

$ brew install automake libtool

$ ./autogen.sh

生成configure文件后执行，

$ ./build_fdk_aac_arm_v7a.sh

生成产出到android目录

使用高于0.1.6版本的fdk-aac软件虽然编译产出了，但是集成ffmpeg会找不到对应头文件导致打包失败。请注意。

## 4. 编译ffmpeg
1)如果只想编译一个ffmpeg产出，使用build_ffmpeg_arm_v7a_clean.sh编译脚本

$ chmod a+x build_ffmpeg_arm_v7a_clean.sh

$ ./build_ffmpeg_arm_v7a_clean.sh

生成产出到android目录

2)如果要编译一个支持fdk-aac及x264的ffmpeg产出，使用build_ffmpeg_arm_v7a.sh编译脚本
首先将编译成功的libx264和fdk-aac-2.0.0文件夹移入到ffmpeg-3.4.7目录中，接着执行

$ chmod a+x build_ffmpeg_arm_v7a.sh

$ ./build_ffmpeg_arm_v7a.sh

生成产出到android目录

# 5. 其它
附带ndk 20b编译ffmpeg的脚本及ffmpeg,fdk-aac,x264源码包。
ffmpeg-3.4.7包含已编译完成的so库。
