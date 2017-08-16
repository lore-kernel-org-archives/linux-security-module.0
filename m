From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 16 Aug 2017 13:30:20 -0400
Subject: [RFC PATCH 4/4] ima: define a new ima_sb_post_remount hook
In-Reply-To: <1502904620-20075-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1502904620-20075-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1502904620-20075-5-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Compare the previous i_version flag with the remounted i_version
flag.  Only if there is a change, log change message.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 include/linux/ima.h               |  9 +++++++++
 security/integrity/ima/ima_main.c | 22 ++++++++++++++++++++--
 security/security.c               |  1 +
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 4475cb01149c..bd98221c00d5 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -25,6 +25,9 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern void ima_sb_post_new_mount(const struct vfsmount *newmnt,
 				  const struct path *path);
+extern  void ima_sb_post_remount(const struct super_block *sb,
+				 unsigned long prev_sb_flags,
+				 const struct path *path);
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
@@ -70,6 +73,12 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
 static inline void ima_sb_post_new_mount(const struct vfsmount *newmnt,
 					 const struct path *path)
 { }
+
+static inline void ima_sb_post_remount(const struct super_block *sb,
+				       unsigned long prev_sb_flags,
+				       const struct path *path)
+{ }
+
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index a0a685189001..1b180f974e8d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -373,8 +373,10 @@ void ima_sb_post_new_mount(const struct vfsmount *newmnt,
 
 	sb = newmnt ? newmnt->mnt_sb : path->mnt->mnt_sb;
 
-	if ((sb->s_flags & MS_I_VERSION) || (sb->s_flags & MS_RDONLY) ||
-	    (sb->s_flags & MS_KERNMOUNT))
+	if ((sb->s_flags & MS_KERNMOUNT) || (sb->s_flags & MS_RDONLY))
+		return;
+
+	if (newmnt && (sb->s_flags & MS_I_VERSION))
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(pseudo_fs); i++) {
@@ -394,9 +396,25 @@ void ima_sb_post_new_mount(const struct vfsmount *newmnt,
 	if (newmnt)
 		pr_warn("ima: %s mounted without i_version enabled\n",
 			pathname);
+	else if (sb->s_flags & MS_I_VERSION)
+		pr_warn("ima: %s re-mounted with i_version enabled\n",
+			pathname);
+	else
+		pr_warn("ima: %s re-mounted without i_version enabled\n",
+			pathname);
 	 __putname(pathbuf);
 }
 
+void ima_sb_post_remount(const struct super_block *sb,
+			 unsigned long prev_sb_flags,
+			 const struct path *path)
+{
+	if ((sb->s_flags & MS_I_VERSION) == (prev_sb_flags & MS_I_VERSION))
+		return;		/* nothing changed */
+
+	ima_sb_post_new_mount(NULL, path);
+}
+
 /**
  * ima_read_file - pre-measure/appraise hook decision based on policy
  * @file: pointer to the file to be measured/appraised/audit
diff --git a/security/security.c b/security/security.c
index 7981ad9019c9..1e2051a52b9f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -382,6 +382,7 @@ void security_sb_post_remount(const struct super_block *sb,
 			      const struct path *path)
 {
 	call_void_hook(sb_post_remount, sb, prev_sb_flags, path);
+	ima_sb_post_remount(sb, prev_sb_flags, path);
 }
 
 int security_sb_kern_mount(struct super_block *sb, int flags, void *data)
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
