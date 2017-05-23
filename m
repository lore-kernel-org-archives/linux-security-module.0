From: lkp@intel.com (kbuild test robot)
Date: Tue, 23 May 2017 22:18:58 +0800
Subject: [PATCH v4 next 3/3] modules:capabilities: add a per-task modules
	auto-load mode
In-Reply-To: <1495454226-10027-4-git-send-email-tixxdz@gmail.com>
Message-ID: <201705232255.t9X5Tbez%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Djalal,

[auto build test ERROR on next-20170522]

url:    https://github.com/0day-ci/linux/commits/Djalal-Harouni/modules-automatic-module-loading-restrictions/20170523-193128
config: sparc64-allnoconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All errors (new ones prefixed by >>):

   In file included from arch/sparc/kernel/setup_64.c:32:0:
   include/linux/module.h:683:30: error: storage class specified for parameter '__module_address'
    static inline struct module *__module_address(unsigned long addr)
                                 ^~~~~~~~~~~~~~~~
   include/linux/module.h:683:30: error: parameter '__module_address' declared 'inline' [-Werror]
>> include/linux/module.h:684:1: error: 'always_inline' attribute ignored [-Werror=attributes]
    {
    ^
   include/linux/module.h:683:30: error: 'no_instrument_function' attribute applies only to functions
    static inline struct module *__module_address(unsigned long addr)
                                 ^~~~~~~~~~~~~~~~
   include/linux/module.h:684:1: error: expected ';', ',' or ')' before '{' token
    {
    ^
   cc1: all warnings being treated as errors

vim +/always_inline +684 include/linux/module.h

98702500 Djalal Harouni 2017-05-22  677  static inline int task_modules_autoload_mode(struct task_struct *task)
98702500 Djalal Harouni 2017-05-22  678  {
98702500 Djalal Harouni 2017-05-22  679  	return -ENOSYS;
98702500 Djalal Harouni 2017-05-22  680  }
98702500 Djalal Harouni 2017-05-22  681  
98702500 Djalal Harouni 2017-05-22  682  static inline bool within_module_core(unsigned long addr,
e610499e Rusty Russell  2009-03-31 @683  static inline struct module *__module_address(unsigned long addr)
e610499e Rusty Russell  2009-03-31 @684  {
e610499e Rusty Russell  2009-03-31  685  	return NULL;
e610499e Rusty Russell  2009-03-31  686  }
e610499e Rusty Russell  2009-03-31  687  

:::::: The code at line 684 was first introduced by commit
:::::: e610499e2656e61975affd0af56b26eb73964c84 module: __module_address

:::::: TO: Rusty Russell <rusty@rustcorp.com.au>
:::::: CC: Rusty Russell <rusty@rustcorp.com.au>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
