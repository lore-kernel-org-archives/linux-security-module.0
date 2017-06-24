From: lkp@intel.com (kbuild test robot)
Date: Sun, 25 Jun 2017 05:02:24 +0800
Subject: [PATCH 1/3] xattr: Enable security.capability in user namespaces
In-Reply-To: <1498157989-11814-2-git-send-email-stefanb@linux.vnet.ibm.com>
Message-ID: <201706250409.PFosMVWz%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Stefan,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.12-rc6 next-20170623]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stefan-Berger/Enable-namespaced-file-capabilities/20170625-001722


coccinelle warnings: (new ones prefixed by >>)

>> fs/xattr.c:516:10-17: WARNING opportunity for kstrdep (strcpy on line 519)

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
