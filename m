From: john.johansen@canonical.com (John Johansen)
Date: Thu, 25 May 2017 08:32:21 -0700
Subject: [PATCH 4/8] apparmor: use macro template to simplify namespace
	seq_files
In-Reply-To: <20170525153225.19070-1-john.johansen@canonical.com>
References: <20170525153225.19070-1-john.johansen@canonical.com>
Message-ID: <20170525153225.19070-5-john.johansen@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Signed-off-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Seth Arnold <seth.arnold@canonical.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 security/apparmor/apparmorfs.c | 53 +++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index c3cef2ed7ee2..efdc6e41c468 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -490,9 +490,27 @@ SEQ_PROFILE_FOPS(mode);
 SEQ_PROFILE_FOPS(attach);
 SEQ_PROFILE_FOPS(hash);
 
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
+static int seq_ns_level_show(struct seq_file *seq, void *v)
 {
 	struct aa_ns *ns = aa_current_profile()->ns;
 
@@ -501,20 +519,7 @@ static int aa_fs_seq_show_ns_level(struct seq_file *seq, void *v)
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
+static int seq_ns_name_show(struct seq_file *seq, void *v)
 {
 	struct aa_ns *ns = aa_current_profile()->ns;
 
@@ -523,18 +528,8 @@ static int aa_fs_seq_show_ns_name(struct seq_file *seq, void *v)
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
+SEQ_NS_FOPS(level);
+SEQ_NS_FOPS(name);
 
 
 /* policy/raw_data/ * file ops */
@@ -1363,8 +1358,8 @@ static struct aa_fs_entry aa_fs_entry_features[] = {
 
 static struct aa_fs_entry aa_fs_entry_apparmor[] = {
 	AA_FS_FILE_FOPS(".access", 0640, &aa_fs_access),
-	AA_FS_FILE_FOPS(".ns_level", 0666, &aa_fs_ns_level),
-	AA_FS_FILE_FOPS(".ns_name", 0640, &aa_fs_ns_name),
+	AA_FS_FILE_FOPS(".ns_level", 0666, &seq_ns_level_fops),
+	AA_FS_FILE_FOPS(".ns_name", 0640, &seq_ns_name_fops),
 	AA_FS_FILE_FOPS("profiles", 0440, &aa_fs_profiles_fops),
 	AA_FS_DIR("features", aa_fs_entry_features),
 	{ }
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
