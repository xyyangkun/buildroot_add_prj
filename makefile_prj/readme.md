
参考：
https://zhuanlan.zhihu.com/p/451071335
https://www.cnblogs.com/qmjc/p/13898498.html

# 1. 建立makefile项目
在external目录下建立代码文件makefile_demo.c
```
#include <stdio.h>
int main()
{
	printf("buildroot helloworld\n");
	return 0;
}
```
在external 目录下建立Makefile文件,
makefile文件注意命令前面的tab或空格对齐，如果有问题，可以直接复制项目文件
```
DEPS =
OBJ = makefile_demo.o
CFLAGS =
%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

makefile_demo: $(OBJ)
	$(CXX) -o $@ $^ $(CFLAGS)

.PHONY: clean
clean:
	rm -f *.o *~ makefile_demo

.PHONY: install
install:
	cp -f makefile_demo $(TARGET_DIR)/usr/bin/

.PHONY: uninstall
uninstall:
	rm -f $(TARGET_DIR)/usr/bin/makefile_demo
```

# 2. 建立buildroot 配置文件
进入buildroot/package/rockchip 目录
添加目录makefile_demo，进入makefile_demo目录
新建Config.in文件
```
config BR2_PACKAGE_MAKEFILE_DEMO
	bool "Simple makefile project Demo"
```

新建makefile_demo.mk
```
MAKEFILE_DEMO_VERSION:=1.0.0
MAKEFILE_DEMO_SITE=$(TOPDIR)/../external/makefile_demo
MAKEFILE_DEMO_SITE_METHOD=local

define MAKEFILE_DEMO_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(MAKE) CC=$(TARGET_CC) CXX=$(TARGET_CXX) -C $(@D)
endef

define MAKEFILE_DEMO_CLEAN_CMDS
    $(TARGET_MAKE_ENV) $(MAKE) -C $(@D) clean
endef

define MAKEFILE_DEMO_INSTALL_TARGET_CMDS
    $(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install
endef

define MAKEFILE_DEMO_UNINSTALL_TARGET_CMDS
    $(TARGET_MAKE_ENV) $(MAKE) -C $(@D) uninstall
endef

$(eval $(generic-package))
```

在Config.ini文件中添加以下代码使配置添加到buildroot系统
```
source "package/rockchip/makefile_demo/Config.in"
```

# 3. 配置buildroot系统
进入buildroot/configs目录
在rockchip_rk3568_defconfig文件添加以下代码,使以上配置生效
```
BR2_PACKAGE_MAKEFILE_DEMO=y 
```

分别执行以下命令，发现可执行文件被安装
```
make makefile_demo-dirclean
make makefile_demo
```
