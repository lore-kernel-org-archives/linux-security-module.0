From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 21 Jun 2017 14:18:28 -0400
Subject: [PATCH v2 08/10] jffs2: define integrity_read method
In-Reply-To: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1498069110-10009-9-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Define an ->integrity_read file operation method to read data for
integrity hash collection.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 fs/jffs2/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index c12476e309c6..5a63034cccf5 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -57,6 +57,7 @@ const struct file_operations jffs2_file_operations =
 	.mmap =		generic_file_readonly_mmap,
 	.fsync =	jffs2_fsync,
 	.splice_read =	generic_file_splice_read,
+	.integrity_read = generic_file_read_iter,
 };
 
 /* jffs2_file_inode_operations */
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
