Installing
==========

The first step to get started with NuttX is to install a series of
required tools, a toolchain for the architecture you will be working
with and, finally, download NuttX source code itself.

Prerequisites
-------------

First, install the following set of system dependencies according to
your Operating System:

> ``` {.console}
>  sudo apt install \
>  bison flex gettext texinfo libncurses5-dev libncursesw5-dev xxd \
>  git gperf automake libtool pkg-config build-essential gperf genromfs \
>  libgmp-dev libmpc-dev libmpfr-dev libisl-dev binutils-dev libelf-dev \
>  libexpat1-dev gcc-multilib g++-multilib picocom u-boot-tools util-linux
> ```
>
> ``` {.console}
>  sudo dnf install \
>  bison flex gettext texinfo ncurses-devel ncurses ncurses-compat-libs \
>  git gperf automake libtool pkgconfig @development-tools gperf genromfs \
>  gmp-devel mpfr-devel libmpc-devel isl-devel binutils-devel elfutils-libelf-devel \
>  expat-devel gcc-c++ g++ picocom uboot-tools util-linux
> ```
>
> ``` {.console}
>  brew tap discoteq/discoteq
>  brew install flock
>  brew install x86_64-elf-gcc  # Used by simulator
>  brew install u-boot-tools  # Some platform integrate with u-boot
> ```
>
> that installation guide for Linux. This has been verified against the
> Ubuntu 18.04 version.
>
> There may be complications interacting with programming tools over
> USB. Recently support for USBIP was added to WSL 2 which has been used
> with the STM32 platform, but it is not trivial to configure:
> <https://learn.microsoft.com/en-us/windows/wsl/connect-usb>
>
> installation in addition to these packages:
>
>     make              bison             libmpc-devel
>     gcc-core          byacc             automake-1.15
>     gcc-g++           gperf             libncurses-devel
>     flex              gdb               libmpfr-devel
>     git               unzip             zlib-devel

### KConfig frontend

NuttX configuration system uses
[KConfig](https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.txt)
which is exposed via a series of interactive menu-based *frontends*,
part of the `kconfig-frontends` package. Depending on your OS you may
use a precompiled package or you will have to build it from source,
which is available in the [NuttX tools
repository](https://bitbucket.org/nuttx/tools/src/master/kconfig-frontends/):

> \ cd tools/kconfig-frontends \ ./configure \--enable-mconf
> \--disable-nconf \--disable-gconf \--disable-qconf \ make \ make
> install
>
> \ cd tools/kconfig-frontends \ ./configure \--enable-mconf
> \--disable-nconf \--disable-gconf \--disable-qconf \ aclocal \
> automake \ make \ sudo make install
>
> \ cd tools/kconfig-frontends \ patch \< ../kconfig-macos.diff -p 1
> \ ./configure \--enable-mconf \--disable-shared \--enable-static
> \--disable-gconf \--disable-qconf \--disable-nconf \ make \ sudo
> make install

NuttX also supports
[kconfiglib](https://github.com/ulfalizer/Kconfiglib) by default, which
is a Kconfig tool implemented in Python 2/3. Compared with
`kconfig-frontends`, kconfiglib provides NuttX with the possibility of
multi-platform support(configure NuttX in Windows native/Visual Studio),
and also `kconfiglib` has a stronger Kconfig syntax check, this will
help developers to avoid some Kconfig syntax errors. Install kconfiglib
via following command:

``` {.shell}
sudo apt install python3-kconfiglib
```

If you are a working on Windows, which also need the support of
windows-curses:

``` {.shell}
pip install windows-curses
```

Toolchain
---------

To build Apache NuttX you need the appropriate toolchain according to
your target platform. Some Operating Systems such as Linux distribute
toolchains for various architectures. This is usually an easy choice
however you should be aware that in some cases the version offered by
your OS may have problems and it may be better to use a widely used
build from another source.

The following example shows how to install a toolchain for ARM
architecture:

> ``` {.console}
>  brew install --cask gcc-arm-embedded
> ```
>
> For 64 bit ARM targets, such as Allwinner A64:
>
> ``` {.console}
>  brew install --cask gcc-aarch64-embedded
> ```
>
> ``` {.console}
>  usermod -a -G users USER
>  # get a login shell that knows we're in this group:
>  su - USER
>  sudo mkdir /opt/gcc
>  sudo chgrp -R users /opt/gcc
>  sudo chmod -R u+rw /opt/gcc
>  cd /opt/gcc
> ```
>
> Download and extract toolchain:
>
> ``` {.console}
>  HOST_PLATFORM=x86_64-linux   # use 'aarch64-linux' for ARM64 Linux, or 'mac' for Intel macOS
>  # For Windows there is a zip instead (gcc-arm-none-eabi-10.3-2021.10-win32.zip)
>  curl -L -O https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-{HOST_PLATFORM}.tar.bz2
>  tar xf gcc-arm-none-eabi-10.3-2021.10-{HOST_PLATFORM}.tar.bz2
> ```
>
> Add the toolchain to your \`PATH\`:
>
> ``` {.console}
>  echo "export PATH=/opt/gcc/gcc-arm-none-eabi-10.3-2021.10/bin:PATH" >> ~/.bashrc
> ```
>
> You can edit your shell\'s rc files if you don\'t use bash.

Tip

There are hints on how to get the latest tool chains for most supported
architectures in the Apache NuttX CI helper
[script](https://github.com/apache/nuttx/tree/master/tools/ci/cibuild.sh)
and Docker
[container](https://github.com/apache/nuttx/tree/master/tools/ci/docker/linux/Dockerfile)

Required toolchain should be part of each arch documentation (see
[relevant issue](https://github.com/apache/nuttx/issues/2409)).

Download NuttX
--------------

Apache NuttX is actively developed on GitHub. There are two main
repositories, [nuttx](https://github.com/apache/nuttx) and
[apps](https://github.com/apache/nuttx-apps), where the latter is
technically optional (but recommended for complete set of features). If
you intend to contribute changes, you need the absolute latest version
or you simply prefer to work using git, you should clone these
repositories (recommended). Otherwise you can choose to download any
[stable release](https://nuttx.apache.org/download/) archive.

> \ mkdir nuttxspace \ cd nuttxspace \ git clone
> <https://github.com/apache/nuttx.git> nuttx \ git clone
> <https://github.com/apache/nuttx-apps> apps
>
> The development source code is also available as a compressed archive,
> should you need it:
>
> ``` {.console}
> ```
>
> \ mkdir nuttxspace \ cd nuttxspace \ curl -L
> <https://github.com/apache/nuttx/tarball/master> -o nuttx.tar.gz \
> curl -L <https://github.com/apache/nuttx-apps/tarball/master> -o
> apps.tar.gz \ tar zxf nuttx.tar.gz \--one-top-level=nuttx
> \--strip-components 1 \ tar zxf apps.tar.gz \--one-top-level=apps
> \--strip-components 1
>
> There are also `.zip` archives available (useful for Windows users):
> just replace `tarball` with `zipball`.
>
> example uses version 12.2.1:
>
> ``` {.console}
> ```
>
> \ mkdir nuttxspace \ cd nuttxspace \ curl -L
> <https://www.apache.org/dyn/closer.lua/nuttx/12.2.1/apache-nuttx-12.2.1.tar.gz?action=download>
> -o nuttx.tar.gz \ curl -L
> <https://www.apache.org/dyn/closer.lua/nuttx/12.2.1/apache-nuttx-apps-12.2.1.tar.gz?action=download>
> -o apps.tar.gz \ tar zxf nuttx.tar.gz \ tar zxf apps.tar.gz
