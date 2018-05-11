From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 10 May 2018 21:36:45 -0400
Subject: [PATCH 0/3] kexec: limit kexec_load syscall 
Message-ID: <1526002608-27474-1-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

IMA-appraisal is mostly being used in the embedded or single purpose
closed system environments.  In these environments, both the Kconfig
options and the userspace tools can be modified appropriately to limit
syscalls.  For stock kernels, userspace applications need to continue to
work with older kernels as well as with newer kernels.

In this environment, the customer needs the ability to define a system
wide IMA runtime policy, such as requiring all kexec'ed images (or
firmware) to be signed, without being dependent on either the Kconfig
options or the userspace tools.

This patch set allows the customer to define a policy which requires
kexec'ed kernels to be signed.

Mimi Zohar (3):
  ima: based on the "secure_boot" policy limit syscalls
  kexec: call LSM hook for kexec_load syscall
  ima: based on policy require signed kexec kernel images

 include/linux/security.h            |  6 ++++++
 kernel/kexec.c                      | 11 +++++++++++
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_main.c   |  9 +++++++++
 security/integrity/ima/ima_policy.c | 27 ++++++++++++++++++++-------
 security/security.c                 |  6 ++++++
 6 files changed, 53 insertions(+), 7 deletions(-)

-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
