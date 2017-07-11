From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 11 Jul 2017 14:47:22 -0400
Subject: [PATCH v2] integrity: track mtime in addition to i_version for
	assessment
In-Reply-To: <20170711161324.GA31196@fieldses.org>
References: <20170707140530.30452-1-jlayton@kernel.org>
	<20170711161324.GA31196@fieldses.org>
Message-ID: <1499798842.6034.248.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-07-11 at 12:13 -0400, J. Bruce Fields wrote:
> On Fri, Jul 07, 2017 at 10:05:30AM -0400, Jeff Layton wrote:
> > From: Jeff Layton <jlayton@redhat.com>
> > 
> > The IMA assessment code tries to use the i_version counter to detect
> > when changes to a file have occurred. Many filesystems don't increment
> > it properly (or at all) so detecting changes with that is not always
> > reliable.
> > 
> > That check should be gated on IS_I_VERSION, as you can't rely on the
> > i_version field changing unless that returns true.
> > 
> > Have the code also track and check the mtime for the file. If the
> > IS_I_VERSION returns false, then use it to detect whether the file's
> > contents might have changed.
> 
> Do they care about attribute changes?  It's still better than nothing, I
> suppose.

IMA is only interested in file data changes, not file meta-data
changes. ?EVM needs to recalculate the hmac stored as security.evm,
when file meta-data changes (eg. xattrs, uid, gid, mode,
i_generations), but this is dependent on being in the setxattr or
notify_change() paths, not i_version.

Mimi

> 
> I also wonder whether they should be mixing in ctime as I plan to for
> nfsd--the difference is whether they use it to check changes across
> reboots.
> 
> --b.
> 
> > 
> > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > ---
> >  security/integrity/ima/ima_api.c  |  4 +++-
> >  security/integrity/ima/ima_main.c | 32 ++++++++++++++++++++++++--------
> >  security/integrity/integrity.h    |  1 +
> >  3 files changed, 28 insertions(+), 9 deletions(-)
> > 
> > v2: switch to storing/checking mtime instead of ctime
> > 
> > diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> > index c2edba8de35e..b8d746bbc43d 100644
> > --- a/security/integrity/ima/ima_api.c
> > +++ b/security/integrity/ima/ima_api.c
> > @@ -205,7 +205,8 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
> >  	} hash;
> >  
> >  	if (!(iint->flags & IMA_COLLECTED)) {
> > -		u64 i_version = file_inode(file)->i_version;
> > +		u64 i_version = inode->i_version;
> > +		struct timespec i_mtime = inode->i_mtime;
> >  
> >  		if (file->f_flags & O_DIRECT) {
> >  			audit_cause = "failed(directio)";
> > @@ -225,6 +226,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
> >  				iint->ima_hash = tmpbuf;
> >  				memcpy(iint->ima_hash, &hash, length);
> >  				iint->version = i_version;
> > +				iint->mtime = i_mtime;
> >  				iint->flags |= IMA_COLLECTED;
> >  			} else
> >  				result = -ENOMEM;
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 2aebb7984437..8d12ef2d3ba2 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -113,6 +113,25 @@ static void ima_rdwr_violation_check(struct file *file,
> >  				  "invalid_pcr", "open_writers");
> >  }
> >  
> > +static bool ima_should_update_iint(struct integrity_iint_cache *iint,
> > +				struct inode *inode)
> > +{
> > +	if (atomic_read(&inode->i_writecount) != 1)
> > +		return false;
> > +	if (iint->flags & IMA_NEW_FILE)
> > +		return true;
> > +	if (IS_I_VERSION(inode)) {
> > +		if (iint->version != inode->i_version)
> > +			return true;
> > +	} else {
> > +		if (iint->mtime.tv_sec != inode->i_mtime.tv_sec)
> > +			return true;
> > +		if (iint->mtime.tv_nsec != inode->i_mtime.tv_nsec)
> > +			return true;
> > +	}
> > +	return false;
> > +}
> > +
> >  static void ima_check_last_writer(struct integrity_iint_cache *iint,
> >  				  struct inode *inode, struct file *file)
> >  {
> > @@ -122,14 +141,11 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
> >  		return;
> >  
> >  	inode_lock(inode);
> > -	if (atomic_read(&inode->i_writecount) == 1) {
> > -		if ((iint->version != inode->i_version) ||
> > -		    (iint->flags & IMA_NEW_FILE)) {
> > -			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
> > -			iint->measured_pcrs = 0;
> > -			if (iint->flags & IMA_APPRAISE)
> > -				ima_update_xattr(iint, file);
> > -		}
> > +	if (ima_should_update_iint(iint, inode)) {
> > +		iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
> > +		iint->measured_pcrs = 0;
> > +		if (iint->flags & IMA_APPRAISE)
> > +			ima_update_xattr(iint, file);
> >  	}
> >  	inode_unlock(inode);
> >  }
> > diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> > index a53e7e4ab06c..61fffa7583bf 100644
> > --- a/security/integrity/integrity.h
> > +++ b/security/integrity/integrity.h
> > @@ -102,6 +102,7 @@ struct integrity_iint_cache {
> >  	struct rb_node rb_node;	/* rooted in integrity_iint_tree */
> >  	struct inode *inode;	/* back pointer to inode in question */
> >  	u64 version;		/* track inode changes */
> > +	struct timespec mtime;	/* track inode changes */
> >  	unsigned long flags;
> >  	unsigned long measured_pcrs;
> >  	enum integrity_status ima_file_status:4;
> > -- 
> > 2.13.0
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
