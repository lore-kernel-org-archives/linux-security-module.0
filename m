From: lkp@intel.com (kbuild test robot)
Date: Fri, 2 Feb 2018 14:14:10 +0800
Subject: [PATCH 6/6] Pmalloc: self-test
In-Reply-To: <20180130151446.24698-7-igor.stoppa@huawei.com>
References: <20180130151446.24698-7-igor.stoppa@huawei.com>
Message-ID: <201802021413.1N8bkxCV%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.15]
[cannot apply to next-20180201]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/mm-security-ro-protection-for-dynamic-data/20180202-123437
config: xtensa-allyesconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All error/warnings (new ones prefixed by >>):

   mm/pmalloc-selftest.c: In function 'pmalloc_selftest':
>> mm/pmalloc-selftest.c:43:14: error: implicit declaration of function 'vmalloc'; did you mean 'kvmalloc'? [-Werror=implicit-function-declaration]
     var_vmall = vmalloc(SIZE_2);
                 ^~~~~~~
                 kvmalloc
>> mm/pmalloc-selftest.c:43:12: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     var_vmall = vmalloc(SIZE_2);
               ^
>> mm/pmalloc-selftest.c:52:2: error: implicit declaration of function 'vfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
     vfree(var_vmall);
     ^~~~~
     kvfree
   cc1: some warnings being treated as errors

vim +43 mm/pmalloc-selftest.c

    19	
    20	#define validate_alloc(expected, variable, size)	\
    21		pr_notice("must be " expected ": %s",		\
    22			  is_pmalloc_object(variable, size) > 0 ? "ok" : "no")
    23	
    24	#define is_alloc_ok(variable, size)	\
    25		validate_alloc("ok", variable, size)
    26	
    27	#define is_alloc_no(variable, size)	\
    28		validate_alloc("no", variable, size)
    29	
    30	void pmalloc_selftest(void)
    31	{
    32		struct gen_pool *pool_unprot;
    33		struct gen_pool *pool_prot;
    34		void *var_prot, *var_unprot, *var_vmall;
    35	
    36		pr_notice("pmalloc self-test");
    37		pool_unprot = pmalloc_create_pool("unprotected", 0);
    38		pool_prot = pmalloc_create_pool("protected", 0);
    39		BUG_ON(!(pool_unprot && pool_prot));
    40	
    41		var_unprot = pmalloc(pool_unprot,  SIZE_1 - 1, GFP_KERNEL);
    42		var_prot = pmalloc(pool_prot,  SIZE_1, GFP_KERNEL);
  > 43		var_vmall = vmalloc(SIZE_2);
    44		is_alloc_ok(var_unprot, 10);
    45		is_alloc_ok(var_unprot, SIZE_1);
    46		is_alloc_ok(var_unprot, PAGE_SIZE);
    47		is_alloc_no(var_unprot, SIZE_1 + 1);
    48		is_alloc_no(var_vmall, 10);
    49	
    50	
    51		pfree(pool_unprot, var_unprot);
  > 52		vfree(var_vmall);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
