Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CC42FDC57
	for <linux-security-module@vger.kernel.org>; Thu,  9 Apr 2026 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775752820; cv=none; b=sBfb8RsrYwK/USY/UMfULCRBjqKC1wKViV5SBWdmNnOK8/F01RXWfc7mJbTc7pcHvEtUQyKUAhThW7Ed2IIoN6CqIUfVdBae8AQ5RxiA+I55urUarmfJGL+xjDkIPGsarfL5cy03UGj5q+zRTBKXWv2o7koa0oamm5x2bjkrlP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775752820; c=relaxed/simple;
	bh=w8RWqMIPM9dHKurNWL/EV36P5jVrHJ45BQDjK03ucxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1RBc2XG83j4pykQbf10a2DUJGRBeVPgaI7SCRc5gGFirYGuj//j2kx4vynDAYqeoiLs6zlp94HrIp0cswyuxqNPhx0uxCBtnJ6Ccff/gqKNYdDRHSQhf0MzxUWbAOOH/6Ufp1nVjCEz9GRnPsuuTHN3lzf3yJFFMdiHPPlSPgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=l6klxyko; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="l6klxyko"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fs5JS3Ld4z7ct;
	Thu,  9 Apr 2026 18:40:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775752808;
	bh=Oeswz4s2QGqXLtf96J6c7pMhOlBQo2ulYnDM2Ex2I7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l6klxykodXS7PAmGnOrmN20zixZJOyFizvKpZuwZK5bZjYEXd6xZ+WImR6ieZjM0A
	 kR32E1jh7Nv9BYeOKKuzSwkeSKz9WQlmuByl9G4+vowVkdbIfu2YSxP39EZdb/e4Vy
	 ETStdXlrIQl2XL6A15pgM0xCse2bnk4tHVomTH0Y=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fs5JR0T5szdll;
	Thu,  9 Apr 2026 18:40:07 +0200 (CEST)
Date: Thu, 9 Apr 2026 18:40:03 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Justin Suess <utilityemal77@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Daniel Durning <danieldurning.work@gmail.com>
Subject: Re: [RFC PATCH v1 01/11] security: add LSM blob and hooks for
 namespaces
Message-ID: <20260409.Mei6Yei0beeZ@digikod.net>
References: <20260312100444.2609563-1-mic@digikod.net>
 <20260312100444.2609563-2-mic@digikod.net>
 <20260325-filmverleih-auffressen-e897fcf8d3f2@brauner>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325-filmverleih-auffressen-e897fcf8d3f2@brauner>
X-Infomaniak-Routing: alpha

