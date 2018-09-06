From: jlayton@kernel.org (Jeff Layton)
Date: Thu, 06 Sep 2018 12:05:42 -0400
Subject: [PATCH 3/3] ceph: xattr security label support
In-Reply-To: <71c71ef6a59db264a9d8c46598beb13782244f06.camel@kernel.org>
References: <20180626084306.27511-1-zyan@redhat.com>
	<20180626084306.27511-3-zyan@redhat.com>
	<71c71ef6a59db264a9d8c46598beb13782244f06.camel@kernel.org>
Message-ID: <ad553d89a61b739b579ba7c8b9bc3c61a6daf55c.camel@kernel.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2018-09-06 at 11:50 -0400, Jeff Layton wrote:
> On Tue, 2018-06-26 at 16:43 +0800, Yan, Zheng wrote:
> > When creating new file/directory, uses dentry_init_security() to prepare
> > security context for the new inode, then sends openc/mkdir request to MDS,
> > together with security xattr "security.<security module name>"
> > 
> > Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> > ---
> >  fs/ceph/Kconfig |   5 ++
> >  fs/ceph/caps.c  |   1 +
> >  fs/ceph/dir.c   |  12 +++++
> >  fs/ceph/file.c  |   3 ++
> >  fs/ceph/inode.c |   1 +
> >  fs/ceph/super.h |  19 +++++++
> >  fs/ceph/xattr.c | 140 ++++++++++++++++++++++++++++++++++++++++++------
> >  7 files changed, 164 insertions(+), 17 deletions(-)
> > 
> > diff --git a/fs/ceph/Kconfig b/fs/ceph/Kconfig
> > index 52095f473464..e1a4100c99eb 100644
> > --- a/fs/ceph/Kconfig
> > +++ b/fs/ceph/Kconfig
> > @@ -35,3 +35,8 @@ config CEPH_FS_POSIX_ACL
> >  	  groups beyond the owner/group/world scheme.
> >  
> >  	  If you don't know what Access Control Lists are, say N
> > +
> > +config CEPH_FS_SECURITY_LABEL
> > +	bool
> > +	depends on CEPH_FS && SECURITY
> > +	default y
> 
> 
> Some help text would be nice here, unless you intend to keep this option
> hidden?
> 
> > diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> > index 990258cbd836..ec49a3858288 100644
> > --- a/fs/ceph/caps.c
> > +++ b/fs/ceph/caps.c
> > @@ -3144,6 +3144,7 @@ static void handle_cap_grant(struct inode *inode,
> >  			ci->i_xattrs.blob = ceph_buffer_get(xattr_buf);
> >  			ci->i_xattrs.version = version;
> >  			ceph_forget_all_cached_acls(inode);
> > +			ceph_security_invalidate_secctx(inode);
> >  		}
> >  	}
> >  
> > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > index f451ad5a37ab..18ece4be4493 100644
> > --- a/fs/ceph/dir.c
> > +++ b/fs/ceph/dir.c
> > @@ -833,6 +833,9 @@ static int ceph_mknod(struct inode *dir, struct dentry *dentry,
> >  	err = ceph_pre_init_acls(dir, &mode, &as_ctx);
> >  	if (err < 0)
> >  		return err;
> > +	err = ceph_security_init_secctx(dentry, mode, &as_ctx);
> > +	if (err < 0)
> > +	       goto out;
> >  
> >  	dout("mknod in dir %p dentry %p mode 0%ho rdev %d\n",
> >  	     dir, dentry, mode, rdev);
> > @@ -878,6 +881,7 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
> >  	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
> >  	struct ceph_mds_client *mdsc = fsc->mdsc;
> >  	struct ceph_mds_request *req;
> > +	struct ceph_acl_sec_ctx as_ctx = {};
> >  	int err;
> >  
> >  	if (ceph_snap(dir) != CEPH_NOSNAP)
> > @@ -886,6 +890,10 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
> >  	if (ceph_quota_is_max_files_exceeded(dir))
> >  		return -EDQUOT;
> >  
> > +	err = ceph_security_init_secctx(dentry, S_IFLNK | S_IRWXUGO, &as_ctx);
> > +	if (err < 0)
> > +	       goto out;
> > +
> >  	dout("symlink in dir %p dentry %p to '%s'\n", dir, dentry, dest);
> >  	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_SYMLINK, USE_AUTH_MDS);
> >  	if (IS_ERR(req)) {
> > @@ -911,6 +919,7 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
> >  out:
> >  	if (err)
> >  		d_drop(dentry);
> > +	ceph_release_acl_sec_ctx(&as_ctx);
> >  	return err;
> >  }
> >  
> > @@ -945,6 +954,9 @@ static int ceph_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
> >  	err = ceph_pre_init_acls(dir, &mode, &as_ctx);
> >  	if (err < 0)
> >  		goto out;
> > +	err = ceph_security_init_secctx(dentry, mode, &as_ctx);
> > +	if (err < 0)
> > +	       goto out;
> >  
> >  	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
> >  	if (IS_ERR(req)) {
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index 701506ec5768..0e835ca720cb 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -453,6 +453,9 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
> >  		err = ceph_pre_init_acls(dir, &mode, &as_ctx);
> >  		if (err < 0)
> >  			return err;
> > +		err = ceph_security_init_secctx(dentry, mode, &as_ctx);
> > +		if (err < 0)
> > +			goto out_ctx;
> >  	}
> >  
> >  	/* do the open */
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index 1fe3a02336b0..db0079fd5c06 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -896,6 +896,7 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
> >  			       iinfo->xattr_data, iinfo->xattr_len);
> >  		ci->i_xattrs.version = le64_to_cpu(info->xattr_version);
> >  		ceph_forget_all_cached_acls(inode);
> > +		ceph_security_invalidate_secctx(inode);
> >  		xattr_blob = NULL;
> >  	}
> >  
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index 83561421afda..60151b8cd5c7 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -910,6 +910,10 @@ struct ceph_acl_sec_ctx {
> >  #ifdef CONFIG_CEPH_FS_POSIX_ACL
> >  	void *default_acl;
> >  	void *acl;
> > +#endif
> > +#ifdef CONFIG_CEPH_FS_SECURITY_LABEL
> > +	void *sec_ctx;
> > +	u32 sec_ctxlen;
> >  #endif
> >  	struct ceph_pagelist *pagelist;
> >  };
> > @@ -928,6 +932,21 @@ static inline bool ceph_security_xattr_wanted(struct inode *in)
> >  }
> >  #endif
> >  
> > +#ifdef CONFIG_CEPH_FS_SECURITY_LABEL
> > +extern int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
> > +				     struct ceph_acl_sec_ctx *ctx);
> > +extern void ceph_security_invalidate_secctx(struct inode *inode);
> > +#else
> > +static inline int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
> > +					    struct ceph_acl_sec_ctx *ctx)
> > +{
> > +	return 0;
> > +}
> > +static inline void ceph_security_invalidate_secctx(struct inode *inode)
> > +{
> > +}
> > +#endif
> > +
> >  void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx);
> >  
> >  /* acl.c */
> > diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> > index ef0e968d56a1..3e87208cbde8 100644
> > --- a/fs/ceph/xattr.c
> > +++ b/fs/ceph/xattr.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/ceph/decode.h>
> >  
> >  #include <linux/xattr.h>
> > +#include <linux/security.h>
> >  #include <linux/posix_acl_xattr.h>
> >  #include <linux/slab.h>
> >  
> > @@ -17,26 +18,9 @@
> >  static int __remove_xattr(struct ceph_inode_info *ci,
> >  			  struct ceph_inode_xattr *xattr);
> >  
> > -static const struct xattr_handler ceph_other_xattr_handler;
> > -
> > -/*
> > - * List of handlers for synthetic system.* attributes. Other
> > - * attributes are handled directly.
> > - */
> > -const struct xattr_handler *ceph_xattr_handlers[] = {
> > -#ifdef CONFIG_CEPH_FS_POSIX_ACL
> > -	&posix_acl_access_xattr_handler,
> > -	&posix_acl_default_xattr_handler,
> > -#endif
> > -	&ceph_other_xattr_handler,
> > -	NULL,
> > -};
> > -
> >  static bool ceph_is_valid_xattr(const char *name)
> >  {
> >  	return !strncmp(name, XATTR_CEPH_PREFIX, XATTR_CEPH_PREFIX_LEN) ||
> > -	       !strncmp(name, XATTR_SECURITY_PREFIX,
> > -			XATTR_SECURITY_PREFIX_LEN) ||
> >  	       !strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN) ||
> >  	       !strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN);
> >  }
> > @@ -1189,6 +1173,109 @@ bool ceph_security_xattr_deadlock(struct inode *in)
> >  	spin_unlock(&ci->i_ceph_lock);
> >  	return ret;
> >  }
> > +
> > +#ifdef CONFIG_CEPH_FS_SECURITY_LABEL
> > +int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
> > +			   struct ceph_acl_sec_ctx *as_ctx)
> > +{
> > +	struct ceph_pagelist *pagelist = as_ctx->pagelist;
> > +	const char *label;
> > +	size_t label_len;
> > +	int err;
> > +
> > +	err = security_dentry_init_security(dentry, mode, &dentry->d_name,
> > +					    &label, &as_ctx->sec_ctx,
> > +					    &as_ctx->sec_ctxlen);
> > +	if (err < 0) {
> > +		err = 0; /* do nothing */
> > +		goto out;
> > +	}
> > +
> > +	err = -ENOMEM;
> > +	if (!pagelist) {
> > +		pagelist = kmalloc(sizeof(struct ceph_pagelist), GFP_KERNEL);
> > +		if (!pagelist)
> > +			goto out;
> > +		ceph_pagelist_init(pagelist);
> > +
> > +		err = ceph_pagelist_reserve(pagelist, PAGE_SIZE);
> > +		if (err)
> > +			goto out;
> > +		ceph_pagelist_encode_32(pagelist, 1);
> > +	}
> > +
> > +	label_len = strlen(label);
> > +	err = ceph_pagelist_reserve(pagelist, XATTR_SECURITY_PREFIX_LEN +
> > +				    label_len + as_ctx->sec_ctxlen + 8);
> > +	if (err)
> > +		goto out;
> > +
> > +	if (as_ctx->pagelist) {
> > +		/* update count of KV pairs */
> > +		BUG_ON(pagelist->length <= sizeof(__le32));
> > +		if (list_is_singular(&pagelist->head)) {
> > +			le32_add_cpu((__le32*)pagelist->mapped_tail, 1);
> > +		} else {
> > +			struct page *page = list_first_entry(&pagelist->head,
> > +							     struct page, lru);
> > +			void *addr = kmap_atomic(page);
> > +			le32_add_cpu((__le32*)addr, 1);
> > +			kunmap_atomic(addr);
> > +		}
> > +	} else {
> > +		as_ctx->pagelist = pagelist;
> > +	}
> > +
> > +	ceph_pagelist_encode_32(pagelist,
> > +				XATTR_SECURITY_PREFIX_LEN + label_len);
> > +	ceph_pagelist_append(pagelist, XATTR_SECURITY_PREFIX,
> > +			     XATTR_SECURITY_PREFIX_LEN);
> > +	ceph_pagelist_append(pagelist, label, label_len);
> > +
> > +	ceph_pagelist_encode_32(pagelist, as_ctx->sec_ctxlen);
> > +	ceph_pagelist_append(pagelist, as_ctx->sec_ctx, as_ctx->sec_ctxlen);
> > +
> > +	err = 0;
> > +out:
> > +	if (pagelist && !as_ctx->pagelist)
> > +		ceph_pagelist_release(pagelist);
> > +	return err;
> > +}
> > +
> > +void ceph_security_invalidate_secctx(struct inode *inode)
> > +{
> > +	security_inode_invalidate_secctx(inode);
> > +}
> > +
> > +static int ceph_xattr_set_security_label(const struct xattr_handler *handler,
> > +				    struct dentry *unused, struct inode *inode,
> > +				    const char *key, const void *buf,
> > +				    size_t buflen, int flags)
> > +{
> > +	if (security_ismaclabel(key)) {
> > +		const char *name = xattr_full_name(handler, key);
> > +		return __ceph_setxattr(inode, name, buf, buflen, flags);
> > +	}
> > +	return  -EOPNOTSUPP;
> > +}
> > +
> > +static int ceph_xattr_get_security_label(const struct xattr_handler *handler,
> > +				    struct dentry *unused, struct inode *inode,
> > +				    const char *key, void *buf, size_t buflen)
> > +{
> > +        if (security_ismaclabel(key)) {
> 
> nit: there may be some whitespace damage above.
> 
> > +		const char *name = xattr_full_name(handler, key);
> > +		return __ceph_getxattr(inode, name, buf, buflen);
> > +	}
> > +	return  -EOPNOTSUPP;
> > +}
> 
> 
> What I'm a little unclear on in all of this is what happens when you
> have an existing cephfs with no security labels, and one client boots to
> a kernel with this support. This is unlike the situation with most local
> filesystems, as we can't really expect to do a full relabel when
> enabling this on an existing fs.
> 
> This function just returns -EOPNOTSUPP, but inode_doinit_with_dentry
> seems like it might expect -ENODATA in this situation. Is this the
> correct way to handle this?
> 

