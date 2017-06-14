From: dhowells@redhat.com (David Howells)
Date: Wed, 14 Jun 2017 16:15:33 +0100
Subject: [PATCH 02/27] VFS: Clean up whitespace in fs/namespace.c and
	fs/super.c [ver #5]
In-Reply-To: <149745330648.10897.9605870130502083184.stgit@warthog.procyon.org.uk>
References: <149745330648.10897.9605870130502083184.stgit@warthog.procyon.org.uk>
Message-ID: <149745333325.10897.1765435470488494106.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Clean up line terminal whitespace in fs/namespace.c and fs/super.c.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/namespace.c |    4 ++--
 fs/super.c     |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 8bd3e4d448b9..c076787871e7 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1656,7 +1656,7 @@ void __detach_mounts(struct dentry *dentry)
 	namespace_unlock();
 }
 
-/* 
+/*
  * Is the caller allowed to modify his namespace?
  */
 static inline bool may_mount(void)
@@ -2210,7 +2210,7 @@ static int do_loopback(struct path *path, const char *old_name,
 
 	err = -EINVAL;
 	if (mnt_ns_loop(old_path.dentry))
-		goto out; 
+		goto out;
 
 	mp = lock_mount(path);
 	err = PTR_ERR(mp);
diff --git a/fs/super.c b/fs/super.c
index adb0c0de428c..dfb56a9665d8 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -508,7 +508,7 @@ struct super_block *sget_userns(struct file_system_type *type,
 			return ERR_PTR(-ENOMEM);
 		goto retry;
 	}
-		
+
 	err = set(s, data);
 	if (err) {
 		spin_unlock(&sb_lock);
@@ -771,7 +771,7 @@ struct super_block *get_active_super(struct block_device *bdev)
 	spin_unlock(&sb_lock);
 	return NULL;
 }
- 
+
 struct super_block *user_get_super(dev_t dev)
 {
 	struct super_block *sb;

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
