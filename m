From: lkp@intel.com (kbuild test robot)
Date: Tue, 24 Oct 2017 18:41:08 +0800
Subject: [PATCH v2 2/2] ima: check signature enforcement against cmdline
	param instead of CONFIG
In-Reply-To: <9fee5f63971c31870a345b2619251f23b4f7462e.1508776704.git.brdeoliv@redhat.com>
Message-ID: <201710241856.M1LDhOUO%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Bruno,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.14-rc6 next-20171018]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bruno-E-O-Meneguele/ima-change-how-MODULE_SIG_FORCE-is-checked-on-modules-checking-policy/20171024-105837
config: i386-randconfig-x0-10241354 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   security/integrity/ima/ima_main.o: In function `ima_read_file':
>> ima_main.c:(.text+0x98e): undefined reference to `is_module_sig_enforced'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
