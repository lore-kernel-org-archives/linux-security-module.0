From: lkp@intel.com (kbuild test robot)
Date: Tue, 3 Jul 2018 17:35:56 +0800
Subject: [PATCH v5 8/8] module: replace the existing LSM hook in
	init_module
In-Reply-To: <1530542283-26145-9-git-send-email-zohar@linux.vnet.ibm.com>
References: <1530542283-26145-9-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <201807031757.qpz6yHPo%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Mimi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on integrity/next-integrity]
[also build test WARNING on v4.18-rc3 next-20180702]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mimi-Zohar/kexec-firmware-support-system-wide-policy-requiring-signatures/20180703-011114
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> security/loadpin/loadpin.c:178:40: sparse: mixing different enum types
   security/loadpin/loadpin.c:178:40:     int enum kernel_load_data_id  versus
   security/loadpin/loadpin.c:178:40:     int enum kernel_read_file_id

vim +178 security/loadpin/loadpin.c

   175	
   176	static int loadpin_load_data(enum kernel_load_data_id id)
   177	{
 > 178		return loadpin_read_file(NULL, id);
   179	}
   180	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
