From: lkp@intel.com (kbuild test robot)
Date: Tue, 20 Feb 2018 06:50:34 +0800
Subject: [PATCH v1 1/2] ima: fail signature verification on untrusted
	filesystems
In-Reply-To: <1519053483-18396-2-git-send-email-zohar@linux.vnet.ibm.com>
References: <1519053483-18396-2-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <201802200637.f8w7cht0%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Mimi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc2 next-20180219]
[cannot apply to integrity/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mimi-Zohar/ima-untrusted-filesystems/20180220-040517
config: i386-randconfig-s1-201807 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

>> WARNING: vmlinux.o(.text+0x2afe73): Section mismatch in reference from the function ima_match_policy() to the variable .init.data:ima_fail_untrusted_fs
   The function ima_match_policy() references
   the variable __initdata ima_fail_untrusted_fs.
   This is often because ima_match_policy lacks a __initdata
   annotation or the annotation of ima_fail_untrusted_fs is wrong.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
