From: sargun@sargun.me (Sargun Dhillon)
Date: Thu, 17 May 2018 07:00:35 +0000
Subject: [PATCH 0/2] Change LSM registration to work with persistent struct
Message-ID: <20180517070033.GA22143@ircssh-2.c.rugged-nimbus-611.internal>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patchset breaks out the first patch from my patchset a while ago, which
started introducing external LSMs. One of the ideas was to make the management
of which LSMs are loaded a bit simpler. In the process, I discovered the
following bug:
root at ubuntu:~# dmesg |grep SELinux
[    0.044035] SELinux:  Initializing.
[    0.052063] SELinux:  Starting in permissive mode
[    3.625348] SELinux:  Registering netfilter hooks
root at ubuntu:~# cat /sys/kernel/security/lsm;echo
capability,yama,loadpin,selinux
root at ubuntu:~# echo 1 > /sys/fs/selinux/disable
root at ubuntu:~# dmesg |grep SELinux
[    0.044035] SELinux:  Initializing.
[    0.052063] SELinux:  Starting in permissive mode
[    3.625348] SELinux:  Registering netfilter hooks
[  189.230174] SELinux:  Disabled at runtime.
[  189.230398] SELinux:  Unregistering netfilter hooks
root at ubuntu:~# cat /sys/kernel/security/lsm;echo
capability,yama,loadpin,selinux

After this fix, it makes it so that it will be properly
removed, a la:
root at ubuntu:~# dmesg |grep SELinux
[    0.040169] SELinux:  Initializing.
[    0.048067] SELinux:  Starting in permissive mode
[    3.023873] SELinux:  Registering netfilter hooks
root at ubuntu:~# cat /sys/kernel/security/lsm;echo
capability,yama,loadpin,selinux
root at ubuntu:~# echo 1 > /sys/fs/selinux/disable
root at ubuntu:~# dmesg |grep SELinux
[    0.040169] SELinux:  Initializing.
[    0.048067] SELinux:  Starting in permissive mode
[    3.023873] SELinux:  Registering netfilter hooks
[  136.059277] SELinux:  Disabled at runtime.
[  136.059505] SELinux:  Unregistering netfilter hooks
root at ubuntu:~# cat /sys/kernel/security/lsm;echo
capability,yama,loadpin

This is pretty low-risk, but introduces two minor conflicts to:
[01/23] procfs: add smack subdir to attrs
[21/23] LSM: Multiple concurrent major security modules


Sargun Dhillon (2):
  security: Move LSM registration arguments to struct lsm_info
  security: Convert lsm list file to a seq_file based on lsm_info_head

 include/linux/lsm_hooks.h  | 47 +++++++++++--------------
 security/apparmor/lsm.c    |  5 +--
 security/commoncap.c       |  6 ++--
 security/inode.c           | 56 ++++++++++++++++++++++++++----
 security/loadpin/loadpin.c |  5 ++-
 security/security.c        | 85 +++++++++++++++++++++-------------------------
 security/security.h        | 10 ++++++
 security/selinux/hooks.c   |  7 ++--
 security/smack/smack_lsm.c |  4 ++-
 security/tomoyo/tomoyo.c   |  5 ++-
 security/yama/yama_lsm.c   |  5 ++-
 11 files changed, 146 insertions(+), 89 deletions(-)
 create mode 100644 security/security.h

-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
