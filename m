From: zyan@redhat.com (Yan, Zheng)
Date: Tue, 26 Jun 2018 16:43:05 +0800
Subject: [PATCH 2/3] ceph: rename struct ceph_acls_info to ceph_acl_sec_ctx
In-Reply-To: <20180626084306.27511-1-zyan@redhat.com>
References: <20180626084306.27511-1-zyan@redhat.com>
Message-ID: <20180626084306.27511-2-zyan@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

this is preparation for security label support

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/acl.c   | 22 +++++++---------------
 fs/ceph/dir.c   | 28 ++++++++++++++--------------
 fs/ceph/file.c  | 18 +++++++++---------
 fs/ceph/super.h | 29 +++++++++++++++--------------
 fs/ceph/xattr.c | 10 ++++++++++
 5 files changed, 55 insertions(+), 52 deletions(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 3351ea14390b..f13ba4250f00 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -172,7 +172,7 @@ int ceph_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 }
 
 int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
-		       struct ceph_acls_info *info)
+		       struct ceph_acl_sec_ctx *as_ctx)
 {
 	struct posix_acl *acl, *default_acl;
 	size_t val_size1 = 0, val_size2 = 0;
@@ -248,9 +248,9 @@ int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
 
 	kfree(tmp_buf);
 
-	info->acl = acl;
-	info->default_acl = default_acl;
-	info->pagelist = pagelist;
+	as_ctx->acl = acl;
+	as_ctx->default_acl = default_acl;
+	as_ctx->pagelist = pagelist;
 	return 0;
 
 out_err:
@@ -262,18 +262,10 @@ int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
 	return err;
 }
 
