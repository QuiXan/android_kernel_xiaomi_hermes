#!/bin/bash

if [ -d include/config ];
then
    echo "Find config,will remove it"
	rm -rf include/config
else
	echo "No Config,good."
fi


echo " "
echo "***Setting environment...***"
# 交叉编译器路径
export PATH=$PATH:$(pwd)/aarch64-linux-android-4.9/bin
export CROSS_COMPILE=aarch64-linux-android-

export GCC_COLORS=auto
export ARCH=arm64
if [ ! -d "out" ];
then
	mkdir out
fi

# 提示用户选择选项
echo "请选择一个选项："
echo "1. 设置defconfig参数为 defconfig"
echo "2. 设置defconfig参数为 hermes_defconfig"
echo "3. 设置defconfig参数为 hermes_n_defconfig"
echo "4. 设置defconfig参数为 hermes_d_defconfig"
echo "请输入数字"

read choice

case $choice in
  1)
    defconfig="defconfig"
    ;;
  2)
    defconfig="hermes_defconfig"
    ;;
  3)
    defconfig="hermes_n_defconfig"
    ;;
  4)
    defconfig="hermes_d_defconfig"
    ;;
  *)
    echo "无效的选项"
    exit 1
    ;;
esac

make ARCH=arm64 O=out ${defconfig}
make ARCH=arm64 O=out -j64 2>&1 | tee build_kernel.log
