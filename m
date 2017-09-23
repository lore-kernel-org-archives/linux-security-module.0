From: aalobaid@linux.com (Ahmad A Alobaid)
Date: Sun, 24 Sep 2017 00:41:16 +0200
Subject: [PATCH] security: commoncap: fix styling
Message-ID: <20170923224116.9163-1-aalobaid@linux.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: "Ahmad A Alobaid" <aalobaid@linux.com>

fix trailing whitespace and Missing a blank line after
declaration

Signed-off-by: Ahmad A Alobaid <aalobaid@linux.com>
---
 security/commoncap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 6bf72b1..c3330c4 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -89,7 +89,7 @@ int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
 		if (ns->level <= cred->user_ns->level)
 			return -EPERM;
 
-		/* 
+		/*
 		 * The owner of the user namespace in the parent of the
 		 * user namespace has all caps.
 		 */
@@ -446,6 +446,7 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 		if (*buffer) {
 			struct vfs_cap_data *cap = *buffer;
 			__le32 nsmagic, magic;
+
 			magic = VFS_CAP_REVISION_2;
 			nsmagic = le32_to_cpu(nscap->magic_etc);
 			if (nsmagic & VFS_CAP_FLAGS_EFFECTIVE)
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
