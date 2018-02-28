From: lkp@intel.com (kbuild test robot)
Date: Thu, 1 Mar 2018 00:58:42 +0800
Subject: [PATCH bpf-next v8 01/11] fs,security: Add a security blob to
	nameidata
In-Reply-To: <20180227004121.3633-2-mic@digikod.net>
References: <20180227004121.3633-2-mic@digikod.net>
Message-ID: <201803010052.yZlY06o7%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Micka?l,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Micka-l-Sala-n/Landlock-LSM-Toward-unprivileged-sandboxing/20180228-233659
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: i386-randconfig-a1-201808 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from init/main.c:37:0:
>> include/linux/security.h:815:43: warning: 'struct nameidata_lookup' declared inside parameter list
      struct nameidata_lookup *lookup, struct inode *inode)
                                              ^
>> include/linux/security.h:815:43: warning: its scope is only this definition or declaration, which is probably not what you want
--
   In file included from fs/namei.c:27:0:
>> include/linux/security.h:815:43: warning: 'struct nameidata_lookup' declared inside parameter list
      struct nameidata_lookup *lookup, struct inode *inode)
                                              ^
>> include/linux/security.h:815:43: warning: its scope is only this definition or declaration, which is probably not what you want
   fs/namei.c: In function 'restore_nameidata':
   fs/namei.c:531:36: error: 'struct nameidata' has no member named 'lookup'
     security_nameidata_put_lookup(&now->lookup, now->inode);
                                       ^
--
   In file included from include/linux/lsm_hooks.h:28:0,
                    from security/commoncap.c:15:
>> include/linux/security.h:815:43: warning: 'struct nameidata_lookup' declared inside parameter list
      struct nameidata_lookup *lookup, struct inode *inode)
                                              ^
>> include/linux/security.h:815:43: warning: its scope is only this definition or declaration, which is probably not what you want
   In file included from security/commoncap.c:15:0:
>> include/linux/lsm_hooks.h:1522:13: warning: 'struct nameidata_lookup' declared inside parameter list
         struct inode *inode);
                ^

vim +815 include/linux/security.h

   813	
   814	static inline void security_nameidata_put_lookup(
 > 815			struct nameidata_lookup *lookup, struct inode *inode)
   816	{ }
   817	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
