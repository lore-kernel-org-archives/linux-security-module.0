From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon, 09 Oct 2017 20:14:52 +0200
Subject: [PATCH] selinux: check CAP_SETFCAP for a particular inode &
	mapped user
In-Reply-To: <20171005064826.GA11630@mail.hallyn.com>
References: <20171005061611.6649-1-lkundrak@v3.sk>
	<20171005064826.GA11630@mail.hallyn.com>
Message-ID: <1507572892.23600.10.camel@v3.sk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2017-10-05 at 01:48 -0500, Serge E. Hallyn wrote:
> On Thu, Oct 05, 2017 at 08:16:11AM +0200, Lubomir Rintel wrote:
> > This allows setting "security.capability" xattr by a user that has
> > CAP_SETFCAP in an userns with SELinux. Namespaced capabilities are
> > supported, as of commit 8db6c34f1dbc ("Introduce v3 namespaced file
> > capabilities").
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> The fix is already on its way into the kernel - see the thread at
> https://marc.info/?l=selinux&m=150713903925728&w=2

Thanks for the response. I'm wondering if there are chances this could
go to 4.14, given the patch that got merged seems reasonably self-
contained, quite useful, and the release is going to be a long-term
one.

If rc5 is too late for such changes, are there changes it could perhaps
go to a subsequent -stable release?

Thanks,
Lubo

> 
> Thanks though :)
> 
> -serge
> 
> > ---
> > A casual warning: Please not assume I know what I'm really doing. I
> > can now 
> > install iputils and /bin/ping in a LXC container, which is great,
> > but I 
> > typically wouldn't be allowed anywhere near anything security
> > related.
> > 
> > Thank you!
> > 
> >  security/selinux/hooks.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index f5d304736852..7bc5f4ffb4e0 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3127,11 +3127,12 @@ static int selinux_inode_getattr(const
> > struct path *path)
> >  static int selinux_inode_setotherxattr(struct dentry *dentry,
> > const char *name)
> >  {
> >  	const struct cred *cred = current_cred();
> > +	struct inode *inode = d_backing_inode(dentry);
> >  
> >  	if (!strncmp(name, XATTR_SECURITY_PREFIX,
> >  		     sizeof XATTR_SECURITY_PREFIX - 1)) {
> >  		if (!strcmp(name, XATTR_NAME_CAPS)) {
> > -			if (!capable(CAP_SETFCAP))
> > +			if (!capable_wrt_inode_uidgid(inode,
> > CAP_SETFCAP))
> >  				return -EPERM;
> >  		} else if (!capable(CAP_SYS_ADMIN)) {
> >  			/* A different attribute in the security
> > namespace.
> > -- 
> > 2.13.6
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
