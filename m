From: lkp@intel.com (kbuild test robot)
Date: Sat, 28 Jul 2018 10:24:41 +0800
Subject: [PATCH 1/4] ima: add support for arch specific policies
In-Reply-To: <20180725233200.761-2-erichte@linux.vnet.ibm.com>
References: <20180725233200.761-2-erichte@linux.vnet.ibm.com>
Message-ID: <201807281011.3IfKWpyx%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Nayna,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on integrity/next-integrity]
[also build test WARNING on next-20180727]
[cannot apply to v4.18-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Eric-Richter/ima-add-support-for-arch-specific-policies/20180728-072442
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> security/integrity/ima/ima_policy.c:198:23: sparse: symbol 'arch_policy_rules' was not declared. Should it be static?
>> security/integrity/ima/ima_policy.c:199:23: sparse: symbol 'arch_policy_entry' was not declared. Should it be static?
   include/linux/slab.h:631:13: sparse: undefined identifier '__builtin_mul_overflow'
   include/linux/slab.h:631:13: sparse: not a function <noident>
   include/linux/slab.h:631:13: sparse: call with no type!

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
