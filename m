From: lkp@intel.com (kbuild test robot)
Date: Thu, 20 Apr 2017 09:57:52 +0800
Subject: [PATCH v3 2/2] modules:capabilities: add a per-task modules
	autoload restriction
In-Reply-To: <1492640420-27345-3-git-send-email-tixxdz@gmail.com>
Message-ID: <201704200933.WfNVZLFx%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Djalal,

[auto build test ERROR on security/next]
[also build test ERROR on next-20170419]
[cannot apply to linus/master v4.11-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Djalal-Harouni/modules-capabilities-automatic-module-loading-restrictions/20170420-093603
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next
config: x86_64-randconfig-x017-201716 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   In file included from include/net/scm.h:7:0,
                    from include/linux/netlink.h:8,
                    from include/uapi/linux/neighbour.h:5,
                    from include/linux/netdevice.h:51,
                    from include/net/sock.h:51,
                    from fs//ocfs2/cluster/tcp.h:32,
                    from fs//ocfs2/cluster/heartbeat.c:41:
   include/linux/security.h: In function 'security_task_alloc':
>> include/linux/security.h:869:9: error: implicit declaration of function 'cap_task_alloc' [-Werror=implicit-function-declaration]
     return cap_task_alloc(task, clone_flags);
            ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/cap_task_alloc +869 include/linux/security.h

   863		return 0;
   864	}
   865	
   866	static inline int security_task_alloc(struct task_struct *task,
   867					      unsigned long clone_flags)
   868	{
 > 869		return cap_task_alloc(task, clone_flags);
   870	}
   871	
   872	static inline void security_task_free(struct task_struct *task)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27284 bytes
Desc: not available
URL: <http://kernsec.org/pipermail/linux-security-module-archive/attachments/20170420/394b73b7/attachment.bin>
