From: dhowells@redhat.com (David Howells)
Date: Tue, 10 Jul 2018 23:42:07 +0100
Subject: [PATCH 06/32] vfs: Add LSM hooks for the new mount API [ver #9]
In-Reply-To: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
Message-ID: <153126252788.14533.8056607575418869139.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Add LSM hooks for use by the new mount API and filesystem context code.
This includes:

 (1) Hooks to handle allocation, duplication and freeing of the security
     record attached to a filesystem context.

 (2) A hook to snoop source specifications.  There may be multiple of these
     if the filesystem supports it.  They will to be local files/devices if
     fs_context::source_is_dev is true and will be something else, possibly
     remote server specifications, if false.

 (3) A hook to snoop superblock configuration options in key[=val] form.
     If the LSM decides it wants to handle it, it can suppress the option
     being passed to the filesystem.  Note that 'val' may include commas
     and binary data with the fsopen patch.

 (4) A hook to perform validation and allocation after the configuration
     has been done but before the superblock is allocated and set up.

 (5) A hook to transfer the security from the context to a newly created
     superblock.

 (6) A hook to rule on whether a path point can be used as a mountpoint.

These are intended to replace:

	security_sb_copy_data
	security_sb_kern_mount
	security_sb_mount
	security_sb_set_mnt_opts
	security_sb_clone_mnt_opts
	security_sb_parse_opts_str

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-security-module at vger.kernel.org
---

 include/linux/lsm_hooks.h |   70 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/security.h  |   49 ++++++++++++++++++++++++++++++++
 security/security.c       |   46 ++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 926607defd83..43ca087b6454 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -76,6 +76,56 @@
  *	changes on the process such as clearing out non-inheritable signal
  *	state.  This is called immediately after commit_creds().
  *
+ * Security hooks for mount using fs_context.
+ *	[See also Documentation/filesystems/mounting.txt]
+ *
+ * @fs_context_alloc:
+ *	Allocate and attach a security structure to sc->security.  This pointer
+ *	is initialised to NULL by the caller.
+ *	@fc indicates the new filesystem context.
+ *	@reference indicates the source dentry of a submount or start of reconfig.
+ * @fs_context_dup:
+ *	Allocate and attach a security structure to sc->security.  This pointer
+ *	is initialised to NULL by the caller.
+ *	@fc indicates the new filesystem context.
+ *	@src_fc indicates the original filesystem context.
+ * @fs_context_free:
+ *	Clean up a filesystem context.
+ *	@fc indicates the filesystem context.
+ * @fs_context_parse_source:
+ *	Check a source for the superblock (multiple sources may be provided).
+ *	The LSM may reject it with an error; otherwise it should return 0.
+ *	@fc indicates the filesystem context.
+ *	@src indicates the source name.  It is NUL-terminated,
+ * @fs_context_parse_option:
+ *	Userspace provided an option to configure a superblock.  The LSM may
+ *	reject it with an error and may use it for itself, in which case it
+ *	should return 1; otherwise it should return 0 to pass it on to the
+ *	filesystem.
+ *	@fc indicates the filesystem context.
+ *	@opt indicates the option in "key[=val]" form.  It is NUL-terminated,
+ *	but val may be binary data.
+ *	@len indicates the size of the option.
+ * @fs_context_validate:
+ *	Validate the filesystem context preparatory to applying it.  This is
+ *	done after all the options have been parsed.
+ *	@fc indicates the filesystem context.
+ * @sb_get_tree:
+ *	Assign the security to a newly created superblock.
+ *	@fc indicates the filesystem context.
+ *	@fc->root indicates the root that will be mounted.
+ *	@fc->root->d_sb points to the superblock.
+ * @sb_reconfigure:
+ *	Apply reconfiguration to the security on a superblock.
+ *	@fc indicates the filesystem context.
+ *	@fc->root indicates a dentry in the mount.
+ *	@fc->root->d_sb points to the superblock.
+ * @sb_mountpoint:
+ *	Equivalent of sb_mount, but with an fs_context.
+ *	@fc indicates the filesystem context.
+ *	@mountpoint indicates the path on which the mount will take place.
+ *	@mnt_flags indicates the MNT_* flags specified.
+ *
  * Security hooks for filesystem operations.
  *
  * @sb_alloc_security:
@@ -1459,6 +1509,17 @@ union security_list_options {
 	void (*bprm_committing_creds)(struct linux_binprm *bprm);
 	void (*bprm_committed_creds)(struct linux_binprm *bprm);
 
+	int (*fs_context_alloc)(struct fs_context *fc, struct dentry *reference);
+	int (*fs_context_dup)(struct fs_context *fc, struct fs_context *src_sc);
+	void (*fs_context_free)(struct fs_context *fc);
+	int (*fs_context_parse_source)(struct fs_context *fc, char *src);
+	int (*fs_context_parse_option)(struct fs_context *fc, char *opt, size_t len);
+	int (*fs_context_validate)(struct fs_context *fc);
+	int (*sb_get_tree)(struct fs_context *fc);
+	void (*sb_reconfigure)(struct fs_context *fc);
+	int (*sb_mountpoint)(struct fs_context *fc, struct path *mountpoint,
+			     unsigned int mnt_flags);
+
 	int (*sb_alloc_security)(struct super_block *sb);
 	void (*sb_free_security)(struct super_block *sb);
 	int (*sb_copy_data)(char *orig, char *copy);
@@ -1798,6 +1859,15 @@ struct security_hook_heads {
 	struct hlist_head bprm_check_security;
 	struct hlist_head bprm_committing_creds;
 	struct hlist_head bprm_committed_creds;
+	struct hlist_head fs_context_alloc;
+	struct hlist_head fs_context_dup;
+	struct hlist_head fs_context_free;
+	struct hlist_head fs_context_parse_source;
+	struct hlist_head fs_context_parse_option;
+	struct hlist_head fs_context_validate;
+	struct hlist_head sb_get_tree;
+	struct hlist_head sb_reconfigure;
+	struct hlist_head sb_mountpoint;
 	struct hlist_head sb_alloc_security;
 	struct hlist_head sb_free_security;
 	struct hlist_head sb_copy_data;
diff --git a/include/linux/security.h b/include/linux/security.h
index 15d121f156b3..7f093b27169d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -53,6 +53,7 @@ struct msg_msg;
 struct xattr;
 struct xfrm_sec_ctx;
 struct mm_struct;
+struct fs_context;
 
 /* If capable should audit the security request */
 #define SECURITY_CAP_NOAUDIT 0
@@ -225,6 +226,16 @@ int security_bprm_set_creds(struct linux_binprm *bprm);
 int security_bprm_check(struct linux_binprm *bprm);
 void security_bprm_committing_creds(struct linux_binprm *bprm);
 void security_bprm_committed_creds(struct linux_binprm *bprm);
+int security_fs_context_alloc(struct fs_context *fc, struct dentry *reference);
+int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc);
+void security_fs_context_free(struct fs_context *fc);
+int security_fs_context_parse_source(struct fs_context *fc, char *src);
+int security_fs_context_parse_option(struct fs_context *fc, char *opt, size_t len);
+int security_fs_context_validate(struct fs_context *fc);
+int security_sb_get_tree(struct fs_context *fc);
+void security_sb_reconfigure(struct fs_context *fc);
+int security_sb_mountpoint(struct fs_context *fc, struct path *mountpoint,
+			   unsigned int mnt_flags);
 int security_sb_alloc(struct super_block *sb);
 void security_sb_free(struct super_block *sb);
 int security_sb_copy_data(char *orig, char *copy);
@@ -526,6 +537,44 @@ static inline void security_bprm_committed_creds(struct linux_binprm *bprm)
 {
 }
 
+static inline int security_fs_context_alloc(struct fs_context *fc,
+					    struct dentry *reference)
+{
+	return 0;
+}
+static inline int security_fs_context_dup(struct fs_context *fc,
+					  struct fs_context *src_fc)
+{
+	return 0;
+}
+static inline void security_fs_context_free(struct fs_context *fc)
+{
+}
+static inline int security_fs_context_parse_source(struct fs_context *fc, char *src)
+{
+	return 0;
+}
+static inline int security_fs_context_parse_option(struct fs_context *fc, char *opt, size_t len)
+{
+	return 0;
+}
+static inline int security_fs_context_validate(struct fs_context *fc)
+{
+	return 0;
+}
+static inline int security_sb_get_tree(struct fs_context *fc)
+{
+	return 0;
+}
+static inline void security_sb_reconfigure(struct fs_context *fc)
+{
+}
+static inline int security_sb_mountpoint(struct fs_context *fc, struct path *mountpoint,
+					 unsigned int mnt_flags)
+{
+	return 0;
+}
+
 static inline int security_sb_alloc(struct super_block *sb)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index c4cbdb7d3a5f..597470fd3727 100644
--- a/security/security.c
+++ b/security/security.c
@@ -358,6 +358,52 @@ void security_bprm_committed_creds(struct linux_binprm *bprm)
 	call_void_hook(bprm_committed_creds, bprm);
 }
 
+int security_fs_context_alloc(struct fs_context *fc, struct dentry *reference)
+{
+	return call_int_hook(fs_context_alloc, 0, fc, reference);
+}
+
+int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
+{
+	return call_int_hook(fs_context_dup, 0, fc, src_fc);
+}
+
+void security_fs_context_free(struct fs_context *fc)
+{
+	call_void_hook(fs_context_free, fc);
+}
+
+int security_fs_context_parse_source(struct fs_context *fc, char *src)
+{
+	return call_int_hook(fs_context_parse_source, 0, fc, src);
+}
+
+int security_fs_context_parse_option(struct fs_context *fc, char *opt, size_t len)
+{
+	return call_int_hook(fs_context_parse_option, 0, fc, opt, len);
+}
+
+int security_fs_context_validate(struct fs_context *fc)
+{
+	return call_int_hook(fs_context_validate, 0, fc);
+}
+
+int security_sb_get_tree(struct fs_context *fc)
+{
+	return call_int_hook(sb_get_tree, 0, fc);
+}
+
+void security_sb_reconfigure(struct fs_context *fc)
+{
+	call_void_hook(sb_reconfigure, fc);
+}
+
+int security_sb_mountpoint(struct fs_context *fc, struct path *mountpoint,
+			   unsigned int mnt_flags)
+{
+	return call_int_hook(sb_mountpoint, 0, fc, mountpoint, mnt_flags);
+}
+
 int security_sb_alloc(struct super_block *sb)
 {
 	return call_int_hook(sb_alloc_security, 0, sb);

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
