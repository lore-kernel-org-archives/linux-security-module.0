From: lkp@intel.com (kbuild test robot)
Date: Fri, 2 Feb 2018 13:41:16 +0800
Subject: [PATCH 4/6] Protectable Memory
In-Reply-To: <20180130151446.24698-5-igor.stoppa@huawei.com>
References: <20180130151446.24698-5-igor.stoppa@huawei.com>
Message-ID: <201802021301.54moEmsn%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.15]
[cannot apply to next-20180201]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/mm-security-ro-protection-for-dynamic-data/20180202-123437
config: i386-randconfig-x071-201804 (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   mm/pmalloc.c: In function 'pmalloc_pool_show_avail':
>> mm/pmalloc.c:71:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t {aka unsigned int}' [-Wformat=]
     return sprintf(buf, "%lu\n", gen_pool_avail(data->pool));
                          ~~^     ~~~~~~~~~~~~~~~~~~~~~~~~~~
                          %u
   mm/pmalloc.c: In function 'pmalloc_pool_show_size':
   mm/pmalloc.c:81:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t {aka unsigned int}' [-Wformat=]
     return sprintf(buf, "%lu\n", gen_pool_size(data->pool));
                          ~~^     ~~~~~~~~~~~~~~~~~~~~~~~~~
                          %u

vim +71 mm/pmalloc.c

    63	
    64	static ssize_t pmalloc_pool_show_avail(struct kobject *dev,
    65					       struct kobj_attribute *attr,
    66					       char *buf)
    67	{
    68		struct pmalloc_data *data;
    69	
    70		data = container_of(attr, struct pmalloc_data, attr_avail);
  > 71		return sprintf(buf, "%lu\n", gen_pool_avail(data->pool));
    72	}
    73	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
