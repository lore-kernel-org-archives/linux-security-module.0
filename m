From: lkp@intel.com (kbuild test robot)
Date: Tue, 27 Jun 2017 11:55:06 +0800
Subject: [PATCH 1/3] Protectable memory support
In-Reply-To: <20170626144116.27599-2-igor.stoppa@huawei.com>
Message-ID: <201706271120.I5LWa6tp%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

[auto build test WARNING on mmotm/master]
[also build test WARNING on v4.12-rc7 next-20170626]
[cannot apply to linus/master linux/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/ro-protection-for-dynamic-data/20170627-103230
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: powerpc-allyesconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All warnings (new ones prefixed by >>):

warning: (ARCH_HAS_SET_MEMORY && CPM && TEE && SGI_XP && SRAM && CAIF_VIRTIO && FSL_FMAN && MVNETA_BM && VIDEO_CODA && FB_SH_MOBILE_MERAM && INFINIBAND_CXGB3 && INFINIBAND_CXGB4 && INFINIBAND_I40IW && MMP_TDMA && UIO_PRUSS && ION && FSL_PAMU && FSL_DPAA && QUICC_ENGINE) selects GENERIC_ALLOCATOR which has unmet direct dependencies (ARCH_HAS_SET_MEMORY)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
