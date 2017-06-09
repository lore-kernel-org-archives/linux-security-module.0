From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri,  9 Jun 2017 14:02:43 -0400
Subject: [PATCH 3/4] ima: use existing read file operation method to calculate
	file hash
In-Reply-To: <1497031364-19949-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1497031364-19949-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1497031364-19949-4-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The few filesystems that currently define the read file operation
method, either call seq_read() or have a filesystem specific read
method.  None of them, at least in the fs directory, take the
i_rwsem.

Since some files on these filesystems were previously
measured/appraised, not measuring them would change the PCR hash
value(s), possibly breaking userspace.  For filesystems that do
not define the integrity_read file operation method and have a
read method, use the read method to calculate the file hash.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/iint.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index c5489672b5aa..e3ef3fba16dc 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -189,20 +189,29 @@ int integrity_kernel_read(struct file *file, loff_t offset,
 	struct iovec iov = { .iov_base = addr, .iov_len = count };
 	struct kiocb kiocb;
 	struct iov_iter iter;
-	ssize_t ret;
+	ssize_t ret = -EBADF;
 
 	lockdep_assert_held(&inode->i_rwsem);
 
 	if (!(file->f_mode & FMODE_READ))
 		return -EBADF;
-	if (!file->f_op->integrity_read)
-		return -EBADF;
 
 	init_sync_kiocb(&kiocb, file);
 	kiocb.ki_pos = offset;
 	iov_iter_init(&iter, READ | ITER_KVEC, &iov, 1, count);
 
-	ret = file->f_op->integrity_read(&kiocb, &iter);
+	if (file->f_op->integrity_read) {
+		ret = file->f_op->integrity_read(&kiocb, &iter);
+	} else if (file->f_op->read) {
+		mm_segment_t old_fs;
+		char __user *buf = (char __user *)addr;
+
+		old_fs = get_fs();
+		set_fs(get_ds());
+		ret = file->f_op->read(file, buf, count, &offset);
+		set_fs(old_fs);
+	}
+
 	BUG_ON(ret == -EIOCBQUEUED);
 	return ret;
 }
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
