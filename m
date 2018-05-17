From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 17 May 2018 10:48:41 -0400
Subject: [PATCH v2 0/9] kexec/firmware: support system wide policy requiring
	signatures
Message-ID: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

IMA-appraisal is mostly being used in the embedded or single purpose
closed system environments.  In these environments, both the Kconfig
options and the userspace tools can be modified appropriately to limit
syscalls.  For stock kernels, userspace applications need to continue to
work with older kernels as well as with newer kernels.

In this environment, the customer needs the ability to define a system
wide IMA policy, such as requiring all kexec'ed images, firmware, kernel
modules to be signed, without being dependent on either the Kconfig
options or the userspace tools.[1]

This patch set allows the customer to define a policy which requires
the kexec'ed kernel images, firmware, and/or kernel modules to be
signed.

New to this patch set is the ability to configure a build time IMA policy,
which is automatically loaded at run time without needing to specify it
on the boot command line.  The build time policy rules persist after
loading a custom kernel policy.

[1] kexec-tools suupports the new syscall based on a flag (-s).

Changelog v3:
- combined "kexec: limit kexec_load syscall" and "firmware: kernel
signature verification" patch sets.
- add support for build time policy.
- defined generic security_kernel_read_blob() wrapper for
  security_kernel_read_file(). Suggested by Luis.
- removed the CONFIG_CFG80211_REQUIRE_SIGNED_REGDB ifdef.  If both REGDB
  and an IMA-appraisal policy require signed firmware, for now require
  both signatures.  Subsequent patches might change this.
- Still unclear if the pre-allocated firmware buffer can be accessed
  prior to the signature verification completes.

Mimi Zohar (9):
  ima: based on policy verify firmware signatures (pre-allocated buffer)
  ima: fix updating the ima_appraise flag
  security: define security_kernel_read_blob() wrapper
  kexec: add call to LSM hook in original kexec_load syscall
  ima: based on policy require signed kexec kernel images
  firmware: add call to LSM hook before firmware sysfs fallback
  ima: based on policy require signed firmware (sysfs fallback)
  ima: add build time policy
  ima: based on policy prevent loading firmware (pre-allocated buffer)

 drivers/base/firmware_loader/fallback.c |  7 +++
 include/linux/fs.h                      |  1 +
 include/linux/security.h                |  6 +++
 kernel/kexec.c                          | 11 +++++
 security/integrity/ima/Kconfig          | 58 +++++++++++++++++++++++++
 security/integrity/ima/ima.h            |  1 +
 security/integrity/ima/ima_main.c       | 29 +++++++++++++
 security/integrity/ima/ima_policy.c     | 76 +++++++++++++++++++++++++++------
 security/security.c                     |  6 +++
 9 files changed, 183 insertions(+), 12 deletions(-)

-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
