From: lkp@intel.com (kbuild test robot)
Date: Wed, 28 Mar 2018 05:57:23 +0800
Subject: [PATCH 3/6] Protectable Memory
In-Reply-To: <20180327015524.14318-4-igor.stoppa@huawei.com>
References: <20180327015524.14318-4-igor.stoppa@huawei.com>
Message-ID: <201803280458.FLPWjWSo%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc7 next-20180327]
[cannot apply to mmotm/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/mm-security-ro-protection-for-dynamic-data/20180328-041541
config: i386-randconfig-x073-201812 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:18:0,
                    from arch/x86/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from mm/pmalloc.c:11:
   mm/pmalloc.c: In function 'grow':
   include/linux/kernel.h:809:16: warning: comparison of distinct pointer types lacks a cast
     (void) (&max1 == &max2);   \
                   ^
   include/linux/kernel.h:818:2: note: in expansion of macro '__max'
     __max(typeof(x), typeof(y),   \
     ^~~~~
>> mm/pmalloc.c:155:17: note: in expansion of macro 'max'
     addr = vmalloc(max(size, pool->refill));
                    ^~~

vim +/max +155 mm/pmalloc.c

  > 11	#include <linux/mm.h>
    12	#include <linux/vmalloc.h>
    13	#include <linux/kernel.h>
    14	#include <linux/log2.h>
    15	#include <linux/slab.h>
    16	#include <linux/set_memory.h>
    17	#include <linux/bug.h>
    18	#include <linux/mutex.h>
    19	#include <linux/llist.h>
    20	#include <asm/cacheflush.h>
    21	#include <asm/page.h>
    22	
    23	#include <linux/pmalloc.h>
    24	
    25	#define MAX_ALIGN_ORDER (ilog2(sizeof(void *)))
    26	struct pmalloc_pool {
    27		struct mutex mutex;
    28		struct list_head pool_node;
    29		struct llist_head vm_areas;
    30		unsigned long refill;
    31		unsigned long offset;
    32		unsigned long align;
    33	};
    34	
    35	static LIST_HEAD(pools_list);
    36	static DEFINE_MUTEX(pools_mutex);
    37	
    38	static inline void tag_area(struct vmap_area *area)
    39	{
    40		area->vm->flags |= VM_PMALLOC;
    41	}
    42	
    43	static inline void untag_area(struct vmap_area *area)
    44	{
    45		area->vm->flags &= ~VM_PMALLOC;
    46	}
    47	
    48	static inline struct vmap_area *current_area(struct pmalloc_pool *pool)
    49	{
    50		return llist_entry(pool->vm_areas.first, struct vmap_area,
    51				   area_list);
    52	}
    53	
    54	static inline bool is_area_protected(struct vmap_area *area)
    55	{
    56		return area->vm->flags & VM_PMALLOC_PROTECTED;
    57	}
    58	
    59	static inline bool protect_area(struct vmap_area *area)
    60	{
    61		if (unlikely(is_area_protected(area)))
    62			return false;
    63		set_memory_ro(area->va_start, area->vm->nr_pages);
    64		area->vm->flags |= VM_PMALLOC_PROTECTED;
    65		return true;
    66	}
    67	
    68	static inline void destroy_area(struct vmap_area *area)
    69	{
    70		WARN(!is_area_protected(area), "Destroying unprotected area.");
    71		set_memory_rw(area->va_start, area->vm->nr_pages);
    72		vfree((void *)area->va_start);
    73	}
    74	
    75	static inline bool empty(struct pmalloc_pool *pool)
    76	{
    77		return unlikely(llist_empty(&pool->vm_areas));
    78	}
    79	
    80	static inline bool protected(struct pmalloc_pool *pool)
    81	{
    82		return is_area_protected(current_area(pool));
    83	}
    84	
    85	static inline unsigned long get_align(struct pmalloc_pool *pool,
    86					      short int align_order)
    87	{
    88		if (likely(align_order < 0))
    89			return pool->align;
    90		return 1UL << align_order;
    91	}
    92	
    93	static inline bool exhausted(struct pmalloc_pool *pool, size_t size,
    94				     short int align_order)
    95	{
    96		unsigned long align = get_align(pool, align_order);
    97		unsigned long space_before = round_down(pool->offset, align);
    98		unsigned long space_after = pool->offset - space_before;
    99	
   100		return unlikely(space_after < size && space_before < size);
   101	}
   102	
   103	static inline bool space_needed(struct pmalloc_pool *pool, size_t size,
   104					short int align_order)
   105	{
   106		return empty(pool) || protected(pool) ||
   107			exhausted(pool, size, align_order);
   108	}
   109	
   110	#define DEFAULT_REFILL_SIZE PAGE_SIZE
   111	/**
   112	 * pmalloc_create_custom_pool() - create a new protectable memory pool
   113	 * @refill: the minimum size to allocate when in need of more memory.
   114	 *          It will be rounded up to a multiple of PAGE_SIZE
   115	 *          The value of 0 gives the default amount of PAGE_SIZE.
   116	 * @align_order: log2 of the alignment to use when allocating memory
   117	 *               Negative values give log2(sizeof(size_t)).
   118	 *
   119	 * Creates a new (empty) memory pool for allocation of protectable
   120	 * memory. Memory will be allocated upon request (through pmalloc).
   121	 *
   122	 * Return:
   123	 * * pointer to the new pool	- success
   124	 * * NULL			- error
   125	 */
   126	struct pmalloc_pool *pmalloc_create_custom_pool(unsigned long refill,
   127							short int align_order)
   128	{
   129		struct pmalloc_pool *pool;
   130	
   131		pool = kzalloc(sizeof(struct pmalloc_pool), GFP_KERNEL);
   132		if (WARN(!pool, "Could not allocate pool meta data."))
   133			return NULL;
   134	
   135		pool->refill = refill ? PAGE_ALIGN(refill) : DEFAULT_REFILL_SIZE;
   136		if (align_order < 0)
   137			pool->align = sizeof(size_t);
   138		else
   139			pool->align = 1UL << align_order;
   140		mutex_init(&pool->mutex);
   141	
   142		mutex_lock(&pools_mutex);
   143		list_add(&pool->pool_node, &pools_list);
   144		mutex_unlock(&pools_mutex);
   145		return pool;
   146	}
   147	
   148	
   149	static int grow(struct pmalloc_pool *pool, size_t size,
   150			short int align_order)
   151	{
   152		void *addr;
   153		struct vmap_area *area;
   154	
 > 155		addr = vmalloc(max(size, pool->refill));
   156		if (WARN(!addr, "Failed to allocate %zd bytes", PAGE_ALIGN(size)))
   157			return -ENOMEM;
   158	
   159		area = find_vmap_area((unsigned long)addr);
   160		tag_area(area);
   161		pool->offset = area->vm->nr_pages * PAGE_SIZE;
   162		llist_add(&area->area_list, &pool->vm_areas);
   163		return 0;
   164	}
   165	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
