From: dhowells@redhat.com (David Howells)
Date: Wed, 14 Jun 2017 16:15:42 +0100
Subject: [PATCH 03/27] VFS: Make get_mnt_ns() return the namespace [ver #5]
In-Reply-To: <149745330648.10897.9605870130502083184.stgit@warthog.procyon.org.uk>
References: <149745330648.10897.9605870130502083184.stgit@warthog.procyon.org.uk>
Message-ID: <149745334260.10897.8377331388521502715.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Make get_mnt_ns() return the namespace it got a ref on for consistency with
other namespace ref getting functions.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/mount.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/mount.h b/fs/mount.h
index bf1fda6eed8f..02ef292a77d7 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -108,9 +108,10 @@ static inline void detach_mounts(struct dentry *dentry)
 	__detach_mounts(dentry);
 }
 
-static inline void get_mnt_ns(struct mnt_namespace *ns)
+static inline struct mnt_namespace *get_mnt_ns(struct mnt_namespace *ns)
 {
 	atomic_inc(&ns->count);
+	return ns;
 }
 
 extern seqlock_t mount_lock;

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
