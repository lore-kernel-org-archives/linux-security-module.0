From: lkp@intel.com (kbuild test robot)
Date: Wed, 13 Jun 2018 22:39:00 +0800
Subject: [integrity:next-integrity-queued 20/22]
	security/integrity/iint.c:225:4: warning: format '%ld' expects argument
	of type 'long int', but argument 2 has type 'int'
Message-ID: <201806132256.DfSETQty%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity-queued
head:   99c8c429103ee990d5a0357b102327da3073d06a
commit: 0ae8680d8fa0de49b7b933c67b74c2d745772140 [20/22] integrity: silence warning when CONFIG_SECURITYFS is not enabled
config: i386-randconfig-b0-06131940 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        git checkout 0ae8680d8fa0de49b7b933c67b74c2d745772140
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   security/integrity/iint.c: In function 'integrity_fs_init':
>> security/integrity/iint.c:225:4: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'int' [-Wformat=]
       pr_err("Unable to create integrity sysfs dir: %ld\n",
       ^

vim +225 security/integrity/iint.c

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
