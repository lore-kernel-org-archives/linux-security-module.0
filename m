From: john.johansen@canonical.com (John Johansen)
Date: Fri, 18 Aug 2017 06:50:28 -0700
Subject: [GIT PULL] apparmor updates for next
Message-ID: <97514264-2fd2-437c-7bfb-bee627a52be6@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

Please pull these apparmor changes for next.

Thanks!

-Kees

The following changes since commit 706224ae390ddbf1871abb7938245be45bf04104:

  samples: Unrename SECCOMP_RET_KILL (2017-08-17 14:17:07 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor for-security

for you to fetch changes up to 76e22e212a850bbd16cf49f9c586d4635507e0b5:

  apparmor: fix incorrect type assignment when freeing proxies (2017-08-18 06:45:37 -0700)

----------------------------------------------------------------
Christos Gkekas (1):
      apparmor: Fix logical error in verify_header()

Dan Carpenter (1):
      apparmor: Fix an error code in aafs_create()

Geert Uytterhoeven (1):
      apparmor: Fix shadowed local variable in unpack_trans_table()

John Johansen (12):
      apparmor: Redundant condition: prev_ns. in [label.c:1498]
      apparmor: add the ability to mediate signals
      apparmor: add mount mediation
      apparmor: cleanup conditional check for label in label_print
      apparmor: add support for absolute root view based labels
      apparmor: make policy_unpack able to audit different info messages
      apparmor: add more debug asserts to apparmorfs
      apparmor: add base infastructure for socket mediation
      apparmor: move new_null_profile to after profile lookup fns()
      apparmor: fix race condition in null profile creation
      apparmor: ensure unconfined profiles have dfas initialized
      apparmor: fix incorrect type assignment when freeing proxies

 security/apparmor/.gitignore          |   1 +
 security/apparmor/Makefile            |  43 ++-
 security/apparmor/apparmorfs.c        |  37 +-
 security/apparmor/domain.c            |   4 +-
 security/apparmor/file.c              |  30 ++
 security/apparmor/include/apparmor.h  |   2 +
 security/apparmor/include/audit.h     |  39 +-
 security/apparmor/include/domain.h    |   5 +
 security/apparmor/include/ipc.h       |   6 +
 security/apparmor/include/label.h     |   1 +
 security/apparmor/include/mount.h     |  54 +++
 security/apparmor/include/net.h       | 114 ++++++
 security/apparmor/include/perms.h     |   5 +-
 security/apparmor/include/policy.h    |  13 +
 security/apparmor/include/sig_names.h |  95 +++++
 security/apparmor/ipc.c               |  99 +++++
 security/apparmor/label.c             |  36 +-
 security/apparmor/lib.c               |   5 +-
 security/apparmor/lsm.c               | 472 +++++++++++++++++++++++
 security/apparmor/mount.c             | 696 ++++++++++++++++++++++++++++++++++
 security/apparmor/net.c               | 184 +++++++++
 security/apparmor/policy.c            | 166 ++++----
 security/apparmor/policy_ns.c         |   2 +
 security/apparmor/policy_unpack.c     | 105 ++++-
 24 files changed, 2081 insertions(+), 133 deletions(-)
 create mode 100644 security/apparmor/include/mount.h
 create mode 100644 security/apparmor/include/net.h
 create mode 100644 security/apparmor/include/sig_names.h
 create mode 100644 security/apparmor/mount.c
 create mode 100644 security/apparmor/net.c
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
