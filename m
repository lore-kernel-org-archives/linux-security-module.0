From: lkp@intel.com (kbuild test robot)
Date: Wed, 7 Feb 2018 18:03:39 +0800
Subject: [PATCH 4/6] Protectable Memory
In-Reply-To: <20180204164732.28241-5-igor.stoppa@huawei.com>
References: <20180204164732.28241-5-igor.stoppa@huawei.com>
Message-ID: <201802071736.PLMzjgWI%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kees/for-next/pstore]
[also build test ERROR on v4.15]
[cannot apply to linus/master mmotm/master next-20180206]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/mm-security-ro-protection-for-dynamic-data/20180207-171252
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the linux-review/Igor-Stoppa/mm-security-ro-protection-for-dynamic-data/20180207-171252 HEAD 99d0cb7905216da7595ef08a781a9be16a8ce687 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> mm/pmalloc.c:24:10: fatal error: pmalloc-selftest.h: No such file or directory
    #include "pmalloc-selftest.h"
             ^~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +24 mm/pmalloc.c

    23	
  > 24	#include "pmalloc-selftest.h"
    25	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
