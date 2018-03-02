From: lkp@intel.com (kbuild test robot)
Date: Sat, 3 Mar 2018 00:37:13 +0800
Subject: [PATCH 1/7] genalloc: track beginning of allocations
In-Reply-To: <20180228200620.30026-2-igor.stoppa@huawei.com>
References: <20180228200620.30026-2-igor.stoppa@huawei.com>
Message-ID: <201803030004.MYDwBx4i%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20180223]
[also build test ERROR on v4.16-rc3]
[cannot apply to linus/master mmotm/master char-misc/char-misc-testing v4.16-rc3 v4.16-rc2 v4.16-rc1]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/mm-security-ro-protection-for-dynamic-data/20180302-232215
config: i386-randconfig-x004-201808 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/bug.h:83:0,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from lib/genalloc.c:99:
   lib/genalloc.c: In function 'gen_pool_free':
>> lib/genalloc.c:616:10: warning: format '%s' expects argument of type 'char *', but argument 2 has type 'struct gen_pool *' [-Wformat=]
             "Trying to free unallocated memory"
             ^
   include/asm-generic/bug.h:98:50: note: in definition of macro '__WARN_printf'
    #define __WARN_printf(arg...) do { __warn_printk(arg); __WARN(); } while (0)
                                                     ^~~
>> lib/genalloc.c:615:5: note: in expansion of macro 'WARN'
        WARN(true,
        ^~~~
   lib/genalloc.c:617:23: note: format string is defined here
             " from pool %s", pool);
                         ~^
   In file included from include/asm-generic/bug.h:5:0,
                    from arch/x86/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from lib/genalloc.c:99:
>> lib/genalloc.c:624:17: error: implicit declaration of function 'exit_test'; did you mean 'exit_sem'? [-Werror=implicit-function-declaration]
       if (unlikely(exit_test(boundary < 0))) {
                    ^
   include/linux/compiler.h:77:42: note: in definition of macro 'unlikely'
    # define unlikely(x) __builtin_expect(!!(x), 0)
                                             ^
   In file included from arch/x86/include/asm/bug.h:83:0,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from lib/genalloc.c:99:
   lib/genalloc.c:626:16: warning: format '%s' expects argument of type 'char *', but argument 2 has type 'struct gen_pool *' [-Wformat=]
        WARN(true, "Corrupted pool %s", pool);
                   ^
   include/asm-generic/bug.h:98:50: note: in definition of macro '__WARN_printf'
    #define __WARN_printf(arg...) do { __warn_printk(arg); __WARN(); } while (0)
                                                     ^~~
   lib/genalloc.c:626:5: note: in expansion of macro 'WARN'
        WARN(true, "Corrupted pool %s", pool);
        ^~~~
   lib/genalloc.c:634:10: warning: format '%s' expects argument of type 'char *', but argument 2 has type 'struct gen_pool *' [-Wformat=]
             "Size provided differs from size "
             ^
   include/asm-generic/bug.h:98:50: note: in definition of macro '__WARN_printf'
    #define __WARN_printf(arg...) do { __warn_printk(arg); __WARN(); } while (0)
                                                     ^~~
   lib/genalloc.c:633:5: note: in expansion of macro 'WARN'
        WARN(true,
        ^~~~
   lib/genalloc.c:635:31: note: format string is defined here
             "measured from pool %s", pool);
                                 ~^
   In file included from arch/x86/include/asm/bug.h:83:0,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from lib/genalloc.c:99:
   lib/genalloc.c:643:10: warning: format '%s' expects argument of type 'char *', but argument 2 has type 'struct gen_pool *' [-Wformat=]
             "Unexpected bitmap collision while"
             ^
   include/asm-generic/bug.h:98:50: note: in definition of macro '__WARN_printf'
    #define __WARN_printf(arg...) do { __warn_printk(arg); __WARN(); } while (0)
                                                     ^~~
   lib/genalloc.c:642:5: note: in expansion of macro 'WARN'
        WARN(true,
        ^~~~
   lib/genalloc.c:644:36: note: format string is defined here
             " freeing memory in pool %s", pool);
                                      ~^
   cc1: some warnings being treated as errors

vim +624 lib/genalloc.c

   609	
   610		rcu_read_lock();
   611		list_for_each_entry_rcu(chunk, &pool->chunks, next_chunk) {
   612			if (addr >= chunk->start_addr && addr <= chunk->end_addr) {
   613				if (unlikely(addr + size - 1 > chunk->end_addr)) {
   614					rcu_read_unlock();
 > 615					WARN(true,
 > 616					     "Trying to free unallocated memory"
   617					     " from pool %s", pool);
   618					return;
   619				}
   620				start_entry = (addr - chunk->start_addr) >> order;
   621				remaining_entries = (chunk->end_addr - addr) >> order;
   622				boundary = get_boundary(chunk->entries, start_entry,
   623							remaining_entries);
 > 624				if (unlikely(exit_test(boundary < 0))) {
   625					rcu_read_unlock();
   626					WARN(true, "Corrupted pool %s", pool);
   627					return;
   628				}
   629				nentries = boundary - start_entry;
   630				if (unlikely(size && (nentries !=
   631						      mem_to_units(size, order)))) {
   632					rcu_read_unlock();
   633					WARN(true,
   634					     "Size provided differs from size "
   635					     "measured from pool %s", pool);
   636					return;
   637				}
   638				remain = alter_bitmap_ll(CLEAR_BITS, chunk->entries,
   639							 start_entry, nentries);
   640				if (unlikely(remain)) {
   641					rcu_read_unlock();
   642					WARN(true,
   643					     "Unexpected bitmap collision while"
   644					     " freeing memory in pool %s", pool);
   645					return;
   646				}
   647				atomic_long_add(nentries << order, &chunk->avail);
   648				rcu_read_unlock();
   649				return;
   650			}
   651		}
   652		rcu_read_unlock();
   653		WARN(true, "address not found in pool %s", pool->name);
   654	}
   655	EXPORT_SYMBOL(gen_pool_free);
   656	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