-void ceph_init_inode_acls(struct inode* inode, struct ceph_acls_info *info)
+void ceph_init_inode_acls(struct inode* inode, struct ceph_acl_sec_ctx *as_ctx)
 {
 	if (!inode)
 		return;
-	ceph_set_cached_acl(inode, ACL_TYPE_ACCESS, info->acl);
-	ceph_set_cached_acl(inode, ACL_TYPE_DEFAULT, info->default_acl);
-}
-
-void ceph_release_acls_info(struct ceph_acls_info *info)
-{
-	posix_acl_release(info->acl);
-	posix_acl_release(info->default_acl);
-	if (info->pagelist)
-		ceph_pagelist_release(info->pagelist);
+	ceph_set_cached_acl(inode, ACL_TYPE_ACCESS, as_ctx->acl);
+	ceph_set_cached_acl(inode, ACL_TYPE_DEFAULT, as_ctx->default_acl);
 }
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 036ac0f3a393..f451ad5a37ab 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -821,7 +821,7 @@ static int ceph_mknod(struct inode *dir, struct dentry *dentry,
 	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
-	struct ceph_acls_info acls = {};
+	struct ceph_acl_sec_ctx as_ctx = {};
 	int err;
 
 	if (ceph_snap(dir) != CEPH_NOSNAP)
@@ -830,7 +830,7 @@ static int ceph_mknod(struct inode *dir, struct dentry *dentry,
 	if (ceph_quota_is_max_files_exceeded(dir))
 		return -EDQUOT;
 
-	err = ceph_pre_init_acls(dir, &mode, &acls);
+	err = ceph_pre_init_acls(dir, &mode, &as_ctx);
 	if (err < 0)
 		return err;
 
@@ -849,9 +849,9 @@ static int ceph_mknod(struct inode *dir, struct dentry *dentry,
 	req->r_args.mknod.rdev = cpu_to_le32(rdev);
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
-	if (acls.pagelist) {
-		req->r_pagelist = acls.pagelist;
-		acls.pagelist = NULL;
+	if (as_ctx.pagelist) {
+		req->r_pagelist = as_ctx.pagelist;
+		as_ctx.pagelist = NULL;
 	}
 	err = ceph_mdsc_do_request(mdsc, dir, req);
 	if (!err && !req->r_reply_info.head->is_dentry)
@@ -859,10 +859,10 @@ static int ceph_mknod(struct inode *dir, struct dentry *dentry,
 	ceph_mdsc_put_request(req);
 out:
 	if (!err)
-		ceph_init_inode_acls(d_inode(dentry), &acls);
+		ceph_init_inode_acls(d_inode(dentry), &as_ctx);
 	else
 		d_drop(dentry);
-	ceph_release_acls_info(&acls);
+	ceph_release_acl_sec_ctx(&as_ctx);
 	return err;
 }
 
@@ -919,7 +919,7 @@ static int ceph_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
-	struct ceph_acls_info acls = {};
+	struct ceph_acl_sec_ctx as_ctx = {};
 	int err = -EROFS;
 	int op;
 
@@ -942,7 +942,7 @@ static int ceph_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	}
 
 	mode |= S_IFDIR;
-	err = ceph_pre_init_acls(dir, &mode, &acls);
+	err = ceph_pre_init_acls(dir, &mode, &as_ctx);
 	if (err < 0)
 		goto out;
 
@@ -959,9 +959,9 @@ static int ceph_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	req->r_args.mkdir.mode = cpu_to_le32(mode);
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
-	if (acls.pagelist) {
-		req->r_pagelist = acls.pagelist;
-		acls.pagelist = NULL;
+	if (as_ctx.pagelist) {
+		req->r_pagelist = as_ctx.pagelist;
+		as_ctx.pagelist = NULL;
 	}
 	err = ceph_mdsc_do_request(mdsc, dir, req);
 	if (!err &&
@@ -971,10 +971,10 @@ static int ceph_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	ceph_mdsc_put_request(req);
 out:
 	if (!err)
-		ceph_init_inode_acls(d_inode(dentry), &acls);
+		ceph_init_inode_acls(d_inode(dentry), &as_ctx);
 	else
 		d_drop(dentry);
-	ceph_release_acls_info(&acls);
+	ceph_release_acl_sec_ctx(&as_ctx);
 	return err;
 }
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index ad0bed99b1d5..701506ec5768 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -436,7 +436,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	struct dentry *dn;
-	struct ceph_acls_info acls = {};
+	struct ceph_acl_sec_ctx as_ctx = {};
 	int mask;
 	int err;
 
@@ -450,7 +450,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	if (flags & O_CREAT) {
 		if (ceph_quota_is_max_files_exceeded(dir))
 			return -EDQUOT;
-		err = ceph_pre_init_acls(dir, &mode, &acls);
+		err = ceph_pre_init_acls(dir, &mode, &as_ctx);
 		if (err < 0)
 			return err;
 	}
@@ -459,16 +459,16 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	req = prepare_open_request(dir->i_sb, flags, mode);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
-		goto out_acl;
+		goto out_ctx;
 	}
 	req->r_dentry = dget(dentry);
 	req->r_num_caps = 2;
 	if (flags & O_CREAT) {
 		req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
 		req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
-		if (acls.pagelist) {
-			req->r_pagelist = acls.pagelist;
-			acls.pagelist = NULL;
+		if (as_ctx.pagelist) {
+			req->r_pagelist = as_ctx.pagelist;
+			as_ctx.pagelist = NULL;
 		}
 	}
 
@@ -506,7 +506,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	} else {
 		dout("atomic_open finish_open on dn %p\n", dn);
 		if (req->r_op == CEPH_MDS_OP_CREATE && req->r_reply_info.has_create_ino) {
-			ceph_init_inode_acls(d_inode(dentry), &acls);
+			ceph_init_inode_acls(d_inode(dentry), &as_ctx);
 			*opened |= FILE_CREATED;
 		}
 		err = finish_open(file, dentry, ceph_open, opened);
@@ -515,8 +515,8 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	if (!req->r_err && req->r_target_inode)
 		ceph_put_fmode(ceph_inode(req->r_target_inode), req->r_fmode);
 	ceph_mdsc_put_request(req);
-out_acl:
-	ceph_release_acls_info(&acls);
+out_ctx:
+	ceph_release_acl_sec_ctx(&as_ctx);
 	dout("atomic_open result=%d\n", err);
 	return err;
 }
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 5df5262b24b0..83561421afda 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -906,6 +906,14 @@ extern void __init ceph_xattr_init(void);
 extern void ceph_xattr_exit(void);
 extern const struct xattr_handler *ceph_xattr_handlers[];
 
+struct ceph_acl_sec_ctx {
+#ifdef CONFIG_CEPH_FS_POSIX_ACL
+	void *default_acl;
+	void *acl;
+#endif
+	struct ceph_pagelist *pagelist;
+};
+
 #ifdef CONFIG_SECURITY
 extern bool ceph_security_xattr_deadlock(struct inode *in);
 extern bool ceph_security_xattr_wanted(struct inode *in);
@@ -920,21 +928,17 @@ static inline bool ceph_security_xattr_wanted(struct inode *in)
 }
 #endif
 
-/* acl.c */
-struct ceph_acls_info {
-	void *default_acl;
-	void *acl;
-	struct ceph_pagelist *pagelist;
-};
+void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx);
 
+/* acl.c */
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
 
 struct posix_acl *ceph_get_acl(struct inode *, int);
 int ceph_set_acl(struct inode *inode, struct posix_acl *acl, int type);
 int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
-		       struct ceph_acls_info *info);
-void ceph_init_inode_acls(struct inode *inode, struct ceph_acls_info *info);
-void ceph_release_acls_info(struct ceph_acls_info *info);
+		       struct ceph_acl_sec_ctx *as_ctx);
+void ceph_init_inode_acls(struct inode *inode,
+			  struct ceph_acl_sec_ctx *as_ctx);
 
 static inline void ceph_forget_all_cached_acls(struct inode *inode)
 {
@@ -947,15 +951,12 @@ static inline void ceph_forget_all_cached_acls(struct inode *inode)
 #define ceph_set_acl NULL
 
 static inline int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
-				     struct ceph_acls_info *info)
+				     struct ceph_acl_sec_ctx *as_ctx)
 {
 	return 0;
 }
 static inline void ceph_init_inode_acls(struct inode *inode,
-					struct ceph_acls_info *info)
-{
-}
-static inline void ceph_release_acls_info(struct ceph_acls_info *info)
+					struct ceph_acl_sec_ctx *as_ctx)
 {
 }
 static inline int ceph_acl_chmod(struct dentry *dentry, struct inode *inode)
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 5bc8edb4c2a6..ef0e968d56a1 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1190,3 +1190,13 @@ bool ceph_security_xattr_deadlock(struct inode *in)
 	return ret;
 }
 #endif
+
+void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
+{
+#ifdef CONFIG_CEPH_FS_POSIX_ACL
+	posix_acl_release(as_ctx->acl);
+	posix_acl_release(as_ctx->default_acl);
+#endif
+	if (as_ctx->pagelist)
+		ceph_pagelist_release(as_ctx->pagelist);
+}
-- 
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
