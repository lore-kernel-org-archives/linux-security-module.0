From: john.johansen@canonical.com (John Johansen)
Date: Thu,  6 Apr 2017 06:55:18 -0700
Subject: [GIT PULL] AppArmor fixes for 4.12
Message-ID: <20170406135524.25481-1-john.johansen@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

Here is the pull request for 4.12

There are no new features here, just a small set of bug fixes since
the 4.11 pull request.

Thanks,
-John

---

The following changes since commit ef933e87785f42868980f0e3af91fec313612868:

  selinux: fix kernel BUG on prlimit(..., NULL, NULL) (2017-03-01 13:11:17 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor for-security

for you to fetch changes up to 6ebcd4c271332ca4f4dd958219f2ff1b7db1ed59:

  apparmor: Make path_max parameter readonly (2017-04-06 05:14:20 -0700)

----------------------------------------------------------------
John Johansen (3):
      apparmor: fix invalid reference to index variable of iterator line 836
      apparmor: fix parameters so that the permission test is bypassed at boot
      apparmor: Make path_max parameter readonly

Nicolas Iooss (1):
      apparmor: use SHASH_DESC_ON_STACK

Valentin Rothberg (1):
      security/apparmor/lsm.c: set debug messages

kbuild test robot (1):
      apparmor: fix boolreturn.cocci warnings

 security/apparmor/crypto.c      | 32 +++++++++++---------------
 security/apparmor/include/lib.h |  2 +-
 security/apparmor/lib.c         |  4 ++--
 security/apparmor/lsm.c         | 51 +++++++++++++++++++----------------------
 security/apparmor/policy.c      |  6 +++--
5 files changed, 44 insertions(+), 51 deletions(-)
      

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
