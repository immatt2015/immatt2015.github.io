---
title: "X86 lede 固件编译"
date: 2021-02-12T15:14:30+08:00
draft: true
---
```
sudo apt update
sudo apt install build-essential ccache ecj fastjar file g++ gawk gettext git java-propose-classpath libelf-dev libncurses5-dev libncursesw5-dev libssl-dev python python2.7-dev python3 unzip wget python3-distutils python3-setuptools python3-dev rsync subversion swig time xsltproc zlib1g-dev upx curl -y

sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3 python2.7 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib antlr3 gperf wget curl swig rsync




git clone https://github.com/openwrt/openwrt.git
git pull
cd openwrt 
cp /usr/bin/upx* staging_dir/host/bin/;
./scripts/feeds update -a
./scripts/feeds install -a

## ipv6 支持。extra Library > ipv6helper

## 修改 target image > Kernel partition size
## 添加依赖 添加  kmod-e1000e(network device)   kmod-usb3(usb support)  kmod-ifb(network devices)
## 可以使用 lxc 作为容器 不好用
## Library >> libustream-*** ***-openssl/***-wolfssl 选其一

## 添加 Base system >> block-mount
## 添加 Utilities >> Filesystem >>  badblocks
## 'kmod-crypto-user=y', *(crypt api module)
## 'kmod-cryptodev=y', *(crypt api module)
## 'kmod-macvlan=y', *(network devices)
## 'kmod-usb-storage-extras=y', *(usb support)
## 'kmod-usb-storage-uas=y' *(usb support)
## 'kmod-fs-antfs=y', *(Filesystem)
## 'kmod-fs-exfat=y', *(Filesystem)
## 'kmod-lib-textsearch=y', * (library)
## 'kmod-nf-nathelper=y', *
kmod-nf-nat6
## 'kmod-nf-nathelper-extra=y', *(netfilters)
## 'kmod-mppe=y', * (network support komd-ppp>)
## 'kmod-fast-classifier=y', 与 lean/shortcut-fe lean/fast-classifier 冲突 *
mkdir -p staging_dir/host/bin/;
cp /usr/bin/upx* staging_dir/host/bin/;

pushd package/
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean
rm -rf lean/autosamba
rm -rf lean/shortcut-fe lean/fast-classifier lean/luci-app-sfe


mkdir -p openwrt-packages

pushd openwrt-packages

svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-ssr-plus
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-gost
svn co https://github.com/kenzok8/openwrt-packages/trunk/gost
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-smartdns


git clone https://github.com/xiaorouji/openwrt-passwall.git
popd

git clone https://github.com/immortalwrt/openwrt-gowebdav
git clone https://github.com/kenzok8/openwrt-packages kenzok8
git clone https://github.com/kenzok8/small
popd
https://lhy.life/20200531-openwrt+openclash/ 添加 clash

## end

make menuconfig
clear && make download -j8 V=sc && clear &&  make -j8 V=sc



##
## 创建分区
## 可以使用 fdisk 来创建分区，不过这里选择更直观的 cfdisk，记得先 opkg update && opkg install cfdisk 安装一下。很明显看出有剩余28.5G 的空间没有分配。
## 选中剩余空间，依次点击 New - Primary - Write - yes - Quit完成分区划分。此时再执行 fdisk -l 可以看到新分区了：

##
## wireguard 使用 通过 接口创建一个新的interface
##
##
```
