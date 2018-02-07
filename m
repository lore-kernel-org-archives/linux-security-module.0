From: lkp@intel.com (kbuild test robot)
Date: Thu, 8 Feb 2018 04:25:59 +0800
Subject: [PATCH 2/6] genalloc: selftest
In-Reply-To: <20180204164732.28241-3-igor.stoppa@huawei.com>
References: <20180204164732.28241-3-igor.stoppa@huawei.com>
Message-ID: <201802080423.jTtuTsUK%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kees/for-next/pstore]
[also build test ERROR on v4.15 next-20180207]
[cannot apply to linus/master mmotm/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/mm-security-ro-protection-for-dynamic-data/20180207-171252
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
config: xtensa-allyesconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

>> lib/genalloc-selftest.c:17:10: fatal error: asm/set_memory.h: No such file or directory
    #include <asm/set_memory.h>
             ^~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +17 lib/genalloc-selftest.c

  > 17	#include <asm/set_memory.h>
    18	#include <linux/string.h>
    19	#include <linux/debugfs.h>
    20	#include <linux/atomic.h>
    21	#include <linux/genalloc.h>
    22	
    23	
    24	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
