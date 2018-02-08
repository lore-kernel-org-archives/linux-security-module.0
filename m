From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Thu, 08 Feb 2018 10:10:41 -0500
Subject: [PATCH v2 4/5] selinux: Use pointer to switch policydb and sidtab
In-Reply-To: <44f6385f-b2a5-2dbe-7034-851e5d06e42d@sony.com>
References: <20180126143241.23108-1-peter.enderborg@sony.com>
	<20180126143241.23108-5-peter.enderborg@sony.com>
	<1517323047.14420.14.camel@tycho.nsa.gov>
	<44f6385f-b2a5-2dbe-7034-851e5d06e42d@sony.com>
Message-ID: <1518102641.21656.52.camel@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2018-02-08 at 08:16 +0100, peter enderborg wrote:
> On 01/30/2018 03:37 PM, Stephen Smalley wrote:
> > On Fri, 2018-01-26 at 15:32 +0100, peter.enderborg at sony.com wrote:
> > goto err;
> >  
> > -	rc = security_preserve_bools(newpolicydb);
> > +	rc = security_preserve_bools(&next_rcu->policydb);
> >  	if (rc) {
> >  		printk(KERN_ERR "SELinux:  unable to preserve
> > booleans\n");
> >  		goto err;
> > Most of this shouldn't need to be under the read lock.
> > 
> > > @@ -2189,7 +2194,7 @@ int security_load_policy(void *data, size_t
> > > len)
> > >  	 * in the new SID table.
> > >  	 */
> > >  	args.oldp = &crm->policydb;
> > > -	args.newp = newpolicydb;
> > > +	args.newp = &next_rcu->policydb;
> > >  	rc = sidtab_map(&newsidtab, convert_context, &args);
> > >  	if (rc) {
> > >  		printk(KERN_ERR "SELinux:  unable to convert the
> > > internal"
> > > @@ -2204,8 +2209,9 @@ int security_load_policy(void *data, size_t
> > > len)
> > >  
> > >  	/* Install the new policydb and SID table. */
> > >  	/* next */
> > > +	security_load_policycaps(&next_rcu->policydb);
> > 
> > This cannot be done outside of the write lock; it has to be atomic
> > with
> > the policy switch.
> 
> Can you please elaborate, does some else write the policydb without a
> lock?
> Is there any other data that is shared? I see this as a private until
> we switch the pointer.

security_load_policycaps() updates the selinux_policycap_* variables
from the policydb.  Those variables are used by the hooks to
enable/disable policy-specific functionality, like whether to check
open permission or assign finer-grained security classes to sockets. 
We need to atomically update those variables with the active policy;
otherwise, a hook may perform a permission check that wasn't supposed
to be enabled under the old policy against the old policy (yielding an
unexpected denial).  Everything done under the write lock currently is
there for a reason.

> > > +	read_unlock(&policy_rwlock);
> > >  	write_lock_irq(&policy_rwlock);
> > > -	memcpy(&next_rcu->policydb, newpolicydb, sizeof(struct
> > > policydb));
> > >  	sidtab_set(&next_rcu->sidtab, &newsidtab);
> > >  	security_load_policycaps(&next_rcu->policydb);
> > >  	oldmap = crm->current_mapping;
> > > @@ -2213,8 +2219,9 @@ int security_load_policy(void *data, size_t
> > > len)
> > >  	next_rcu->current_mapping_size = map_size;
> > >  
> > >  	seqno = ++latest_granting;
> > > -	write_unlock_irq(&policy_rwlock);
> > > +	old_rcu = crm;
> > >  	crm = next_rcu;
> > > +	write_unlock_irq(&policy_rwlock);
> > >  
> > >  	/* Free the old policydb and SID table. */
> > >  	policydb_destroy(oldpolicydb);
> > > @@ -2226,17 +2233,16 @@ int security_load_policy(void *data,
> > > size_t
> > > len)
> > >  	selinux_status_update_policyload(seqno);
> > >  	selinux_netlbl_cache_invalidate();
> > >  	selinux_xfrm_notify_policyload();
> > > +	kfree(oldpolicydb);
> > > +	kfree(old_rcu);
> > >  
> > >  	rc = 0;
> > >  	goto out;
> > > -
> > >  err:
> > >  	kfree(map);
> > >  	sidtab_destroy(&newsidtab);
> > > -	policydb_destroy(newpolicydb);
> > > -
> > > +	
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
