From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 15 Sep 2017 00:58:13 -0400
Subject: [PATCH 2/3] integrity: replace call to integrity_read_file with
	kernel version
In-Reply-To: <1505451494-30228-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1505451494-30228-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1505451494-30228-3-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

The CONFIG_IMA_LOAD_X509 and CONFIG_EVM_LOAD_X509 options permit
loading x509 signed certificates onto the trusted keyrings without
verifying the x509 certificate file's signature.

This patch replaces the call to the integrity_read_file() specific
function with the common kernel_read_file_from_path() function.
To avoid verifying the file signature, this patch defines
READING_X509_CERTFICATE.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

---
Changelog:
- rewrote patch description
- fixed parameters to kernel_read_file_from_path() and key_create_or_update()
- defined READING_X509_CERTIFICATE, a new __kernel_read_file enumeration
- removed constify change
---
 include/linux/fs.h                |  1 +
 security/integrity/digsig.c       | 14 +++++++----
 security/integrity/iint.c         | 49 ---------------------------------------
 security/integrity/ima/ima_main.c |  4 ++++
 security/integrity/integrity.h    |  2 --
 5 files changed, 14 insertions(+), 56 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d783cc8340de..e522d25d0836 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2751,6 +2751,7 @@ extern int do_pipe_flags(int *, int);
 	id(KEXEC_IMAGE, kexec-image)		\
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
 	id(POLICY, security-policy)		\
+	id(X509_CERTIFICATE, x509-certificate)	\
 	id(MAX_ID, )
 
 #define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 06554c448dce..6f9e4ce568cd 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -112,21 +112,25 @@ int __init integrity_init_keyring(const unsigned int id)
 int __init integrity_load_x509(const unsigned int id, const char *path)
 {
 	key_ref_t key;
-	char *data;
+	void *data;
+	loff_t size;
 	int rc;
 
 	if (!keyring[id])
 		return -EINVAL;
 
-	rc = integrity_read_file(path, &data);
-	if (rc < 0)
+	rc = kernel_read_file_from_path(path, &data, &size, 0,
+					READING_X509_CERTIFICATE);
+	if (rc < 0) {
+		pr_err("Unable to open file: %s (%d)", path, rc);
 		return rc;
+	}
 
 	key = key_create_or_update(make_key_ref(keyring[id], 1),
 				   "asymmetric",
 				   NULL,
 				   data,
-				   rc,
+				   size,
 				   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
 				    KEY_USR_VIEW | KEY_USR_READ),
 				   KEY_ALLOC_NOT_IN_QUOTA);
@@ -139,6 +143,6 @@ int __init integrity_load_x509(const unsigned int id, const char *path)
 			  key_ref_to_ptr(key)->description, path);
 		key_ref_put(key);
 	}
-	kfree(data);
+	vfree(data);
 	return 0;
 }
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 6fc888ca468e..c84e05866052 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -200,55 +200,6 @@ int integrity_kernel_read(struct file *file, loff_t offset,
 }
 
 /*
- * integrity_read_file - read entire file content into the buffer
- *
- * This is function opens a file, allocates the buffer of required
- * size, read entire file content to the buffer and closes the file
- *
- * It is used only by init code.
- *
- */
-int __init integrity_read_file(const char *path, char **data)
-{
-	struct file *file;
-	loff_t size;
-	char *buf;
-	int rc = -EINVAL;
-
-	if (!path || !*path)
-		return -EINVAL;
-
-	file = filp_open(path, O_RDONLY, 0);
-	if (IS_ERR(file)) {
-		rc = PTR_ERR(file);
-		pr_err("Unable to open file: %s (%d)", path, rc);
-		return rc;
-	}
-
-	size = i_size_read(file_inode(file));
-	if (size <= 0)
-		goto out;
-
-	buf = kmalloc(size, GFP_KERNEL);
-	if (!buf) {
-		rc = -ENOMEM;
-		goto out;
-	}
-
-	rc = integrity_kernel_read(file, 0, buf, size);
-	if (rc == size) {
-		*data = buf;
-	} else {
-		kfree(buf);
-		if (rc >= 0)
-			rc = -EIO;
-	}
-out:
-	fput(file);
-	return rc;
-}
-
-/*
  * integrity_load_keys - load integrity keys hook
  *
  * Hooks is called from init/main.c:kernel_init_freeable()
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index b00186914df8..72bd2b666a31 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -413,6 +413,10 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	if (!file && read_id == READING_MODULE) /* MODULE_SIG_FORCE enabled */
 		return 0;
 
+	/* permit signed certs */
+	if (!file && read_id == READING_X509_CERTIFICATE)
+		return 0;
+
 	if (!file || !buf || size == 0) { /* should never happen */
 		if (ima_appraise & IMA_APPRAISE_ENFORCE)
 			return -EACCES;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index a53e7e4ab06c..e1bf040fb110 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -120,8 +120,6 @@ struct integrity_iint_cache *integrity_iint_find(struct inode *inode);
 int integrity_kernel_read(struct file *file, loff_t offset,
 			  void *addr, unsigned long count);
 
-int __init integrity_read_file(const char *path, char **data);
-
 #define INTEGRITY_KEYRING_EVM		0
 #define INTEGRITY_KEYRING_IMA		1
 #define INTEGRITY_KEYRING_MODULE	2
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
