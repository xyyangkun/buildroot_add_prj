参考
https://www.cnblogs.com/qmjc/p/13898498.html

# 1. 建立cmake 功能项目

在external 目录下建立cmake_demo目录

新建文件main.cpp
``
#include <stdio.h>
int main(int argc, char const *argv[])
{
    printf("Hello word!\n");
    return 0;
}
```

新建cmake项目文件CMakeLists.txt
```
cmake_minimum_required(VERSION 3.1.0)
set(CMAKE_CXX_STANDARD 11)

project(cmake_demo)

set(SOURCES main.cpp)

add_executable(${PROJECT_NAME} ${SOURCES})

install(TARGETS cmake_demo DESTINATION bin)

```

# 2. 添加buildroot 配置, 这一步做完make menuconfig 可以看到buildroot中添加的配置了
进入buildroot/package/rockchip目录
在buildroot/package/rockchip/Config.in文件中添加:
```
source "package/rockchip/cmake_demo/Config.in"
```

在buildroot/package/rockchip目录下新建目录：cmake_demo
在cmake_demo目录下新建文件cmake_demo.mk
```
CMAKE_DEMO_VERSION:=1.0.0
CMAKE_DEMO_SITE=$(TOPDIR)/../external/cmake_demo
CMAKE_DEMO_SITE_METHOD=local
CMAKE_DEMO_INSTALL_STAGING = YES

$(eval $(cmake-package))
```

在cmake_demo目录下新建配置文件Config.in
```
config BR2_PACKAGE_CMAKE_DEMO
	bool "test cmake demo "
	help
		This is a deme to cmake project
```

# 3. 使buildroot 配置生效
在buildroot/configs/rockchip_rk3568_defconfig 文件最后添加：
```
BR2_PACKAGE_CMAKE_DEMO=y
```

在根目录下运行以下命令，可见cmake_demo项目已经可以正常编译并且安装可执行文件到文件系统
```
make cmake_demo-dirclean
make cmake_demo
```
