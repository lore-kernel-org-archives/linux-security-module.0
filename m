From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue,  2 May 2017 14:47:08 -0400
Subject: [PATCH 0/4] ima: builtin policy requiring file signatures
Message-ID: <1493750832-11981-1-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The builtin "ima_appraise_tcb" policy should require file signatures
for at least a few of the hooks (eg. kernel modules, firmware, kexec
kernel image, and the IMA policy), but changing it would break the
existing userspace/kernel ABI.

This patch set extends the "ima_policy=" boot command line option to
support specifying multiple builtin policies, introduces a new builtin
policy named "secure_boot" to require file signatures, defines a new
Kconfig option to permit specifying "log" and "fix" modes as options on
the "ima_appraise=" boot command line, and defines is_ima_appraise_enabled().

These changes provide some of the missing functionality needed for the
"locked-down" patch set to detect whether file signatures are being
validated.

Mimi

Mimi Zohar (4):
  ima: extend the "ima_policy" boot command line to support multiple
    policies
  ima: define a set of appraisal rules requiring file signatures
  ima: define Kconfig IMA_APPRAISE_BOOTPARAM option
  ima: define is_ima_appraise_enabled()

 Documentation/admin-guide/kernel-parameters.txt | 21 +++++++++----
 include/linux/ima.h                             |  6 ++++
 security/integrity/ima/Kconfig                  |  8 +++++
 security/integrity/ima/ima_appraise.c           | 12 ++++++++
 security/integrity/ima/ima_policy.c             | 41 +++++++++++++++++++++----
 5 files changed, 76 insertions(+), 12 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
