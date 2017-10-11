From: james.l.morris@oracle.com (James Morris)
Date: Thu, 12 Oct 2017 10:30:36 +1100 (AEDT)
Subject: [PATCH][capabilities-next] commoncap: move assignment of fs_ns
	to avoid null pointer dereference
In-Reply-To: <20171011204809.GD8207@mail.hallyn.com>
References: <20170904175005.29871-1-colin.king@canonical.com>
	<20170904185339.GA11576@mail.hallyn.com>
	<20171011204809.GD8207@mail.hallyn.com>
Message-ID: <alpine.LFD.2.20.1710121030190.16516@t440.gateway.2wire.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 11 Oct 2017, Serge E. Hallyn wrote:

> Hi James,
> 
> it doesn't look like this has been picked up yet.  Assuming I'm not looking
> in the wrong place, can you pull it into the security tree?

Sure, Colin, can you please resend this?


> 
> Quoting Serge E. Hallyn (serge at hallyn.com):
> > On Mon, Sep 04, 2017 at 06:50:05PM +0100, Colin King wrote:
> > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > The pointer fs_ns is assigned from inode->i_ib->s_user_ns before
> > > a null pointer check on inode, hence if inode is actually null we
> > > will get a null pointer dereference on this assignment. Fix this
> > > by only dereferencing inode after the null pointer check on
> > > inode.
> > > 
> > > Detected by CoverityScan CID#1455328 ("Dereference before null check")
> > > 
> > > Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > 
> > thanks!
> > 
> > Acked-by: Serge Hallyn <serge@hallyn.com>
> > 
> > > ---
> > >  security/commoncap.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/security/commoncap.c b/security/commoncap.c
> > > index c25e0d27537f..fc46f5b85251 100644
> > > --- a/security/commoncap.c
> > > +++ b/security/commoncap.c
> > > @@ -585,13 +585,14 @@ int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data
> > >  	struct vfs_ns_cap_data data, *nscaps = &data;
> > >  	struct vfs_cap_data *caps = (struct vfs_cap_data *) &data;
> > >  	kuid_t rootkuid;
> > > -	struct user_namespace *fs_ns = inode->i_sb->s_user_ns;
> > > +	struct user_namespace *fs_ns;
> > >  
> > >  	memset(cpu_caps, 0, sizeof(struct cpu_vfs_cap_data));
> > >  
> > >  	if (!inode)
> > >  		return -ENODATA;
> > >  
> > > +	fs_ns = inode->i_sb->s_user_ns;
> > >  	size = __vfs_getxattr((struct dentry *)dentry, inode,
> > >  			      XATTR_NAME_CAPS, &data, XATTR_CAPS_SZ);
> > >  	if (size == -ENODATA || size == -EOPNOTSUPP)
> > > -- 
> > > 2.14.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
