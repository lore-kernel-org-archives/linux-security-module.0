From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 17 Aug 2017 01:58:29 +0800
Subject: [integrity:next-log-iversion 9/11] include/linux/ima.h:70:20:
	warning: 'ima_sb_post_new_mount' used but never defined
Message-ID: <201708170127.b1ajiWwb%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-log-iversion
head:   5873cd8f629e0306acdc40d3a9142eb50ae70c2d
commit: 58015ce0b48226300bb6805a75c99cf538a524c6 [9/11] ima: define new ima_sb_post_new_mount hook
config: x86_64-randconfig-x007-201733 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 58015ce0b48226300bb6805a75c99cf538a524c6
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from security/security.c:22:0:
   include/linux/ima.h:72:1: error: expected identifier or '(' before '{' token
    { }
    ^
   In file included from security/security.c:22:0:
>> include/linux/ima.h:70:20: warning: 'ima_sb_post_new_mount' used but never defined
    static inline void ima_sb_post_new_mount(const struct vfsmount *newmnt,
                       ^~~~~~~~~~~~~~~~~~~~~

vim +/ima_sb_post_new_mount +70 include/linux/ima.h

    69	
  > 70	static inline void ima_sb_post_new_mount(const struct vfsmount *newmnt,
    71						 const struct path *path);
  > 72	{ }
    73	#endif /* CONFIG_IMA */
    74	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
