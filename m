From: lkp@intel.com (kbuild test robot)
Date: Mon, 30 Apr 2018 12:04:10 +0800
Subject: [PATCH 3/3] genalloc: selftest
In-Reply-To: <20180429024542.19475-4-igor.stoppa@huawei.com>
References: <20180429024542.19475-4-igor.stoppa@huawei.com>
Message-ID: <201804301051.vVqqUaZj%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.17-rc3 next-20180426]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/linux-next-mm-hardening-Track-genalloc-allocations/20180430-064850
config: um-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um 

All errors (new ones prefixed by >>):

>> lib/test_genalloc.c:18:10: fatal error: linux/test_genalloc.h: No such file or directory
    #include <linux/test_genalloc.h>
             ^~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +18 lib/test_genalloc.c

    17	
  > 18	#include <linux/test_genalloc.h>
    19	
    20	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
