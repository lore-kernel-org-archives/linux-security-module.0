From: lkp@intel.com (kbuild test robot)
Date: Sun, 25 Feb 2018 11:46:35 +0800
Subject: [PATCH 6/7] lkdtm: crash on overwriting protected pmalloc var
In-Reply-To: <20180223144807.1180-7-igor.stoppa@huawei.com>
References: <20180223144807.1180-7-igor.stoppa@huawei.com>
Message-ID: <201802251124.dMLMGcJG%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc2]
[cannot apply to next-20180223]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/genalloc-track-beginning-of-allocations/20180225-081601
config: x86_64-rhel (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> ERROR: "pmalloc" [drivers/misc/lkdtm.ko] undefined!
>> ERROR: "pmalloc_create_pool" [drivers/misc/lkdtm.ko] undefined!
>> ERROR: "pmalloc_destroy_pool" [drivers/misc/lkdtm.ko] undefined!
>> ERROR: "pmalloc_protect_pool" [drivers/misc/lkdtm.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
