From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 11 Oct 2017 08:28:01 -0400
Subject: [PATCH] vfs: fix mounting a filesystem with i_version
In-Reply-To: <alpine.LRH.2.21.1710090924410.3670@namei.org>
References: <1507436901.5841.4.camel@linux.vnet.ibm.com>
	<alpine.LRH.2.21.1710090924410.3670@namei.org>
Message-ID: <1507724881.3428.19.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Al,

This patch fixes a regression.??Without it, you can't mount a file
system with i_version.??This obviously affects IMA.??Could you pick up
this patch and forward it to Linus please?

Commit dd924ea17c0c "vfs: fix mounting a filesystem with i_version"
can be found in my git repo.

thanks,

Mimi


On Mon, 2017-10-09 at 09:24 +1100, James Morris wrote:
> cc: Al Viro.
> 
> 
> On Sun, 8 Oct 2017, Mimi Zohar wrote:
> 
> > The mount i_version flag is not enabled in the new sb_flags.  This patch
> > adds the missing SB_I_VERSION flag.
> > 
> > Fixes: e462ec5 "VFS: Differentiate mount flags (MS_*) from internal
> >        superblock flags"
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > ---
> >  fs/namespace.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 3b601f115b6c..d18deb4c410b 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -2825,7 +2825,8 @@ long do_mount(const char *dev_name, const char __user *dir_name,
> >  			    SB_MANDLOCK |
> >  			    SB_DIRSYNC |
> >  			    SB_SILENT |
> > -			    SB_POSIXACL);
> > +			    SB_POSIXACL |
> > +			    SB_I_VERSION);
> >  
> >  	if (flags & MS_REMOUNT)
> >  		retval = do_remount(&path, flags, sb_flags, mnt_flags,
> > 
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
