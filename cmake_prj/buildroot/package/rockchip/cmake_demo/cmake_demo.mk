#ifeq ($(BR2_PACKAGE_CMAKE_DEMO), y)

CMAKE_DEMO_VERSION:=1.0.0
CMAKE_DEMO_SITE=$(TOPDIR)/../external/cmake_demo
CMAKE_DEMO_SITE_METHOD=local
CMAKE_DEMO_INSTALL_STAGING = YES

$(eval $(cmake-package))
#endif
