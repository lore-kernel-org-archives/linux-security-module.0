From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Fri, 29 Sep 2017 08:36:41 -0400
Subject: [RFC][PATCH] security: Make the selinux setxattr and
	removexattr hooks behave
In-Reply-To: <87tvzmqwoi.fsf@xmission.com>
References: <87tvzmqwoi.fsf@xmission.com>
Message-ID: <1506688601.5571.1.camel@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2017-09-28 at 17:34 -0500, Eric W. Biederman wrote:
> It looks like once upon a time a long time ago selinux copied code
> from cap_inode_removexattr and cap_inode_setxattr into
> selinux_inode_setotherxattr.??However the code has now diverged and
> selinux is implementing a policy that is quite different than
> cap_inode_setxattr and cap_inode_removexattr especially when it comes
> to the security.capable xattr.
> 
> To keep things working and to make the comments in
> security/security.c
> correct when the xattr is securit.capable, call cap_inode_setxattr
> or cap_inode_removexattr as appropriate.
> 
> I suspect there is a larger conversation to be had here but this
> is enough to keep selinux from implementing a non-sense hard coded
> policy that breaks other parts of the kernel.

Originally SELinux called the cap functions directly since there was no
stacking support in the infrastructure and one had to manually stack a
secondary module internally.  inode_setxattr and inode_removexattr
however were special cases because the cap functions would check
CAP_SYS_ADMIN for any non-capability attributes in the security.*
namespace, and we don't want to impose that requirement on setting
security.selinux.  Thus, we inlined the capabilities logic into the
selinux hook functions and adapted it appropriately.  When the stacking
support was introduced, it had to also special case these hooks so that
only the primary module's hook is used for the same reason; otherwise,
the kernel would end up applying a CAP_SYS_ADMIN check on setting
security.selinux.  Your change below is almost but not quite right
since it only calls the cap functions when setting the capability
attribute; the residual problem is that it will then skip the SELinux
FILE__SETATTR (file setattr) permission check when setting those
attributes, which we want to retain.  So you need to only return early
if cap_inode_setxattr()/removexattr() return an error; otherwise, you
need to proceed to the SELinux check, and you can then delete the
duplicated logic from selinux_inode_setotherxattr().  At which point it
just becomes a call to dentry_has_perm() and you can just inline that
into selinux_inode_setxattr() and selinux_inode_removexattr().

> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
> ?security/selinux/hooks.c | 6 ++++++
> ?1 file changed, 6 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f5d304736852..edf4bd292dc7 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3167,6 +3167,9 @@ static int selinux_inode_setxattr(struct dentry
> *dentry, const char *name,
> ?	u32 newsid, sid = current_sid();
> ?	int rc = 0;
> ?
> +	if (strcmp(name, XATTR_NAME_CAPS) == 0)
> +		return cap_inode_setxattr(dentry, name, value, size,
> flags);
> +
> ?	if (strcmp(name, XATTR_NAME_SELINUX))
> ?		return selinux_inode_setotherxattr(dentry, name);
> ?
> @@ -3282,6 +3285,9 @@ static int selinux_inode_listxattr(struct
> dentry *dentry)
> ?
> ?static int selinux_inode_removexattr(struct dentry *dentry, const
> char *name)
> ?{
> +	if (strcmp(name, XATTR_NAME_CAPS) == 0)
> +		return cap_inode_removexattr(dentry, name);
> +
> ?	if (strcmp(name, XATTR_NAME_SELINUX))
> ?		return selinux_inode_setotherxattr(dentry, name);
> ?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
