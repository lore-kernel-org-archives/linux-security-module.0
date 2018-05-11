From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 10 May 2018 17:53:28 -0700
Subject: [PATCH 08/23] SELinux: Abstract use of inode security blob
In-Reply-To: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
Message-ID: <22bc0287-52b9-61c2-ab8d-f69f688d68fb@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Casey Schaufler <casey@schaufler-ca.com>
Date: Thu, 10 May 2018 14:16:55 -0700
Subject: [PATCH 08/23] SELinux: Abstract use of inode security blob

Don't use the inode->i_security pointer directly.
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/selinux/hooks.c          | 26 +++++++++++++-------------
 security/selinux/include/objsec.h |  5 +++++
 security/selinux/selinuxfs.c      |  4 ++--
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 334f47305551..baefd36b44df 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -277,7 +277,7 @@ static int __inode_security_revalidate(struct inode *inode,
 				       struct dentry *opt_dentry,
 				       bool may_sleep)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 
 	might_sleep_if(may_sleep);
 
@@ -298,7 +298,7 @@ static int __inode_security_revalidate(struct inode *inode,
 
 static struct inode_security_struct *inode_security_novalidate(struct inode *inode)
 {
-	return inode->i_security;
+	return selinux_inode(inode);
 }
 
 static struct inode_security_struct *inode_security_rcu(struct inode *inode, bool rcu)
@@ -308,7 +308,7 @@ static struct inode_security_struct *inode_security_rcu(struct inode *inode, boo
 	error = __inode_security_revalidate(inode, NULL, !rcu);
 	if (error)
 		return ERR_PTR(error);
-	return inode->i_security;
+	return selinux_inode(inode);
 }
 
 /*
@@ -317,14 +317,14 @@ static struct inode_security_struct *inode_security_rcu(struct inode *inode, boo
 static struct inode_security_struct *inode_security(struct inode *inode)
 {
 	__inode_security_revalidate(inode, NULL, true);
-	return inode->i_security;
+	return selinux_inode(inode);
 }
 
 static struct inode_security_struct *backing_inode_security_novalidate(struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
 
-	return inode->i_security;
+	return selinux_inode(inode);
 }
 
 /*
@@ -335,7 +335,7 @@ static struct inode_security_struct *backing_inode_security(struct dentry *dentr
 	struct inode *inode = d_backing_inode(dentry);
 
 	__inode_security_revalidate(inode, dentry, true);
-	return inode->i_security;
+	return selinux_inode(inode);
 }
 
 static void inode_free_rcu(struct rcu_head *head)
@@ -348,7 +348,7 @@ static void inode_free_rcu(struct rcu_head *head)
 
 static void inode_free_security(struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
 
 	/*
@@ -1501,7 +1501,7 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry)
 {
 	struct superblock_security_struct *sbsec = NULL;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 	u32 task_sid, sid = 0;
 	u16 sclass;
 	struct dentry *dentry;
@@ -1790,7 +1790,7 @@ static int inode_has_perm(const struct cred *cred,
 		return 0;
 
 	sid = cred_sid(cred);
-	isec = inode->i_security;
+	isec = selinux_inode(inode);
 
 	return avc_has_perm(&selinux_state,
 			    sid, isec->sid, isec->sclass, perms, adp);
@@ -3018,7 +3018,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 
 	/* Possibly defer initialization to selinux_complete_init. */
 	if (sbsec->flags & SE_SBINITIALIZED) {
-		struct inode_security_struct *isec = inode->i_security;
+		struct inode_security_struct *isec = selinux_inode(inode);
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 		isec->sid = newsid;
 		isec->initialized = LABEL_INITIALIZED;
@@ -3118,7 +3118,7 @@ static noinline int audit_inode_permission(struct inode *inode,
 					   unsigned flags)
 {
 	struct common_audit_data ad;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 	int rc;
 
 	ad.type = LSM_AUDIT_DATA_INODE;
@@ -4124,7 +4124,7 @@ static int selinux_task_kill(struct task_struct *p, struct siginfo *info,
 static void selinux_task_to_inode(struct task_struct *p,
 				  struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 	u32 sid = task_sid(p);
 
 	spin_lock(&isec->lock);
@@ -6483,7 +6483,7 @@ static void selinux_release_secctx(char *secdata, u32 seclen)
 
 static void selinux_inode_invalidate_secctx(struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = selinux_inode(inode);
 
 	spin_lock(&isec->lock);
 	isec->initialized = LABEL_INVALID;
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 2586fbc7e38c..168a96104fa0 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -172,4 +172,9 @@ static inline struct file_security_struct *selinux_file(const struct file *file)
 	return file->f_security;
 }
 
+static inline struct inode_security_struct *selinux_inode(const struct inode *inode)
+{
+	return inode->i_security;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index a1a389c09857..cbb270c9a3c1 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1380,7 +1380,7 @@ static int sel_make_bools(struct selinux_fs_info *fsi)
 		if (len >= PAGE_SIZE)
 			goto out;
 
-		isec = (struct inode_security_struct *)inode->i_security;
+		isec = selinux_inode(inode);
 		ret = security_genfs_sid(fsi->state, "selinuxfs", page,
 					 SECCLASS_FILE, &sid);
 		if (ret) {
@@ -1943,7 +1943,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 		goto err;
 
 	inode->i_ino = ++fsi->last_ino;
-	isec = (struct inode_security_struct *)inode->i_security;
+	isec = selinux_inode(inode);
 	isec->sid = SECINITSID_DEVNULL;
 	isec->sclass = SECCLASS_CHR_FILE;
 	isec->initialized = LABEL_INITIALIZED;
-- 
2.14.3


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
