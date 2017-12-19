From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 19 Dec 2017 14:30:19 -0800
Subject: [PATCH 0/6] LSM: Infrastructure management of security blobs for
	stacking
Message-ID: <5219980c-b689-8bfe-1b77-38c76175fa56@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Subject: [PATCH 0/6] LSM: Infrastructure management of security blobs for stacking

Move the management of Linux Security Module (LSM) data blobs
out of the individual modules and into the LSM infrastructure.
The modules are now required to declare how much space they need
for each sort of blob used. This will allow modules that use
security blobs to be stacked so long as they aren't using hooks
that require secids. Several proposed modules, including S.A.R.A.,
PTAGS and Landlock, meet these criteria.

A patch set Addressing the secid and netlabel issues associated
with networking will follow, and should have minimal impact on
what is provided here. I am separating the patch sets because I
would like to finalize the blob management. They are different
problems requiring different mindset.

Also available git://github.com/cschaufler/lsm_stacking.git#stacking-4.16

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/admin-guide/LSM/index.rst |  23 +-
 fs/proc/base.c                          |  63 +++-
 fs/proc/internal.h                      |   1 +
 include/linux/lsm_hooks.h               |  26 +-
 include/linux/security.h                |  15 +-
 kernel/cred.c                           |  13 -
 security/Kconfig                        |  97 ++++++
 security/apparmor/context.c             |   2 -
 security/apparmor/include/context.h     |  24 +-
 security/apparmor/include/file.h        |   2 +-
 security/apparmor/lsm.c                 |  71 ++---
 security/security.c                     | 533 ++++++++++++++++++++++++++++++--
 security/selinux/hooks.c                | 490 ++++++++++-------------------
 security/selinux/include/objsec.h       |  87 +++++-
 security/selinux/netlabel.c             |  15 +-
 security/selinux/selinuxfs.c            |   5 +-
 security/selinux/ss/services.c          |   3 +-
 security/selinux/xfrm.c                 |   4 +-
 security/smack/smack.h                  |  90 +++++-
 security/smack/smack_access.c           |   2 +-
 security/smack/smack_lsm.c              | 532 +++++++++++--------------------
 security/smack/smack_netfilter.c        |   8 +-
 security/smack/smackfs.c                |  18 +-
 security/tomoyo/common.h                |  31 +-
 security/tomoyo/domain.c                |   4 +-
 security/tomoyo/securityfs_if.c         |  15 +-
 security/tomoyo/tomoyo.c                |  57 +++-
 27 files changed, 1390 insertions(+), 841 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
