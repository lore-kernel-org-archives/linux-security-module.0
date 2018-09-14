From: lkp@intel.com (kbuild test robot)
Date: Fri, 14 Sep 2018 21:50:31 +0800
Subject: [PATCH v2 6/6] x86/ima: define arch_get_ima_policy() for x86
In-Reply-To: <20180914080005.6138-7-nayna@linux.vnet.ibm.com>
References: <20180914080005.6138-7-nayna@linux.vnet.ibm.com>
Message-ID: <201809142126.oa45Rj76%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Eric,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on integrity/next-integrity]
[also build test ERROR on v4.19-rc3 next-20180913]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nayna-Jain/Add-support-for-architecture-specific-IMA-policies/20180914-202254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
config: i386-randconfig-s1-201836 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> arch/x86//kernel/ima_arch.c:28:21: error: redefinition of 'arch_get_ima_policy'
    const char * const *arch_get_ima_policy(void)
                        ^~~~~~~~~~~~~~~~~~~
   In file included from arch/x86//kernel/ima_arch.c:6:0:
   include/linux/ima.h:45:35: note: previous definition of 'arch_get_ima_policy' was here
    static inline const char * const *arch_get_ima_policy(void)
                                      ^~~~~~~~~~~~~~~~~~~

vim +/arch_get_ima_policy +28 arch/x86//kernel/ima_arch.c

    27	
  > 28	const char * const *arch_get_ima_policy(void)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
