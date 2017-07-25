From: serge@hallyn.com (Serge E. Hallyn)
Date: Tue, 25 Jul 2017 15:49:42 -0500
Subject: [RFC PATCH 2/5] ima: Add ns_status for storing namespaced iint
	data
In-Reply-To: <1501013725.27413.27.camel@linux.vnet.ibm.com>
References: <20170720225033.21298-1-mkayaalp@linux.vnet.ibm.com>
	<20170720225033.21298-3-mkayaalp@linux.vnet.ibm.com>
	<20170725194315.GA2397@mail.hallyn.com>
	<1501013725.27413.27.camel@linux.vnet.ibm.com>
Message-ID: <20170725204942.GC4969@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jul 25, 2017 at 04:15:25PM -0400, Mimi Zohar wrote:
> On Tue, 2017-07-25 at 14:43 -0500, Serge E. Hallyn wrote:
> > ...
> > > +static void free_ns_status_cache(struct ima_namespace *ns)
> > > +{
> > > +	struct ns_status *status, *next;
> > > +
> > > +	write_lock(&ns->ns_status_lock);
> > > +	rbtree_postorder_for_each_entry_safe(status, next,
> > > +					     &ns->ns_status_tree, rb_node)
> > > +		kmem_cache_free(ns->ns_status_cache, status);
> > > +	ns->ns_status_tree = RB_ROOT;
> > > +	write_unlock(&ns->ns_status_lock);
> > > +	kmem_cache_destroy(ns->ns_status_cache);
> > > +}
> > > +
> > >  static void destroy_ima_ns(struct ima_namespace *ns)
> > >  {
> > >  	put_user_ns(ns->user_ns);
> > >  	ns_free_inum(&ns->ns);
> > > +	free_ns_status_cache(ns);
> > >  	kfree(ns);
> > >  }
> > >  
> > > @@ -181,3 +198,106 @@ struct ima_namespace init_ima_ns = {
> > >  	.parent = NULL,
> > >  };
> > >  EXPORT_SYMBOL(init_ima_ns);
> > > +
> > > +/*
> > > + * __ima_ns_status_find - return the ns_status associated with an inode
> > > + */
> > > +static struct ns_status *__ima_ns_status_find(struct ima_namespace *ns,
> > > +					      struct inode *inode)
> > > +{
> > > +	struct ns_status *status;
> > > +	struct rb_node *n = ns->ns_status_tree.rb_node;
> > > +
> > > +	while (n) {
> > > +		status = rb_entry(n, struct ns_status, rb_node);
> > > +
> > > +		if (inode < status->inode)
> > > +			n = n->rb_left;
> > > +		else if (inode->i_ino > status->i_ino)
> > > +			n = n->rb_right;
> > > +		else
> > > +			break;
> > > +	}
> > > +	if (!n)
> > > +		return NULL;
> > > +
> > > +	return status;
> > > +}
> > > +
> > > +/*
> > > + * ima_ns_status_find - return the ns_status associated with an inode
> > > + */
> > > +static struct ns_status *ima_ns_status_find(struct ima_namespace *ns,
> > > +					    struct inode *inode)
> > > +{
> > > +	struct ns_status *status;
> > > +
> > > +	read_lock(&ns->ns_status_lock);
> > > +	status = __ima_ns_status_find(ns, inode);
> > > +	read_unlock(&ns->ns_status_lock);
> > > +
> > > +	return status;
> > > +}
> > ...
> > > +
> > > +struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
> > > +				    struct inode *inode)
> > > +{
> > > +	struct ns_status *status;
> > > +	int skip_insert = 0;
> > > +
> > > +	status = ima_ns_status_find(ns, inode);
> > > +	if (status) {
> > > +		/*
> > > +		 * Unlike integrity_iint_cache we are not free'ing the
> > > +		 * ns_status data when the inode is free'd. So, in addition to
> > > +		 * checking the inode pointer, we need to make sure the
> > > +		 * (i_generation, i_ino) pair matches as well. In the future
> > > +		 * we might want to add support for lazily walking the rbtree
> > > +		 * to clean it up.
> > > +		 */
> > > +		if (inode->i_ino == status->i_ino &&
> > > +		    inode->i_generation == status->i_generation)
> > > +			return status;
> > > +
> > > +		/* Same inode number is reused, overwrite the ns_status */
> > > +		skip_insert = 1;
> > > +	} else {
> > > +		status = kmem_cache_alloc(ns->ns_status_cache, GFP_NOFS);
> > > +		if (!status)
> > > +			return ERR_PTR(-ENOMEM);
> > > +	}
> > 
> > What prevents the status from being freed between the read_lock
> > in ima_ns_status_find() and the write_lock in the following line?
> > 
> > IIUC it's that ns is always current's ima_ns, which will pin the ns
> > and cause no statuses to be freed.  But then the ns should probably
> > not be passed in here?  Or a comment should say that ns must be
> > pinned?
> > 
> > Just trying to make sure I understand the locking.
> 
> iint's are only freed after the last reference to the inode is deleted
> in __fput(). ?Refer to ima_file_free(). ?ns_status is a bit different
> in that they are freed on namespace cleanup.

Ok, thanks - that sounds ok then.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
