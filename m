From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 08 Nov 2017 16:54:17 -0500
Subject: [GIT PULL] linux-integrity patches for 4.15-security-next-testing
Message-ID: <1510178057.4484.64.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

These are the rebased EVM & IMA patches for the security/next-testing
branch. ?There is a mixture of bug fixes, code cleanup, preparatory
code for new functionality and new functionality.

Commit?26ddabfe96bb "evm: enable EVM when X509 certificate is loaded"
enabled EVM without loading a symmetric key, but was limited to
defining the x509 certificate pathname at build. ?Included in this set
of patches is the ability of enabling EVM, without loading the EVM
symmetric key, from userspace. ?New is the ability to prevent the
loading of an EVM symmetric key.

[A version of commit 917086ff231f "vfs: fix mounting a filesystem with
i_version" is included here, as it was upstreamed in -rc6.]

thanks,

Mimi

---

The following changes since commit 34d8751fd4ffa34e85ee7e85d34168b3f3f62b42:

  MAINTAINERS: update the IMA, EVM, trusted-keys, encrypted-keys entries (2017-11-06 02:21:44 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git security-next-integrity

for you to fetch changes up to e5729f86a2987c9404f9b2fb494b9a6fc4412baf:

  ima: Remove redundant conditional operator (2017-11-08 15:16:36 -0500)

----------------------------------------------------------------
Boshi Wang (1):
      ima: fix hash algorithm initialization

Bruno E. O. Meneguele (2):
      module: export module signature enforcement status
      ima: check signature enforcement against cmdline param instead of CONFIG

Christoph Hellwig (1):
      integrity: use kernel_read_file_from_path() to read x509 certs

Matthew Garrett (3):
      EVM: Include security.apparmor in EVM measurements
      EVM: Allow userspace to signal an RSA key has been loaded
      EVM: Only complain about a missing HMAC key once

Mimi Zohar (4):
      vfs: fix mounting a filesystem with i_version
      ima: don't remove the securityfs policy file
      ima: always measure and audit files in policy
      ima: call ima_file_free() prior to calling fasync

Thiago Jung Bauermann (1):
      ima: Remove redundant conditional operator

Thomas Meyer (1):
      ima: Fix bool initialization/comparison

 Documentation/ABI/testing/evm         | 47 ++++++++++++++++--------
 fs/file_table.c                       |  2 +-
 fs/namespace.c                        |  3 +-
 include/linux/fs.h                    |  1 +
 include/linux/module.h                |  7 ++++
 include/uapi/linux/xattr.h            |  3 ++
 kernel/module.c                       | 10 ++++++
 security/integrity/digsig.c           | 14 +++++---
 security/integrity/evm/evm.h          |  3 ++
 security/integrity/evm/evm_crypto.c   |  2 +-
 security/integrity/evm/evm_main.c     |  3 ++
 security/integrity/evm/evm_secfs.c    | 29 ++++++++-------
 security/integrity/iint.c             | 49 -------------------------
 security/integrity/ima/ima_api.c      | 67 ++++++++++++++++++++++-------------
 security/integrity/ima/ima_appraise.c |  4 +--
 security/integrity/ima/ima_crypto.c   | 10 ++++++
 security/integrity/ima/ima_fs.c       |  6 ++--
 security/integrity/ima/ima_main.c     | 23 +++++++-----
 security/integrity/ima/ima_policy.c   |  6 ++--
 security/integrity/integrity.h        |  2 --
 20 files changed, 165 insertions(+), 126 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
