From: lkp@intel.com (kbuild test robot)
Date: Fri, 2 Feb 2018 13:53:00 +0800
Subject: [PATCH 4/6] Protectable Memory
In-Reply-To: <20180130151446.24698-5-igor.stoppa@huawei.com>
References: <20180130151446.24698-5-igor.stoppa@huawei.com>
Message-ID: <201802021349.3PPjTUdu%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.15]
[cannot apply to next-20180201]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/mm-security-ro-protection-for-dynamic-data/20180202-123437
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   mm/pmalloc.o: In function `pmalloc_pool_show_chunks':
>> pmalloc.c:(.text+0x50): undefined reference to `gen_pool_for_each_chunk'
   mm/pmalloc.o: In function `pmalloc_pool_show_size':
>> pmalloc.c:(.text+0x6e): undefined reference to `gen_pool_size'
   mm/pmalloc.o: In function `pmalloc_pool_show_avail':
>> pmalloc.c:(.text+0x8a): undefined reference to `gen_pool_avail'
   mm/pmalloc.o: In function `pmalloc_chunk_free':
>> pmalloc.c:(.text+0x171): undefined reference to `gen_pool_flush_chunk'
   mm/pmalloc.o: In function `pmalloc_create_pool':
>> pmalloc.c:(.text+0x19b): undefined reference to `gen_pool_create'
>> pmalloc.c:(.text+0x2bb): undefined reference to `gen_pool_destroy'
   mm/pmalloc.o: In function `pmalloc_prealloc':
>> pmalloc.c:(.text+0x350): undefined reference to `gen_pool_add_virt'
   mm/pmalloc.o: In function `pmalloc':
>> pmalloc.c:(.text+0x3a7): undefined reference to `gen_pool_alloc'
   pmalloc.c:(.text+0x3f1): undefined reference to `gen_pool_add_virt'
   pmalloc.c:(.text+0x401): undefined reference to `gen_pool_alloc'
   mm/pmalloc.o: In function `pmalloc_destroy_pool':
   pmalloc.c:(.text+0x4a1): undefined reference to `gen_pool_for_each_chunk'
   pmalloc.c:(.text+0x4a8): undefined reference to `gen_pool_destroy'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
