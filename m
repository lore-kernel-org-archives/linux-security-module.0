From: keescook@chromium.org (Kees Cook)
Date: Wed, 29 Mar 2017 16:52:58 -0700
Subject: [RESEND][PATCH] TOMOYO: Use designated initializers
Message-ID: <20170329235258.GA43176@beast>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Prepare to mark sensitive kernel structures for randomization by making
sure they're using designated initializers. These were identified during
allyesconfig builds of x86, arm, and arm64, with most initializer fixes
extracted from grsecurity.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/tomoyo/file.c   | 12 ++++++------
 security/tomoyo/tomoyo.c | 20 ++++++++++----------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/security/tomoyo/file.c b/security/tomoyo/file.c
index 7041a580019e..223f21ffa632 100644
--- a/security/tomoyo/file.c
+++ b/security/tomoyo/file.c
@@ -692,7 +692,7 @@ int tomoyo_path_number_perm(const u8 type, const struct path *path,
 {
 	struct tomoyo_request_info r;
 	struct tomoyo_obj_info obj = {
-		.path1 = *path,
+		.path1 = { .mnt = path->mnt, .dentry = path->dentry },
 	};
 	int error = -ENOMEM;
 	struct tomoyo_path_info buf;
@@ -740,7 +740,7 @@ int tomoyo_check_open_permission(struct tomoyo_domain_info *domain,
 	struct tomoyo_path_info buf;
 	struct tomoyo_request_info r;
 	struct tomoyo_obj_info obj = {
-		.path1 = *path,
+		.path1 = { .mnt = path->mnt, .dentry = path->dentry },
 	};
 	int idx;
 
@@ -786,7 +786,7 @@ int tomoyo_path_perm(const u8 operation, const struct path *path, const char *ta
 {
 	struct tomoyo_request_info r;
 	struct tomoyo_obj_info obj = {
-		.path1 = *path,
+		.path1 = { .mnt = path->mnt, .dentry = path->dentry },
 	};
 	int error;
 	struct tomoyo_path_info buf;
@@ -843,7 +843,7 @@ int tomoyo_mkdev_perm(const u8 operation, const struct path *path,
 {
 	struct tomoyo_request_info r;
 	struct tomoyo_obj_info obj = {
-		.path1 = *path,
+		.path1 = { .mnt = path->mnt, .dentry = path->dentry },
 	};
 	int error = -ENOMEM;
 	struct tomoyo_path_info buf;
@@ -890,8 +890,8 @@ int tomoyo_path2_perm(const u8 operation, const struct path *path1,
 	struct tomoyo_path_info buf2;
 	struct tomoyo_request_info r;
 	struct tomoyo_obj_info obj = {
-		.path1 = *path1,
-		.path2 = *path2,
+		.path1 = { .mnt = path1->mnt, .dentry = path1->dentry },
+		.path2 = { .mnt = path2->mnt, .dentry = path2->dentry }
 	};
 	int idx;
 
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index b5fb930349a9..130b4fa4f65f 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -165,7 +165,7 @@ static int tomoyo_path_truncate(const struct path *path)
  */
 static int tomoyo_path_unlink(const struct path *parent, struct dentry *dentry)
 {
-	struct path path = { parent->mnt, dentry };
+	struct path path = { .mnt = parent->mnt, .dentry = dentry };
 	return tomoyo_path_perm(TOMOYO_TYPE_UNLINK, &path, NULL);
 }
 
@@ -181,7 +181,7 @@ static int tomoyo_path_unlink(const struct path *parent, struct dentry *dentry)
 static int tomoyo_path_mkdir(const struct path *parent, struct dentry *dentry,
 			     umode_t mode)
 {
-	struct path path = { parent->mnt, dentry };
+	struct path path = { .mnt = parent->mnt, .dentry = dentry };
 	return tomoyo_path_number_perm(TOMOYO_TYPE_MKDIR, &path,
 				       mode & S_IALLUGO);
 }
@@ -196,7 +196,7 @@ static int tomoyo_path_mkdir(const struct path *parent, struct dentry *dentry,
  */
 static int tomoyo_path_rmdir(const struct path *parent, struct dentry *dentry)
 {
-	struct path path = { parent->mnt, dentry };
+	struct path path = { .mnt = parent->mnt, .dentry = dentry };
 	return tomoyo_path_perm(TOMOYO_TYPE_RMDIR, &path, NULL);
 }
 
@@ -212,7 +212,7 @@ static int tomoyo_path_rmdir(const struct path *parent, struct dentry *dentry)
 static int tomoyo_path_symlink(const struct path *parent, struct dentry *dentry,
 			       const char *old_name)
 {
-	struct path path = { parent->mnt, dentry };
+	struct path path = { .mnt = parent->mnt, .dentry = dentry };
 	return tomoyo_path_perm(TOMOYO_TYPE_SYMLINK, &path, old_name);
 }
 
@@ -229,7 +229,7 @@ static int tomoyo_path_symlink(const struct path *parent, struct dentry *dentry,
 static int tomoyo_path_mknod(const struct path *parent, struct dentry *dentry,
 			     umode_t mode, unsigned int dev)
 {
-	struct path path = { parent->mnt, dentry };
+	struct path path = { .mnt = parent->mnt, .dentry = dentry };
 	int type = TOMOYO_TYPE_CREATE;
 	const unsigned int perm = mode & S_IALLUGO;
 
@@ -268,8 +268,8 @@ static int tomoyo_path_mknod(const struct path *parent, struct dentry *dentry,
 static int tomoyo_path_link(struct dentry *old_dentry, const struct path *new_dir,
 			    struct dentry *new_dentry)
 {
-	struct path path1 = { new_dir->mnt, old_dentry };
-	struct path path2 = { new_dir->mnt, new_dentry };
+	struct path path1 = { .mnt = new_dir->mnt, .dentry = old_dentry };
+	struct path path2 = { .mnt = new_dir->mnt, .dentry = new_dentry };
 	return tomoyo_path2_perm(TOMOYO_TYPE_LINK, &path1, &path2);
 }
 
@@ -288,8 +288,8 @@ static int tomoyo_path_rename(const struct path *old_parent,
 			      const struct path *new_parent,
 			      struct dentry *new_dentry)
 {
-	struct path path1 = { old_parent->mnt, old_dentry };
-	struct path path2 = { new_parent->mnt, new_dentry };
+	struct path path1 = { .mnt = old_parent->mnt, .dentry = old_dentry };
+	struct path path2 = { .mnt = new_parent->mnt, .dentry = new_dentry };
 	return tomoyo_path2_perm(TOMOYO_TYPE_RENAME, &path1, &path2);
 }
 
@@ -417,7 +417,7 @@ static int tomoyo_sb_mount(const char *dev_name, const struct path *path,
  */
 static int tomoyo_sb_umount(struct vfsmount *mnt, int flags)
 {
-	struct path path = { mnt, mnt->mnt_root };
+	struct path path = { .mnt = mnt, .dentry = mnt->mnt_root };
 	return tomoyo_path_perm(TOMOYO_TYPE_UMOUNT, &path, NULL);
 }
 
-- 
2.7.4


-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
