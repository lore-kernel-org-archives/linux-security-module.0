From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 02 Feb 2018 10:33:44 -0500
Subject: [RFC PATCH v4 1/2] fuse: introduce new fs_type flag
	FS_IMA_NO_CACHE
In-Reply-To: <1517584816.3171.61.camel@linux.vnet.ibm.com>
References: <cover.1517314847.git.dongsu@kinvolk.io>
	<86832c6adb256f29f44b6229222b80964fc8cfcc.1517314847.git.dongsu@kinvolk.io>
	<1517584816.3171.61.camel@linux.vnet.ibm.com>
Message-ID: <1517585624.3171.64.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2018-02-02 at 10:20 -0500, Mimi Zohar wrote:
> Hi Miklos,
> 
> On Tue, 2018-01-30 at 19:06 +0100, Dongsu Park wrote:
> > From: Alban Crequy <alban@kinvolk.io>
> > 
> > This new fs_type flag FS_IMA_NO_CACHE means files should be re-measured,
> > re-appraised and re-audited each time. Cached integrity results should
> > not be used.
> > 
> > It is useful in FUSE because the userspace FUSE process can change the
> > underlying files at any time without notifying the kernel.
> 
> Both IMA-measurement and IMA-appraisal cache the integrity results and
> are dependent on the kernel to detect when a file changes in order to
> clear the cached info and force the file to be re-evaluated.??This
> detection was dependent on i_version changing.??For filesystems that
> do not support i_version, remote or fuse filesystems, where the kernel
> does not detect the file change, the file was measured and the
> signature evaluated just once.
> 
> With commit a2a2c3c8580a ("ima: Use i_version only when filesystem
> supports it"), which is being upstreamed in this open window,
> i_version is considered an optimization.??If i_version is not enabled,
> either because the local filesystem does not support it or the
> filesystem wasn't mounted with i_version, the file will now always be
> re-evaluated.
> 
> That patch does not address FUSE or remote filesystems, as the kernel
> does not detect the change.??Further, even if the kernel could detect
> the change, FUSE filesystems by definition are untrusted.
> 
> The original patches addressed FUSE filesystems, by defining a new IMA
> policy option, forcing the file to be re-evaluated based on the
> filesystem magic number. ?All of the changes were in the IMA
> subsystem. ?These patches are the result of Christoph's comment on the
> original patches saying, "ima has no business looking at either the
> name _or_ the magic number."
> 
> Your help in resolving this problem is much appreciated!

Meaning, can you ack the fuse flag addition so we can take the series
through the IMA tree?

thanks,

Mimi

> 
> > 
> > Cc: linux-kernel at vger.kernel.org
> > Cc: linux-integrity at vger.kernel.org
> > Cc: linux-security-module at vger.kernel.org
> > Cc: linux-fsdevel at vger.kernel.org
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Acked-by: "Serge E. Hallyn" <serge@hallyn.com>
> > Acked-by: Seth Forshee <seth.forshee@canonical.com>
> > Tested-by: Dongsu Park <dongsu@kinvolk.io>
> > Signed-off-by: Alban Crequy <alban@kinvolk.io>
> > ---
> >  fs/fuse/inode.c    | 2 +-
> >  include/linux/fs.h | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 624f18bb..0a9e5164 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1205,7 +1205,7 @@ static void fuse_kill_sb_anon(struct super_block *sb)
> >  static struct file_system_type fuse_fs_type = {
> >  	.owner		= THIS_MODULE,
> >  	.name		= "fuse",
> > -	.fs_flags	= FS_HAS_SUBTYPE,
> > +	.fs_flags	= FS_HAS_SUBTYPE | FS_IMA_NO_CACHE,
> >  	.mount		= fuse_mount,
> >  	.kill_sb	= fuse_kill_sb_anon,
> >  };
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 511fbaab..ced841ba 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2075,6 +2075,7 @@ struct file_system_type {
> >  #define FS_BINARY_MOUNTDATA	2
> >  #define FS_HAS_SUBTYPE		4
> >  #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
> > +#define FS_IMA_NO_CACHE		16	/* Force IMA to re-measure, re-appraise, re-audit files */
> >  #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
> >  	struct dentry *(*mount) (struct file_system_type *, int,
> >  		       const char *, void *);
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
