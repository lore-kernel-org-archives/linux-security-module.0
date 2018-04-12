From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 12 Apr 2018 18:41:48 -0400
Subject: [PATCH 0/3] kexec: limit kexec_load syscall
Message-ID: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

In environments that require the kexec kernel image to be signed, prevent
using the kexec_load syscall.  In order for LSMs and IMA to differentiate
between kexec_load and kexec_file_load syscalls, this patch set adds a
call to security_kernel_read_file() in kexec_load_check().

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Mimi Zohar (3):
  ima: based on the "secure_boot" policy limit syscalls
  kexec: call LSM hook for kexec_load syscall
  ima: based on policy require signed kexec kernel images

 kernel/kexec.c                      | 11 +++++++++++
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_main.c   |  9 +++++++++
 security/integrity/ima/ima_policy.c | 27 ++++++++++++++++++++-------
 4 files changed, 41 insertions(+), 7 deletions(-)

-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
