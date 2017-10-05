From: lkundrak@v3.sk (Lubomir Rintel)
Date: Thu,  5 Oct 2017 08:16:11 +0200
Subject: [PATCH] selinux: check CAP_SETFCAP for a particular inode & mapped
	user
Message-ID: <20171005061611.6649-1-lkundrak@v3.sk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This allows setting "security.capability" xattr by a user that has
CAP_SETFCAP in an userns with SELinux. Namespaced capabilities are
supported, as of commit 8db6c34f1dbc ("Introduce v3 namespaced file
capabilities").

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
A casual warning: Please not assume I know what I'm really doing. I can now 
install iputils and /bin/ping in a LXC container, which is great, but I 
typically wouldn't be allowed anywhere near anything security related.

Thank you!

 security/selinux/hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f5d304736852..7bc5f4ffb4e0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3127,11 +3127,12 @@ static int selinux_inode_getattr(const struct path *path)
 static int selinux_inode_setotherxattr(struct dentry *dentry, const char *name)
 {
 	const struct cred *cred = current_cred();
+	struct inode *inode = d_backing_inode(dentry);
 
 	if (!strncmp(name, XATTR_SECURITY_PREFIX,
 		     sizeof XATTR_SECURITY_PREFIX - 1)) {
 		if (!strcmp(name, XATTR_NAME_CAPS)) {
-			if (!capable(CAP_SETFCAP))
+			if (!capable_wrt_inode_uidgid(inode, CAP_SETFCAP))
 				return -EPERM;
 		} else if (!capable(CAP_SYS_ADMIN)) {
 			/* A different attribute in the security namespace.
-- 
2.13.6

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
