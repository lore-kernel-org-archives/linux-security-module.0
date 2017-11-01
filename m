From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Wed, 01 Nov 2017 08:20:40 -0400
Subject: [PATCH 3/9] LSM: Manage file security blobs
In-Reply-To: <a1cf32cc-911c-20a3-f6c2-4c35bf5d46d6@schaufler-ca.com>
References: <1473402e-a714-7ace-2698-b65d73e3f17e@schaufler-ca.com>
	<66c1324f-744c-3d00-5253-df3465ffd03a@schaufler-ca.com>
	<1509463551.20694.17.camel@tycho.nsa.gov>
	<7da21e72-7ec5-ecf4-9a9a-bf35ca89b4fd@schaufler-ca.com>
	<30d8f777-beb8-7145-25bb-98ee1b9ebeab@canonical.com>
	<a1cf32cc-911c-20a3-f6c2-4c35bf5d46d6@schaufler-ca.com>
Message-ID: <1509538840.24459.1.camel@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-10-31 at 14:30 -0700, Casey Schaufler wrote:
> On 10/31/2017 10:32 AM, John Johansen wrote:
> > On 10/31/2017 09:16 AM, Casey Schaufler wrote:
> > > On 10/31/2017 8:25 AM, Stephen Smalley wrote:
> > > > On Fri, 2017-10-27 at 14:45 -0700, Casey Schaufler wrote:
> > > > > Subject: [PATCH 3/9] LSM: Manage file security blobs
> > > > > 
> > > > > Move the management of file security blobs from the
> > > > > individual
> > > > > security modules to the security infrastructure. The security
> > > > > modules
> > > > > using file blobs have been updated accordingly. Modules are
> > > > > required
> > > > > to identify the space they need at module initialization. In
> > > > > some
> > > > > cases a module no longer needs to supply a blob management
> > > > > hook, in
> > > > > which case the hook has been removed.
> > > > > 
> > > > > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > > > > ---
> > > > > ?include/linux/lsm_hooks.h???????????|??1 +
> > > > > ?security/apparmor/include/context.h |??5 +++++
> > > > > ?security/apparmor/include/file.h????|??2 +-
> > > > > ?security/apparmor/lsm.c?????????????| 19 ++++++++--------
> > > > > ?security/security.c?????????????????| 43
> > > > > +++++++++++++++++++++++++++++++++++++
> > > > > ?security/selinux/hooks.c????????????| 41 +++++++++--------
> > > > > --------
> > > > > ----------
> > > > > ?security/selinux/include/objsec.h???|??5 +++++
> > > > > ?security/smack/smack.h??????????????|??5 +++++
> > > > > ?security/smack/smack_lsm.c??????????| 26 ++++++++-----------
> > > > > ---
> > > > > ?9 files changed, 89 insertions(+), 58 deletions(-)
> > > > > 
> > > > > diff --git a/include/linux/lsm_hooks.h
> > > > > b/include/linux/lsm_hooks.h
> > > > > index ee4fcc51fa91..e5d0f1e01b81 100644
> > > > > --- a/include/linux/lsm_hooks.h
> > > > > +++ b/include/linux/lsm_hooks.h
> > > > > @@ -1919,6 +1919,7 @@ struct security_hook_list {
> > > > > ? */
> > > > > ?struct lsm_blob_sizes {
> > > > > ?	int	lbs_cred;
> > > > > +	int	lbs_file;
> > > > > ?};
> > > > > ?
> > > > > ?/*
> > > > > diff --git a/security/apparmor/include/context.h
> > > > > b/security/apparmor/include/context.h
> > > > > index 301ab3a0dd04..c6e106a533e8 100644
> > > > > --- a/security/apparmor/include/context.h
> > > > > +++ b/security/apparmor/include/context.h
> > > > > @@ -87,6 +87,11 @@ static inline struct aa_label
> > > > > *aa_get_newest_cred_label(const struct cred *cred)
> > > > > ?	return aa_get_newest_label(aa_cred_raw_label(cred));
> > > > > ?}
> > > > > ?
> > > > > +static inline struct aa_file_ctx *apparmor_file(const struct
> > > > > file
> > > > > *file)
> > > > > +{
> > > > > +	return file->f_security;
> > > > > +}
> > > > > +
> > > > > ?/**
> > > > > ? * __aa_task_raw_label - retrieve another task's label
> > > > > ? * @task: task to query??(NOT NULL)
> > > > > diff --git a/security/apparmor/include/file.h
> > > > > b/security/apparmor/include/file.h
> > > > > index 4c2c8ac8842f..b9efe6bc226b 100644
> > > > > --- a/security/apparmor/include/file.h
> > > > > +++ b/security/apparmor/include/file.h
> > > > > @@ -32,7 +32,7 @@ struct path;
> > > > > ?				?AA_MAY_CHMOD | AA_MAY_CHOWN
> > > > > |
> > > > > AA_MAY_LOCK | \
> > > > > ?				?AA_EXEC_MMAP | AA_MAY_LINK)
> > > > > ?
> > > > > -#define file_ctx(X) ((struct aa_file_ctx *)(X)->f_security)
> > > > > +#define file_ctx(X) apparmor_file(X)
> > > > > ?
> > > > > ?/* struct aa_file_ctx - the AppArmor context the file was
> > > > > opened in
> > > > > ? * @lock: lock to update the ctx
> > > > > diff --git a/security/apparmor/lsm.c
> > > > > b/security/apparmor/lsm.c
> > > > > index d80293bde5bf..f2814ba84481 100644
> > > > > --- a/security/apparmor/lsm.c
> > > > > +++ b/security/apparmor/lsm.c
> > > > > @@ -402,21 +402,21 @@ static int apparmor_file_open(struct
> > > > > file
> > > > > *file, const struct cred *cred)
> > > > > ?
> > > > > ?static int apparmor_file_alloc_security(struct file *file)
> > > > > ?{
> > > > > -	int error = 0;
> > > > > -
> > > > > -	/* freed by apparmor_file_free_security */
> > > > > +	struct aa_file_ctx *ctx = file_ctx(file);
> > > > > ?	struct aa_label *label =
> > > > > begin_current_label_crit_section();
> > > > > -	file->f_security = aa_alloc_file_ctx(label,
> > > > > GFP_KERNEL);
> > > > > -	if (!file_ctx(file))
> > > > > -		error = -ENOMEM;
> > > > > -	end_current_label_crit_section(label);
> > > > > ?
> > > > > -	return error;
> > > > > +	spin_lock_init(&ctx->lock);
> > > > > +	rcu_assign_pointer(ctx->label, aa_get_label(label));
> > > > > +	end_current_label_crit_section(label);
> > > > > +	return 0;
> > > > > ?}
> > > > > ?
> > > > > ?static void apparmor_file_free_security(struct file *file)
> > > > > ?{
> > > > > -	aa_free_file_ctx(file_ctx(file));
> > > > > +	struct aa_file_ctx *ctx = file_ctx(file);
> > > > > +
> > > > > +	if (ctx)
> > > > > +		aa_put_label(rcu_access_pointer(ctx-
> > > > > >label));
> > > > > ?}
> > > > > ?
> > > > > ?static int common_file_perm(const char *op, struct file
> > > > > *file, u32
> > > > > mask)
> > > > > @@ -1078,6 +1078,7 @@ static void apparmor_sock_graft(struct
> > > > > sock
> > > > > *sk, struct socket *parent)
> > > > > ?
> > > > > ?struct lsm_blob_sizes apparmor_blob_sizes = {
> > > > > ?	.lbs_cred = sizeof(struct aa_task_ctx),
> > > > > +	.lbs_file = sizeof(struct aa_file_ctx),
> > > > > ?};
> > > > > ?
> > > > > ?static struct security_hook_list apparmor_hooks[]
> > > > > __lsm_ro_after_init = {
> > > > > diff --git a/security/security.c b/security/security.c
> > > > > index 6fadc3860fb0..4d8e702fa22f 100644
> > > > > --- a/security/security.c
> > > > > +++ b/security/security.c
> > > > > @@ -37,6 +37,8 @@
> > > > > ?struct security_hook_heads security_hook_heads
> > > > > __lsm_ro_after_init;
> > > > > ?static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
> > > > > ?
> > > > > +static struct kmem_cache *lsm_file_cache;
> > > > > +
> > > > > ?char *lsm_names;
> > > > > ?static struct lsm_blob_sizes blob_sizes;
> > > > > ?
> > > > > @@ -83,6 +85,13 @@ int __init security_init(void)
> > > > > ?	do_security_initcalls();
> > > > > ?
> > > > > ?	/*
> > > > > +	?* Create any kmem_caches needed for blobs
> > > > > +	?*/
> > > > > +	if (blob_sizes.lbs_file)
> > > > > +		lsm_file_cache =
> > > > > kmem_cache_create("lsm_file_cache",
> > > > > +						???blob_size
> > > > > s.lbs_fi
> > > > > le, 0,
> > > > > +						???SLAB_PANI
> > > > > C,
> > > > > NULL);
> > > > > +	/*
> > > > > ?	?* The second call to a module specific init
> > > > > function
> > > > > ?	?* adds hooks to the hook lists and does any other
> > > > > early
> > > > > ?	?* initializations required.
> > > > > @@ -91,6 +100,7 @@ int __init security_init(void)
> > > > > ?
> > > > > ?#ifdef CONFIG_SECURITY_LSM_DEBUG
> > > > > ?	pr_info("LSM: cred blob size???????= %d\n",
> > > > > blob_sizes.lbs_cred);
> > > > > +	pr_info("LSM: file blob size???????= %d\n",
> > > > > blob_sizes.lbs_file);
> > > > > ?#endif
> > > > > ?
> > > > > ?	return 0;
> > > > > @@ -267,6 +277,26 @@ static void __init lsm_set_size(int
> > > > > *need, int
> > > > > *lbs)
> > > > > ?void __init security_add_blobs(struct lsm_blob_sizes
> > > > > *needed)
> > > > > ?{
> > > > > ?	lsm_set_size(&needed->lbs_cred,
> > > > > &blob_sizes.lbs_cred);
> > > > > +	lsm_set_size(&needed->lbs_file,
> > > > > &blob_sizes.lbs_file);
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * lsm_file_alloc - allocate a composite file blob
> > > > > + * @file: the file that needs a blob
> > > > > + *
> > > > > + * Allocate the file blob for all the modules
> > > > > + *
> > > > > + * Returns 0, or -ENOMEM if memory can't be allocated.
> > > > > + */
> > > > > +int lsm_file_alloc(struct file *file)
> > > > > +{
> > > > > +	if (!lsm_file_cache)
> > > > > +		return 0;
> > > > > +
> > > > > +	file->f_security = kmem_cache_zalloc(lsm_file_cache,
> > > > > GFP_KERNEL);
> > > > > +	if (file->f_security == NULL)
> > > > > +		return -ENOMEM;
> > > > > +	return 0;
> > > > > ?}
> > > > > ?
> > > > > ?/*
> > > > > @@ -952,12 +982,25 @@ int security_file_permission(struct
> > > > > file *file,
> > > > > int mask)
> > > > > ?
> > > > > ?int security_file_alloc(struct file *file)
> > > > > ?{
> > > > > +	int rc = lsm_file_alloc(file);
> > > > > +
> > > > > +	if (rc)
> > > > > +		return rc;
> > > > > ?	return call_int_hook(file_alloc_security, 0, file);
> > > > 
> > > > Suppose that a module's file_alloc_security() hook returns an
> > > > error.?
> > > > What should happen to the blob allocated by lsm_file_alloc()?
> > > > In
> > > > general, callers assumes that security_file_alloc() handles
> > > > cleanup
> > > > internally if it returns an error and do not call
> > > > security_file_free();
> > > > this is also true of other similar alloc hooks I believe.
> > > > ?Further, if
> > > > we allow the module file_alloc_security() hooks to perform any
> > > > allocation themselves, then we have a similar problem with
> > > > regard to
> > > > cleanup if any one of them fails; to be fully safe, we'd need
> > > > to call
> > > > the file_free_security() hook on the ones that had previously
> > > > returned
> > > > success. Either we need to handle such errors within
> > > > security_file_alloc(), or we need to dispense with the ability
> > > > to
> > > > allocate and return an error code from the module's
> > > > file_alloc_security(), i.e. make them return void, and probably
> > > > rename
> > > > them to file_init_security() or similar.
> > > 
> > > I like the idea of changing file_alloc_security() to
> > > file_init_security()
> > > or maybe file_setup_security() and making the hook a void
> > > function. If a
> > > module wants to allocate space on its own it will need to deal
> > > with the
> > > fact that it may have been unable to do so. I hesitate to
> > > prohibit modules
> > > from allocating their own space because someone is going to want
> > > to have a
> > > list of attributes. Trying to manage memory that you don't know
> > > about is
> > > a loosing proposition.
> > > 
> > 
> > Changing it to a void is just going to lead to LSMs that handle
> > this them
> > selves having to deny every access of the object, because that is
> > the only
> > sane thing they can do if the data they need isn't present.
> 
> It's also not going to work for the IPC cases where SELinux is
> doing access checks in the alloc functions. I sure wasn't expecting
> that. But the reality is that no security module does additional
> allocation, and I don't see any initialization that requires cleanup.
> Life will be a whole lot simpler if we keep it that way.
> 
> Or, we can have a post_file_alloc_security() hook which takes a
> boolean
> that tells the function to complete or delete the action. The boolean
> would be set depending on whether security_file_alloc() succeeded or
> failed. It would be called in security_file_alloc() after the
> file_alloc_security() functions. Hm. That would keep it contained and
> mean that only modules that do their own management would have to
> have
> a hook. Brilliant! Messy, but workable. And best of all, nothing
> needs
> to be done until we have a module that needs it.
> 
> > It far better to have the one failure upfront than having an LSM
> > rejecting
> > every access to the object after the fact. And looking down the
> > road to
> > namespacing for containers I don't see away to handle some of the
> > things
> > that will be needed without an LSM doing allocations and managing
> > stuff
> > internally, but thats an argument for a different patch series.
> 
> OK, I'll buy that. Let's plan for post_file_alloc entries when the
> need
> arises, and leave the code the way it is for now.?

At a minimum, you need to change the code to free the lsm blob if any
of the hook calls fail; otherwise, you'll leak memory.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
