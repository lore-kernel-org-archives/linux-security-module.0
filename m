From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 28 Sep 2017 08:39:33 -0400
Subject: [RFC PATCH 3/3] fs: detect that the i_rwsem has already been taken
	exclusively
In-Reply-To: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1506602373-4799-4-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Don't attempt to take the i_rwsem, if it has already been taken
exclusively.

Signed-off-by:  Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 fs/ext2/file.c    |  6 ++++--
 fs/ext4/file.c    |  8 +++++---
 fs/xfs/xfs_file.c | 10 ++++++----
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 839095f66d8d..d174b2880929 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -38,9 +38,11 @@ static ssize_t ext2_dax_read_iter(struct kiocb *iocb, struct iov_iter *to,
 	if (!iov_iter_count(to))
 		return 0; /* skip atime */
 
-	inode_lock_shared(inode);
+	if (!rwf)
+		inode_lock_shared(inode);
 	ret = dax_iomap_rw(iocb, to, &ext2_iomap_ops);
-	inode_unlock_shared(inode);
+	if (!rwf)
+		inode_unlock_shared(inode);
 
 	file_accessed(iocb->ki_filp);
 	return ret;
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 10789666725e..7d7c0e380add 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -38,7 +38,7 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to,
 	struct inode *inode = file_inode(iocb->ki_filp);
 	ssize_t ret;
 
-	if (!inode_trylock_shared(inode)) {
+	if (!rwf && !inode_trylock_shared(inode)) {
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			return -EAGAIN;
 		inode_lock_shared(inode);
@@ -48,12 +48,14 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to,
 	 * change anymore
 	 */
 	if (!IS_DAX(inode)) {
-		inode_unlock_shared(inode);
+		if (!rwf)
+			inode_unlock_shared(inode);
 		/* Fallback to buffered IO in case we cannot support DAX */
 		return generic_file_read_iter(iocb, to, rwf);
 	}
 	ret = dax_iomap_rw(iocb, to, &ext4_iomap_ops);
-	inode_unlock_shared(inode);
+	if (!rwf)
+		inode_unlock_shared(inode);
 
 	file_accessed(iocb->ki_filp);
 	return ret;
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index cf1ce8961601..0cffca97ed68 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -239,7 +239,7 @@ xfs_file_dax_read(
 	if (!count)
 		return 0; /* skip atime */
 
-	if (!xfs_ilock_nowait(ip, XFS_IOLOCK_SHARED)) {
+	if (!rwf && !xfs_ilock_nowait(ip, XFS_IOLOCK_SHARED)) {
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			return -EAGAIN;
 		xfs_ilock(ip, XFS_IOLOCK_SHARED);
@@ -247,7 +247,8 @@ xfs_file_dax_read(
 	ret = dax_iomap_rw(iocb, to, &xfs_iomap_ops);
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
-	file_accessed(iocb->ki_filp);
+	if (!rwf)
+		file_accessed(iocb->ki_filp);
 	return ret;
 }
 
@@ -262,13 +263,14 @@ xfs_file_buffered_aio_read(
 
 	trace_xfs_file_buffered_read(ip, iov_iter_count(to), iocb->ki_pos);
 
-	if (!xfs_ilock_nowait(ip, XFS_IOLOCK_SHARED)) {
+	if (!rwf && !xfs_ilock_nowait(ip, XFS_IOLOCK_SHARED)) {
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			return -EAGAIN;
 		xfs_ilock(ip, XFS_IOLOCK_SHARED);
 	}
 	ret = generic_file_read_iter(iocb, to, rwf);
-	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
+	if (!rwf)
+		xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
 	return ret;
 }
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
