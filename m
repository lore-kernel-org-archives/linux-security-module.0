From: lkp@intel.com (kbuild test robot)
Date: Tue, 27 Jun 2017 13:07:00 +0800
Subject: [PATCH 3/3] Make LSM Writable Hooks a command line option
In-Reply-To: <20170626144116.27599-4-igor.stoppa@huawei.com>
Message-ID: <201706271329.1BcwNJr9%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

[auto build test ERROR on mmotm/master]
[cannot apply to linus/master linux/master v4.12-rc7 next-20170626]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/ro-protection-for-dynamic-data/20170627-103230
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   init/built-in.o: In function `start_kernel':
   (.init.text+0x1832): undefined reference to `pmalloc_init'
   mm/built-in.o: In function `__check_object_size':
   (.text+0x14f1b2): undefined reference to `__pmalloc_check_object'
   security/built-in.o: In function `security_init':
>> (.init.text+0x802): undefined reference to `pmalloc_create_pool'
   security/built-in.o: In function `security_init':
>> (.init.text+0x832): undefined reference to `pmalloc'
   security/built-in.o: In function `security_init':
>> (.init.text+0x9d2): undefined reference to `pmalloc_protect_pool'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
