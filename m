From: guilherme.magalhaes@hpe.com (Guilherme Magalhaes)
Date: Thu, 11 May 2017 11:00:01 -0300
Subject: [RFC 09/11] ima: delete namespace policy securityfs file in
	write-once mode
In-Reply-To: <1494511203-8397-1-git-send-email-guilherme.magalhaes@hpe.com>
References: <1494511203-8397-1-git-send-email-guilherme.magalhaes@hpe.com>
Message-ID: <1494511203-8397-10-git-send-email-guilherme.magalhaes@hpe.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

When policy file is written and write-once is enabled, the policy file
must be deleted. Select the namespace policy structure to get the correct
policy file descriptor.

Signed-off-by: Guilherme Magalhaes <guilherme.magalhaes@hpe.com>
---
 security/integrity/ima/ima_fs.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 65c43e7..94e89fe 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -575,6 +575,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
 static int ima_release_policy(struct inode *inode, struct file *file)
 {
 	const char *cause = valid_policy ? "completed" : "failed";
+	struct ima_ns_policy *ins;
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 		return seq_release(inode, file);
@@ -595,15 +596,37 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 		return 0;
 	}
 
+	/* get the namespace id from file->inode (policy file inode).
+	 * We also need to synchronize this operation with concurrent namespace
+	 * releasing. */
+	ima_namespace_lock();
+	ins = ima_get_namespace_policy_from_inode(inode);
+	if (!ins) {
+		/* the namespace is not valid anymore, discard new policy
+		 * rules and exit */
+		ima_delete_rules();
+		valid_policy = 1;
+		clear_bit(IMA_FS_BUSY, &ima_fs_flags);
+		ima_namespace_unlock();
+		return 0;
+	}
+
 	ima_update_policy();
 #ifndef	CONFIG_IMA_WRITE_POLICY
-	securityfs_remove(ima_policy_initial_ns);
-	ima_policy = NULL;
+	if (ins == &ima_initial_namespace_policy) {
+		securityfs_remove(ima_policy_initial_ns);
+		ima_policy_initial_ns = NULL;
+	} else {
+		securityfs_remove(ins->policy_dentry);
+		ins->policy_dentry = NULL;
+	}
 #endif
 
 	/* always clear the busy flag so other namespaces can use it */
 	clear_bit(IMA_FS_BUSY, &ima_fs_flags);
 
+	ima_namespace_unlock();
+
 	return 0;
 }
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
