From: lkp@intel.com (kbuild test robot)
Date: Tue, 11 Jul 2017 10:05:12 +0800
Subject: [PATCH 1/3] Protectable memory support
In-Reply-To: <20170710150603.387-2-igor.stoppa@huawei.com>
Message-ID: <201707110914.6Cgn7Gsp%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.12 next-20170710]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/mm-security-ro-protection-for-dynamic-data/20170711-084116
config: i386-randconfig-x070-07101331 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   mm/pmalloc.c: In function '__pmalloc_pool_show_avail':
   mm/pmalloc.c:78:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t {aka unsigned int}' [-Wformat=]
     return sprintf(buf, "%lu\n", gen_pool_avail(data->pool));
                            ^
   mm/pmalloc.c: In function '__pmalloc_pool_show_size':
   mm/pmalloc.c:88:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t {aka unsigned int}' [-Wformat=]
     return sprintf(buf, "%lu\n", gen_pool_size(data->pool));
                            ^
   In file included from include/linux/init.h:4:0,
                    from include/linux/printk.h:5,
                    from mm/pmalloc.c:13:
   mm/pmalloc.c: In function 'pmalloc':
   mm/pmalloc.c:263:5: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
        (phys_addr_t)NULL, chunk_size, NUMA_NO_NODE));
        ^
   include/linux/compiler.h:175:42: note: in definition of macro 'unlikely'
    # define unlikely(x) __builtin_expect(!!(x), 0)
                                             ^
   mm/pmalloc.c:262:2: note: in expansion of macro 'BUG_ON'
     BUG_ON(gen_pool_add_virt(pool, (unsigned long)chunk,
     ^~~~~~
   mm/pmalloc.c: In function '__pmalloc_connect':
>> mm/pmalloc.c:118:2: warning: ignoring return value of 'sysfs_create_file', declared with attribute warn_unused_result [-Wunused-result]
     sysfs_create_file(data->pool_kobject, &data->attr_protected.attr);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/pmalloc.c:119:2: warning: ignoring return value of 'sysfs_create_file', declared with attribute warn_unused_result [-Wunused-result]
     sysfs_create_file(data->pool_kobject, &data->attr_avail.attr);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/pmalloc.c:120:2: warning: ignoring return value of 'sysfs_create_file', declared with attribute warn_unused_result [-Wunused-result]
     sysfs_create_file(data->pool_kobject, &data->attr_size.attr);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/pmalloc.c:121:2: warning: ignoring return value of 'sysfs_create_file', declared with attribute warn_unused_result [-Wunused-result]
     sysfs_create_file(data->pool_kobject, &data->attr_chunks.attr);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/sysfs_create_file +118 mm/pmalloc.c

   110	
   111	/**
   112	 * Exposes the pool and its attributes through sysfs.
   113	 */
   114	static void __pmalloc_connect(struct pmalloc_data *data)
   115	{
   116		data->pool_kobject = kobject_create_and_add(data->pool->name,
   117							    pmalloc_kobject);
 > 118		sysfs_create_file(data->pool_kobject, &data->attr_protected.attr);
   119		sysfs_create_file(data->pool_kobject, &data->attr_avail.attr);
   120		sysfs_create_file(data->pool_kobject, &data->attr_size.attr);
   121		sysfs_create_file(data->pool_kobject, &data->attr_chunks.attr);
   122	}
   123	
   124	/**
   125	 * Removes the pool and its attributes from sysfs.
   126	 */
   127	static void __pmalloc_disconnect(struct pmalloc_data *data)
   128	{
   129		sysfs_remove_file(data->pool_kobject, &data->attr_protected.attr);
   130		sysfs_remove_file(data->pool_kobject, &data->attr_avail.attr);
   131		sysfs_remove_file(data->pool_kobject, &data->attr_size.attr);
   132		sysfs_remove_file(data->pool_kobject, &data->attr_chunks.attr);
   133		kobject_put(data->pool_kobject);
   134	}
   135	
   136	/**
   137	 * Declares an attribute of the pool.
   138	 */
   139	
   140	
   141	#ifdef CONFIG_DEBUG_LOCK_ALLOC
   142	#define do_lock_dep(data, attr_name) \
   143		(data->attr_##attr_name.attr.ignore_lockdep = 1)
   144	#else
   145	#define do_lock_dep(data, attr_name) do {} while (0)
   146	#endif
   147	
   148	#define __pmalloc_attr_init(data, attr_name) \
   149	do { \
   150		data->attr_##attr_name.attr.name = #attr_name; \
   151		data->attr_##attr_name.attr.mode = VERIFY_OCTAL_PERMISSIONS(0444); \
   152		data->attr_##attr_name.show = __pmalloc_pool_show_##attr_name; \
   153		do_lock_dep(data, attr_name); \
   154	} while (0)
   155	
   156	struct gen_pool *pmalloc_create_pool(const char *name, int min_alloc_order)
   157	{
   158		struct gen_pool *pool;
   159		const char *pool_name;
   160		struct pmalloc_data *data;
   161	
   162		if (!name)
   163			return NULL;
   164		pool_name = kstrdup(name, GFP_KERNEL);
   165		if (!pool_name)
   166			return NULL;
   167		data = kzalloc(sizeof(struct pmalloc_data), GFP_KERNEL);
   168		if (!data)
   169			return NULL;
   170		if (min_alloc_order < 0)
   171			min_alloc_order = ilog2(sizeof(unsigned long));
   172		pool = gen_pool_create(min_alloc_order, NUMA_NO_NODE);
   173		if (!pool) {
   174			kfree(pool_name);
   175			kfree(data);
   176			return NULL;
   177		}
   178		data->protected = false;
   179		data->pool = pool;
   180		mutex_init(&data->mutex);
   181		__pmalloc_attr_init(data, protected);
   182		__pmalloc_attr_init(data, avail);
   183		__pmalloc_attr_init(data, size);
   184		__pmalloc_attr_init(data, chunks);
   185		pool->data = data;
   186		pool->name = pool_name;
   187		mutex_lock(&pmalloc_mutex);
   188		list_add(&data->node, &pmalloc_tmp_list);
   189		if (pmalloc_list == &pmalloc_final_list)
   190			__pmalloc_connect(data);
   191		mutex_unlock(&pmalloc_mutex);
   192		return pool;
   193	}
   194	
   195	
   196	bool is_pmalloc_page(struct page *page)
   197	{
   198		return page && page_private(page) &&
   199			page->private == pmalloc_signature;
   200	}
   201	EXPORT_SYMBOL(is_pmalloc_page);
   202	
   203	/**
   204	 * To support hardened usercopy, tag/untag pages supplied by pmalloc.
   205	 * Pages are tagged when added to a pool and untagged when removed
   206	 * from said pool.
   207	 */
   208	#define PMALLOC_TAG_PAGE true
   209	#define PMALLOC_UNTAG_PAGE false
   210	static inline
   211	int __pmalloc_tag_pages(void *base, const size_t size, const bool set_tag)
   212	{
   213		void *end = base + size - 1;
   214	
   215		do {
   216			struct page *page;
   217	
   218			if (!is_vmalloc_addr(base))
   219				return -EINVAL;
   220			page = vmalloc_to_page(base);
   221			if (set_tag) {
   222				BUG_ON(page_private(page) || page->private);
   223				set_page_private(page, 1);
   224				page->private = pmalloc_signature;
   225			} else {
   226				BUG_ON(!(page_private(page) &&
   227					 page->private == pmalloc_signature));
   228				set_page_private(page, 0);
   229				page->private = 0;
   230			}
   231			base += PAGE_SIZE;
   232		} while ((PAGE_MASK & (unsigned long)base) <=
   233			 (PAGE_MASK & (unsigned long)end));
   234		return 0;
   235	}
   236	
   237	
   238	static void __page_untag(struct gen_pool *pool,
   239				 struct gen_pool_chunk *chunk, void *data)
   240	{
   241		__pmalloc_tag_pages((void *)chunk->start_addr,
   242				    chunk->end_addr - chunk->start_addr + 1,
   243				    PMALLOC_UNTAG_PAGE);
   244	}
   245	
   246	void *pmalloc(struct gen_pool *pool, size_t size)
   247	{
   248		void *retval, *chunk;
   249		size_t chunk_size;
   250	
   251		if (!size || !pool || ((struct pmalloc_data *)pool->data)->protected)
   252			return NULL;
   253		retval = (void *)gen_pool_alloc(pool, size);
   254		if (retval)
   255			return retval;
   256		chunk_size = roundup(size, PAGE_SIZE);
   257		chunk = vmalloc(chunk_size);
   258		if (!chunk)
   259			return NULL;
   260		__pmalloc_tag_pages(chunk, size, PMALLOC_TAG_PAGE);
   261		/* Locking is already done inside gen_pool_add_virt */
 > 262		BUG_ON(gen_pool_add_virt(pool, (unsigned long)chunk,
   263					(phys_addr_t)NULL, chunk_size, NUMA_NO_NODE));
   264		return (void *)gen_pool_alloc(pool, size);
   265	}
   266	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
