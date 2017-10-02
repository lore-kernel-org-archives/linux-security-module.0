From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 02 Oct 2017 09:38:20 -0500
Subject: [PATCH] selinux: Perform both commoncap and selinux xattr checks
In-Reply-To: <1506688601.5571.1.camel@tycho.nsa.gov> (Stephen Smalley's
	message of "Fri, 29 Sep 2017 08:36:41 -0400")
References: <87tvzmqwoi.fsf@xmission.com>
	<1506688601.5571.1.camel@tycho.nsa.gov>
Message-ID: <873771ipib.fsf_-_@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


When selinux is loaded the relax permission checks for writing
security.capable are not honored.  Which keeps file capabilities
from being used in user namespaces.

Stephen Smalley <sds@tycho.nsa.gov> writes:
> Originally SELinux called the cap functions directly since there was no
> stacking support in the infrastructure and one had to manually stack a
> secondary module internally.  inode_setxattr and inode_removexattr
> however were special cases because the cap functions would check
> CAP_SYS_ADMIN for any non-capability attributes in the security.*
> namespace, and we don't want to impose that requirement on setting
> security.selinux.  Thus, we inlined the capabilities logic into the
> selinux hook functions and adapted it appropriately.

Now that the permission checks in commoncap have evolved this
inlining of their contents has become a problem.  So restructure
selinux_inode_removexattr, and selinux_inode_setxattr to call
both the corresponding cap_inode_ function and dentry_has_perm
when the attribute is not a selinux security xattr.   This ensures
the policies of both commoncap and selinux are enforced.

This results in smack and selinux having the same basic structure
for setxattr and removexattr.  Performing their own special permission
checks when it is their modules xattr being written to, and deferring
to commoncap when that is not the case.  Then finally performing their
generic module policy on all xattr writes.

This structure is fine when you only consider stacking with the
commoncap lsm, but it becomes a problem if two lsms that don't want
the commoncap security checks on their own attributes need to be
stack.  This means there will need to be updates in the future as lsm
stacking is improved, but at least now the structure between smack and
selinux is common making the code easier to refactor.

This change also has the effect that selinux_linux_setotherxattr becomes
unnecessary so it is removed.

Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
Fixes: 7bbf0e052b76 ("[PATCH] selinux merge")
Historical Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

While this fixes some things this isn't a regression so it should be
able to wait until the next merge window to be merged.   Would you like
to take this through the selinux tree?  Or shall I take it through mine?

security/selinux/hooks.c | 43 ++++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f5d304736852..c78dbec627f6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3124,27 +3124,6 @@ static int selinux_inode_getattr(const struct path *path)
 	return path_has_perm(current_cred(), path, FILE__GETATTR);
 }
 
-static int selinux_inode_setotherxattr(struct dentry *dentry, const char *name)
-{
-	const struct cred *cred = current_cred();
-
-	if (!strncmp(name, XATTR_SECURITY_PREFIX,
-		     sizeof XATTR_SECURITY_PREFIX - 1)) {
-		if (!strcmp(name, XATTR_NAME_CAPS)) {
-			if (!capable(CAP_SETFCAP))
-				return -EPERM;
-		} else if (!capable(CAP_SYS_ADMIN)) {
-			/* A different attribute in the security namespace.
-			   Restrict to administrator. */
-			return -EPERM;
-		}
-	}
-
-	/* Not an attribute we recognize, so just check the
-	   ordinary setattr permission. */
-	return dentry_has_perm(cred, dentry, FILE__SETATTR);
-}
-
 static bool has_cap_mac_admin(bool audit)
 {
 	const struct cred *cred = current_cred();
@@ -3167,8 +3146,15 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 	u32 newsid, sid = current_sid();
 	int rc = 0;
 
-	if (strcmp(name, XATTR_NAME_SELINUX))
-		return selinux_inode_setotherxattr(dentry, name);
+	if (strcmp(name, XATTR_NAME_SELINUX)) {
+		rc = cap_inode_setxattr(dentry, name, value, size, flags);
+		if (rc)
+			return rc;
+
+		/* Not an attribute we recognize, so just check the
+		   ordinary setattr permission. */
+		return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
+	}
 
 	sbsec = inode->i_sb->s_security;
 	if (!(sbsec->flags & SBLABEL_MNT))
@@ -3282,8 +3268,15 @@ static int selinux_inode_listxattr(struct dentry *dentry)
 
 static int selinux_inode_removexattr(struct dentry *dentry, const char *name)
 {
-	if (strcmp(name, XATTR_NAME_SELINUX))
-		return selinux_inode_setotherxattr(dentry, name);
+	if (strcmp(name, XATTR_NAME_SELINUX)) {
+		int rc = cap_inode_removexattr(dentry, name);
+		if (rc)
+			return rc;
+
+		/* Not an attribute we recognize, so just check the
+		   ordinary setattr permission. */
+		return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
+	}
 
 	/* No one is allowed to remove a SELinux security label.
 	   You can change the label, but all data must be labeled. */
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
