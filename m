From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 21 Jun 2017 14:18:27 -0400
Subject: [PATCH v2 07/10] ocfs2: define integrity_read method
In-Reply-To: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1498069110-10009-8-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Define an ->integrity_read file operation method to read data for
integrity hash collection.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 fs/ocfs2/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index bfeb647459d9..2832a7c92acd 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2536,6 +2536,7 @@ const struct file_operations ocfs2_fops = {
 	.fallocate	= ocfs2_fallocate,
 	.clone_file_range = ocfs2_file_clone_range,
 	.dedupe_file_range = ocfs2_file_dedupe_range,
+	.integrity_read	= ocfs2_file_read_iter,
 };
 
 const struct file_operations ocfs2_dops = {
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
