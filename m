From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 15 Aug 2017 10:43:53 -0400
Subject: [PATCH v6 2/6] efivarfs: replaces the read file operation with
	read_iter
In-Reply-To: <1502808237-2035-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1502808237-2035-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1502808237-2035-3-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

In preparation for defining the integrity_read file operation
method, replace the read file operation method with read_iter.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>

---
Changelog v6:
- Defined as a separate patch.
 
 fs/efivarfs/file.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index 5f22e74bbade..863f1b100165 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -64,9 +64,10 @@ static ssize_t efivarfs_file_write(struct file *file,
 	return bytes;
 }
 
-static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
-		size_t count, loff_t *ppos)
+static ssize_t efivarfs_file_read_iter(struct kiocb *iocb,
+				       struct iov_iter *iter)
 {
+	struct file *file = iocb->ki_filp;
 	struct efivar_entry *var = file->private_data;
 	unsigned long datasize = 0;
 	u32 attributes;
@@ -96,8 +97,8 @@ static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
 		goto out_free;
 
 	memcpy(data, &attributes, sizeof(attributes));
-	size = simple_read_from_buffer(userbuf, count, ppos,
-				       data, datasize + sizeof(attributes));
+	size = simple_read_iter_from_buffer(iocb, iter, data,
+					    datasize + sizeof(attributes));
 out_free:
 	kfree(data);
 
@@ -174,7 +175,7 @@ efivarfs_file_ioctl(struct file *file, unsigned int cmd, unsigned long p)
 
 const struct file_operations efivarfs_file_operations = {
 	.open	= simple_open,
-	.read	= efivarfs_file_read,
+	.read_iter = efivarfs_file_read_iter,
 	.write	= efivarfs_file_write,
 	.llseek	= no_llseek,
 	.unlocked_ioctl = efivarfs_file_ioctl,
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
