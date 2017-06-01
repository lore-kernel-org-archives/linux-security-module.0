From: lkp@intel.com (kbuild test robot)
Date: Fri, 2 Jun 2017 07:56:16 +0800
Subject: [PATCH] tpm: Enable CLKRUN protocol for Braswell systems
In-Reply-To: <1496344432-76640-1-git-send-email-azhar.shaikh@intel.com>
Message-ID: <201706020756.rGf6jOpP%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Azhar,

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on v4.12-rc3]
[cannot apply to next-20170601]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Azhar-Shaikh/tpm-Enable-CLKRUN-protocol-for-Braswell-systems/20170602-053032
config: frv-allyesconfig (attached as .config)
compiler: frv-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=frv 

All errors (new ones prefixed by >>):

   drivers/char/tpm/tpm_tis.c: In function 'disable_lpc_clk_run':
>> drivers/char/tpm/tpm_tis.c:101:3: error: implicit declaration of function 'kmap_atomic_pfn' [-Werror=implicit-function-declaration]
      kmap_atomic_pfn(INTEL_LEGACY_BLK_BASE_ADDR >> PAGE_SHIFT);
      ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/kmap_atomic_pfn +101 drivers/char/tpm/tpm_tis.c

    95	static void disable_lpc_clk_run(void)
    96	{
    97		u32 clkrun_val;
    98		void __iomem *ilb_base_addr = NULL;
    99	
   100		ilb_base_addr = (void __iomem *)
 > 101			kmap_atomic_pfn(INTEL_LEGACY_BLK_BASE_ADDR >> PAGE_SHIFT);
   102	
   103		clkrun_val = ioread32(ilb_base_addr + LPC_CNTRL_REG_OFFSET);
   104	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
