From: john.johansen@canonical.com (John Johansen)
Date: Wed, 13 Jun 2018 04:23:15 -0700
Subject: [GIT PULL] apparmor updates for v4.18
Message-ID: <7a8e5491-fd2c-b904-33cc-b32e5e9f8896@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,


Please pull these apparmor changes for v4.18

Thanks!

- John


The following changes since commit 552c69b36ebd966186573b9c7a286b390935cce1:

  Merge tag 'v4.17-rc3' into apparmor-next (2018-05-02 00:38:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2018-06-13

for you to fetch changes up to 338d0be437ef10e247a35aed83dbab182cf406a2:

  apparmor: fix ptrace read check (2018-06-07 01:51:02 -0700)

----------------------------------------------------------------
+ Features
  - add support for mapping secids and using secctxes
  - add the ability to get a task's secid
  - add support for audit rule filtering

+ Cleanups
  - multiple typo fixes
  - Convert to use match_string() helper
  - update git and wiki locations in AppArmor docs
  - improve get_buffers macro by using get_cpu_ptr
  - Use an IDR to allocate apparmor secids

+ Bug fixes
  - fix '*seclen' is never less than zero
  - fix mediation of prlimit
  - fix memory leak when deduping profile load
  - fix ptrace read check
  - fix memory leak of rule on error exit path

----------------------------------------------------------------
Andy Shevchenko (1):
      apparmor: Convert to use match_string() helper

John Johansen (9):
      apparmor: add support for mapping secids and using secctxes
      apparmor: add the ability to get a task's secid
      apparmor: fix '*seclen' is never less than zero
      apparmor: improve get_buffers macro by using get_cpu_ptr
      apparmor: modify audit rule support to support profile stacks
      apparmor: fixup secid map conversion to using IDR
      apparmor: fix mediation of prlimit
      apparmor: fix memory leak when deduping profile load
      apparmor: fix ptrace read check

Jordan Glover (1):
      apparmor: update git and wiki locations in AppArmor docs

Matthew Garrett (1):
      apparmor: Add support for audit rule filtering

Matthew Wilcox (1):
      apparmor: Use an IDR to allocate apparmor secids

Tyler Hicks (1):
      apparmor: Fix memory leak of rule on error exit path

Zygmunt Krynicki (7):
      apparmor: fix typo "loosen"
      apparmor: fix typo "comparison"
      apparmor: fix typo "replace"
      apparmor: fix typo "type"
      apparmor: fix typo "traverse"
      apparmor: fix typo "independent"
      apparmor: fix typo "preconfinement"

 Documentation/admin-guide/LSM/apparmor.rst |   6 +-
 security/apparmor/audit.c                  |  90 ++++++++++++++++-
 security/apparmor/domain.c                 |   2 +-
 security/apparmor/include/audit.h          |   6 ++
 security/apparmor/include/label.h          |   2 +-
 security/apparmor/include/path.h           |  33 +++----
 security/apparmor/include/secid.h          |  17 +++-
 security/apparmor/label.c                  |  15 ++-
 security/apparmor/lib.c                    |   2 +-
 security/apparmor/lsm.c                    |  50 +++++++---
 security/apparmor/match.c                  |   2 +-
 security/apparmor/mount.c                  |   2 +-
 security/apparmor/policy.c                 |   7 +-
 security/apparmor/resource.c               |   2 +-
 security/apparmor/secid.c                  | 151 +++++++++++++++++++++++++----
 15 files changed, 313 insertions(+), 74 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
