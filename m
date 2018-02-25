From: lkp@intel.com (kbuild test robot)
Date: Sun, 25 Feb 2018 10:33:21 +0800
Subject: [PATCH 4/7] Protectable Memory
In-Reply-To: <20180223144807.1180-5-igor.stoppa@huawei.com>
References: <20180223144807.1180-5-igor.stoppa@huawei.com>
Message-ID: <201802251005.338ZhiMt%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc2]
[cannot apply to next-20180223]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/genalloc-track-beginning-of-allocations/20180225-081601
config: arm-allnoconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   mm/pmalloc.o: In function `pmalloc_prealloc':
>> pmalloc.c:(.text+0x280): undefined reference to `vfree_atomic'
   mm/pmalloc.o: In function `pmalloc':
   pmalloc.c:(.text+0x2c4): undefined reference to `vfree_atomic'
   mm/pmalloc.o: In function `pmalloc_chunk_free':
   pmalloc.c:(.text+0x9e): undefined reference to `vfree_atomic'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
