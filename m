From: lkp@intel.com (kbuild test robot)
Date: Tue, 27 Jun 2017 14:48:38 +0800
Subject: [PATCH 3/3] Make LSM Writable Hooks a command line option
In-Reply-To: <20170626144116.27599-4-igor.stoppa@huawei.com>
Message-ID: <201706271400.vAtoRsLU%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

[auto build test ERROR on mmotm/master]
[cannot apply to linus/master linux/master v4.12-rc7 next-20170626]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/ro-protection-for-dynamic-data/20170627-103230
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: tile-tilegx_defconfig (attached as .config)
compiler: tilegx-linux-gcc (GCC) 4.6.2
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=tile 

All errors (new ones prefixed by >>):

   init/built-in.o: In function `start_kernel':
   init/main.c:678: undefined reference to `pmalloc_init'
   security/built-in.o: In function `security_init':
>> security/security.c:75: undefined reference to `pmalloc_create_pool'
>> security/security.c:77: undefined reference to `pmalloc'
>> security/security.c:96: undefined reference to `pmalloc_protect_pool'

vim +75 security/security.c

    69	 * This should be called early in the kernel initialization sequence.
    70	 */
    71	int __init security_init(void)
    72	{
    73		enum security_hook_index i;
    74	
  > 75		sec_pool = pmalloc_create_pool("security", PMALLOC_DEFAULT_ALLOC_ORDER);
    76		BUG_ON(!sec_pool);
  > 77		hook_heads = pmalloc(sec_pool,
    78				     sizeof(struct list_head) * LSM_MAX_HOOK_INDEX);
    79		BUG_ON(!hook_heads);
    80		for (i = 0; i < LSM_MAX_HOOK_INDEX; i++)
    81			INIT_LIST_HEAD(&hook_heads[i]);
    82		pr_info("Security Framework initialized\n");
    83	
    84		/*
    85		 * Load minor LSMs, with the capability module always first.
    86		 */
    87		capability_add_hooks();
    88		yama_add_hooks();
    89		loadpin_add_hooks();
    90	
    91		/*
    92		 * Load all the remaining security modules.
    93		 */
    94		do_security_initcalls();
    95		if (!dynamic_lsm)
  > 96			pmalloc_protect_pool(sec_pool);
    97		return 0;
    98	}
    99	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
