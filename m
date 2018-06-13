From: lkp@intel.com (kbuild test robot)
Date: Wed, 13 Jun 2018 22:24:38 +0800
Subject: [integrity:next-integrity-queued 20/22]
	security//integrity/iint.c:225:4: note: in expansion of macro 'pr_err'
Message-ID: <201806132233.Lv37Nqq9%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity-queued
head:   99c8c429103ee990d5a0357b102327da3073d06a
commit: 0ae8680d8fa0de49b7b933c67b74c2d745772140 [20/22] integrity: silence warning when CONFIG_SECURITYFS is not enabled
config: x86_64-randconfig-x012-201823 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout 0ae8680d8fa0de49b7b933c67b74c2d745772140
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:7:0,
                    from include/linux/kernel.h:14,
                    from include/asm-generic/bug.h:18,
                    from arch/x86/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from security//integrity/iint.c:18:
   security//integrity/iint.c: In function 'integrity_fs_init':
>> include/linux/kern_levels.h:5:18: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
    #define KERN_ERR KERN_SOH "3" /* error conditions */
                     ^~~~~~~~
   include/linux/printk.h:304:9: note: in expansion of macro 'KERN_ERR'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~
>> security//integrity/iint.c:225:4: note: in expansion of macro 'pr_err'
       pr_err("Unable to create integrity sysfs dir: %ld\n",
       ^~~~~~
   security//integrity/iint.c:225:52: note: format string is defined here
       pr_err("Unable to create integrity sysfs dir: %ld\n",
                                                     ~~^
                                                     %d
--
   In file included from include/linux/printk.h:7:0,
                    from include/linux/kernel.h:14,
                    from include/asm-generic/bug.h:18,
                    from arch/x86/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from security/integrity/iint.c:18:
   security/integrity/iint.c: In function 'integrity_fs_init':
>> include/linux/kern_levels.h:5:18: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
    #define KERN_ERR KERN_SOH "3" /* error conditions */
                     ^~~~~~~~
   include/linux/printk.h:304:9: note: in expansion of macro 'KERN_ERR'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~
   security/integrity/iint.c:225:4: note: in expansion of macro 'pr_err'
       pr_err("Unable to create integrity sysfs dir: %ld\n",
       ^~~~~~
   security/integrity/iint.c:225:52: note: format string is defined here
       pr_err("Unable to create integrity sysfs dir: %ld\n",
                                                     ~~^
                                                     %d

vim +/pr_err +225 security//integrity/iint.c

0c343af8 Matthew Garrett 2018-05-11  217  
0c343af8 Matthew Garrett 2018-05-11  218  static int __init integrity_fs_init(void)
0c343af8 Matthew Garrett 2018-05-11  219  {
0c343af8 Matthew Garrett 2018-05-11  220  	integrity_dir = securityfs_create_dir("integrity", NULL);
0c343af8 Matthew Garrett 2018-05-11  221  	if (IS_ERR(integrity_dir)) {
0ae8680d Sudeep Holla    2018-06-05  222  		int ret = PTR_ERR(integrity_dir);
0ae8680d Sudeep Holla    2018-06-05  223  
0ae8680d Sudeep Holla    2018-06-05  224  		if (ret != -ENODEV)
0c343af8 Matthew Garrett 2018-05-11 @225  			pr_err("Unable to create integrity sysfs dir: %ld\n",
0ae8680d Sudeep Holla    2018-06-05  226  			       ret);
0c343af8 Matthew Garrett 2018-05-11  227  		integrity_dir = NULL;
0ae8680d Sudeep Holla    2018-06-05  228  		return ret;
0c343af8 Matthew Garrett 2018-05-11  229  	}
0c343af8 Matthew Garrett 2018-05-11  230  
0c343af8 Matthew Garrett 2018-05-11  231  	return 0;
0c343af8 Matthew Garrett 2018-05-11  232  }
0c343af8 Matthew Garrett 2018-05-11  233  

:::::: The code at line 225 was first introduced by commit
:::::: 0c343af8065be5ceb0c03a876af7c513e960e2ff integrity: Add an integrity directory in securityfs

:::::: TO: Matthew Garrett <mjg59@google.com>
:::::: CC: Mimi Zohar <zohar@linux.vnet.ibm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
