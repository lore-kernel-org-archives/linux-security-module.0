From: lkp@intel.com (kbuild test robot)
Date: Tue, 13 Jun 2017 09:15:36 +0800
Subject: [PATCH 03/11] Creation of "usb_device_auth" LSM hook
In-Reply-To: <1497286620-15027-4-git-send-email-s.mesoraca16@gmail.com>
Message-ID: <201706130839.2rJO1rou%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Salvatore,

[auto build test WARNING on security/next]
[also build test WARNING on v4.12-rc5]
[cannot apply to next-20170609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Salvatore-Mesoraca/S-A-R-A-Documentation/20170613-050631
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next
config: cris-allyesconfig (attached as .config)
compiler: cris-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=cris 

All warnings (new ones prefixed by >>):

>> security/sara/securityfs.c:24:0: warning: "STR" redefined
    #define STR(x) STR_HELPER(x)
    
   In file included from arch/cris/include/asm/irq.h:4:0,
                    from include/linux/irq.h:26,
                    from include/asm-generic/hardirq.h:12,
                    from ./arch/cris/include/generated/asm/hardirq.h:1,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from include/linux/usb.h:15,
                    from include/linux/security.h:33,
                    from security/sara/securityfs.c:17:
   arch/cris/include/arch-v10/arch/irq.h:81:0: note: this is the location of the previous definition
    #define STR(x) __STR(x)
    

vim +/STR +24 security/sara/securityfs.c

4c272b9a Salvatore Mesoraca 2017-06-12   8   * published by the Free Software Foundation.
4c272b9a Salvatore Mesoraca 2017-06-12   9   *
4c272b9a Salvatore Mesoraca 2017-06-12  10   */
4c272b9a Salvatore Mesoraca 2017-06-12  11  
4c272b9a Salvatore Mesoraca 2017-06-12  12  #include <linux/ctype.h>
4c272b9a Salvatore Mesoraca 2017-06-12  13  #include <linux/seq_file.h>
4c272b9a Salvatore Mesoraca 2017-06-12  14  #include <linux/uaccess.h>
4c272b9a Salvatore Mesoraca 2017-06-12  15  #include <linux/mm.h>
4c272b9a Salvatore Mesoraca 2017-06-12  16  #include <linux/spinlock.h>
4c272b9a Salvatore Mesoraca 2017-06-12  17  #include <linux/security.h>
4c272b9a Salvatore Mesoraca 2017-06-12  18  
4c272b9a Salvatore Mesoraca 2017-06-12  19  #include "include/sara.h"
4c272b9a Salvatore Mesoraca 2017-06-12  20  #include "include/utils.h"
4c272b9a Salvatore Mesoraca 2017-06-12  21  #include "include/securityfs.h"
4c272b9a Salvatore Mesoraca 2017-06-12  22  
4c272b9a Salvatore Mesoraca 2017-06-12  23  #define STR_HELPER(x) #x
4c272b9a Salvatore Mesoraca 2017-06-12 @24  #define STR(x) STR_HELPER(x)
4c272b9a Salvatore Mesoraca 2017-06-12  25  
4c272b9a Salvatore Mesoraca 2017-06-12  26  static struct dentry *fs_root;
4c272b9a Salvatore Mesoraca 2017-06-12  27  
4c272b9a Salvatore Mesoraca 2017-06-12  28  static inline bool check_config_write_access(void)
4c272b9a Salvatore Mesoraca 2017-06-12  29  {
4c272b9a Salvatore Mesoraca 2017-06-12  30  	if (unlikely(sara_config_locked && !capable(CAP_MAC_ADMIN))) {
4c272b9a Salvatore Mesoraca 2017-06-12  31  		pr_warn("config write access blocked.\n");
4c272b9a Salvatore Mesoraca 2017-06-12  32  		return false;

:::::: The code at line 24 was first introduced by commit
:::::: 4c272b9af7b3b969359f7c0dc41fd2a8a03be9fc S.A.R.A. framework creation

:::::: TO: Salvatore Mesoraca <s.mesoraca16@gmail.com>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
