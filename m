From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 17 May 2018 10:48:42 -0400
Subject: [PATCH v2 1/9] ima: based on policy verify firmware signatures
	(pre-allocated buffer)
In-Reply-To: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1526568530-9144-2-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Don't differentiate between kernel_read_file_id READING_FIRMWARE and
READING_FIRMWARE_PREALLOC_BUFFER enumerations.

Fixes: a098ecd firmware: support loading into a pre-allocated buffer (since 4.8)
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Stephen Boyd <stephen.boyd@linaro.org>
---
 security/integrity/ima/ima_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index e771b736aa03..83f84928ad76 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -447,6 +447,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 
 static int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
+	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
 	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
 	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
