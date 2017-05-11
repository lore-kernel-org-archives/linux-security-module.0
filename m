From: john.johansen@canonical.com (John Johansen)
Date: Wed, 10 May 2017 19:46:25 -0700
Subject: [PATCH 3/3] apparmor: virtualize the policy/ directory
In-Reply-To: <20170511024625.13887-1-john.johansen@canonical.com>
References: <20170511024625.13887-1-john.johansen@canonical.com>
Message-ID: <20170511024625.13887-4-john.johansen@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

virtualize the apparmor policy/ directory so that the current namespace
affects what part of policy is seen. This is done by

 * creating a new apparmorfs filesystem
 * creating a magic symlink from securityfs to the correct apparmorfs
   file in the tree (similar to nsfs use).

apparmor fs data and fns also get renamed some to help indicate where
they are used

  aafs - special magic apparmorfs
  aa_sfs - for fns/data that go into securityfs
  aa_fs - for fns/data that may be used in the either of aafs or securityfs

Signed-off-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Seth Arnold <seth.arnold@canonical.com>
---
 include/uapi/linux/magic.h             |   2 +
 security/apparmor/Makefile             |   6 +-
 security/apparmor/apparmorfs.c         | 773 ++++++++++++++++++++++++---------
 security/apparmor/capability.c         |   4 +-
 security/apparmor/include/apparmorfs.h |  60 +--
 security/apparmor/include/capability.h |   2 +-
 security/apparmor/include/resource.h   |   2 +-
 security/apparmor/policy.c             |   6 +-
 security/apparmor/policy_ns.c          |   4 +-
 security/apparmor/resource.c           |   4 +-
 10 files changed, 611 insertions(+), 252 deletions(-)

diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index e230af2e6855..a0908f1d2760 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -80,6 +80,8 @@
 #define BTRFS_TEST_MAGIC	0x73727279
 #define NSFS_MAGIC		0x6e736673
 #define BPF_FS_MAGIC		0xcafe4a11
+#define AAFS_MAGIC		0x5a3c69f0
+
 /* Since UDF 2.01 is ISO 13346 based... */
 #define UDF_SUPER_MAGIC		0x15013346
 #define BALLOON_KVM_MAGIC	0x13661366
diff --git a/security/apparmor/Makefile b/security/apparmor/Makefile
index ad369a7aac24..b3b6f70f32c5 100644
--- a/security/apparmor/Makefile
+++ b/security/apparmor/Makefile
@@ -20,7 +20,7 @@ cmd_make-caps = echo "static const char *const capability_names[] = {" > $@ ;\
 	sed $< >>$@ -r -n -e '/CAP_FS_MASK/d' \
 	-e 's/^\#define[ \t]+CAP_([A-Z0-9_]+)[ \t]+([0-9]+)/[\2] = "\L\1",/p';\
 	echo "};" >> $@ ;\
-	echo -n '\#define AA_FS_CAPS_MASK "' >> $@ ;\
+	echo -n '\#define AA_SFS_CAPS_MASK "' >> $@ ;\
 	sed $< -r -n -e '/CAP_FS_MASK/d' \
 	    -e 's/^\#define[ \t]+CAP_([A-Z0-9_]+)[ \t]+([0-9]+)/\L\1/p' | \
 	     tr '\n' ' ' | sed -e 's/ $$/"\n/' >> $@
@@ -46,7 +46,7 @@ cmd_make-caps = echo "static const char *const capability_names[] = {" > $@ ;\
 #    #define RLIMIT_FSIZE        1   /* Maximum filesize */
 #    #define RLIMIT_STACK		3	/* max stack size */
 # to
-# #define AA_FS_RLIMIT_MASK "fsize stack"
+# #define AA_SFS_RLIMIT_MASK "fsize stack"
 quiet_cmd_make-rlim = GEN     $@
 cmd_make-rlim = echo "static const char *const rlim_names[RLIM_NLIMITS] = {" \
 	> $@ ;\
@@ -56,7 +56,7 @@ cmd_make-rlim = echo "static const char *const rlim_names[RLIM_NLIMITS] = {" \
 	echo "static const int rlim_map[RLIM_NLIMITS] = {" >> $@ ;\
 	sed -r -n "s/^\# ?define[ \t]+(RLIMIT_[A-Z0-9_]+).*/\1,/p" $< >> $@ ;\
 	echo "};" >> $@ ; \
-	echo -n '\#define AA_FS_RLIMIT_MASK "' >> $@ ;\
+	echo -n '\#define AA_SFS_RLIMIT_MASK "' >> $@ ;\
 	sed -r -n 's/^\# ?define[ \t]+RLIMIT_([A-Z0-9_]+).*/\L\1/p' $< | \
 	    tr '\n' ' ' | sed -e 's/ $$/"\n/' >> $@
 
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 5a6010007046..cc1b95628f0f 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -35,6 +35,35 @@
 #include "include/resource.h"
 #include "include/policy_unpack.h"
 
