From: lkp@intel.com (kbuild test robot)
Date: Thu, 1 Mar 2018 00:27:33 +0800
Subject: [PATCH bpf-next v8 01/11] fs,security: Add a security blob to
	nameidata
In-Reply-To: <20180227004121.3633-2-mic@digikod.net>
References: <20180227004121.3633-2-mic@digikod.net>
Message-ID: <201803010059.epnyXU90%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Micka?l,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Micka-l-Sala-n/Landlock-LSM-Toward-unprivileged-sandboxing/20180228-233659
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: x86_64-randconfig-x017-201808 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from fs//quota/dquot.c:74:0:
>> include/linux/security.h:815:10: warning: 'struct nameidata_lookup' declared inside parameter list will not be visible outside of this definition or declaration
      struct nameidata_lookup *lookup, struct inode *inode)
             ^~~~~~~~~~~~~~~~

vim +815 include/linux/security.h

   813	
   814	static inline void security_nameidata_put_lookup(
 > 815			struct nameidata_lookup *lookup, struct inode *inode)
   816	{ }
   817	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