On Wed, Mar 25, 2026 at 01:31:30PM +0100, Christian Brauner wrote:
> On Thu, Mar 12, 2026 at 11:04:34AM +0100, Mickaël Salaün wrote:
> > From: Christian Brauner <brauner@kernel.org>
> > 
> > All namespace types now share the same ns_common infrastructure. Extend
> > this to include a security blob so LSMs can start managing namespaces
> > uniformly without having to add one-off hooks or security fields to
> > every individual namespace type.
> > 
> > Add a ns_security pointer to ns_common and the corresponding lbs_ns
> > blob size to lsm_blob_sizes. Allocation and freeing hooks are called
> > from the common __ns_common_init() and __ns_common_free() paths so
> > every namespace type gets covered in one go. All information about the
> > namespace type and the appropriate casting helpers to get at the
> > containing namespace are available via ns_common making it
> > straightforward for LSMs to differentiate when they need to.
> > 
> > A namespace_install hook is called from validate_ns() during setns(2)
> > giving LSMs a chance to enforce policy on namespace transitions.
> > 
> > Individual namespace types can still have their own specialized security
> > hooks when needed. This is just the common baseline that makes it easy
> > to track and manage namespaces from the security side without requiring
> > every namespace type to reinvent the wheel.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Serge E. Hallyn <serge@hallyn.com>
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > Link: https://lore.kernel.org/r/20260216-work-security-namespace-v1-1-075c28758e1f@kernel.org
> > ---
> >  include/linux/lsm_hook_defs.h      |  3 ++
> >  include/linux/lsm_hooks.h          |  1 +
> >  include/linux/ns/ns_common_types.h |  3 ++
> >  include/linux/security.h           | 20 ++++++++
> >  kernel/nscommon.c                  | 12 +++++
> >  kernel/nsproxy.c                   |  8 +++-
> >  security/lsm_init.c                |  2 +
> >  security/security.c                | 76 ++++++++++++++++++++++++++++++
> >  8 files changed, 124 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index 8c42b4bde09c..fefd3aa6d8f4 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -260,6 +260,9 @@ LSM_HOOK(int, -ENOSYS, task_prctl, int option, unsigned long arg2,
> >  LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
> >  	 struct inode *inode)
> >  LSM_HOOK(int, 0, userns_create, const struct cred *cred)
> > +LSM_HOOK(int, 0, namespace_alloc, struct ns_common *ns)
> > +LSM_HOOK(void, LSM_RET_VOID, namespace_free, struct ns_common *ns)
> > +LSM_HOOK(int, 0, namespace_install, const struct nsset *nsset, struct ns_common *ns)
> >  LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
> >  LSM_HOOK(void, LSM_RET_VOID, ipc_getlsmprop, struct kern_ipc_perm *ipcp,
> >  	 struct lsm_prop *prop)
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index d48bf0ad26f4..3e7afe76e86c 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -111,6 +111,7 @@ struct lsm_blob_sizes {
> >  	unsigned int lbs_ipc;
> >  	unsigned int lbs_key;
> >  	unsigned int lbs_msg_msg;
> > +	unsigned int lbs_ns;
> >  	unsigned int lbs_perf_event;
> >  	unsigned int lbs_task;
> >  	unsigned int lbs_xattr_count; /* num xattr slots in new_xattrs array */
> > diff --git a/include/linux/ns/ns_common_types.h b/include/linux/ns/ns_common_types.h
> > index 0014fbc1c626..170288e2e895 100644
> > --- a/include/linux/ns/ns_common_types.h
> > +++ b/include/linux/ns/ns_common_types.h
> > @@ -115,6 +115,9 @@ struct ns_common {
> >  	struct dentry *stashed;
> >  	const struct proc_ns_operations *ops;
> >  	unsigned int inum;
> > +#ifdef CONFIG_SECURITY
> > +	void *ns_security;
> > +#endif
> >  	union {
> >  		struct ns_tree;
> >  		struct rcu_head ns_rcu;
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 83a646d72f6f..611b9098367d 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -67,6 +67,7 @@ enum fs_value_type;
> >  struct watch;
> >  struct watch_notification;
> >  struct lsm_ctx;
> > +struct nsset;
> >  
> >  /* Default (no) options for the capable function */
> >  #define CAP_OPT_NONE 0x0
> > @@ -80,6 +81,7 @@ struct lsm_ctx;
> >  
> >  struct ctl_table;
> >  struct audit_krule;
> > +struct ns_common;
> >  struct user_namespace;
> >  struct timezone;
> >  
> > @@ -533,6 +535,9 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
> >  			unsigned long arg4, unsigned long arg5);
> >  void security_task_to_inode(struct task_struct *p, struct inode *inode);
> >  int security_create_user_ns(const struct cred *cred);
> > +int security_namespace_alloc(struct ns_common *ns);
> > +void security_namespace_free(struct ns_common *ns);
> > +int security_namespace_install(const struct nsset *nsset, struct ns_common *ns);
> >  int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
> >  void security_ipc_getlsmprop(struct kern_ipc_perm *ipcp, struct lsm_prop *prop);
> >  int security_msg_msg_alloc(struct msg_msg *msg);
> > @@ -1407,6 +1412,21 @@ static inline int security_create_user_ns(const struct cred *cred)
> >  	return 0;
> >  }
> >  
> > +static inline int security_namespace_alloc(struct ns_common *ns)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline void security_namespace_free(struct ns_common *ns)
> > +{
> > +}
> > +
> > +static inline int security_namespace_install(const struct nsset *nsset,
> > +					     struct ns_common *ns)
> > +{
> > +	return 0;
> > +}
> > +
> >  static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
> >  					  short flag)
> >  {
> > diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> > index bdc3c86231d3..de774e374f9d 100644
> > --- a/kernel/nscommon.c
> > +++ b/kernel/nscommon.c
> > @@ -4,6 +4,7 @@
> >  #include <linux/ns_common.h>
> >  #include <linux/nstree.h>
> >  #include <linux/proc_ns.h>
> > +#include <linux/security.h>
> >  #include <linux/user_namespace.h>
> >  #include <linux/vfsdebug.h>
> >  
> > @@ -59,6 +60,9 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
> >  
> >  	refcount_set(&ns->__ns_ref, 1);
> >  	ns->stashed = NULL;
> > +#ifdef CONFIG_SECURITY
> > +	ns->ns_security = NULL;
> > +#endif
> >  	ns->ops = ops;
> >  	ns->ns_id = 0;
> >  	ns->ns_type = ns_type;
> > @@ -77,6 +81,13 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
> >  		ret = proc_alloc_inum(&ns->inum);
> >  	if (ret)
> >  		return ret;
> > +
> > +	ret = security_namespace_alloc(ns);
> > +	if (ret) {
> > +		proc_free_inum(ns->inum);
> 
> ret = security_namespace_alloc(ns);
> if (ret && !inum)
>         proc_free_inum(ns->inum);
> return ret;
> 
> 
> > +		return ret;
> > +	}
> > +
> >  	/*
> >  	 * Tree ref starts at 0. It's incremented when namespace enters
> >  	 * active use (installed in nsproxy) and decremented when all
> > @@ -91,6 +102,7 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
> >  
> >  void __ns_common_free(struct ns_common *ns)
> >  {
> > +	security_namespace_free(ns);
> >  	proc_free_inum(ns->inum);
> >  }
> >  
> > diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> > index 259c4b4f1eeb..f0b30d1907e7 100644
> > --- a/kernel/nsproxy.c
> > +++ b/kernel/nsproxy.c
> > @@ -379,7 +379,13 @@ static int prepare_nsset(unsigned flags, struct nsset *nsset)
> >  
> >  static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
> >  {
> > -	return ns->ops->install(nsset, ns);
> > +	int ret;
> > +
> > +	ret = ns->ops->install(nsset, ns);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return security_namespace_install(nsset, ns);
> 
> In my local tree I had that moved before the ->install() and I think
> that's the correct thing to do. So please switch to that.

Looks good, I'll include your fixes in the next version.

> 
> The rest looks good to me, thanks.

Another issue raised by Daniel Durning [1] is freeing of anonymous
namespaces.

I'll extend this patch with this new hunk if that's ok:

diff --git a/fs/namespace.c b/fs/namespace.c
index 854f4fc66469..f6977e59be7d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4186,6 +4186,8 @@ static void free_mnt_ns(struct mnt_namespace *ns)
 {
        if (!is_anon_ns(ns))
                ns_common_free(ns);
+       else
+               security_namespace_free(&ns->ns);
        dec_mnt_namespaces(ns->ucounts);
        mnt_ns_tree_remove(ns);
 }

Daniel, could you please confirm that this fixes the memory leak?

[1] https://lore.kernel.org/all/20260330193100.3603-1-danieldurning.work@gmail.com/


> > +/**
> > + * security_namespace_free() - Release LSM security data from a namespace
> > + * @ns: the namespace being freed
> > + *
> > + * Release security data attached to the namespace. Called before the
> > + * namespace structure is freed.
> > + *
> > + * Note: The namespace may be freed via kfree_rcu(). LSMs must use
> > + * RCU-safe freeing for any data that might be accessed by concurrent
> > + * RCU readers.
> > + */
> > +void security_namespace_free(struct ns_common *ns)
> > +{
> > +       if (!ns->ns_security)
> > +               return;
> > +
> > +       call_void_hook(namespace_free, ns);
> > +

> > +       kfree(ns->ns_security);
> > +       ns->ns_security = NULL;

I think it would be safer to replace these two lines with:
kfree_rcu_mightsleep(ns->ns_security)

> > +}
