From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 22 May 2018 16:50:41 -0400
Subject: [GIT PULL]  linux-integrity for Linux 4.18
Message-ID: <1527022241.3789.35.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,


This pull request adds run time support for specifying additional security xattrs
included in the security.evm HMAC/signature, some code clean up and bug fixes.

thanks,

Mimi

The following changes since commit 890e2abe1028c39e5399101a2c277219cd637aaa:

  dh key: get rid of stack allocated array for zeroes (2018-05-11 13:07:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

for you to fetch changes up to 6f0911a666d1f99ff72e7848ddee36af7bbce050:

  ima: fix updating the ima_appraise flag (2018-05-22 13:16:42 -0400)

----------------------------------------------------------------
Matthew Garrett (3):
      integrity: Add an integrity directory in securityfs
      EVM: turn evm_config_xattrnames into a list
      EVM: Allow runtime modification of the set of verified xattrs

Mimi Zohar (3):
      ima: define a new policy condition based on the filesystem name
      ima: based on policy verify firmware signatures (pre-allocated buffer)
      ima: fix updating the ima_appraise flag

Petr Vorel (3):
      ima: Reflect correct permissions for policy
      ima: Unify logging
      ima: Remove unused variable ima_initialized

 Documentation/ABI/testing/evm             |  13 ++
 Documentation/ABI/testing/ima_policy      |   2 +-
 include/uapi/linux/audit.h                |   1 +
 security/integrity/evm/Kconfig            |  11 ++
 security/integrity/evm/evm.h              |   7 +-
 security/integrity/evm/evm_crypto.c       |  10 +-
 security/integrity/evm/evm_main.c         |  79 +++++++-----
 security/integrity/evm/evm_secfs.c        | 200 +++++++++++++++++++++++++++++-
 security/integrity/iint.c                 |  18 +++
 security/integrity/ima/ima.h              |   1 -
 security/integrity/ima/ima_fs.c           |  18 ++-
 security/integrity/ima/ima_kexec.c        |   2 +
 security/integrity/ima/ima_main.c         |   8 +-
 security/integrity/ima/ima_policy.c       |  53 ++++++--
 security/integrity/ima/ima_template_lib.c |   2 +
 security/integrity/integrity.h            |   2 +
 16 files changed, 365 insertions(+), 62 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
