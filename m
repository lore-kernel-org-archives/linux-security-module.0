From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 21 Jun 2017 14:18:29 -0400
Subject: [PATCH v2 09/10] ubifs: define integrity_read method
In-Reply-To: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1498069110-10009-10-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Define an ->integrity_read file operation method to read data for
integrity hash collection.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 fs/ubifs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 2cda3d67e2d0..eeb4e872e47a 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1754,4 +1754,5 @@ const struct file_operations ubifs_file_operations = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl   = ubifs_compat_ioctl,
 #endif
+	.integrity_read = generic_file_read_iter,
 };
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
