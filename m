From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 16 Aug 2017 13:30:19 -0400
Subject: [RFC PATCH 3/4] security: define a new LSM sb_post_remount hook
In-Reply-To: <1502904620-20075-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1502904620-20075-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1502904620-20075-4-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Allow LSMs to compare the previous and new mount flags. This patch
defines a new LSM hook named security_sb_post_remount.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 fs/namespace.c            | 3 +++
 include/linux/lsm_hooks.h | 9 +++++++++
 include/linux/security.h  | 8 ++++++++
 security/security.c       | 7 +++++++
 4 files changed, 27 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index a7fa13f422ad..e6f4ea9a1008 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2228,6 +2228,7 @@ static int do_remount(struct path *path, int flags, int mnt_flags,
 	int err;
 	struct super_block *sb = path->mnt->mnt_sb;
 	struct mount *mnt = real_mount(path->mnt);
+	unsigned long prev_sb_flags = sb->s_flags;
 
 	if (!check_mnt(mnt))
 		return -EINVAL;
@@ -2279,6 +2280,8 @@ static int do_remount(struct path *path, int flags, int mnt_flags,
 		mnt->mnt.mnt_flags = mnt_flags;
 		touch_mnt_namespace(mnt->mnt_ns);
 		unlock_mount_hash();
+
+		security_sb_post_remount(sb, prev_sb_flags, path);
 	}
 	up_write(&sb->s_umount);
 	return err;
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index c3ecea0d0dca..e940dc43786c 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -123,6 +123,11 @@
  *	@sb superblock being remounted
  *	@data contains the filesystem-specific data.
  *	Return 0 if permission is granted.
+ * @sb_post_remount:
+ *	Allow comparison between new and previous mount flags.
+ *	@sb superblock being remounted
+ *	@prev_sb_flags previous mount flags
+ *	@path contains the path for mount point object.
  * @sb_umount:
  *	Check permission before the @mnt file system is unmounted.
  *	@mnt contains the mounted file system.
@@ -1395,6 +1400,9 @@ union security_list_options {
 	void (*sb_free_security)(struct super_block *sb);
 	int (*sb_copy_data)(char *orig, char *copy);
 	int (*sb_remount)(struct super_block *sb, void *data);
+	void (*sb_post_remount)(const struct super_block *sb,
+				const unsigned long prev_sb_flags,
+				const struct path *path);
 	int (*sb_kern_mount)(struct super_block *sb, int flags, void *data);
 	int (*sb_show_options)(struct seq_file *m, struct super_block *sb);
 	int (*sb_statfs)(struct dentry *dentry);
@@ -1717,6 +1725,7 @@ struct security_hook_heads {
 	struct list_head sb_free_security;
 	struct list_head sb_copy_data;
 	struct list_head sb_remount;
+	struct list_head sb_post_remount;
 	struct list_head sb_kern_mount;
 	struct list_head sb_show_options;
 	struct list_head sb_statfs;
diff --git a/include/linux/security.h b/include/linux/security.h
index 4acdaae7aa04..fa963a870a84 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -237,6 +237,9 @@ int security_sb_alloc(struct super_block *sb);
 void security_sb_free(struct super_block *sb);
 int security_sb_copy_data(char *orig, char *copy);
 int security_sb_remount(struct super_block *sb, void *data);
+void security_sb_post_remount(const struct super_block *sb,
+			      unsigned long prev_sb_flags,
+			      const struct path *path);
 int security_sb_kern_mount(struct super_block *sb, int flags, void *data);
 int security_sb_show_options(struct seq_file *m, struct super_block *sb);
 int security_sb_statfs(struct dentry *dentry);
@@ -565,6 +568,11 @@ static inline int security_sb_remount(struct super_block *sb, void *data)
 	return 0;
 }
 
+static inline void security_sb_post_remount(const struct super_block *sb,
+					    unsigned long prev_sb_flags,
+					    const struct path *path))
+{ }
+
 static inline int security_sb_kern_mount(struct super_block *sb, int flags, void *data)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index 79111141b383..7981ad9019c9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -377,6 +377,13 @@ int security_sb_remount(struct super_block *sb, void *data)
 	return call_int_hook(sb_remount, 0, sb, data);
 }
 
+void security_sb_post_remount(const struct super_block *sb,
+			      unsigned long prev_sb_flags,
+			      const struct path *path)
+{
+	call_void_hook(sb_post_remount, sb, prev_sb_flags, path);
+}
+
 int security_sb_kern_mount(struct super_block *sb, int flags, void *data)
 {
 	return call_int_hook(sb_kern_mount, 0, sb, flags, data);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
