From: jlayton@kernel.org (Jeff Layton)
Date: Thu,  6 Jul 2017 12:23:20 -0400
Subject: [PATCH] integrity: track ctime in addition to i_version for assessment
Message-ID: <20170706162320.13174-1-jlayton@kernel.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

The IMA assessment code tries to use the i_version counter to detect
when changes to a file have occurred. Many filesystems don't increment
it properly (or at all) so detecting changes with that is not always
reliable.

That check should really be gated on IS_I_VERSION. When that returns
false, you can't rely on the i_version field changing like you expect.

Have the code also track and check the ctime for the file. If the
IS_I_VERSION returns false, then use it to detect whether the file
might have changed.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 security/integrity/ima/ima_api.c  |  4 +++-
 security/integrity/ima/ima_main.c | 32 ++++++++++++++++++++++++--------
 security/integrity/integrity.h    |  1 +
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c2edba8de35e..2a01e8f3c613 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -205,7 +205,8 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	} hash;
 
 	if (!(iint->flags & IMA_COLLECTED)) {
-		u64 i_version = file_inode(file)->i_version;
+		u64 i_version = inode->i_version;
+		struct timespec i_ctime = inode->i_ctime;
 
 		if (file->f_flags & O_DIRECT) {
 			audit_cause = "failed(directio)";
@@ -225,6 +226,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 				iint->ima_hash = tmpbuf;
 				memcpy(iint->ima_hash, &hash, length);
 				iint->version = i_version;
+				iint->ctime = i_ctime;
 				iint->flags |= IMA_COLLECTED;
 			} else
 				result = -ENOMEM;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2aebb7984437..3508b13e7181 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -113,6 +113,25 @@ static void ima_rdwr_violation_check(struct file *file,
 				  "invalid_pcr", "open_writers");
 }
 
+static bool ima_should_update_iint(struct integrity_iint_cache *iint,
+				struct inode *inode)
+{
+	if (atomic_read(&inode->i_writecount) != 1)
+		return false;
+	if (iint->flags & IMA_NEW_FILE)
+		return true;
+	if (IS_I_VERSION(inode)) {
+		if (iint->version != inode->i_version)
+			return true;
+	} else {
+		if (iint->ctime.tv_sec != inode->i_ctime.tv_sec)
+			return true;
+		if (iint->ctime.tv_nsec != inode->i_ctime.tv_nsec)
+			return true;
+	}
+	return false;
+}
+
 static void ima_check_last_writer(struct integrity_iint_cache *iint,
 				  struct inode *inode, struct file *file)
 {
@@ -122,14 +141,11 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
 		return;
 
 	inode_lock(inode);
-	if (atomic_read(&inode->i_writecount) == 1) {
-		if ((iint->version != inode->i_version) ||
-		    (iint->flags & IMA_NEW_FILE)) {
-			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
-			iint->measured_pcrs = 0;
-			if (iint->flags & IMA_APPRAISE)
-				ima_update_xattr(iint, file);
-		}
+	if (ima_should_update_iint(iint, inode)) {
+		iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
+		iint->measured_pcrs = 0;
+		if (iint->flags & IMA_APPRAISE)
+			ima_update_xattr(iint, file);
 	}
 	inode_unlock(inode);
 }
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index a53e7e4ab06c..10c3f96beb98 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -102,6 +102,7 @@ struct integrity_iint_cache {
 	struct rb_node rb_node;	/* rooted in integrity_iint_tree */
 	struct inode *inode;	/* back pointer to inode in question */
 	u64 version;		/* track inode changes */
+	struct timespec ctime;	/* track inode changes */
 	unsigned long flags;
 	unsigned long measured_pcrs;
 	enum integrity_status ima_file_status:4;
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
