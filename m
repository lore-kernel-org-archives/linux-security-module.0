From: lkp@intel.com (kbuild test robot)
Date: Tue, 13 Feb 2018 08:43:20 +0800
Subject: [PATCH 1/6] genalloc: track beginning of allocations
In-Reply-To: <20180211031920.3424-2-igor.stoppa@huawei.com>
References: <20180211031920.3424-2-igor.stoppa@huawei.com>
Message-ID: <201802130849.K85nqOtM%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc1 next-20180212]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/genalloc-track-beginning-of-allocations/20180212-192839
config: openrisc-allmodconfig (attached as .config)
compiler: or1k-linux-gcc (GCC) 6.0.0 20160327 (experimental)
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All errors (new ones prefixed by >>):

   WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/mtk-vcodec/mtk-vcodec-common.o
   see include/linux/module.h for more information
   WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/tegra-cec/tegra_cec.o
   see include/linux/module.h for more information
>> ERROR: "gen_pool_best_fit" [drivers/tee/tee.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
