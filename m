From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue,  2 May 2017 14:47:12 -0400
Subject: [PATCH 4/4] ima: define is_ima_appraise_enabled()
In-Reply-To: <1493750832-11981-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1493750832-11981-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1493750832-11981-5-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Only return enabled if in enforcing mode, not fix or log modes.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Changes:
- Define is_ima_appraise_enabled() as a bool (Thiago Bauermann)
---
 include/linux/ima.h                   |  6 ++++++
 security/integrity/ima/ima_appraise.c | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 7f6952f8d6aa..0e4647e0eb60 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -75,11 +75,17 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
 #endif
 
 #ifdef CONFIG_IMA_APPRAISE
+extern bool is_ima_appraise_enabled(void);
 extern void ima_inode_post_setattr(struct dentry *dentry);
 extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		       const void *xattr_value, size_t xattr_value_len);
 extern int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name);
 #else
+static inline bool is_ima_appraise_enabled(void)
+{
+	return 0;
+}
+
 static inline void ima_inode_post_setattr(struct dentry *dentry)
 {
 	return;
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index ac546df73afc..7fe0566142d8 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -34,6 +34,16 @@ static int __init default_appraise_setup(char *str)
 __setup("ima_appraise=", default_appraise_setup);
 
 /*
+ * is_ima_appraise_enabled - return appraise status
+ *
+ * Only return enabled, if not in ima_appraise="fix" or "log" modes.
+ */
+bool is_ima_appraise_enabled(void)
+{
+	return (ima_appraise & IMA_APPRAISE_ENFORCE) ? 1 : 0;
+}
+
+/*
  * ima_must_appraise - set appraise flag
  *
  * Return 1 to appraise
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
