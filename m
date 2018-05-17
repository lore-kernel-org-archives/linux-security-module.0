From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 17 May 2018 10:48:45 -0400
Subject: [PATCH v2 4/9] kexec: add call to LSM hook in original kexec_load
	syscall
In-Reply-To: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1526568530-9144-5-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

In order for LSMs and IMA-appraisal to differentiate between the
original and new syscalls, both the original and new syscalls must call
an LSM hook.  This patch adds a call to security_kernel_read_blob() in
the original kexec syscall.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>
---
 kernel/kexec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index aed8fb2564b3..64cebe92a690 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -11,6 +11,7 @@
 #include <linux/capability.h>
 #include <linux/mm.h>
 #include <linux/file.h>
+#include <linux/security.h>
 #include <linux/kexec.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
@@ -195,11 +196,21 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 static inline int kexec_load_check(unsigned long nr_segments,
 				   unsigned long flags)
 {
+	int result;
+
 	/* We only trust the superuser with rebooting the system. */
 	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
 		return -EPERM;
 
 	/*
+	 * Allow LSMs and IMA to differentiate between kexec_load and
+	 * kexec_file_load syscalls.
+	 */
+	result = security_kernel_read_blob(READING_KEXEC_IMAGE);
+	if (result < 0)
+		return result;
+
+	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.
 	 */
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
