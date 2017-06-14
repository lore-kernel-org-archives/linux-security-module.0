From: dhowells@redhat.com (David Howells)
Date: Wed, 14 Jun 2017 16:15:50 +0100
Subject: [PATCH 04/27] VFS: Make get_filesystem() return the affected
	filesystem [ver #5]
In-Reply-To: <149745330648.10897.9605870130502083184.stgit@warthog.procyon.org.uk>
References: <149745330648.10897.9605870130502083184.stgit@warthog.procyon.org.uk>
Message-ID: <149745335084.10897.6510651041826452700.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Make get_filesystem() return a pointer to the filesystem on which it just
got a ref.

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/filesystems.c   |    3 ++-
 include/linux/fs.h |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/filesystems.c b/fs/filesystems.c
index cac75547d35c..591e52d23ed4 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -33,9 +33,10 @@ static struct file_system_type *file_systems;
 static DEFINE_RWLOCK(file_systems_lock);
 
 /* WARNING: This can be used only if we _already_ own a reference */
-void get_filesystem(struct file_system_type *fs)
+struct file_system_type *get_filesystem(struct file_system_type *fs)
 {
 	__module_get(fs->owner);
+	return fs;
 }
 
 void put_filesystem(struct file_system_type *fs)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 803e5a9b2654..bc0c054894b9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2956,7 +2956,7 @@ extern int generic_block_fiemap(struct inode *inode,
 				struct fiemap_extent_info *fieinfo, u64 start,
 				u64 len, get_block_t *get_block);
 
-extern void get_filesystem(struct file_system_type *fs);
+extern struct file_system_type *get_filesystem(struct file_system_type *fs);
 extern void put_filesystem(struct file_system_type *fs);
 extern struct file_system_type *get_fs_type(const char *name);
 extern struct super_block *get_super(struct block_device *);

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
