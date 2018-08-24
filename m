From: john.johansen@canonical.com (John Johansen)
Date: Thu, 23 Aug 2018 19:34:46 -0700
Subject: [GIT PULL] apparmor updates for v4.19
Message-ID: <f4d603ba-254b-fbf5-8d06-11cc61d29de0@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,


Please pull these apparmor changes for v4.19. There is nothing major this time just 4 bug fixes and a patch to remove so dead code.

Thanks!

- John


The following changes since commit fb7d1bcf1602b46f37ada72178516c01a250e434:

  Merge tag 'pci-v4.18-fixes-3' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci (2018-07-19 11:54:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2018-08-23

for you to fetch changes up to c037bd615885f1d9d3bdb48531bace79fae1505d:

  apparmor: remove no-op permission check in policy_unpack (2018-08-22 18:44:42 -0700)

----------------------------------------------------------------
+ Cleanups
  - apparmor: remove no-op permission check in policy_unpack

+ Bug fixes
  - apparmor: fix an error code in __aa_create_ns()
  - apparmor: Fix failure to audit context info in build_change_hat
  - apparmor: Check buffer bounds when mapping permissions mask
  - apparmor: Fully initialize aa_perms struct when answering userspace query

----------------------------------------------------------------
Dan Carpenter (1):
      apparmor: fix an error code in __aa_create_ns()

John Johansen (2):
      apparmor: Fix failure to audit context info in build_change_hat
      apparmor: remove no-op permission check in policy_unpack

Tyler Hicks (2):
      apparmor: Check buffer bounds when mapping permissions mask
      apparmor: Fully initialize aa_perms struct when answering userspace query

 security/apparmor/apparmorfs.c    |  5 +----
 security/apparmor/domain.c        |  2 +-
 security/apparmor/file.c          |  3 ++-
 security/apparmor/include/perms.h |  3 ++-
 security/apparmor/lib.c           | 17 +++++++++++++----
 security/apparmor/policy_ns.c     |  2 +-
 security/apparmor/policy_unpack.c | 32 --------------------------------
 7 files changed, 20 insertions(+), 44 deletions(-)