Ahh, nevermind -- I missed that the above -EOPNOTSUPP is for when we
don't recognize the xattr key name. It looks like we should get back
ENODATA in this situation, which should result in the inode getting the
default file label for the sb.

> 
> > +static const struct xattr_handler ceph_security_label_handler = {
> > +        .prefix = XATTR_SECURITY_PREFIX,
> > +        .get    = ceph_xattr_get_security_label,
> > +        .set    = ceph_xattr_set_security_label,
> > +};
> > +#endif
> >  #endif
> >  
> >  void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
> > @@ -1196,7 +1283,26 @@ void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
> >  #ifdef CONFIG_CEPH_FS_POSIX_ACL
> >  	posix_acl_release(as_ctx->acl);
> >  	posix_acl_release(as_ctx->default_acl);
> > +#endif
> > +#ifdef CONFIG_CEPH_FS_SECURITY_LABEL
> > +	security_release_secctx(as_ctx->sec_ctx, as_ctx->sec_ctxlen);
> >  #endif
> >  	if (as_ctx->pagelist)
> >  		ceph_pagelist_release(as_ctx->pagelist);
> >  }
> > +
> > +/*
> > + * List of handlers for synthetic system.* attributes. Other
> > + * attributes are handled directly.
> > + */
> > +const struct xattr_handler *ceph_xattr_handlers[] = {
> > +#ifdef CONFIG_CEPH_FS_POSIX_ACL
> > +	&posix_acl_access_xattr_handler,
> > +	&posix_acl_default_xattr_handler,
> > +#endif
> > +#ifdef CONFIG_CEPH_FS_SECURITY_LABEL
> > +	&ceph_security_label_handler,
> > +#endif
> > +	&ceph_other_xattr_handler,
> > +	NULL,
> > +};
> 
> 
> 

-- 
Jeff Layton <jlayton@kernel.org>
