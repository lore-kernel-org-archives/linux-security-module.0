From: jmorris@namei.org (James Morris)
Date: Tue, 14 Aug 2018 08:51:52 +1000 (AEST)
Subject: [GIT PULL] security subsystem: general update for v4.19
Message-ID: <alpine.LRH.2.21.1808140835030.2526@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Please pull these general updates for v4.19.

Summary:

- kstrdup() return value fix from Eric Biggers

- Add new security_load_data hook to differentiate security checking of 
kernel-loaded binaries in the case of there being no associated file 
descriptor, from Mimi Zohar.

- Add ability to IMA to specify a policy at build-time, rather than just 
via command line params or by loading a custom policy, from Mimi.

- Allow IMA and LSMs to prevent sysfs firmware load fallback (e.g. if 
using signed firmware), from Mimi.

- Allow IMA to deny loading of kexec kernel images, as they cannot be 
measured by IMA, from Mimi.


I'll followup with updates for Smack and TPM once this is merged.


---

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

for you to fetch changes up to 87ea58433208d17295e200d56be5e2a4fe4ce7d6:

  security: check for kstrdup() failure in lsm_append() (2018-07-17 21:27:06 -0700)

----------------------------------------------------------------
Arnd Bergmann (1):
      security: export security_kernel_load_data function

Eric Biggers (1):
      security: check for kstrdup() failure in lsm_append()

James Morris (1):
      Merge tag 'v4.18-rc2' into next-general

Mimi Zohar (8):
      security: define new LSM hook named security_kernel_load_data
      kexec: add call to LSM hook in original kexec_load syscall
      ima: based on policy require signed kexec kernel images
      firmware: add call to LSM hook before firmware sysfs fallback
      ima: based on policy require signed firmware (sysfs fallback)
      ima: add build time policy
      module: replace the existing LSM hook in init_module
      ima: based on policy warn about loading firmware (pre-allocated buffer)

Paul Moore (1):
      MAINTAINERS: remove the outdated "LINUX SECURITY MODULE (LSM) FRAMEWORK" entry

 MAINTAINERS                             |  5 ---
 drivers/base/firmware_loader/fallback.c |  7 ++++
 include/linux/ima.h                     |  7 ++++
 include/linux/lsm_hooks.h               |  6 +++
 include/linux/security.h                | 27 +++++++++++++
 kernel/kexec.c                          |  8 ++++
 kernel/module.c                         |  2 +-
 security/integrity/ima/Kconfig          | 58 ++++++++++++++++++++++++++++
 security/integrity/ima/ima.h            |  1 +
 security/integrity/ima/ima_main.c       | 68 ++++++++++++++++++++++++++-------
 security/integrity/ima/ima_policy.c     | 48 +++++++++++++++++++++--
 security/loadpin/loadpin.c              |  6 +++
 security/security.c                     | 13 +++++++
 security/selinux/hooks.c                | 15 ++++++++
 14 files changed, 248 insertions(+), 23 deletions(-)
