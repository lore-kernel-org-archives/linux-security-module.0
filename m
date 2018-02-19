From: lkp@intel.com (kbuild test robot)
Date: Tue, 20 Feb 2018 07:36:30 +0800
Subject: [PATCH v1 1/2] ima: fail signature verification on untrusted
	filesystems
In-Reply-To: <1519053483-18396-2-git-send-email-zohar@linux.vnet.ibm.com>
References: <1519053483-18396-2-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <201802200726.dwtJaW4L%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Mimi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc2 next-20180219]
[cannot apply to integrity/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mimi-Zohar/ima-untrusted-filesystems/20180220-040517
config: x86_64-rhel (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

>> WARNING: vmlinux.o(.text+0x3b320a): Section mismatch in reference from the function ima_match_policy() to the variable .init.data:init_keyring
   The function ima_match_policy() references
   the variable __initdata init_keyring.
   This is often because ima_match_policy lacks a __initdata
   annotation or the annotation of init_keyring is wrong.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
