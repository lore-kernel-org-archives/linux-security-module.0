From: lkp@intel.com (kbuild test robot)
Date: Tue, 13 Jun 2017 08:02:02 +0800
Subject: [PATCH 09/11] Trampoline emulation
In-Reply-To: <1497286620-15027-10-git-send-email-s.mesoraca16@gmail.com>
Message-ID: <201706130733.FCafYuAP%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Salvatore,

[auto build test ERROR on security/next]
[also build test ERROR on v4.12-rc5]
[cannot apply to next-20170609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Salvatore-Mesoraca/S-A-R-A-Documentation/20170613-050631
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   security/sara/wxprot.c: In function 'sara_pagefault_handler_x86':
>> security/sara/wxprot.c:407:18: error: '__USER32_CS' undeclared (first use in this function)
         regs->cs == __USER32_CS ||
                     ^~~~~~~~~~~
   security/sara/wxprot.c:407:18: note: each undeclared identifier is reported only once for each function it appears in
>> security/sara/wxprot.c:409:17: warning: right shift count >= width of type [-Wshift-count-overflow]
      if (!(address >> 32)) /* K8 erratum #100 */
                    ^~

vim +/__USER32_CS +407 security/sara/wxprot.c

   401	
   402		local_irq_enable();
   403		might_sleep();
   404		might_fault();
   405	
   406		if (IS_ENABLED(CONFIG_X86_32) ||
 > 407		    regs->cs == __USER32_CS ||
   408		    (regs->cs & (1<<2))) {
 > 409			if (!(address >> 32))	/* K8 erratum #100 */
   410				ret = sara_pagefault_handler_x86_32(regs);
   411		} else
   412			ret = sara_pagefault_handler_x86_64(regs);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
