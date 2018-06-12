From: lkp@intel.com (kbuild test robot)
Date: Tue, 12 Jun 2018 10:53:25 +0800
Subject: [PATCH v2 2/2] tpm: add support for nonblocking operation
In-Reply-To: <152876282414.19591.7972634639749417028.stgit@tstruk-mobl1.jf.intel.com>
References: <152876282414.19591.7972634639749417028.stgit@tstruk-mobl1.jf.intel.com>
Message-ID: <201806120803.W0vjfLEH%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Tadeusz,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on next-20180608]
[cannot apply to v4.17]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Tadeusz-Struk/tpm-add-ptr-to-the-tpm_space-struct-to-file_priv/20180612-082203
config: i386-randconfig-x008-201823 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

>> drivers/char//tpm/tpm-dev-common.c:223:1: warning: data definition has no type or storage class
    __exitcall(tpm_dev_common_exit);
    ^~~~~~~~~~
>> drivers/char//tpm/tpm-dev-common.c:223:1: error: type defaults to 'int' in declaration of '__exitcall' [-Werror=implicit-int]
>> drivers/char//tpm/tpm-dev-common.c:223:1: warning: parameter names (without types) in function declaration
   drivers/char//tpm/tpm-dev-common.c:215:20: warning: 'tpm_dev_common_exit' defined but not used [-Wunused-function]
    static void __exit tpm_dev_common_exit(void)
                       ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +223 drivers/char//tpm/tpm-dev-common.c

   222	
 > 223	__exitcall(tpm_dev_common_exit);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
