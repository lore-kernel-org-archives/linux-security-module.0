From: jmorris@namei.org (James Morris)
Date: Fri, 8 Jun 2018 03:46:05 +1000 (AEST)
Subject: [GIT PULL] Security subsystem: Integrity updates for v4.18
Message-ID: <alpine.LRH.2.21.1806080340420.27121@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Please pull these updates for the Integrity subsystem.


>From Mimi:

- adds run time support for specifying additional security xattrs
  included in the security.evm HMAC/signature

- some code clean up and bug fixes.


---

The following changes since commit 890e2abe1028c39e5399101a2c277219cd637aaa:

  dh key: get rid of stack allocated array for zeroes (2018-05-11 13:07:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-integrity

for you to fetch changes up to b5c90a7526fe39164c2204f0404ce8f8ff21e522:

  EVM: unlock on error path in evm_read_xattrs() (2018-06-01 06:03:08 -0400)

----------------------------------------------------------------
Colin Ian King (2):
      EVM: fix memory leak of temporary buffer 'temp'
      EVM: Fix null dereference on xattr when xattr fails to allocate

Dan Carpenter (2):
      EVM: prevent array underflow in evm_write_xattrs()
      EVM: unlock on error path in evm_read_xattrs()

Matthew Garrett (3):
      integrity: Add an integrity directory in securityfs
      EVM: turn evm_config_xattrnames into a list
      EVM: Allow runtime modification of the set of verified xattrs

Mimi Zohar (3):
      ima: define a new policy condition based on the filesystem name
      ima: based on policy verify firmware signatures (pre-allocated buffer)
      ima: fix updating the ima_appraise flag

Petko Manolov (1):
      IMA: use list_splice_tail_init_rcu() instead of its open coded variant

Petr Vorel (3):
      ima: Reflect correct permissions for policy
      ima: Unify logging
      ima: Remove unused variable ima_initialized

Yisheng Xie (1):
      ima: use match_string() helper

 Documentation/ABI/testing/evm             |  13 ++
 Documentation/ABI/testing/ima_policy      |   2 +-
 include/uapi/linux/audit.h                |   1 +
 security/integrity/evm/Kconfig            |  11 ++
 security/integrity/evm/evm.h              |   7 +-
 security/integrity/evm/evm_crypto.c       |  10 +-
 security/integrity/evm/evm_main.c         |  79 +++++++-----
 security/integrity/evm/evm_secfs.c        | 206 +++++++++++++++++++++++++++++-
 security/integrity/iint.c                 |  18 +++
 security/integrity/ima/ima.h              |   1 -
 security/integrity/ima/ima_fs.c           |  18 ++-
 security/integrity/ima/ima_kexec.c        |   2 +
 security/integrity/ima/ima_main.c         |  19 +--
 security/integrity/ima/ima_policy.c       |  70 ++++++----
 security/integrity/ima/ima_template_lib.c |   2 +
 security/integrity/integrity.h            |   2 +
 16 files changed, 377 insertions(+), 84 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
