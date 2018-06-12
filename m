From: peter.enderborg@sony.com (Peter Enderborg)
Date: Tue, 12 Jun 2018 10:09:06 +0200
Subject: [PATCH 07/13] selinux: Cleanup printk logging in selinuxfs
In-Reply-To: <20180612080912.7827-1-peter.enderborg@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
Message-ID: <20180612080912.7827-8-peter.enderborg@sony.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Replace printk with pr_* to avoid checkpatch warnings.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/selinuxfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c0cadbc5f85c..2adfade99945 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -620,7 +620,7 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 
 	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
-		printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
+		pr_err("SELinux: %s:  context size (%u) exceeds "
 			"payload max\n", __func__, len);
 		goto out;
 	}
@@ -956,7 +956,7 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 
 	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
-		printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
+		pr_err("SELinux: %s:  context size (%u) exceeds "
 			"payload max\n", __func__, len);
 		goto out;
 	}
@@ -1147,7 +1147,7 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 
 	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
-		printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
+		pr_err("SELinux: %s:  context size (%u) exceeds "
 			"payload max\n", __func__, len);
 		goto out;
 	}
@@ -1996,7 +1996,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 		goto err;
 	return 0;
 err:
-	printk(KERN_ERR "SELinux: %s:  failed while creating inodes\n",
+	pr_err("SELinux: %s:  failed while creating inodes\n",
 		__func__);
 
 	selinux_fs_info_free(sb);
@@ -2046,7 +2046,7 @@ static int __init init_sel_fs(void)
 
 	selinux_null.mnt = selinuxfs_mount = kern_mount(&sel_fs_type);
 	if (IS_ERR(selinuxfs_mount)) {
-		printk(KERN_ERR "selinuxfs:  could not mount!\n");
+		pr_err("selinuxfs:  could not mount!\n");
 		err = PTR_ERR(selinuxfs_mount);
 		selinuxfs_mount = NULL;
 	}
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
