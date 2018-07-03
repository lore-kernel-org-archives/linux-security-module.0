From: lkp@intel.com (kbuild test robot)
Date: Tue, 3 Jul 2018 20:04:49 +0800
Subject: [PATCH v5 4/8] firmware: add call to LSM hook before firmware
	sysfs fallback
In-Reply-To: <1530542283-26145-5-git-send-email-zohar@linux.vnet.ibm.com>
References: <1530542283-26145-5-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <201807031814.ptUHudMj%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Mimi,

I love your patch! Yet something to improve:

[auto build test ERROR on integrity/next-integrity]
[also build test ERROR on v4.18-rc3 next-20180702]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mimi-Zohar/kexec-firmware-support-system-wide-policy-requiring-signatures/20180703-011114
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
config: x86_64-randconfig-ws0-07031240 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> ERROR: "security_kernel_load_data" [drivers/base/firmware_loader/firmware_class.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
