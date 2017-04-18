From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Tue, 18 Apr 2017 17:17:40 -0300
Subject: [PATCH 0/6] Appended signatures support for IMA appraisal
Message-ID: <1492546666-16615-1-git-send-email-bauerman@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On the OpenPOWER platform, secure boot and trusted boot are being
implemented using IMA for taking measurements and verifying signatures.
Since the kernel image on Power servers is an ELF binary, kernels are
signed using the scripts/sign-file tool and thus use the same signature
format as signed kernel modules.

This patch series adds support in IMA for verifying those signatures.
It adds flexibility to OpenPOWER secure boot, because it can boot kernels
with the signature appended to them as well as kernels where the signature
is stored in the IMA extended attribute.

The first four patches are cleanups and improvements that can be taken
independently from the others (and from each other as well). The last two
are the ones actually focused on this feature.

These patches apply on top of today's linux-security/next.

Thiago Jung Bauermann (6):
  integrity: Small code improvements
  ima: Tidy up constant strings
  ima: Simplify policy_func_show.
  ima: Log the same audit cause whenever a file has no signature
  MODSIGN: Export module signature definitions.
  ima: Support appended signatures for appraisal

 crypto/asymmetric_keys/asymmetric_type.c |  1 +
 crypto/asymmetric_keys/pkcs7_parser.c    | 12 +++++
 crypto/asymmetric_keys/pkcs7_verify.c    | 13 +++++
 include/crypto/pkcs7.h                   |  3 ++
 include/linux/module_signature.h         | 45 ++++++++++++++++
 include/linux/verification.h             |  1 +
 init/Kconfig                             |  6 ++-
 kernel/Makefile                          |  2 +-
 kernel/module_signing.c                  | 74 +++++++++++----------------
 security/integrity/Kconfig               |  2 +-
 security/integrity/digsig_asymmetric.c   |  4 +-
 security/integrity/iint.c                |  2 +-
 security/integrity/ima/Kconfig           | 13 +++++
 security/integrity/ima/ima.h             |  8 +++
 security/integrity/ima/ima_appraise.c    | 86 ++++++++++++++++++++++++++++++-
 security/integrity/ima/ima_init.c        |  2 +-
 security/integrity/ima/ima_main.c        | 30 +++++++++--
 security/integrity/ima/ima_policy.c      | 88 ++++++++++++--------------------
 security/integrity/integrity.h           | 27 ++++++----
 19 files changed, 302 insertions(+), 117 deletions(-)
 create mode 100644 include/linux/module_signature.h

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
