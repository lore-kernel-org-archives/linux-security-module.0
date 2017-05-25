From: john.johansen@canonical.com (John Johansen)
Date: Thu, 25 May 2017 08:32:20 -0700
Subject: [PATCH 3/8] apparmor: use macro template to simplify profile seq_files
In-Reply-To: <20170525153225.19070-1-john.johansen@canonical.com>
References: <20170525153225.19070-1-john.johansen@canonical.com>
Message-ID: <20170525153225.19070-4-john.johansen@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Signed-off-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Seth Arnold <seth.arnold@canonical.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 security/apparmor/apparmorfs.c | 97 ++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 61 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index a59fbcf3991a..c3cef2ed7ee2 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -393,8 +393,27 @@ const struct file_operations aa_fs_seq_file_ops = {
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
@@ -407,7 +426,7 @@ static int aa_fs_seq_profile_open(struct inode *inode, struct file *file,
 	return error;
 }
 
-static int aa_fs_seq_profile_release(struct inode *inode, struct file *file)
+static int seq_profile_release(struct inode *inode, struct file *file)
 {
 	struct seq_file *seq = (struct seq_file *) file->private_data;
 	if (seq)
@@ -415,7 +434,7 @@ static int aa_fs_seq_profile_release(struct inode *inode, struct file *file)
 	return single_release(inode, file);
 }
 
-static int aa_fs_seq_profname_show(struct seq_file *seq, void *v)
+static int seq_profile_name_show(struct seq_file *seq, void *v)
 {
 	struct aa_proxy *proxy = seq->private;
 	struct aa_profile *profile = aa_get_profile_rcu(&proxy->profile);
@@ -425,20 +444,7 @@ static int aa_fs_seq_profname_show(struct seq_file *seq, void *v)
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
@@ -448,20 +454,7 @@ static int aa_fs_seq_profmode_show(struct seq_file *seq, void *v)
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
@@ -476,20 +469,7 @@ static int aa_fs_seq_profattach_show(struct seq_file *seq, void *v)
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
@@ -505,18 +485,11 @@ static int aa_fs_seq_hash_show(struct seq_file *seq, void *v)
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
 
 
 static int aa_fs_seq_show_ns_level(struct seq_file *seq, void *v)
@@ -890,25 +863,27 @@ int __aa_fs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
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
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
