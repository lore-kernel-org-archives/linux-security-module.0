From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 13 Jul 2018 14:05:55 -0400
Subject: [PATCH v6 0/8] kexec/firmware: support system wide policy requiring
	signatures
Message-ID: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
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

In addition, this patch set includes the ability to configure a build
time IMA policy, which is automatically loaded at run time without
needing to specify it on the boot command line and persists after
loading a custom kernel policy.

[1] kexec-tools suupports the new syscall based on a flag (-s).

Changelog v6:
- Instead of warning about loading firmware from pre-allocated, shared
  memory, just add a comment. Refer to the patch description for reason.
- LoadPin: add missing cast from enum kernel_load_file_id to
  kernel_read_file_id.

Changelog v5:
- Shared kernel_load_data_id and kernel_read_file_id enumerations.

The previous version of this patch set defined a new LSM hook named
security_kernel_load_data and an associated enumeration named
kernel_load_data_id, independent of kernel_read_file_id.  In this
version, the kernel_load_data_id and kernel_read_file_id values are
shared, simplifying Loadpin's and other LSMs calling one LSM hook from
the other.

- Warn about loading firmware from pre-shared memory.

Previous versions of this patch set prevented loading firmware, based on
policy, from pre-allocated (DMA) memory, introduced in commit
a098ecd2fa7d ("firmware: support loading into a pre-allocated buffer").
Based on discussions, calling dma_alloc_coherent() is unnecessary and
confusing.  This version of the patch set allows loading the firmware,
but emits a warning.

Changelog v4:
- Define a new LSM hook named security_kernel_load_data().
- Define kernel_load_data_id enumeration.
- Replace the existing LSM hook in init_module syscall.

Changelog v3:
Based on James' feedback:
- Renamed security_kernel_read_file() to security_kernel_read_data().
- Defined new kernel_load_data_id enumeration.
- Cleaned up ima_read_data(), replacing if's with switch.

Mimi Zohar (8):
  security: define new LSM hook named security_kernel_load_data
  kexec: add call to LSM hook in original kexec_load syscall
  ima: based on policy require signed kexec kernel images
  firmware: add call to LSM hook before firmware sysfs fallback
  ima: based on policy require signed firmware (sysfs fallback)
  ima: add build time policy
  module: replace the existing LSM hook in init_module
  ima: based on policy warn about loading firmware (pre-allocated
    buffer)

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
 security/security.c                     | 10 +++++
 security/selinux/hooks.c                | 15 ++++++++
 13 files changed, 245 insertions(+), 18 deletions(-)

-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
