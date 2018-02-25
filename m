From: lkp@intel.com (kbuild test robot)
Date: Sun, 25 Feb 2018 11:37:43 +0800
Subject: [PATCH 1/7] genalloc: track beginning of allocations
In-Reply-To: <20180223144807.1180-2-igor.stoppa@huawei.com>
References: <20180223144807.1180-2-igor.stoppa@huawei.com>
Message-ID: <201802251109.AbnWVLJr%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc2 next-20180223]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/genalloc-track-beginning-of-allocations/20180225-081601
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

Note: the linux-review/Igor-Stoppa/genalloc-track-beginning-of-allocations/20180225-081601 HEAD 9c42e8278ff35263f8381461592f6737e4b7b129 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> ERROR: "gen_pool_best_fit" [drivers/tee/tee.ko] undefined!
   ERROR: "ia64_delay_loop" [drivers/spi/spi-thunderx.ko] undefined!
   ERROR: "ia64_delay_loop" [drivers/net/phy/mdio-cavium.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
