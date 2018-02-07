From: lkp@intel.com (kbuild test robot)
Date: Thu, 8 Feb 2018 01:18:26 +0800
Subject: [PATCH 5/6] Pmalloc: self-test
In-Reply-To: <20180204170056.28772-1-igor.stoppa@huawei.com>
References: <20180204170056.28772-1-igor.stoppa@huawei.com>
Message-ID: <201802080158.oKwP7HVR%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kees/for-next/pstore]
[also build test ERROR on v4.15]
[cannot apply to linus/master mmotm/master next-20180207]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/mm-security-ro-protection-for-dynamic-data/20180207-171252
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
config: i386-randconfig-s1-201805+bisect_validate (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   mm/pmalloc.o: In function `pmalloc_pool_show_chunks':
>> mm/pmalloc.c:100: undefined reference to `gen_pool_for_each_chunk'
   mm/pmalloc.o: In function `pmalloc_pool_show_size':
>> mm/pmalloc.c:81: undefined reference to `gen_pool_size'
   mm/pmalloc.o: In function `pmalloc_pool_show_avail':
>> mm/pmalloc.c:70: undefined reference to `gen_pool_avail'
   mm/pmalloc.o: In function `pmalloc_chunk_free':
>> mm/pmalloc.c:459: undefined reference to `gen_pool_flush_chunk'
   mm/pmalloc.o: In function `pmalloc_create_pool':
>> mm/pmalloc.c:173: undefined reference to `gen_pool_create'
>> mm/pmalloc.c:210: undefined reference to `gen_pool_destroy'
   mm/pmalloc.o: In function `gen_pool_add':
>> include/linux/genalloc.h:115: undefined reference to `gen_pool_add_virt'
   mm/pmalloc.o: In function `pmalloc':
>> mm/pmalloc.c:357: undefined reference to `gen_pool_alloc'
   mm/pmalloc.o: In function `gen_pool_add':
>> include/linux/genalloc.h:115: undefined reference to `gen_pool_add_virt'
   mm/pmalloc.o: In function `pmalloc':
   mm/pmalloc.c:386: undefined reference to `gen_pool_alloc'
   mm/pmalloc.o: In function `pmalloc_destroy_pool':
   mm/pmalloc.c:484: undefined reference to `gen_pool_for_each_chunk'
   mm/pmalloc.c:485: undefined reference to `gen_pool_destroy'

vim +100 mm/pmalloc.c

13e2be64 Igor Stoppa 2018-02-04   61  
13e2be64 Igor Stoppa 2018-02-04   62  static ssize_t pmalloc_pool_show_avail(struct kobject *dev,
13e2be64 Igor Stoppa 2018-02-04   63  				       struct kobj_attribute *attr,
13e2be64 Igor Stoppa 2018-02-04   64  				       char *buf)
13e2be64 Igor Stoppa 2018-02-04   65  {
13e2be64 Igor Stoppa 2018-02-04   66  	struct pmalloc_data *data;
13e2be64 Igor Stoppa 2018-02-04   67  
13e2be64 Igor Stoppa 2018-02-04   68  	data = container_of(attr, struct pmalloc_data, attr_avail);
13e2be64 Igor Stoppa 2018-02-04   69  	return sprintf(buf, "%lu\n",
13e2be64 Igor Stoppa 2018-02-04  @70  		       (unsigned long)gen_pool_avail(data->pool));
13e2be64 Igor Stoppa 2018-02-04   71  }
13e2be64 Igor Stoppa 2018-02-04   72  
13e2be64 Igor Stoppa 2018-02-04   73  static ssize_t pmalloc_pool_show_size(struct kobject *dev,
13e2be64 Igor Stoppa 2018-02-04   74  				      struct kobj_attribute *attr,
13e2be64 Igor Stoppa 2018-02-04   75  				      char *buf)
13e2be64 Igor Stoppa 2018-02-04   76  {
13e2be64 Igor Stoppa 2018-02-04   77  	struct pmalloc_data *data;
13e2be64 Igor Stoppa 2018-02-04   78  
13e2be64 Igor Stoppa 2018-02-04   79  	data = container_of(attr, struct pmalloc_data, attr_size);
13e2be64 Igor Stoppa 2018-02-04   80  	return sprintf(buf, "%lu\n",
13e2be64 Igor Stoppa 2018-02-04  @81  		       (unsigned long)gen_pool_size(data->pool));
13e2be64 Igor Stoppa 2018-02-04   82  }
13e2be64 Igor Stoppa 2018-02-04   83  
13e2be64 Igor Stoppa 2018-02-04   84  static void pool_chunk_number(struct gen_pool *pool,
13e2be64 Igor Stoppa 2018-02-04   85  			      struct gen_pool_chunk *chunk, void *data)
13e2be64 Igor Stoppa 2018-02-04   86  {
13e2be64 Igor Stoppa 2018-02-04   87  	unsigned long *counter = data;
13e2be64 Igor Stoppa 2018-02-04   88  
13e2be64 Igor Stoppa 2018-02-04   89  	(*counter)++;
13e2be64 Igor Stoppa 2018-02-04   90  }
13e2be64 Igor Stoppa 2018-02-04   91  
13e2be64 Igor Stoppa 2018-02-04   92  static ssize_t pmalloc_pool_show_chunks(struct kobject *dev,
13e2be64 Igor Stoppa 2018-02-04   93  					struct kobj_attribute *attr,
13e2be64 Igor Stoppa 2018-02-04   94  					char *buf)
13e2be64 Igor Stoppa 2018-02-04   95  {
13e2be64 Igor Stoppa 2018-02-04   96  	struct pmalloc_data *data;
13e2be64 Igor Stoppa 2018-02-04   97  	unsigned long chunks_num = 0;
13e2be64 Igor Stoppa 2018-02-04   98  
13e2be64 Igor Stoppa 2018-02-04   99  	data = container_of(attr, struct pmalloc_data, attr_chunks);
13e2be64 Igor Stoppa 2018-02-04 @100  	gen_pool_for_each_chunk(data->pool, pool_chunk_number, &chunks_num);
13e2be64 Igor Stoppa 2018-02-04  101  	return sprintf(buf, "%lu\n", chunks_num);
13e2be64 Igor Stoppa 2018-02-04  102  }
13e2be64 Igor Stoppa 2018-02-04  103  
13e2be64 Igor Stoppa 2018-02-04  104  /**
13e2be64 Igor Stoppa 2018-02-04  105   * Exposes the pool and its attributes through sysfs.
13e2be64 Igor Stoppa 2018-02-04  106   */
13e2be64 Igor Stoppa 2018-02-04  107  static struct kobject *pmalloc_connect(struct pmalloc_data *data)
13e2be64 Igor Stoppa 2018-02-04  108  {
13e2be64 Igor Stoppa 2018-02-04  109  	const struct attribute *attrs[] = {
13e2be64 Igor Stoppa 2018-02-04  110  		&data->attr_protected.attr,
13e2be64 Igor Stoppa 2018-02-04  111  		&data->attr_avail.attr,
13e2be64 Igor Stoppa 2018-02-04  112  		&data->attr_size.attr,
13e2be64 Igor Stoppa 2018-02-04  113  		&data->attr_chunks.attr,
13e2be64 Igor Stoppa 2018-02-04  114  		NULL
13e2be64 Igor Stoppa 2018-02-04  115  	};
13e2be64 Igor Stoppa 2018-02-04  116  	struct kobject *kobj;
13e2be64 Igor Stoppa 2018-02-04  117  
13e2be64 Igor Stoppa 2018-02-04  118  	kobj = kobject_create_and_add(data->pool->name, pmalloc_kobject);
13e2be64 Igor Stoppa 2018-02-04  119  	if (unlikely(!kobj))
13e2be64 Igor Stoppa 2018-02-04  120  		return NULL;
13e2be64 Igor Stoppa 2018-02-04  121  
13e2be64 Igor Stoppa 2018-02-04  122  	if (unlikely(sysfs_create_files(kobj, attrs) < 0)) {
13e2be64 Igor Stoppa 2018-02-04  123  		kobject_put(kobj);
13e2be64 Igor Stoppa 2018-02-04  124  		kobj = NULL;
13e2be64 Igor Stoppa 2018-02-04  125  	}
13e2be64 Igor Stoppa 2018-02-04  126  	return kobj;
13e2be64 Igor Stoppa 2018-02-04  127  }
13e2be64 Igor Stoppa 2018-02-04  128  
13e2be64 Igor Stoppa 2018-02-04  129  /**
13e2be64 Igor Stoppa 2018-02-04  130   * Removes the pool and its attributes from sysfs.
13e2be64 Igor Stoppa 2018-02-04  131   */
13e2be64 Igor Stoppa 2018-02-04  132  static void pmalloc_disconnect(struct pmalloc_data *data,
13e2be64 Igor Stoppa 2018-02-04  133  			       struct kobject *kobj)
13e2be64 Igor Stoppa 2018-02-04  134  {
13e2be64 Igor Stoppa 2018-02-04  135  	const struct attribute *attrs[] = {
13e2be64 Igor Stoppa 2018-02-04  136  		&data->attr_protected.attr,
13e2be64 Igor Stoppa 2018-02-04  137  		&data->attr_avail.attr,
13e2be64 Igor Stoppa 2018-02-04  138  		&data->attr_size.attr,
13e2be64 Igor Stoppa 2018-02-04  139  		&data->attr_chunks.attr,
13e2be64 Igor Stoppa 2018-02-04  140  		NULL
13e2be64 Igor Stoppa 2018-02-04  141  	};
13e2be64 Igor Stoppa 2018-02-04  142  
13e2be64 Igor Stoppa 2018-02-04  143  	sysfs_remove_files(kobj, attrs);
13e2be64 Igor Stoppa 2018-02-04  144  	kobject_put(kobj);
13e2be64 Igor Stoppa 2018-02-04  145  }
13e2be64 Igor Stoppa 2018-02-04  146  
13e2be64 Igor Stoppa 2018-02-04  147  /**
13e2be64 Igor Stoppa 2018-02-04  148   * Declares an attribute of the pool.
13e2be64 Igor Stoppa 2018-02-04  149   */
13e2be64 Igor Stoppa 2018-02-04  150  
13e2be64 Igor Stoppa 2018-02-04  151  #define pmalloc_attr_init(data, attr_name) \
13e2be64 Igor Stoppa 2018-02-04  152  do { \
13e2be64 Igor Stoppa 2018-02-04  153  	sysfs_attr_init(&data->attr_##attr_name.attr); \
13e2be64 Igor Stoppa 2018-02-04  154  	data->attr_##attr_name.attr.name = #attr_name; \
13e2be64 Igor Stoppa 2018-02-04  155  	data->attr_##attr_name.attr.mode = VERIFY_OCTAL_PERMISSIONS(0400); \
13e2be64 Igor Stoppa 2018-02-04  156  	data->attr_##attr_name.show = pmalloc_pool_show_##attr_name; \
13e2be64 Igor Stoppa 2018-02-04  157  } while (0)
13e2be64 Igor Stoppa 2018-02-04  158  
13e2be64 Igor Stoppa 2018-02-04  159  struct gen_pool *pmalloc_create_pool(const char *name, int min_alloc_order)
13e2be64 Igor Stoppa 2018-02-04  160  {
13e2be64 Igor Stoppa 2018-02-04  161  	struct gen_pool *pool;
13e2be64 Igor Stoppa 2018-02-04  162  	const char *pool_name;
13e2be64 Igor Stoppa 2018-02-04  163  	struct pmalloc_data *data;
13e2be64 Igor Stoppa 2018-02-04  164  
13e2be64 Igor Stoppa 2018-02-04  165  	if (!name) {
13e2be64 Igor Stoppa 2018-02-04  166  		WARN_ON(1);
13e2be64 Igor Stoppa 2018-02-04  167  		return NULL;
13e2be64 Igor Stoppa 2018-02-04  168  	}
13e2be64 Igor Stoppa 2018-02-04  169  
13e2be64 Igor Stoppa 2018-02-04  170  	if (min_alloc_order < 0)
13e2be64 Igor Stoppa 2018-02-04  171  		min_alloc_order = ilog2(sizeof(unsigned long));
13e2be64 Igor Stoppa 2018-02-04  172  
13e2be64 Igor Stoppa 2018-02-04 @173  	pool = gen_pool_create(min_alloc_order, NUMA_NO_NODE);
13e2be64 Igor Stoppa 2018-02-04  174  	if (unlikely(!pool))
13e2be64 Igor Stoppa 2018-02-04  175  		return NULL;
13e2be64 Igor Stoppa 2018-02-04  176  
13e2be64 Igor Stoppa 2018-02-04  177  	mutex_lock(&pmalloc_mutex);
13e2be64 Igor Stoppa 2018-02-04  178  	list_for_each_entry(data, pmalloc_list, node)
13e2be64 Igor Stoppa 2018-02-04  179  		if (!strcmp(name, data->pool->name))
13e2be64 Igor Stoppa 2018-02-04  180  			goto same_name_err;
13e2be64 Igor Stoppa 2018-02-04  181  
13e2be64 Igor Stoppa 2018-02-04  182  	pool_name = kstrdup(name, GFP_KERNEL);
13e2be64 Igor Stoppa 2018-02-04  183  	if (unlikely(!pool_name))
13e2be64 Igor Stoppa 2018-02-04  184  		goto name_alloc_err;
13e2be64 Igor Stoppa 2018-02-04  185  
13e2be64 Igor Stoppa 2018-02-04  186  	data = kzalloc(sizeof(struct pmalloc_data), GFP_KERNEL);
13e2be64 Igor Stoppa 2018-02-04  187  	if (unlikely(!data))
13e2be64 Igor Stoppa 2018-02-04  188  		goto data_alloc_err;
13e2be64 Igor Stoppa 2018-02-04  189  
13e2be64 Igor Stoppa 2018-02-04  190  	data->protected = false;
13e2be64 Igor Stoppa 2018-02-04  191  	data->pool = pool;
13e2be64 Igor Stoppa 2018-02-04  192  	pmalloc_attr_init(data, protected);
13e2be64 Igor Stoppa 2018-02-04  193  	pmalloc_attr_init(data, avail);
13e2be64 Igor Stoppa 2018-02-04  194  	pmalloc_attr_init(data, size);
13e2be64 Igor Stoppa 2018-02-04  195  	pmalloc_attr_init(data, chunks);
13e2be64 Igor Stoppa 2018-02-04  196  	pool->data = data;
13e2be64 Igor Stoppa 2018-02-04  197  	pool->name = pool_name;
13e2be64 Igor Stoppa 2018-02-04  198  
13e2be64 Igor Stoppa 2018-02-04  199  	list_add(&data->node, pmalloc_list);
13e2be64 Igor Stoppa 2018-02-04  200  	if (pmalloc_list == &pmalloc_final_list)
13e2be64 Igor Stoppa 2018-02-04  201  		data->pool_kobject = pmalloc_connect(data);
13e2be64 Igor Stoppa 2018-02-04  202  	mutex_unlock(&pmalloc_mutex);
13e2be64 Igor Stoppa 2018-02-04  203  	return pool;
13e2be64 Igor Stoppa 2018-02-04  204  
13e2be64 Igor Stoppa 2018-02-04  205  data_alloc_err:
13e2be64 Igor Stoppa 2018-02-04  206  	kfree(pool_name);
13e2be64 Igor Stoppa 2018-02-04  207  name_alloc_err:
13e2be64 Igor Stoppa 2018-02-04  208  same_name_err:
13e2be64 Igor Stoppa 2018-02-04  209  	mutex_unlock(&pmalloc_mutex);
13e2be64 Igor Stoppa 2018-02-04 @210  	gen_pool_destroy(pool);
13e2be64 Igor Stoppa 2018-02-04  211  	return NULL;
13e2be64 Igor Stoppa 2018-02-04  212  }
13e2be64 Igor Stoppa 2018-02-04  213  

:::::: The code at line 100 was first introduced by commit
:::::: 13e2be64b34fce3c12159af55855eef7a8b4a54f Protectable Memory

:::::: TO: Igor Stoppa <igor.stoppa@huawei.com>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
