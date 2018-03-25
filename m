From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Sun, 25 Mar 2018 13:46:25 -0400
Subject: [GIT PULL] linux-integrity patches for Linux 4.17
Message-ID: <1521999985.3541.32.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

This pull request contains a mixture of bug fixes, code cleanup, and
continues to close IMA-measurement, IMA-appraisal, and IMA-audit gaps.

Closing measurement, appraisal, and audit gaps:
- A new LSM hook named security_cred_getsecid is defined in order to
validate a file's integrity based on the credentials of the process
going to being executed, not of the existing process.

- Fuse filesystems are inherently untrusted. ?Instead of always re-
evaluating files, this pull request differentiates between privileged
and unprivileged mounts, and defines a new builtin policy to fail file
signature verification even on privileged mounted filesystems.

Code cleanup:
- Support for verifying a file's integrity based on an appended
signature (scripts/sign-file) is coming along really nicely. ?This
pull request includes some of the cleanup patches from the appended
signature patch series.
?
thanks,

Mimi
---

The following changes since commit 5893ed18a26d1f56b97c0290b0cbbc2d49d6de28:

  Merge tag 'v4.16-rc6' into next-general (2018-03-23 08:26:16 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

for you to fetch changes up to ab60368ab6a452466885ef4edf0cefd089465132:

  ima: Fallback to the builtin hash algorithm (2018-03-25 07:26:32 -0400)

----------------------------------------------------------------
Hern?n Gonzalez (2):
      evm: Move evm_hmac and evm_hash from evm_main.c to evm_crypto.c
      evm: Constify *integrity_status_msg[]

Jiandi An (1):
      ima: Fix Kconfig to select TPM 2.0 CRB interface

Martin Townsend (1):
      ima: Add smackfs to the default appraise/measure list

Matthew Garrett (2):
      security: Add a cred_getsecid hook
      IMA: Support using new creds in appraisal policy

Mimi Zohar (5):
      ima: fail file signature verification on non-init mounted filesystems
      ima: re-evaluate files on privileged mounted filesystems
      ima: clear IMA_HASH
      ima: fail signature verification based on policy
      fuse: define the filesystem as untrusted

Petr Vorel (1):
      ima: Fallback to the builtin hash algorithm

Sascha Hauer (1):
      evm: check for remount ro in progress before writing

Thiago Jung Bauermann (3):
      integrity: Remove unused macro IMA_ACTION_RULE_FLAGS
      ima: Simplify ima_eventsig_init()
      ima: Improvements in ima_appraise_measurement()

Tycho Andersen (1):
      ima: drop vla in ima_audit_measurement()

 Documentation/ABI/testing/ima_policy            |  2 +-
 Documentation/admin-guide/kernel-parameters.txt |  8 ++-
 fs/fuse/inode.c                                 |  3 ++
 include/linux/fs.h                              |  2 +
 include/linux/lsm_hooks.h                       |  6 +++
 include/linux/security.h                        |  1 +
 security/integrity/evm/evm.h                    |  2 -
 security/integrity/evm/evm_crypto.c             |  3 ++
 security/integrity/evm/evm_main.c               | 12 +++--
 security/integrity/iint.c                       |  2 +
 security/integrity/ima/Kconfig                  |  1 +
 security/integrity/ima/ima.h                    |  9 ++--
 security/integrity/ima/ima_api.c                | 25 +++++----
 security/integrity/ima/ima_appraise.c           | 65 +++++++++++++++++------
 security/integrity/ima/ima_crypto.c             |  2 +
 security/integrity/ima/ima_main.c               | 69 ++++++++++++++++++++-----
 security/integrity/ima/ima_policy.c             | 32 ++++++++----
 security/integrity/ima/ima_template_lib.c       | 11 ++--
 security/integrity/integrity.h                  | 11 ++--
 security/security.c                             |  7 +++
 security/selinux/hooks.c                        |  6 +++
 security/smack/smack_lsm.c                      | 18 +++++++
 22 files changed, 227 insertions(+), 70 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
