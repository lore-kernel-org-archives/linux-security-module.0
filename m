From: lkp@intel.com (kbuild test robot)
Date: Tue, 13 Feb 2018 10:43:27 +0800
Subject: [PATCH 5/6] Pmalloc: self-test
In-Reply-To: <20180211031920.3424-6-igor.stoppa@huawei.com>
References: <20180211031920.3424-6-igor.stoppa@huawei.com>
Message-ID: <201802131011.XACTqdLh%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc1 next-20180212]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/genalloc-track-beginning-of-allocations/20180212-192839
config: arm-allnoconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   mm/pmalloc.o: In function `pmalloc_prealloc':
>> pmalloc.c:(.text+0x268): undefined reference to `vfree_atomic'
   mm/pmalloc.o: In function `pmalloc':
   pmalloc.c:(.text+0x2ac): undefined reference to `vfree_atomic'
   mm/pmalloc.o: In function `pmalloc_chunk_free':
   pmalloc.c:(.text+0x86): undefined reference to `vfree_atomic'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
