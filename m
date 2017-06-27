From: lkp@intel.com (kbuild test robot)
Date: Tue, 27 Jun 2017 11:17:37 +0800
Subject: [PATCH 1/3] Protectable memory support
In-Reply-To: <20170626144116.27599-2-igor.stoppa@huawei.com>
Message-ID: <201706271155.SBkfOuT6%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Igor,

[auto build test WARNING on mmotm/master]
[also build test WARNING on v4.12-rc7 next-20170626]
[cannot apply to linus/master linux/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/ro-protection-for-dynamic-data/20170627-103230
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: i386-tinyconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   mm/pmalloc.c: In function '__pmalloc_pool_show_avail':
>> mm/pmalloc.c:81:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t {aka unsigned int}' [-Wformat=]
     return sprintf(buf, "%lu\n", gen_pool_avail(data->pool));
                            ^
   mm/pmalloc.c: In function '__pmalloc_pool_show_size':
   mm/pmalloc.c:91:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t {aka unsigned int}' [-Wformat=]
     return sprintf(buf, "%lu\n", gen_pool_size(data->pool));
                            ^

vim +81 mm/pmalloc.c

    65		struct pmalloc_data *data;
    66	
    67		data = container_of(attr, struct pmalloc_data, attr_protected);
    68		if (atomic_read(&data->protected))
    69			return sprintf(buf, "protected\n");
    70		else
    71			return sprintf(buf, "unprotected\n");
    72	}
    73	
    74	static ssize_t __pmalloc_pool_show_avail(struct device *dev,
    75						 struct device_attribute *attr,
    76						 char *buf)
    77	{
    78		struct pmalloc_data *data;
    79	
    80		data = container_of(attr, struct pmalloc_data, attr_avail);
  > 81		return sprintf(buf, "%lu\n", gen_pool_avail(data->pool));
    82	}
    83	
    84	static ssize_t __pmalloc_pool_show_size(struct device *dev,
    85						struct device_attribute *attr,
    86						char *buf)
    87	{
    88		struct pmalloc_data *data;
    89	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
