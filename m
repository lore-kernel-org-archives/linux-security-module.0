From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri,  9 Jun 2017 14:02:42 -0400
Subject: [PATCH 2/4] tmpfs: define integrity_read file operation method
In-Reply-To: <1497031364-19949-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1497031364-19949-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1497031364-19949-3-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Although temporary filesystems for the most part are not something
that we're interested in measuring or appraising, we do want to at least
measure, and at some point appraise, files on the rootfs.

This patch defines an integrity_read file operation method used for
calculating the file hash.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 mm/shmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index e67d6ba4e98e..16958b20946f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3846,6 +3846,7 @@ static const struct file_operations shmem_file_operations = {
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= shmem_fallocate,
+	.integrity_read	= shmem_file_read_iter,
 #endif
 };
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
