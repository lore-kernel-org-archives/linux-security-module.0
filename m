From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 15 Aug 2017 10:43:52 -0400
Subject: [PATCH v6 1/6] libfs: define simple_read_iter_from_buffer
In-Reply-To: <1502808237-2035-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1502808237-2035-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1502808237-2035-2-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

In preparation for defining an integrity_read file operation
method for efivarfs, define a simple_read_iter_from_buffer()
function.

(Based on Al's code as posted in thread.)

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>

---
Changelog v6:
- defined as a separate patch
 
 fs/libfs.c         | 32 ++++++++++++++++++++++++++++++++
 include/linux/fs.h |  2 ++
 2 files changed, 34 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 3aabe553fc45..b6e304c6828b 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -16,6 +16,7 @@
 #include <linux/exportfs.h>
 #include <linux/writeback.h>
 #include <linux/buffer_head.h> /* sync_mapping_buffers */
+#include <linux/uio.h>
 
 #include <linux/uaccess.h>
 
@@ -676,6 +677,37 @@ ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
 EXPORT_SYMBOL(simple_write_to_buffer);
 
 /**
+ * simple_read_iter_from_buffer - copy data from the buffer to user space
+ * @iocb: struct containing the file, the current position and other info
+ * @to: the user space buffer to read to
+ * @from: the buffer to read from
+ * @available: the size of the buffer
+ *
+ * The simple_read_iter_from_buffer() function reads up to @available bytes
+ * from the current buffer into the user space buffer.
+ *
+ * On success, the current buffer offset is advanced by the number of bytes
+ * read, or a negative value is returned on error.
+ **/
+ssize_t simple_read_iter_from_buffer(struct kiocb *iocb, struct iov_iter *to,
+				     const void *from, size_t available)
+{
+	loff_t pos = iocb->ki_pos;
+	size_t ret;
+
+	if (pos < 0)
+		return -EINVAL;
+	if (pos >= available)
+		return 0;
+	ret = copy_to_iter(from + pos, available - pos, to);
+	if (!ret && iov_iter_count(to))
+		return -EFAULT;
+	iocb->ki_pos = pos + ret;
+	return ret;
+}
+EXPORT_SYMBOL(simple_read_iter_from_buffer);
+
+/**
  * memory_read_from_buffer - copy data from the buffer
  * @to: the kernel space buffer to read to
  * @count: the maximum number of bytes to read
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6e1fd5d21248..fdec9b763b54 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3097,6 +3097,8 @@ extern void simple_release_fs(struct vfsmount **mount, int *count);
 
 extern ssize_t simple_read_from_buffer(void __user *to, size_t count,
 			loff_t *ppos, const void *from, size_t available);
+extern ssize_t simple_read_iter_from_buffer(struct kiocb *iocb,
+		struct iov_iter *to, const void *from, size_t available);
 extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
 		const void __user *from, size_t count);
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