+/*
+ * The apparmor filesystem interface used for policy load and introspection
+ * The interface is split into two main components based on their function
+ * a securityfs component:
+ *   used for static files that are always available, and which allows
+ *   userspace to specificy the location of the security filesystem.
+ *
+ *   fns and data are prefixed with
+ *      aa_sfs_
+ *
+ * an apparmorfs component:
+ *   used loaded policy content and introspection. It is not part of  a
+ *   regular mounted filesystem and is available only through the magic
+ *   policy symlink in the root of the securityfs apparmor/ directory.
+ *   Tasks queries will be magically redirected to the correct portion
+ *   of the policy tree based on their confinement.
+ *
+ *   fns and data are prefixed with
+ *      aafs_
+ *
+ * The aa_fs_ prefix is used to indicate the fn is used by both the
+ * securityfs and apparmorfs filesystems.
+ */
+
+
+/*
+ * support fns
+ */
+
 /**
  * aa_mangle_name - mangle a profile name to std profile layout form
  * @name: profile name to mangle  (NOT NULL)
@@ -74,6 +103,265 @@ static int mangle_name(const char *name, char *target)
 	return t - target;
 }
 
+
+/*
+ * aafs - core fns and data for the policy tree
+ */
+
+#define AAFS_NAME		"apparmorfs"
+static struct vfsmount *aafs_mnt;
+static int aafs_count;
+
+
+static int aafs_show_path(struct seq_file *seq, struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+
+	seq_printf(seq, "%s:[%lu]", AAFS_NAME, inode->i_ino);
+	return 0;
+}
+
+static void aafs_evict_inode(struct inode *inode)
+{
+	truncate_inode_pages_final(&inode->i_data);
+	clear_inode(inode);
+	if (S_ISLNK(inode->i_mode))
+		kfree(inode->i_link);
+}
+
+static const struct super_operations aafs_super_ops = {
+	.statfs = simple_statfs,
+	.evict_inode = aafs_evict_inode,
+	.show_path = aafs_show_path,
+};
+
+static int fill_super(struct super_block *sb, void *data, int silent)
+{
+	static struct tree_descr files[] = { {""} };
+	int error;
+
+	error = simple_fill_super(sb, AAFS_MAGIC, files);
+	if (error)
+		return error;
+	sb->s_op = &aafs_super_ops;
+
+	return 0;
+}
+
+static struct dentry *aafs_mount(struct file_system_type *fs_type,
+				 int flags, const char *dev_name, void *data)
+{
+	return mount_single(fs_type, flags, data, fill_super);
+}
+
+static struct file_system_type aafs_ops = {
+	.owner = THIS_MODULE,
+	.name = AAFS_NAME,
+	.mount = aafs_mount,
+	.kill_sb = kill_anon_super,
+};
+
+/**
+ * __aafs_setup_d_inode - basic inode setup for apparmorfs
+ * @dir: parent directory for the dentry
+ * @dentry: dentry we are seting the inode up for
+ * @mode: permissions the file should have
+ * @data: data to store on inode.i_private, available in open()
+ * @link: if symlink, symlink target string
+ * @fops: struct file_operations that should be used
+ * @iops: struct of inode_operations that should be used
+ */
+static int __aafs_setup_d_inode(struct inode *dir, struct dentry *dentry,
+			       umode_t mode, void *data, char *link,
+			       const struct file_operations *fops,
+			       const struct inode_operations *iops)
+{
+	struct inode *inode = new_inode(dir->i_sb);
+
+	AA_BUG(!dir);
+	AA_BUG(!dentry);
+
+	if (!inode)
+		return -ENOMEM;
+
+	inode->i_ino = get_next_ino();
+	inode->i_mode = mode;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_private = data;
+	if (S_ISDIR(mode)) {
+		inode->i_op = iops ? iops : &simple_dir_inode_operations;
+		inode->i_fop = &simple_dir_operations;
+		inc_nlink(inode);
+		inc_nlink(dir);
+	} else if (S_ISLNK(mode)) {
+		inode->i_op = iops ? iops : &simple_symlink_inode_operations;
+		inode->i_link = link;
+	} else {
+		inode->i_fop = fops;
+	}
+	d_instantiate(dentry, inode);
+	dget(dentry);
+
+	return 0;
+}
+
+/**
+ * aafs_create - create a dentry in the apparmorfs filesystem
+ *
+ * @name: name of dentry to create
+ * @mode: permissions the file should have
+ * @parent: parent directory for this dentry
+ * @data: data to store on inode.i_private, available in open()
+ * @link: if symlink, symlink target string
+ * @fops: struct file_operations that should be used for
+ * @iops: struct of inode_operations that should be used
+ *
+ * This is the basic "create a xxx" function for apparmorfs.
+ *
+ * Returns a pointer to a dentry if it succeeds, that must be free with
+ * aafs_remove(). Will return ERR_PTR on failure.
+ */
+static struct dentry *aafs_create(const char *name, umode_t mode,
+				  struct dentry *parent, void *data, void *link,
+				  const struct file_operations *fops,
+				  const struct inode_operations *iops)
+{
+	struct dentry *dentry;
+	struct inode *dir;
+	int error;
+
+	AA_BUG(!name);
+	AA_BUG(!parent);
+
+	if (!(mode & S_IFMT))
+		mode = (mode & S_IALLUGO) | S_IFREG;
+
+	error = simple_pin_fs(&aafs_ops, &aafs_mnt, &aafs_count);
+	if (error)
+		return ERR_PTR(error);
+
+	dir = d_inode(parent);
+
+	inode_lock(dir);
+	dentry = lookup_one_len(name, parent, strlen(name));
+	if (IS_ERR(dentry))
+		goto fail_lock;
+
+	if (d_really_is_positive(dentry)) {
+		error = -EEXIST;
+		goto fail_dentry;
+	}
+
+	error = __aafs_setup_d_inode(dir, dentry, mode, data, link, fops, iops);
+	if (error)
+		goto fail_dentry;
+	inode_unlock(dir);
+
+	return dentry;
+
+fail_dentry:
+	dput(dentry);
+
+fail_lock:
+	inode_unlock(dir);
+	simple_release_fs(&aafs_mnt, &aafs_count);
+
+	return ERR_PTR(error);
+}
+
+/**
+ * aafs_create_file - create a file in the apparmorfs filesystem
+ *
+ * @name: name of dentry to create
+ * @mode: permissions the file should have
+ * @parent: parent directory for this dentry
+ * @data: data to store on inode.i_private, available in open()
+ * @fops: struct file_operations that should be used for
+ *
+ * see aafs_create
+ */
+static struct dentry *aafs_create_file(const char *name, umode_t mode,
+				       struct dentry *parent, void *data,
+				       const struct file_operations *fops)
+{
+	return aafs_create(name, mode, parent, data, NULL, fops, NULL);
+}
+
+/**
+ * aafs_create_dir - create a directory in the apparmorfs filesystem
+ *
+ * @name: name of dentry to create
+ * @parent: parent directory for this dentry
+ *
+ * see aafs_create
+ */
+static struct dentry *aafs_create_dir(const char *name, struct dentry *parent)
+{
+	return aafs_create(name, S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
+			   parent, NULL, NULL, NULL, NULL);
+}
+
+/**
+ * aafs_create_symlink - create a symlink in the apparmorfs filesystem
+ * @name: name of dentry to create
+ * @parent: parent directory for this dentry
+ * @target: if symlink, symlink target string
+ * @iops: struct of inode_operations that should be used
+ *
+ * If @target parameter is %NULL, then the @iops parameter needs to be
+ * setup to handle .readlink and .get_link inode_operations.
+ */
+static struct dentry *aafs_create_symlink(const char *name,
+					  struct dentry *parent,
+					  const char *target,
+					  const struct inode_operations *iops)
+{
+	struct dentry *dent;
+	char *link = NULL;
+
+	if (target) {
+		link = kstrdup(target, GFP_KERNEL);
+		if (!link)
+			return ERR_PTR(-ENOMEM);
+	}
+	dent = aafs_create(name, S_IFLNK | S_IRUGO, parent, NULL, link, NULL,
+			   iops);
+	if (IS_ERR(dent))
+		kfree(link);
+
+	return dent;
+}
+
+/**
+ * aafs_remove - removes a file or directory from the apparmorfs filesystem
+ *
+ * @dentry: dentry of the file/directory/symlink to removed.
+ */
+static void aafs_remove(struct dentry *dentry)
+{
+	struct inode *dir;
+
+	if (!dentry || IS_ERR(dentry))
+		return;
+
+	dir = d_inode(dentry->d_parent);
+	inode_lock(dir);
+	if (simple_positive(dentry)) {
+		if (d_is_dir(dentry))
+			simple_rmdir(dir, dentry);
+		else
+			simple_unlink(dir, dentry);
+		dput(dentry);
+	}
+	inode_unlock(dir);
+	simple_release_fs(&aafs_mnt, &aafs_count);
+}
+
+
+/*
+ * aa_fs - policy load/replace/remove
+ */
+
 /**
  * aa_simple_write_to_buffer - common routine for getting policy from user
  * @userbuf: user buffer to copy data from  (NOT NULL)
@@ -213,6 +501,11 @@ static const struct file_operations aa_fs_profile_remove = {
 	.llseek = default_llseek,
 };
 
+void __aa_bump_ns_revision(struct aa_ns *ns)
+{
+	ns->revision++;
+}
+
 /**
  * query_data - queries a policy and writes its data to buf
  * @buf: the resulting data is stored here (NOT NULL)
@@ -344,28 +637,28 @@ static ssize_t aa_write_access(struct file *file, const char __user *ubuf,
 	return count;
 }
 
-static const struct file_operations aa_fs_access = {
+static const struct file_operations aa_sfs_access = {
 	.write		= aa_write_access,
 	.read		= simple_transaction_read,
 	.release	= simple_transaction_release,
 	.llseek		= generic_file_llseek,
 };
 
-static int aa_fs_seq_show(struct seq_file *seq, void *v)
+static int aa_sfs_seq_show(struct seq_file *seq, void *v)
 {
-	struct aa_fs_entry *fs_file = seq->private;
+	struct aa_sfs_entry *fs_file = seq->private;
 
 	if (!fs_file)
 		return 0;
 
 	switch (fs_file->v_type) {
-	case AA_FS_TYPE_BOOLEAN:
+	case AA_SFS_TYPE_BOOLEAN:
 		seq_printf(seq, "%s\n", fs_file->v.boolean ? "yes" : "no");
 		break;
-	case AA_FS_TYPE_STRING:
+	case AA_SFS_TYPE_STRING:
 		seq_printf(seq, "%s\n", fs_file->v.string);
 		break;
-	case AA_FS_TYPE_U64:
+	case AA_SFS_TYPE_U64:
 		seq_printf(seq, "%#08lx\n", fs_file->v.u64);
 		break;
 	default:
@@ -376,21 +669,40 @@ static int aa_fs_seq_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int aa_fs_seq_open(struct inode *inode, struct file *file)
+static int aa_sfs_seq_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, aa_fs_seq_show, inode->i_private);
+	return single_open(file, aa_sfs_seq_show, inode->i_private);
 }
 
-const struct file_operations aa_fs_seq_file_ops = {
+const struct file_operations aa_sfs_seq_file_ops = {
 	.owner		= THIS_MODULE,
-	.open		= aa_fs_seq_open,
+	.open		= aa_sfs_seq_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
 
-static int aa_fs_seq_profile_open(struct inode *inode, struct file *file,
-				  int (*show)(struct seq_file *, void *))
+/*
+ * profile based file operations
+ *     policy/profiles/XXXX/profiles/ *
+ */
+
+#define SEQ_PROFILE_FOPS(NAME)						      \
+static int seq_profile_ ##NAME ##_open(struct inode *inode, struct file *file)\
+{									      \
+	return seq_profile_open(inode, file, seq_profile_ ##NAME ##_show);    \
+}									      \
+									      \
+static const struct file_operations seq_profile_ ##NAME ##_fops = {	      \
+	.owner		= THIS_MODULE,					      \
+	.open		= seq_profile_ ##NAME ##_open,			      \
+	.read		= seq_read,					      \
+	.llseek		= seq_lseek,					      \
+	.release	= seq_profile_release,				      \
+}									      \
+
+static int seq_profile_open(struct inode *inode, struct file *file,
+			    int (*show)(struct seq_file *, void *))
 {
 	struct aa_proxy *proxy = aa_get_proxy(inode->i_private);
 	int error = single_open(file, show, proxy);
@@ -403,7 +715,7 @@ static int aa_fs_seq_profile_open(struct inode *inode, struct file *file,
 	return error;
 }
 
-static int aa_fs_seq_profile_release(struct inode *inode, struct file *file)
+static int seq_profile_release(struct inode *inode, struct file *file)
 {
 	struct seq_file *seq = (struct seq_file *) file->private_data;
 	if (seq)
@@ -411,7 +723,7 @@ static int aa_fs_seq_profile_release(struct inode *inode, struct file *file)
 	return single_release(inode, file);
 }
 
-static int aa_fs_seq_profname_show(struct seq_file *seq, void *v)
+static int seq_profile_name_show(struct seq_file *seq, void *v)
 {
 	struct aa_proxy *proxy = seq->private;
 	struct aa_profile *profile = aa_get_profile_rcu(&proxy->profile);
@@ -421,20 +733,7 @@ static int aa_fs_seq_profname_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int aa_fs_seq_profname_open(struct inode *inode, struct file *file)
-{
-	return aa_fs_seq_profile_open(inode, file, aa_fs_seq_profname_show);
-}
-
-static const struct file_operations aa_fs_profname_fops = {
-	.owner		= THIS_MODULE,
-	.open		= aa_fs_seq_profname_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= aa_fs_seq_profile_release,
-};
-
-static int aa_fs_seq_profmode_show(struct seq_file *seq, void *v)
+static int seq_profile_mode_show(struct seq_file *seq, void *v)
 {
 	struct aa_proxy *proxy = seq->private;
 	struct aa_profile *profile = aa_get_profile_rcu(&proxy->profile);
@@ -444,20 +743,7 @@ static int aa_fs_seq_profmode_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int aa_fs_seq_profmode_open(struct inode *inode, struct file *file)
-{
-	return aa_fs_seq_profile_open(inode, file, aa_fs_seq_profmode_show);
-}
-
-static const struct file_operations aa_fs_profmode_fops = {
-	.owner		= THIS_MODULE,
-	.open		= aa_fs_seq_profmode_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= aa_fs_seq_profile_release,
-};
-
-static int aa_fs_seq_profattach_show(struct seq_file *seq, void *v)
+static int seq_profile_attach_show(struct seq_file *seq, void *v)
 {
 	struct aa_proxy *proxy = seq->private;
 	struct aa_profile *profile = aa_get_profile_rcu(&proxy->profile);
@@ -472,20 +758,7 @@ static int aa_fs_seq_profattach_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int aa_fs_seq_profattach_open(struct inode *inode, struct file *file)
-{
-	return aa_fs_seq_profile_open(inode, file, aa_fs_seq_profattach_show);
-}
-
-static const struct file_operations aa_fs_profattach_fops = {
-	.owner		= THIS_MODULE,
-	.open		= aa_fs_seq_profattach_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= aa_fs_seq_profile_release,
-};
-
-static int aa_fs_seq_hash_show(struct seq_file *seq, void *v)
+static int seq_profile_hash_show(struct seq_file *seq, void *v)
 {
 	struct aa_proxy *proxy = seq->private;
 	struct aa_profile *profile = aa_get_profile_rcu(&proxy->profile);
@@ -501,21 +774,32 @@ static int aa_fs_seq_hash_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int aa_fs_seq_hash_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, aa_fs_seq_hash_show, inode->i_private);
-}
+SEQ_PROFILE_FOPS(name);
+SEQ_PROFILE_FOPS(mode);
+SEQ_PROFILE_FOPS(attach);
+SEQ_PROFILE_FOPS(hash);
 
-static const struct file_operations aa_fs_seq_hash_fops = {
-	.owner		= THIS_MODULE,
-	.open		= aa_fs_seq_hash_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+/*
+ * namespace based files
+ *     several root files and
+ *     policy/ *
+ */
 
+#define SEQ_NS_FOPS(NAME)						      \
+static int seq_ns_ ##NAME ##_open(struct inode *inode, struct file *file)     \
+{									      \
+	return single_open(file, seq_ns_ ##NAME ##_show, inode->i_private);   \
+}									      \
+									      \
+static const struct file_operations seq_ns_ ##NAME ##_fops = {	      \
+	.owner		= THIS_MODULE,					      \
+	.open		= seq_ns_ ##NAME ##_open,			      \
+	.read		= seq_read,					      \
+	.llseek		= seq_lseek,					      \
+	.release	= single_release,				      \
+}									      \
 
-static int aa_fs_seq_show_ns_level(struct seq_file *seq, void *v)
+static int seq_ns_stacked_show(struct seq_file *seq, void *v)
 {
 	struct aa_ns *ns = aa_current_profile()->ns;
 
@@ -524,20 +808,7 @@ static int aa_fs_seq_show_ns_level(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int aa_fs_seq_open_ns_level(struct inode *inode, struct file *file)
-{
-	return single_open(file, aa_fs_seq_show_ns_level, inode->i_private);
-}
-
-static const struct file_operations aa_fs_ns_level = {
-	.owner		= THIS_MODULE,
-	.open		= aa_fs_seq_open_ns_level,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int aa_fs_seq_show_ns_name(struct seq_file *seq, void *v)
+static int seq_ns_level_show(struct seq_file *seq, void *v)
 {
 	struct aa_ns *ns = aa_current_profile()->ns;
 
@@ -546,18 +817,8 @@ static int aa_fs_seq_show_ns_name(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int aa_fs_seq_open_ns_name(struct inode *inode, struct file *file)
-{
-	return single_open(file, aa_fs_seq_show_ns_name, inode->i_private);
-}
-
-static const struct file_operations aa_fs_ns_name = {
-	.owner		= THIS_MODULE,
-	.open		= aa_fs_seq_open_ns_name,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+SEQ_NS_FOPS(stacked);
+SEQ_NS_FOPS(level);
 
 
 /* policy/raw_data/ * file ops */
@@ -691,7 +952,7 @@ static void remove_rawdata_dents(struct aa_loaddata *rawdata)
 	for (i = 0; i < AAFS_LOADDATA_NDENTS; i++) {
 		if (!IS_ERR_OR_NULL(rawdata->dents[i])) {
 			/* no refcounts on i_private */
-			securityfs_remove(rawdata->dents[i]);
+			aafs_remove(rawdata->dents[i]);
 			rawdata->dents[i] = NULL;
 		}
 	}
@@ -728,32 +989,32 @@ int __aa_fs_create_rawdata(struct aa_ns *ns, struct aa_loaddata *rawdata)
 		/* ->name freed when rawdata freed */
 		return -ENOMEM;
 
-	dir = securityfs_create_dir(rawdata->name, ns_subdata_dir(ns));
+	dir = aafs_create_dir(rawdata->name, ns_subdata_dir(ns));
 	if (IS_ERR(dir))
 		return PTR_ERR(dir);
 	rawdata->dents[AAFS_LOADDATA_DIR] = dir;
 
-	dent = securityfs_create_file("abi", S_IFREG | 0444, dir, rawdata,
+	dent = aafs_create_file("abi", S_IFREG | 0444, dir, rawdata,
 				      &seq_rawdata_abi_fops);
 	if (IS_ERR(dent))
 		goto fail;
 	rawdata->dents[AAFS_LOADDATA_ABI] = dent;
 
-	dent = securityfs_create_file("revision", S_IFREG | 0444, dir, rawdata,
+	dent = aafs_create_file("revision", S_IFREG | 0444, dir, rawdata,
 				      &seq_rawdata_revision_fops);
 	if (IS_ERR(dent))
 		goto fail;
 	rawdata->dents[AAFS_LOADDATA_REVISION] = dent;
 
 	if (aa_g_hash_policy) {
-		dent = securityfs_create_file("sha1", S_IFREG | 0444, dir,
+		dent = aafs_create_file("sha1", S_IFREG | 0444, dir,
 					      rawdata, &seq_rawdata_hash_fops);
 		if (IS_ERR(dent))
 			goto fail;
 		rawdata->dents[AAFS_LOADDATA_HASH] = dent;
 	}
 
-	dent = securityfs_create_file("raw_data", S_IFREG | 0444,
+	dent = aafs_create_file("raw_data", S_IFREG | 0444,
 				      dir, rawdata, &rawdata_fops);
 	if (IS_ERR(dent))
 		goto fail;
@@ -773,7 +1034,12 @@ int __aa_fs_create_rawdata(struct aa_ns *ns, struct aa_loaddata *rawdata)
 }
 
 /** fns to setup dynamic per profile/namespace files **/
-void __aa_fs_profile_rmdir(struct aa_profile *profile)
+
+/**
+ *
+ * Requires: @profile->ns->lock held
+ */
+void __aafs_profile_rmdir(struct aa_profile *profile)
 {
 	struct aa_profile *child;
 	int i;
@@ -782,7 +1048,7 @@ void __aa_fs_profile_rmdir(struct aa_profile *profile)
 		return;
 
 	list_for_each_entry(child, &profile->base.profiles, base.list)
-		__aa_fs_profile_rmdir(child);
+		__aafs_profile_rmdir(child);
 
 	for (i = AAFS_PROF_SIZEOF - 1; i >= 0; --i) {
 		struct aa_proxy *proxy;
@@ -790,17 +1056,25 @@ void __aa_fs_profile_rmdir(struct aa_profile *profile)
 			continue;
 
 		proxy = d_inode(profile->dents[i])->i_private;
-		securityfs_remove(profile->dents[i]);
+		aafs_remove(profile->dents[i]);
 		aa_put_proxy(proxy);
 		profile->dents[i] = NULL;
 	}
 }
 
-void __aa_fs_profile_migrate_dents(struct aa_profile *old,
-				   struct aa_profile *new)
+/**
+ *
+ * Requires: @old->ns->lock held
+ */
+void __aafs_profile_migrate_dents(struct aa_profile *old,
+				  struct aa_profile *new)
 {
 	int i;
 
+	AA_BUG(!old);
+	AA_BUG(!new);
+	AA_BUG(!mutex_is_locked(&profiles_ns(old)->lock));
+
 	for (i = 0; i < AAFS_PROF_SIZEOF; i++) {
 		new->dents[i] = old->dents[i];
 		if (new->dents[i])
@@ -816,7 +1090,7 @@ static struct dentry *create_profile_file(struct dentry *dir, const char *name,
 	struct aa_proxy *proxy = aa_get_proxy(profile->proxy);
 	struct dentry *dent;
 
-	dent = securityfs_create_file(name, S_IFREG | 0444, dir, proxy, fops);
+	dent = aafs_create_file(name, S_IFREG | 0444, dir, proxy, fops);
 	if (IS_ERR(dent))
 		aa_put_proxy(proxy);
 
@@ -858,18 +1132,21 @@ static int gen_symlink_name(char *buffer, size_t bsize, int depth,
 /*
  * Requires: @profile->ns->lock held
  */
-int __aa_fs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
+int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
 {
 	struct aa_profile *child;
 	struct dentry *dent = NULL, *dir;
 	int error;
 
+	AA_BUG(!profile);
+	AA_BUG(!mutex_is_locked(&profiles_ns(profile)->lock));
+
 	if (!parent) {
 		struct aa_profile *p;
 		p = aa_deref_parent(profile);
 		dent = prof_dir(p);
 		/* adding to parent that previously didn't have children */
-		dent = securityfs_create_dir("profiles", dent);
+		dent = aafs_create_dir("profiles", dent);
 		if (IS_ERR(dent))
 			goto fail;
 		prof_child_dir(p) = parent = dent;
@@ -888,30 +1165,32 @@ int __aa_fs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
 		sprintf(profile->dirname + len, ".%ld", profile->ns->uniq_id++);
 	}
 
-	dent = securityfs_create_dir(profile->dirname, parent);
+	dent = aafs_create_dir(profile->dirname, parent);
 	if (IS_ERR(dent))
 		goto fail;
 	prof_dir(profile) = dir = dent;
 
-	dent = create_profile_file(dir, "name", profile, &aa_fs_profname_fops);
+	dent = create_profile_file(dir, "name", profile,
+				   &seq_profile_name_fops);
 	if (IS_ERR(dent))
 		goto fail;
 	profile->dents[AAFS_PROF_NAME] = dent;
 
-	dent = create_profile_file(dir, "mode", profile, &aa_fs_profmode_fops);
+	dent = create_profile_file(dir, "mode", profile,
+				   &seq_profile_mode_fops);
 	if (IS_ERR(dent))
 		goto fail;
 	profile->dents[AAFS_PROF_MODE] = dent;
 
 	dent = create_profile_file(dir, "attach", profile,
-				   &aa_fs_profattach_fops);
+				   &seq_profile_attach_fops);
 	if (IS_ERR(dent))
 		goto fail;
 	profile->dents[AAFS_PROF_ATTACH] = dent;
 
 	if (profile->hash) {
 		dent = create_profile_file(dir, "sha1", profile,
-					   &aa_fs_seq_hash_fops);
+					   &seq_profile_hash_fops);
 		if (IS_ERR(dent))
 			goto fail;
 		profile->dents[AAFS_PROF_HASH] = dent;
@@ -920,11 +1199,12 @@ int __aa_fs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
 	if (profile->rawdata) {
 		char target[64];
 		int depth = profile_depth(profile);
+
 		error = gen_symlink_name(target, sizeof(target), depth,
 					 profile->rawdata->name, "sha1");
 		if (error < 0)
 			goto fail2;
-		dent = securityfs_create_symlink("raw_sha1", dir, target, NULL);
+		dent = aafs_create_symlink("raw_sha1", dir, target, NULL);
 		if (IS_ERR(dent))
 			goto fail;
 		profile->dents[AAFS_PROF_RAW_HASH] = dent;
@@ -933,7 +1213,7 @@ int __aa_fs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
 					 profile->rawdata->name, "abi");
 		if (error < 0)
 			goto fail2;
-		dent = securityfs_create_symlink("raw_abi", dir, target, NULL);
+		dent = aafs_create_symlink("raw_abi", dir, target, NULL);
 		if (IS_ERR(dent))
 			goto fail;
 		profile->dents[AAFS_PROF_RAW_ABI] = dent;
@@ -942,14 +1222,14 @@ int __aa_fs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
 					 profile->rawdata->name, "raw_data");
 		if (error < 0)
 			goto fail2;
-		dent = securityfs_create_symlink("raw_data", dir, target, NULL);
+		dent = aafs_create_symlink("raw_data", dir, target, NULL);
 		if (IS_ERR(dent))
 			goto fail;
 		profile->dents[AAFS_PROF_RAW_DATA] = dent;
 	}
 
 	list_for_each_entry(child, &profile->base.profiles, base.list) {
-		error = __aa_fs_profile_mkdir(child, prof_child_dir(profile));
+		error = __aafs_profile_mkdir(child, prof_child_dir(profile));
 		if (error)
 			goto fail2;
 	}
@@ -960,7 +1240,7 @@ int __aa_fs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
 	error = PTR_ERR(dent);
 
 fail2:
-	__aa_fs_profile_rmdir(profile);
+	__aafs_profile_rmdir(profile);
 
 	return error;
 }
@@ -975,7 +1255,11 @@ static void __aa_fs_list_remove_rawdata(struct aa_ns *ns)
 		__aa_fs_remove_rawdata(ent);
 }
 
-void __aa_fs_ns_rmdir(struct aa_ns *ns)
+/**
+ *
+ * Requires: @ns->lock held
+ */
+void __aafs_ns_rmdir(struct aa_ns *ns)
 {
 	struct aa_ns *sub;
 	struct aa_profile *child;
@@ -983,13 +1267,14 @@ void __aa_fs_ns_rmdir(struct aa_ns *ns)
 
 	if (!ns)
 		return;
+	AA_BUG(!mutex_is_locked(&ns->lock));
 
 	list_for_each_entry(child, &ns->base.profiles, base.list)
-		__aa_fs_profile_rmdir(child);
+		__aafs_profile_rmdir(child);
 
 	list_for_each_entry(sub, &ns->sub_ns, base.list) {
 		mutex_lock(&sub->lock);
-		__aa_fs_ns_rmdir(sub);
+		__aafs_ns_rmdir(sub);
 		mutex_unlock(&sub->lock);
 	}
 
@@ -1013,51 +1298,51 @@ void __aa_fs_ns_rmdir(struct aa_ns *ns)
 	}
 
 	for (i = AAFS_NS_SIZEOF - 1; i >= 0; --i) {
-		securityfs_remove(ns->dents[i]);
+		aafs_remove(ns->dents[i]);
 		ns->dents[i] = NULL;
 	}
 }
 
 /* assumes cleanup in caller */
-static int __aa_fs_ns_mkdir_entries(struct aa_ns *ns, struct dentry *dir)
+static int __aafs_ns_mkdir_entries(struct aa_ns *ns, struct dentry *dir)
 {
 	struct dentry *dent;
 
 	AA_BUG(!ns);
 	AA_BUG(!dir);
 
-	dent = securityfs_create_dir("profiles", dir);
+	dent = aafs_create_dir("profiles", dir);
 	if (IS_ERR(dent))
 		return PTR_ERR(dent);
 	ns_subprofs_dir(ns) = dent;
 
-	dent = securityfs_create_dir("raw_data", dir);
+	dent = aafs_create_dir("raw_data", dir);
 	if (IS_ERR(dent))
 		return PTR_ERR(dent);
 	ns_subdata_dir(ns) = dent;
 
-	dent = securityfs_create_file(".load", 0640, dir, ns,
+	dent = aafs_create_file(".load", 0640, dir, ns,
 				      &aa_fs_profile_load);
 	if (IS_ERR(dent))
 		return PTR_ERR(dent);
 	aa_get_ns(ns);
 	ns_subload(ns) = dent;
 
-	dent = securityfs_create_file(".replace", 0640, dir, ns,
+	dent = aafs_create_file(".replace", 0640, dir, ns,
 				      &aa_fs_profile_replace);
 	if (IS_ERR(dent))
 		return PTR_ERR(dent);
 	aa_get_ns(ns);
 	ns_subreplace(ns) = dent;
 
-	dent = securityfs_create_file(".remove", 0640, dir, ns,
+	dent = aafs_create_file(".remove", 0640, dir, ns,
 				      &aa_fs_profile_remove);
 	if (IS_ERR(dent))
 		return PTR_ERR(dent);
 	aa_get_ns(ns);
 	ns_subremove(ns) = dent;
 
-	dent = securityfs_create_dir("namespaces", dir);
+	dent = aafs_create_dir("namespaces", dir);
 	if (IS_ERR(dent))
 		return PTR_ERR(dent);
 	aa_get_ns(ns);
@@ -1066,11 +1351,16 @@ static int __aa_fs_ns_mkdir_entries(struct aa_ns *ns, struct dentry *dir)
 	return 0;
 }
 
-int __aa_fs_ns_mkdir(struct aa_ns *ns, struct dentry *parent, const char *name)
+/**
+ *
+ * Requires: @ns->lock held
+ */
+int __aafs_ns_mkdir(struct aa_ns *ns, struct dentry *parent, const char *name,
+		    struct dentry *dent)
 {
 	struct aa_ns *sub;
 	struct aa_profile *child;
-	struct dentry *dent, *dir;
+	struct dentry *dir;
 	int error;
 
 	AA_BUG(!ns);
@@ -1080,19 +1370,21 @@ int __aa_fs_ns_mkdir(struct aa_ns *ns, struct dentry *parent, const char *name)
 	if (!name)
 		name = ns->base.name;
 
-	/* create ns dir if it doesn't already exist */
-	dent = securityfs_create_dir(name, parent);
-	if (IS_ERR(dent))
-		goto fail;
-
+	if (!dent) {
+		/* create ns dir if it doesn't already exist */
+		dent = aafs_create_dir(name, parent);
+		if (IS_ERR(dent))
+			goto fail;
+	} else
+		dget(dent);
 	ns_dir(ns) = dir = dent;
-	error = __aa_fs_ns_mkdir_entries(ns, dir);
+	error = __aafs_ns_mkdir_entries(ns, dir);
 	if (error)
 		goto fail2;
 
 	/* profiles */
 	list_for_each_entry(child, &ns->base.profiles, base.list) {
-		error = __aa_fs_profile_mkdir(child, ns_subprofs_dir(ns));
+		error = __aafs_profile_mkdir(child, ns_subprofs_dir(ns));
 		if (error)
 			goto fail2;
 	}
@@ -1100,7 +1392,7 @@ int __aa_fs_ns_mkdir(struct aa_ns *ns, struct dentry *parent, const char *name)
 	/* subnamespaces */
 	list_for_each_entry(sub, &ns->sub_ns, base.list) {
 		mutex_lock(&sub->lock);
-		error = __aa_fs_ns_mkdir(sub, ns_subns_dir(ns), NULL);
+		error = __aafs_ns_mkdir(sub, ns_subns_dir(ns), NULL, NULL);
 		mutex_unlock(&sub->lock);
 		if (error)
 			goto fail2;
@@ -1112,7 +1404,7 @@ int __aa_fs_ns_mkdir(struct aa_ns *ns, struct dentry *parent, const char *name)
 	error = PTR_ERR(dent);
 
 fail2:
-	__aa_fs_ns_rmdir(ns);
+	__aafs_ns_rmdir(ns);
 
 	return error;
 }
@@ -1322,7 +1614,7 @@ static int seq_show_profile(struct seq_file *f, void *p)
 	return 0;
 }
 
-static const struct seq_operations aa_fs_profiles_op = {
+static const struct seq_operations aa_sfs_profiles_op = {
 	.start = p_start,
 	.next = p_next,
 	.stop = p_stop,
@@ -1334,7 +1626,7 @@ static int profiles_open(struct inode *inode, struct file *file)
 	if (!policy_view_capable(NULL))
 		return -EACCES;
 
-	return seq_open(file, &aa_fs_profiles_op);
+	return seq_open(file, &aa_sfs_profiles_op);
 }
 
 static int profiles_release(struct inode *inode, struct file *file)
@@ -1342,7 +1634,7 @@ static int profiles_release(struct inode *inode, struct file *file)
 	return seq_release(inode, file);
 }
 
-static const struct file_operations aa_fs_profiles_fops = {
+static const struct file_operations aa_sfs_profiles_fops = {
 	.open = profiles_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
@@ -1351,64 +1643,62 @@ static const struct file_operations aa_fs_profiles_fops = {
 
 
 /** Base file system setup **/
-static struct aa_fs_entry aa_fs_entry_file[] = {
-	AA_FS_FILE_STRING("mask", "create read write exec append mmap_exec " \
-				  "link lock"),
+static struct aa_sfs_entry aa_sfs_entry_file[] = {
+	AA_SFS_FILE_STRING("mask",
+			   "create read write exec append mmap_exec link lock"),
 	{ }
 };
 
-static struct aa_fs_entry aa_fs_entry_domain[] = {
-	AA_FS_FILE_BOOLEAN("change_hat",	1),
-	AA_FS_FILE_BOOLEAN("change_hatv",	1),
-	AA_FS_FILE_BOOLEAN("change_onexec",	1),
-	AA_FS_FILE_BOOLEAN("change_profile",	1),
-	AA_FS_FILE_BOOLEAN("fix_binfmt_elf_mmap",	1),
-	AA_FS_FILE_STRING("version", "1.2"),
+static struct aa_sfs_entry aa_sfs_entry_domain[] = {
+	AA_SFS_FILE_BOOLEAN("change_hat",	1),
+	AA_SFS_FILE_BOOLEAN("change_hatv",	1),
+	AA_SFS_FILE_BOOLEAN("change_onexec",	1),
+	AA_SFS_FILE_BOOLEAN("change_profile",	1),
+	AA_SFS_FILE_BOOLEAN("fix_binfmt_elf_mmap",	1),
+	AA_SFS_FILE_STRING("version", "1.2"),
 	{ }
 };
 
-static struct aa_fs_entry aa_fs_entry_versions[] = {
-	AA_FS_FILE_BOOLEAN("v5",	1),
+static struct aa_sfs_entry aa_sfs_entry_versions[] = {
+	AA_SFS_FILE_BOOLEAN("v5",	1),
 	{ }
 };
 
-static struct aa_fs_entry aa_fs_entry_policy[] = {
-	AA_FS_DIR("versions",                   aa_fs_entry_versions),
-	AA_FS_FILE_BOOLEAN("set_load",		1),
+static struct aa_sfs_entry aa_sfs_entry_policy[] = {
+	AA_SFS_DIR("versions",			aa_sfs_entry_versions),
+	AA_SFS_FILE_BOOLEAN("set_load",		1),
 	{ }
 };
 
-static struct aa_fs_entry aa_fs_entry_features[] = {
-	AA_FS_DIR("policy",			aa_fs_entry_policy),
-	AA_FS_DIR("domain",			aa_fs_entry_domain),
-	AA_FS_DIR("file",			aa_fs_entry_file),
-	AA_FS_FILE_U64("capability",		VFS_CAP_FLAGS_MASK),
-	AA_FS_DIR("rlimit",			aa_fs_entry_rlimit),
-	AA_FS_DIR("caps",			aa_fs_entry_caps),
+static struct aa_sfs_entry aa_sfs_entry_features[] = {
+	AA_SFS_DIR("policy",			aa_sfs_entry_policy),
+	AA_SFS_DIR("domain",			aa_sfs_entry_domain),
+	AA_SFS_DIR("file",			aa_sfs_entry_file),
+	AA_SFS_FILE_U64("capability",		VFS_CAP_FLAGS_MASK),
+	AA_SFS_DIR("rlimit",			aa_sfs_entry_rlimit),
+	AA_SFS_DIR("caps",			aa_sfs_entry_caps),
 	{ }
 };
 
-static struct aa_fs_entry aa_fs_entry_apparmor[] = {
-	AA_FS_FILE_FOPS(".access", 0640, &aa_fs_access),
-	AA_FS_FILE_FOPS(".ns_level", 0666, &aa_fs_ns_level),
-	AA_FS_FILE_FOPS(".ns_name", 0640, &aa_fs_ns_name),
-	AA_FS_FILE_FOPS("profiles", 0440, &aa_fs_profiles_fops),
-	AA_FS_DIR("features", aa_fs_entry_features),
+static struct aa_sfs_entry aa_sfs_entry_apparmor[] = {
+	AA_SFS_FILE_FOPS(".access", 0640, &aa_sfs_access),
+	AA_SFS_FILE_FOPS("profiles", 0440, &aa_sfs_profiles_fops),
+	AA_SFS_DIR("features", aa_sfs_entry_features),
 	{ }
 };
 
-static struct aa_fs_entry aa_fs_entry =
-	AA_FS_DIR("apparmor", aa_fs_entry_apparmor);
+static struct aa_sfs_entry aa_sfs_entry =
+	AA_SFS_DIR("apparmor", aa_sfs_entry_apparmor);
 
 /**
- * aafs_create_file - create a file entry in the apparmor securityfs
- * @fs_file: aa_fs_entry to build an entry for (NOT NULL)
+ * entry_create_file - create a file entry in the apparmor securityfs
+ * @fs_file: aa_sfs_entry to build an entry for (NOT NULL)
  * @parent: the parent dentry in the securityfs
  *
- * Use aafs_remove_file to remove entries created with this fn.
+ * Use entry_remove_file to remove entries created with this fn.
  */
-static int __init aafs_create_file(struct aa_fs_entry *fs_file,
-				   struct dentry *parent)
+static int __init entry_create_file(struct aa_sfs_entry *fs_file,
+				    struct dentry *parent)
 {
 	int error = 0;
 
@@ -1423,18 +1713,18 @@ static int __init aafs_create_file(struct aa_fs_entry *fs_file,
 	return error;
 }
 
-static void __init aafs_remove_dir(struct aa_fs_entry *fs_dir);
+static void __init entry_remove_dir(struct aa_sfs_entry *fs_dir);
 /**
- * aafs_create_dir - recursively create a directory entry in the securityfs
- * @fs_dir: aa_fs_entry (and all child entries) to build (NOT NULL)
+ * entry_create_dir - recursively create a directory entry in the securityfs
+ * @fs_dir: aa_sfs_entry (and all child entries) to build (NOT NULL)
  * @parent: the parent dentry in the securityfs
  *
- * Use aafs_remove_dir to remove entries created with this fn.
+ * Use entry_remove_dir to remove entries created with this fn.
  */
-static int __init aafs_create_dir(struct aa_fs_entry *fs_dir,
-				  struct dentry *parent)
+static int __init entry_create_dir(struct aa_sfs_entry *fs_dir,
+				   struct dentry *parent)
 {
-	struct aa_fs_entry *fs_file;
+	struct aa_sfs_entry *fs_file;
 	struct dentry *dir;
 	int error;
 
@@ -1444,10 +1734,10 @@ static int __init aafs_create_dir(struct aa_fs_entry *fs_dir,
 	fs_dir->dentry = dir;
 
 	for (fs_file = fs_dir->v.files; fs_file && fs_file->name; ++fs_file) {
-		if (fs_file->v_type == AA_FS_TYPE_DIR)
-			error = aafs_create_dir(fs_file, fs_dir->dentry);
+		if (fs_file->v_type == AA_SFS_TYPE_DIR)
+			error = entry_create_dir(fs_file, fs_dir->dentry);
 		else
-			error = aafs_create_file(fs_file, fs_dir->dentry);
+			error = entry_create_file(fs_file, fs_dir->dentry);
 		if (error)
 			goto failed;
 	}
@@ -1455,16 +1745,16 @@ static int __init aafs_create_dir(struct aa_fs_entry *fs_dir,
 	return 0;
 
 failed:
-	aafs_remove_dir(fs_dir);
+	entry_remove_dir(fs_dir);
 
 	return error;
 }
 
 /**
- * aafs_remove_file - drop a single file entry in the apparmor securityfs
- * @fs_file: aa_fs_entry to detach from the securityfs (NOT NULL)
+ * entry_remove_file - drop a single file entry in the apparmor securityfs
+ * @fs_file: aa_sfs_entry to detach from the securityfs (NOT NULL)
  */
-static void __init aafs_remove_file(struct aa_fs_entry *fs_file)
+static void __init entry_remove_file(struct aa_sfs_entry *fs_file)
 {
 	if (!fs_file->dentry)
 		return;
@@ -1474,21 +1764,21 @@ static void __init aafs_remove_file(struct aa_fs_entry *fs_file)
 }
 
 /**
- * aafs_remove_dir - recursively drop a directory entry from the securityfs
- * @fs_dir: aa_fs_entry (and all child entries) to detach (NOT NULL)
+ * entry_remove_dir - recursively drop a directory entry from the securityfs
+ * @fs_dir: aa_sfs_entry (and all child entries) to detach (NOT NULL)
  */
-static void __init aafs_remove_dir(struct aa_fs_entry *fs_dir)
+static void __init entry_remove_dir(struct aa_sfs_entry *fs_dir)
 {
-	struct aa_fs_entry *fs_file;
+	struct aa_sfs_entry *fs_file;
 
 	for (fs_file = fs_dir->v.files; fs_file && fs_file->name; ++fs_file) {
-		if (fs_file->v_type == AA_FS_TYPE_DIR)
-			aafs_remove_dir(fs_file);
+		if (fs_file->v_type == AA_SFS_TYPE_DIR)
+			entry_remove_dir(fs_file);
 		else
-			aafs_remove_file(fs_file);
+			entry_remove_file(fs_file);
 	}
 
-	aafs_remove_file(fs_dir);
+	entry_remove_file(fs_dir);
 }
 
 /**
@@ -1498,7 +1788,7 @@ static void __init aafs_remove_dir(struct aa_fs_entry *fs_dir)
  */
 void __init aa_destroy_aafs(void)
 {
-	aafs_remove_dir(&aa_fs_entry);
+	entry_remove_dir(&aa_sfs_entry);
 }
 
 
@@ -1547,6 +1837,58 @@ static int aa_mk_null_file(struct dentry *parent)
 	return error;
 }
 
+
+
+static const char *policy_get_link(struct dentry *dentry,
+				   struct inode *inode,
+				   struct delayed_call *done)
+{
+	struct aa_ns *ns;
+	struct path path;
+
+	if (!dentry)
+		return ERR_PTR(-ECHILD);
+	ns = aa_get_current_ns();
+	path.mnt = mntget(aafs_mnt);
+	path.dentry = dget(ns_dir(ns));
+	nd_jump_link(&path);
+	aa_put_ns(ns);
+
+	return NULL;
+}
+
+static int ns_get_name(char *buf, size_t size, struct aa_ns *ns,
+		       struct inode *inode)
+{
+	int res = snprintf(buf, size, "%s:[%lu]", AAFS_NAME, inode->i_ino);
+	if (res < 0 || res >= size)
+		res = -ENOENT;
+
+	return res;
+}
+
+static int policy_readlink(struct dentry *dentry, char __user *buffer,
+			   int buflen)
+{
+	struct aa_ns *ns;
+	char name[32];
+	int res;
+
+	ns = aa_get_current_ns();
+	res = ns_get_name(name, sizeof(name), ns, d_inode(dentry));
+	if (res >= 0)
+		res = readlink_copy(buffer, buflen, name);
+	aa_put_ns(ns);
+
+	return res;
+}
+
+static const struct inode_operations policy_link_iops = {
+	.readlink	= policy_readlink,
+	.get_link	= policy_get_link,
+};
+
+
 /**
  * aa_create_aafs - create the apparmor security filesystem
  *
@@ -1562,17 +1904,23 @@ static int __init aa_create_aafs(void)
 	if (!apparmor_initialized)
 		return 0;
 
-	if (aa_fs_entry.dentry) {
+	if (aa_sfs_entry.dentry) {
 		AA_ERROR("%s: AppArmor securityfs already exists\n", __func__);
 		return -EEXIST;
 	}
 
+	/* setup apparmorfs used to virtualize policy/ */
+	aafs_mnt = kern_mount(&aafs_ops);
+	if (IS_ERR(aafs_mnt))
+		panic("can't set apparmorfs up\n");
+	aafs_mnt->mnt_sb->s_flags &= ~MS_NOUSER;
+
 	/* Populate fs tree. */
-	error = aafs_create_dir(&aa_fs_entry, NULL);
+	error = entry_create_dir(&aa_sfs_entry, NULL);
 	if (error)
 		goto error;
 
-	dent = securityfs_create_file(".load", 0666, aa_fs_entry.dentry,
+	dent = securityfs_create_file(".load", 0666, aa_sfs_entry.dentry,
 				      NULL, &aa_fs_profile_load);
 	if (IS_ERR(dent)) {
 		error = PTR_ERR(dent);
@@ -1580,7 +1928,7 @@ static int __init aa_create_aafs(void)
 	}
 	ns_subload(root_ns) = dent;
 
-	dent = securityfs_create_file(".replace", 0666, aa_fs_entry.dentry,
+	dent = securityfs_create_file(".replace", 0666, aa_sfs_entry.dentry,
 				      NULL, &aa_fs_profile_replace);
 	if (IS_ERR(dent)) {
 		error = PTR_ERR(dent);
@@ -1588,7 +1936,7 @@ static int __init aa_create_aafs(void)
 	}
 	ns_subreplace(root_ns) = dent;
 
-	dent = securityfs_create_file(".remove", 0666, aa_fs_entry.dentry,
+	dent = securityfs_create_file(".remove", 0666, aa_sfs_entry.dentry,
 				      NULL, &aa_fs_profile_remove);
 	if (IS_ERR(dent)) {
 		error = PTR_ERR(dent);
@@ -1597,13 +1945,22 @@ static int __init aa_create_aafs(void)
 	ns_subremove(root_ns) = dent;
 
 	mutex_lock(&root_ns->lock);
-	error = __aa_fs_ns_mkdir(root_ns, aa_fs_entry.dentry, "policy");
+	error = __aafs_ns_mkdir(root_ns, aafs_mnt->mnt_root, ".policy",
+				aafs_mnt->mnt_root);
 	mutex_unlock(&root_ns->lock);
 
 	if (error)
 		goto error;
 
-	error = aa_mk_null_file(aa_fs_entry.dentry);
+	/* magic symlink similar to nsfs redirects based on task policy */
+	dent = securityfs_create_symlink("policy", aa_sfs_entry.dentry,
+					 NULL, &policy_link_iops);
+	if (IS_ERR(dent)) {
+		error = PTR_ERR(dent);
+		goto error;
+	}
+
+	error = aa_mk_null_file(aa_sfs_entry.dentry);
 	if (error)
 		goto error;
 
diff --git a/security/apparmor/capability.c b/security/apparmor/capability.c
index ed0a3e6b8022..3bc19843d8df 100644
--- a/security/apparmor/capability.c
+++ b/security/apparmor/capability.c
@@ -28,8 +28,8 @@
  */
 #include "capability_names.h"
 
-struct aa_fs_entry aa_fs_entry_caps[] = {
-	AA_FS_FILE_STRING("mask", AA_FS_CAPS_MASK),
+struct aa_sfs_entry aa_sfs_entry_caps[] = {
+	AA_SFS_FILE_STRING("mask", AA_SFS_CAPS_MASK),
 	{ }
 };
 
diff --git a/security/apparmor/include/apparmorfs.h b/security/apparmor/include/apparmorfs.h
index 0b6d32b3f05e..071a59a1f056 100644
--- a/security/apparmor/include/apparmorfs.h
+++ b/security/apparmor/include/apparmorfs.h
@@ -17,49 +17,49 @@
 
 extern struct path aa_null;
 
-enum aa_fs_type {
-	AA_FS_TYPE_BOOLEAN,
-	AA_FS_TYPE_STRING,
-	AA_FS_TYPE_U64,
-	AA_FS_TYPE_FOPS,
-	AA_FS_TYPE_DIR,
+enum aa_sfs_type {
+	AA_SFS_TYPE_BOOLEAN,
+	AA_SFS_TYPE_STRING,
+	AA_SFS_TYPE_U64,
+	AA_SFS_TYPE_FOPS,
+	AA_SFS_TYPE_DIR,
 };
 
-struct aa_fs_entry;
+struct aa_sfs_entry;
 
-struct aa_fs_entry {
+struct aa_sfs_entry {
 	const char *name;
 	struct dentry *dentry;
 	umode_t mode;
-	enum aa_fs_type v_type;
+	enum aa_sfs_type v_type;
 	union {
 		bool boolean;
 		char *string;
 		unsigned long u64;
-		struct aa_fs_entry *files;
+		struct aa_sfs_entry *files;
 	} v;
 	const struct file_operations *file_ops;
 };
 
-extern const struct file_operations aa_fs_seq_file_ops;
+extern const struct file_operations aa_sfs_seq_file_ops;
 
-#define AA_FS_FILE_BOOLEAN(_name, _value) \
+#define AA_SFS_FILE_BOOLEAN(_name, _value) \
 	{ .name = (_name), .mode = 0444, \
-	  .v_type = AA_FS_TYPE_BOOLEAN, .v.boolean = (_value), \
-	  .file_ops = &aa_fs_seq_file_ops }
-#define AA_FS_FILE_STRING(_name, _value) \
+	  .v_type = AA_SFS_TYPE_BOOLEAN, .v.boolean = (_value), \
+	  .file_ops = &aa_sfs_seq_file_ops }
+#define AA_SFS_FILE_STRING(_name, _value) \
 	{ .name = (_name), .mode = 0444, \
-	  .v_type = AA_FS_TYPE_STRING, .v.string = (_value), \
-	  .file_ops = &aa_fs_seq_file_ops }
-#define AA_FS_FILE_U64(_name, _value) \
+	  .v_type = AA_SFS_TYPE_STRING, .v.string = (_value), \
+	  .file_ops = &aa_sfs_seq_file_ops }
+#define AA_SFS_FILE_U64(_name, _value) \
 	{ .name = (_name), .mode = 0444, \
-	  .v_type = AA_FS_TYPE_U64, .v.u64 = (_value), \
-	  .file_ops = &aa_fs_seq_file_ops }
-#define AA_FS_FILE_FOPS(_name, _mode, _fops) \
-	{ .name = (_name), .v_type = AA_FS_TYPE_FOPS, \
+	  .v_type = AA_SFS_TYPE_U64, .v.u64 = (_value), \
+	  .file_ops = &aa_sfs_seq_file_ops }
+#define AA_SFS_FILE_FOPS(_name, _mode, _fops) \
+	{ .name = (_name), .v_type = AA_SFS_TYPE_FOPS, \
 	  .mode = (_mode), .file_ops = (_fops) }
-#define AA_FS_DIR(_name, _value) \
-	{ .name = (_name), .v_type = AA_FS_TYPE_DIR, .v.files = (_value) }
+#define AA_SFS_DIR(_name, _value) \
+	{ .name = (_name), .v_type = AA_SFS_TYPE_DIR, .v.files = (_value) }
 
 extern void __init aa_destroy_aafs(void);
 
@@ -107,13 +107,13 @@ enum aafs_prof_type {
 #define prof_child_dir(X) ((X)->dents[AAFS_PROF_PROFS])
 
 void __aa_bump_ns_revision(struct aa_ns *ns);
-void __aa_fs_profile_rmdir(struct aa_profile *profile);
-void __aa_fs_profile_migrate_dents(struct aa_profile *old,
+void __aafs_profile_rmdir(struct aa_profile *profile);
+void __aafs_profile_migrate_dents(struct aa_profile *old,
 				   struct aa_profile *new);
-int __aa_fs_profile_mkdir(struct aa_profile *profile, struct dentry *parent);
-void __aa_fs_ns_rmdir(struct aa_ns *ns);
-int __aa_fs_ns_mkdir(struct aa_ns *ns, struct dentry *parent,
-		     const char *name);
+int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent);
+void __aafs_ns_rmdir(struct aa_ns *ns);
+int __aafs_ns_mkdir(struct aa_ns *ns, struct dentry *parent, const char *name,
+		     struct dentry *dent);
 
 struct aa_loaddata;
 void __aa_fs_remove_rawdata(struct aa_loaddata *rawdata);
diff --git a/security/apparmor/include/capability.h b/security/apparmor/include/capability.h
index fc3fa381d850..1218e95ebe49 100644
--- a/security/apparmor/include/capability.h
+++ b/security/apparmor/include/capability.h
@@ -36,7 +36,7 @@ struct aa_caps {
 	kernel_cap_t extended;
 };
 
-extern struct aa_fs_entry aa_fs_entry_caps[];
+extern struct aa_sfs_entry aa_sfs_entry_caps[];
 
 int aa_capable(struct aa_profile *profile, int cap, int audit);
 
diff --git a/security/apparmor/include/resource.h b/security/apparmor/include/resource.h
index d3f4cf027957..f6289f335c4d 100644
--- a/security/apparmor/include/resource.h
+++ b/security/apparmor/include/resource.h
@@ -34,7 +34,7 @@ struct aa_rlimit {
 	struct rlimit limits[RLIM_NLIMITS];
 };
 
-extern struct aa_fs_entry aa_fs_entry_rlimit[];
+extern struct aa_sfs_entry aa_sfs_entry_rlimit[];
 
 int aa_map_resource(int resource);
 int aa_task_setrlimit(struct aa_profile *profile, struct task_struct *,
diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 27e39dd278f6..301d688860a4 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -158,7 +158,7 @@ static void __remove_profile(struct aa_profile *profile)
 	__aa_profile_list_release(&profile->base.profiles);
 	/* released by free_profile */
 	__aa_update_proxy(profile, profile->ns->unconfined);
-	__aa_fs_profile_rmdir(profile);
+	__aafs_profile_rmdir(profile);
 	__list_remove_profile(profile);
 }
 
@@ -782,7 +782,7 @@ static void __replace_profile(struct aa_profile *old, struct aa_profile *new,
 		/* aafs interface uses proxy */
 		rcu_assign_pointer(new->proxy->profile,
 				   aa_get_profile(new));
-	__aa_fs_profile_migrate_dents(old, new);
+	__aafs_profile_migrate_dents(old, new);
 
 	if (list_empty(&new->base.list)) {
 		/* new is not on a list already */
@@ -966,7 +966,7 @@ ssize_t aa_replace_profiles(struct aa_ns *view, struct aa_profile *profile,
 				parent = prof_child_dir(p);
 			} else
 				parent = ns_subprofs_dir(ent->new->ns);
-			error = __aa_fs_profile_mkdir(ent->new, parent);
+			error = __aafs_profile_mkdir(ent->new, parent);
 		}
 
 		if (error) {
diff --git a/security/apparmor/policy_ns.c b/security/apparmor/policy_ns.c
index e08ad92471a6..f3418a9e59b1 100644
--- a/security/apparmor/policy_ns.c
+++ b/security/apparmor/policy_ns.c
@@ -197,7 +197,7 @@ static struct aa_ns *__aa_create_ns(struct aa_ns *parent, const char *name,
 	if (!ns)
 		return NULL;
 	mutex_lock(&ns->lock);
-	error = __aa_fs_ns_mkdir(ns, ns_subns_dir(parent), name);
+	error = __aafs_ns_mkdir(ns, ns_subns_dir(parent), name, dir);
 	if (error) {
 		AA_ERROR("Failed to create interface for ns %s\n",
 			 ns->base.name);
@@ -285,7 +285,7 @@ static void destroy_ns(struct aa_ns *ns)
 
 	if (ns->parent)
 		__aa_update_proxy(ns->unconfined, ns->parent->unconfined);
-	__aa_fs_ns_rmdir(ns);
+	__aafs_ns_rmdir(ns);
 	mutex_unlock(&ns->lock);
 }
 
diff --git a/security/apparmor/resource.c b/security/apparmor/resource.c
index 86a941afd956..ae66151fdc38 100644
--- a/security/apparmor/resource.c
+++ b/security/apparmor/resource.c
@@ -24,8 +24,8 @@
  */
 #include "rlim_names.h"
 
-struct aa_fs_entry aa_fs_entry_rlimit[] = {
-	AA_FS_FILE_STRING("mask", AA_FS_RLIMIT_MASK),
+struct aa_sfs_entry aa_sfs_entry_rlimit[] = {
+	AA_SFS_FILE_STRING("mask", AA_SFS_RLIMIT_MASK),
 	{ }
 };
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
