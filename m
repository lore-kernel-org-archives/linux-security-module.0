From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 28 Sep 2017 17:34:53 -0500
Subject: [RFC][PATCH] security: Make the selinux setxattr and removexattr
	hooks behave
Message-ID: <87tvzmqwoi.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


It looks like once upon a time a long time ago selinux copied code
from cap_inode_removexattr and cap_inode_setxattr into
selinux_inode_setotherxattr.  However the code has now diverged and
selinux is implementing a policy that is quite different than
cap_inode_setxattr and cap_inode_removexattr especially when it comes
to the security.capable xattr.

To keep things working and to make the comments in security/security.c
correct when the xattr is securit.capable, call cap_inode_setxattr
or cap_inode_removexattr as appropriate.

I suspect there is a larger conversation to be had here but this
is enough to keep selinux from implementing a non-sense hard coded
policy that breaks other parts of the kernel.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 security/selinux/hooks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f5d304736852..edf4bd292dc7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3167,6 +3167,9 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 	u32 newsid, sid = current_sid();
 	int rc = 0;
 
+	if (strcmp(name, XATTR_NAME_CAPS) == 0)
+		return cap_inode_setxattr(dentry, name, value, size, flags);
+
 	if (strcmp(name, XATTR_NAME_SELINUX))
 		return selinux_inode_setotherxattr(dentry, name);
 
@@ -3282,6 +3285,9 @@ static int selinux_inode_listxattr(struct dentry *dentry)
 
 static int selinux_inode_removexattr(struct dentry *dentry, const char *name)
 {
+	if (strcmp(name, XATTR_NAME_CAPS) == 0)
+		return cap_inode_removexattr(dentry, name);
+
 	if (strcmp(name, XATTR_NAME_SELINUX))
 		return selinux_inode_setotherxattr(dentry, name);
 
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
