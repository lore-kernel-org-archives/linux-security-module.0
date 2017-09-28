From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 28 Sep 2017 14:54:50 -0700
Subject: [PATCH] Smack: Base support for overlayfs
Message-ID: <408f9331-c780-9a35-f2fe-b803a38aa84f@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Subject: Smack: Base support for overlayfs

Supply the Smack module hooks in support of overlayfs.
Ensure that the Smack label of new files gets the correct
value when a directory is transmuting. Original implementation
by Romanini Daniele, with a few tweaks added.

Signed-off-by: Romanini Daniele <daniele.romanini@aalto.fi>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 319add3..569f280 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4605,6 +4605,82 @@ static int smack_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 	return 0;
 }
 
+static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
+{
+
+	struct task_smack *tsp;
+	struct smack_known *skp;
+	struct inode_smack *isp;
+	struct cred *new_creds = *new;
+
+	if (new_creds == NULL) {
+		new_creds = prepare_creds();
+		if (new_creds == NULL)
+			return -ENOMEM;
+	}
+
+	tsp = new_creds->security;
+
+	/*
+	 * Get label from overlay inode and set it in create_sid
+	 */
+	isp = d_inode(dentry->d_parent)->i_security;
+	skp = isp->smk_inode;
+	tsp->smk_task = skp;
+	*new = new_creds;
+	return 0;
+}
+
+static int smack_inode_copy_up_xattr(const char *name)
+{
+	/*
+	 * Return 1 if this is the smack access Smack attribute.
+	 */
+	if (strcmp(name, XATTR_NAME_SMACK) == 0)
+		return 1;
+
+	return -EOPNOTSUPP;
+}
+
+static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
+					struct qstr *name,
+					const struct cred *old,
+					struct cred *new)
+{
+	struct task_smack *otsp = old->security;
+	struct task_smack *ntsp = new->security;
+	struct inode_smack *isp;
+	int may;
+
+	/*
+	 * Use the process credential unless all of
+	 * the transmuting criteria are met
+	 */
+	ntsp->smk_task = otsp->smk_task;
+
+	/*
+	 * the attribute of the containing directory
+	 */
+	isp = d_inode(dentry->d_parent)->i_security;
+
+	if (isp->smk_flags & SMK_INODE_TRANSMUTE) {
+		rcu_read_lock();
+		may = smk_access_entry(otsp->smk_task->smk_known,
+				       isp->smk_inode->smk_known,
+				       &otsp->smk_task->smk_rules);
+		rcu_read_unlock();
+
+		/*
+		 * If the directory is transmuting and the rule
+		 * providing access is transmuting use the containing
+		 * directory label instead of the process label.
+		 */
+		if (may > 0 && (may & MAY_TRANSMUTE))
+			ntsp->smk_task = isp->smk_inode;
+	}
+	return 0;
+}
+
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
@@ -4740,6 +4816,9 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_notifysecctx, smack_inode_notifysecctx),
 	LSM_HOOK_INIT(inode_setsecctx, smack_inode_setsecctx),
 	LSM_HOOK_INIT(inode_getsecctx, smack_inode_getsecctx),
+	LSM_HOOK_INIT(inode_copy_up, smack_inode_copy_up),
+	LSM_HOOK_INIT(inode_copy_up_xattr, smack_inode_copy_up_xattr),
+	LSM_HOOK_INIT(dentry_create_files_as, smack_dentry_create_files_as),
 };
 
 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
