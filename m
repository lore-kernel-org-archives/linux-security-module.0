From: lkp@intel.com (kbuild test robot)
Date: Fri, 1 Jun 2018 21:48:23 +0800
Subject: [PATCH V3 2/5 selinux-next] selinux: Introduce selinux_ruleset
	struct
In-Reply-To: <20180530141104.28569-3-peter.enderborg@sony.com>
References: <20180530141104.28569-3-peter.enderborg@sony.com>
Message-ID: <201806012133.FLgLxXv3%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Peter,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pcmoore-selinux/next]
[also build test WARNING on v4.17-rc7]
[cannot apply to security/next next-20180531]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Enderborg/selinux-Make-allocation-atomic-in-policydb-objects-functions/20180601-205558
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
config: i386-defconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:7:0,
                    from include/linux/kernel.h:14,
                    from security/selinux/ss/policydb.c:33:
   security/selinux/ss/policydb.c: In function 'policydb_flattened_alloc':
>> include/linux/kern_levels.h:5:18: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'size_t {aka unsigned int}' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
    #define KERN_ERR KERN_SOH "3" /* error conditions */
                     ^~~~~~~~
>> security/selinux/ss/policydb.c:3548:10: note: in expansion of macro 'KERN_ERR'
      printk(KERN_ERR "SELinux: vmalloc failed for %ld\n", *size);
             ^~~~~~~~
   security/selinux/ss/policydb.c:3548:50: note: format string is defined here
      printk(KERN_ERR "SELinux: vmalloc failed for %ld\n", *size);
                                                   ~~^
                                                   %d
--
   In file included from include/linux/printk.h:7:0,
                    from include/linux/kernel.h:14,
                    from security//selinux/ss/policydb.c:33:
   security//selinux/ss/policydb.c: In function 'policydb_flattened_alloc':
>> include/linux/kern_levels.h:5:18: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'size_t {aka unsigned int}' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
    #define KERN_ERR KERN_SOH "3" /* error conditions */
                     ^~~~~~~~
   security//selinux/ss/policydb.c:3548:10: note: in expansion of macro 'KERN_ERR'
      printk(KERN_ERR "SELinux: vmalloc failed for %ld\n", *size);
             ^~~~~~~~
   security//selinux/ss/policydb.c:3548:50: note: format string is defined here
      printk(KERN_ERR "SELinux: vmalloc failed for %ld\n", *size);
                                                   ~~^
                                                   %d

vim +/KERN_ERR +3548 security/selinux/ss/policydb.c

  3538	
  3539	int policydb_flattened_alloc(struct policydb *db, void **tmpbuf, size_t *size)
  3540	{
  3541		int rc = 0;
  3542	
  3543		*size = db->len;
  3544		*tmpbuf = vmalloc(*size);
  3545	
  3546		if (!*tmpbuf) {
  3547			rc = -ENOMEM;
> 3548			printk(KERN_ERR "SELinux: vmalloc failed for %ld\n", *size);
  3549		}
  3550		return rc;
  3551	}
  3552	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
