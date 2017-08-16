From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 16 Aug 2017 13:30:17 -0400
Subject: [RFC PATCH 1/4] security: define new LSM sb_post_new_mount hook
In-Reply-To: <1502904620-20075-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1502904620-20075-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1502904620-20075-2-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Different filesystems enable different flags automatically, while
others require the mount flag to be supplied as a mount option (eg.
i_version).  Although this hook is post mount, permit logging or
auditing missing flags.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 fs/namespace.c            | 2 ++
 include/linux/lsm_hooks.h | 7 +++++++
 include/linux/security.h  | 2 ++
 security/security.c       | 6 ++++++
 4 files changed, 17 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index f8893dc6a989..a7fa13f422ad 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2468,6 +2468,8 @@ static int do_new_mount(struct path *path, const char *fstype, int flags,
 	err = do_add_mount(real_mount(mnt), path, mnt_flags);
 	if (err)
 		mntput(mnt);
+	else
+		security_sb_post_new_mount(mnt, path);
 	return err;
 }
 
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ce02f76a6188..c3ecea0d0dca 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -128,6 +128,10 @@
  *	@mnt contains the mounted file system.
  *	@flags contains the unmount flags, e.g. MNT_FORCE.
  *	Return 0 if permission is granted.
+ * @sb_post_new_mount:
+ *	Check mounted options conform to expectations
+ *	@newmnt contains the newly mounted file system.
+ *	@path contains the path for mount point object.
  * @sb_pivotroot:
  *	Check permission before pivoting the root filesystem.
  *	@old_path contains the path for the new location of the
@@ -1396,6 +1400,8 @@ union security_list_options {
 	int (*sb_statfs)(struct dentry *dentry);
 	int (*sb_mount)(const char *dev_name, const struct path *path,
 			const char *type, unsigned long flags, void *data);
+	void (*sb_post_new_mount)(const struct vfsmount *newmnt,
+				  const struct path *path);
 	int (*sb_umount)(struct vfsmount *mnt, int flags);
 	int (*sb_pivotroot)(const struct path *old_path, const struct path *new_path);
 	int (*sb_set_mnt_opts)(struct super_block *sb,
@@ -1716,6 +1722,7 @@ struct security_hook_heads {
 	struct list_head sb_statfs;
 	struct list_head sb_mount;
 	struct list_head sb_umount;
+	struct list_head sb_post_new_mount;
 	struct list_head sb_pivotroot;
 	struct list_head sb_set_mnt_opts;
 	struct list_head sb_clone_mnt_opts;
diff --git a/include/linux/security.h b/include/linux/security.h
index 458e24bea2d4..4acdaae7aa04 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -242,6 +242,8 @@ int security_sb_show_options(struct seq_file *m, struct super_block *sb);
 int security_sb_statfs(struct dentry *dentry);
 int security_sb_mount(const char *dev_name, const struct path *path,
 		      const char *type, unsigned long flags, void *data);
+void security_sb_post_new_mount(const struct vfsmount *mnt,
+				const struct path *path);
 int security_sb_umount(struct vfsmount *mnt, int flags);
 int security_sb_pivotroot(const struct path *old_path, const struct path *new_path);
 int security_sb_set_mnt_opts(struct super_block *sb,
diff --git a/security/security.c b/security/security.c
index 55b5997e4b72..592153e8d2b6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -398,6 +398,12 @@ int security_sb_mount(const char *dev_name, const struct path *path,
 	return call_int_hook(sb_mount, 0, dev_name, path, type, flags, data);
 }
 
+void security_sb_post_new_mount(const struct vfsmount *newmnt,
+				const struct path *path)
+{
+	call_void_hook(sb_post_new_mount, newmnt, path);
+}
+
 int security_sb_umount(struct vfsmount *mnt, int flags)
 {
 	return call_int_hook(sb_umount, 0, mnt, flags);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
