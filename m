Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E31328B7A
	for <linux-security-module@vger.kernel.org>; Wed, 22 Apr 2026 21:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776892882; cv=none; b=byaqQvJ3lQE6pb34GntrLgeer+efFTL1GOL+n/aJmcBthDhRsQvTTBKHyVbB9vx/brl4SxngeMEDn/NuFtI27kr9lXuzS6PuOEziz9M2ySquwE2DIJTpB/d/nEVClzfHXb2cobGtVV0CfQSHWmprd9asLVb5o8e8mWA94kEB75k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776892882; c=relaxed/simple;
	bh=r86yNoOlt6BZyF0XkxhlWCyN64IsU9je1cK+91LtuCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9qM6Yd8GU11AuX0KFA9LB0KuI0Cgif1wPddeywLTR/wJnEo2CMqsHu1T7kbaKDdySghvjT3sjsNUaYGjVjzy38HnHSsqYeGvQdm9KGrS4QprygDmXYad5uQAxju/3UUw+baWlW6CHUuOc1ACsC/kcwf/D8ZaEguYzsSEjpssYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOmQ8ExX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOmQ8ExX"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d7213b6ebso3908664f8f.3
        for <linux-security-module@vger.kernel.org>; Wed, 22 Apr 2026 14:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776892879; x=1777497679; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=az+5z1Ny2ESjbQT0bubQkyHk5FTmA2Ked5mKU6eBTLk=;
        b=EOmQ8ExXmBOAh4RPzfk+XbXUW77DUVU/f5ftiDbVnn+MoO8MQcCsjZRGsIRc3yqj0D
         UJ1fOpz+McXdV3wnuyHYZ/oQAyVExA9Ov+gXxSHMktxe0C0x8SOimVRQ7OEAWcpjkoeO
         gaU5A/rRONJiODqahI8ZCk0qoW4NDLXkrc5S9lZuPxFMzkRCI4hqLOJfP21WHecpWdV0
         Q3fklSbEAetxO9F5XUUNfO+xZ3hagcsxAUzoc31Eatp1VIWKd8iatSrDQwdFveX1i2eo
         mLjNsO0N36N+qu+9OlzApOTnhjHE/3u/mg5iokhcrYG+cyI4BRLd+w8ow0SSOnu0GBQv
         XU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776892879; x=1777497679;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=az+5z1Ny2ESjbQT0bubQkyHk5FTmA2Ked5mKU6eBTLk=;
        b=N4PNIDqiSjcta9Aara/oLhnzFWQiSugRO1EdzBauimyuJKYQ9Yi29fF9T15F5LkR65
         Tdt9AWba19WZHz2pMc4Vu0kUBXzfta/5ins+8zGpqaw3i9qfarnc1LkzrOKsQMlkdQzY
         h+kL412d9KYKXu8Dk5VtQJFQhfpeCBM02FNrlh+nO/6aMTtXnKfWbLSgRb1ajdza2f9n
         ImeHoWzP2b7Q7XSz6v5Q5lq8jYS2Yqy5tBCQ4InYoZYQJKVxl6XQR6wF3Q3Cosvb8BKQ
         w4xYqg42GiU0sSKS+lK+m9YST1a/+zMWDURcqF0qzm7A8tFUMz87uhSVXpmMe9eb3sfI
         0fhQ==
X-Forwarded-Encrypted: i=1; AFNElJ80So43YLFNuRtXnZit9Qi2T/FHltlq7cmw0YPqpzUq/5eKJj+Hxd1h0S9DRvgrxKgu1DoRtArOKKF2w1Wqxn8/VWcd49k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdSYWbLZEOgcKqnvJB3M5fqRFWhAuMNSYgQqUelIIXGBwXOiVU
	qtJn7UbAkLt2axObv+QQx1+h1TYAJuCqPccaNRqWzqWrgklUUCGpLVmb
X-Gm-Gg: AeBDiet/XcKFbvY1SvDnjXPQESlbaLzIxXADFXuqiKRTkptqjZzfEYQnc1pVT4qxgsn
	DhfU8xKJ5dUxxwEHlS/GrjBU4VSBy3ckXZC5LV5nsnAJ7QFNeIUa8yNEfE7mC9pr2OA8K177wWF
	PeIOPQxN3WvCMuYIekCctl5KYXcfWjA6KUyX4dqGGQy/VZmd/qwj3SGaB/L7tFOyEuf/7M/Cm2L
	HMxDmDTlrWRPL0mE9t7skPdPRlCMj0p84e6Ek7xjW7tmD/LPJuxUXjOADriDKWUbfH/hGj8LGJY
	OdWbH50zShNhOpyB8xWO6oSQMx6hBI/54Mq5Mx7plCzR/dFBwDSqJIIspDS1lY6OUxzudsnbwpP
	f2T0VXSQjBM7fOB2AvpDAJNGj+ciMhXrU3csbTe6AmO+EuWTDRjTpJkOzXWT5kECW6YtabMzvRO
	BzA6pPs8/K1SMdCvTIoRoFOZozx6fEd80xhiLaPSMI63sDIE+hOFJvJjRBiXQzibEi9w9Ebw==
X-Received: by 2002:a05:6000:2c0c:b0:43e:a70d:763c with SMTP id ffacd0b85a97d-43fe3e1e0ccmr33731127f8f.42.1776892878755;
        Wed, 22 Apr 2026 14:21:18 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d5b1sm52064249f8f.30.2026.04.22.14.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 14:21:18 -0700 (PDT)
Date: Wed, 22 Apr 2026 23:21:17 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 01/11] security: add LSM blob and hooks for
 namespaces
Message-ID: <20260422.ed4f7fcdd9f3@gnoack.org>
References: <20260312100444.2609563-1-mic@digikod.net>
 <20260312100444.2609563-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260312100444.2609563-2-mic@digikod.net>

On Thu, Mar 12, 2026 at 11:04:34AM +0100, Mickaël Salaün wrote:
> From: Christian Brauner <brauner@kernel.org>
> 
> All namespace types now share the same ns_common infrastructure. Extend
> this to include a security blob so LSMs can start managing namespaces
> uniformly without having to add one-off hooks or security fields to
> every individual namespace type.
> 
> Add a ns_security pointer to ns_common and the corresponding lbs_ns
> blob size to lsm_blob_sizes. Allocation and freeing hooks are called
> from the common __ns_common_init() and __ns_common_free() paths so
> every namespace type gets covered in one go. All information about the
> namespace type and the appropriate casting helpers to get at the
> containing namespace are available via ns_common making it
> straightforward for LSMs to differentiate when they need to.
> 
> A namespace_install hook is called from validate_ns() during setns(2)
> giving LSMs a chance to enforce policy on namespace transitions.
> 
> Individual namespace types can still have their own specialized security
> hooks when needed. This is just the common baseline that makes it easy
> to track and manage namespaces from the security side without requiring
> every namespace type to reinvent the wheel.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Link: https://lore.kernel.org/r/20260216-work-security-namespace-v1-1-075c28758e1f@kernel.org
> ---
>  include/linux/lsm_hook_defs.h      |  3 ++
>  include/linux/lsm_hooks.h          |  1 +
>  include/linux/ns/ns_common_types.h |  3 ++
>  include/linux/security.h           | 20 ++++++++
>  kernel/nscommon.c                  | 12 +++++
>  kernel/nsproxy.c                   |  8 +++-
>  security/lsm_init.c                |  2 +
>  security/security.c                | 76 ++++++++++++++++++++++++++++++
>  8 files changed, 124 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 8c42b4bde09c..fefd3aa6d8f4 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -260,6 +260,9 @@ LSM_HOOK(int, -ENOSYS, task_prctl, int option, unsigned long arg2,
>  LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
>  	 struct inode *inode)
>  LSM_HOOK(int, 0, userns_create, const struct cred *cred)
> +LSM_HOOK(int, 0, namespace_alloc, struct ns_common *ns)
> +LSM_HOOK(void, LSM_RET_VOID, namespace_free, struct ns_common *ns)
> +LSM_HOOK(int, 0, namespace_install, const struct nsset *nsset, struct ns_common *ns)
>  LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
>  LSM_HOOK(void, LSM_RET_VOID, ipc_getlsmprop, struct kern_ipc_perm *ipcp,
>  	 struct lsm_prop *prop)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index d48bf0ad26f4..3e7afe76e86c 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -111,6 +111,7 @@ struct lsm_blob_sizes {
>  	unsigned int lbs_ipc;
>  	unsigned int lbs_key;
>  	unsigned int lbs_msg_msg;
> +	unsigned int lbs_ns;
>  	unsigned int lbs_perf_event;
>  	unsigned int lbs_task;
>  	unsigned int lbs_xattr_count; /* num xattr slots in new_xattrs array */
> diff --git a/include/linux/ns/ns_common_types.h b/include/linux/ns/ns_common_types.h
> index 0014fbc1c626..170288e2e895 100644
> --- a/include/linux/ns/ns_common_types.h
> +++ b/include/linux/ns/ns_common_types.h
> @@ -115,6 +115,9 @@ struct ns_common {
>  	struct dentry *stashed;
>  	const struct proc_ns_operations *ops;
>  	unsigned int inum;
> +#ifdef CONFIG_SECURITY
> +	void *ns_security;
> +#endif
>  	union {
>  		struct ns_tree;
>  		struct rcu_head ns_rcu;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 83a646d72f6f..611b9098367d 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -67,6 +67,7 @@ enum fs_value_type;
>  struct watch;
>  struct watch_notification;
>  struct lsm_ctx;
> +struct nsset;
>  
>  /* Default (no) options for the capable function */
>  #define CAP_OPT_NONE 0x0
> @@ -80,6 +81,7 @@ struct lsm_ctx;
>  
>  struct ctl_table;
>  struct audit_krule;
> +struct ns_common;
>  struct user_namespace;
>  struct timezone;
>  
> @@ -533,6 +535,9 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  			unsigned long arg4, unsigned long arg5);
>  void security_task_to_inode(struct task_struct *p, struct inode *inode);
>  int security_create_user_ns(const struct cred *cred);
> +int security_namespace_alloc(struct ns_common *ns);
> +void security_namespace_free(struct ns_common *ns);
> +int security_namespace_install(const struct nsset *nsset, struct ns_common *ns);
>  int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
>  void security_ipc_getlsmprop(struct kern_ipc_perm *ipcp, struct lsm_prop *prop);
>  int security_msg_msg_alloc(struct msg_msg *msg);
> @@ -1407,6 +1412,21 @@ static inline int security_create_user_ns(const struct cred *cred)
>  	return 0;
>  }
>  
> +static inline int security_namespace_alloc(struct ns_common *ns)
> +{
> +	return 0;
> +}
> +
> +static inline void security_namespace_free(struct ns_common *ns)
> +{
> +}
> +
> +static inline int security_namespace_install(const struct nsset *nsset,
> +					     struct ns_common *ns)
> +{
> +	return 0;
> +}
> +
>  static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
>  					  short flag)
>  {
> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> index bdc3c86231d3..de774e374f9d 100644
> --- a/kernel/nscommon.c
> +++ b/kernel/nscommon.c
> @@ -4,6 +4,7 @@
>  #include <linux/ns_common.h>
>  #include <linux/nstree.h>
>  #include <linux/proc_ns.h>
> +#include <linux/security.h>
>  #include <linux/user_namespace.h>
>  #include <linux/vfsdebug.h>
>  
> @@ -59,6 +60,9 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
>  
>  	refcount_set(&ns->__ns_ref, 1);
>  	ns->stashed = NULL;
> +#ifdef CONFIG_SECURITY
> +	ns->ns_security = NULL;
> +#endif
>  	ns->ops = ops;
>  	ns->ns_id = 0;
>  	ns->ns_type = ns_type;
> @@ -77,6 +81,13 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
>  		ret = proc_alloc_inum(&ns->inum);
>  	if (ret)
>  		return ret;
> +
> +	ret = security_namespace_alloc(ns);
> +	if (ret) {
> +		proc_free_inum(ns->inum);
> +		return ret;
> +	}
> +
>  	/*
>  	 * Tree ref starts at 0. It's incremented when namespace enters
>  	 * active use (installed in nsproxy) and decremented when all
> @@ -91,6 +102,7 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
>  
>  void __ns_common_free(struct ns_common *ns)
>  {
> +	security_namespace_free(ns);
>  	proc_free_inum(ns->inum);
>  }
>  
> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> index 259c4b4f1eeb..f0b30d1907e7 100644
> --- a/kernel/nsproxy.c
> +++ b/kernel/nsproxy.c
> @@ -379,7 +379,13 @@ static int prepare_nsset(unsigned flags, struct nsset *nsset)
>  
>  static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
>  {
> -	return ns->ops->install(nsset, ns);
> +	int ret;
> +
> +	ret = ns->ops->install(nsset, ns);
> +	if (ret)
> +		return ret;
> +
> +	return security_namespace_install(nsset, ns);
>  }
>  
>  /*
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 573e2a7250c4..637c2d65e131 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -301,6 +301,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
>  	lsm_blob_size_update(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
>  	lsm_blob_size_update(&blobs->lbs_key, &blob_sizes.lbs_key);
>  	lsm_blob_size_update(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> +	lsm_blob_size_update(&blobs->lbs_ns, &blob_sizes.lbs_ns);
>  	lsm_blob_size_update(&blobs->lbs_perf_event,
>  			     &blob_sizes.lbs_perf_event);
>  	lsm_blob_size_update(&blobs->lbs_sock, &blob_sizes.lbs_sock);
> @@ -446,6 +447,7 @@ int __init security_init(void)
>  		lsm_pr("blob(ipc) size %d\n", blob_sizes.lbs_ipc);
>  		lsm_pr("blob(key) size %d\n", blob_sizes.lbs_key);
>  		lsm_pr("blob(msg_msg)_size %d\n", blob_sizes.lbs_msg_msg);
> +		lsm_pr("blob(ns) size %d\n", blob_sizes.lbs_ns);
>  		lsm_pr("blob(sock) size %d\n", blob_sizes.lbs_sock);
>  		lsm_pr("blob(superblock) size %d\n", blob_sizes.lbs_superblock);
>  		lsm_pr("blob(perf_event) size %d\n", blob_sizes.lbs_perf_event);
> diff --git a/security/security.c b/security/security.c
> index 67af9228c4e9..dcf073cac848 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -26,6 +26,7 @@
>  #include <linux/string.h>
>  #include <linux/xattr.h>
>  #include <linux/msg.h>
> +#include <linux/ns_common.h>
>  #include <linux/overflow.h>
>  #include <linux/perf_event.h>
>  #include <linux/fs.h>
> @@ -355,6 +356,19 @@ static int lsm_superblock_alloc(struct super_block *sb)
>  			      GFP_KERNEL);
>  }
>  
> +/**
> + * lsm_ns_alloc - allocate a composite namespace blob
> + * @ns: the namespace that needs a blob
> + *
> + * Allocate the namespace blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +static int lsm_ns_alloc(struct ns_common *ns)
> +{
> +	return lsm_blob_alloc(&ns->ns_security, blob_sizes.lbs_ns, GFP_KERNEL);
> +}
> +
>  /**
>   * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
>   * @uctx: a userspace LSM context to be filled
> @@ -3255,6 +3269,68 @@ int security_create_user_ns(const struct cred *cred)
>  	return call_int_hook(userns_create, cred);
>  }
>  
> +/**
> + * security_namespace_alloc() - Allocate LSM security data for a namespace
> + * @ns: the namespace being allocated
> + *
> + * Allocate and attach security data to the namespace. The namespace type
> + * is available via ns->ns_type, and the owning user namespace (if any)
> + * via ns->ops->owner(ns).
> + *
> + * Return: Returns 0 if successful, otherwise < 0 error code.
> + */
> +int security_namespace_alloc(struct ns_common *ns)
> +{
> +	int rc;
> +
> +	rc = lsm_ns_alloc(ns);
> +	if (unlikely(rc))
> +		return rc;
> +
> +	rc = call_int_hook(namespace_alloc, ns);
> +	if (unlikely(rc))
> +		security_namespace_free(ns);
> +
> +	return rc;
> +}
> +
> +/**
> + * security_namespace_free() - Release LSM security data from a namespace
> + * @ns: the namespace being freed
> + *
> + * Release security data attached to the namespace. Called before the
> + * namespace structure is freed.
> + *
> + * Note: The namespace may be freed via kfree_rcu(). LSMs must use
> + * RCU-safe freeing for any data that might be accessed by concurrent
> + * RCU readers.
> + */
> +void security_namespace_free(struct ns_common *ns)
> +{
> +	if (!ns->ns_security)
> +		return;
> +
> +	call_void_hook(namespace_free, ns);
> +
> +	kfree(ns->ns_security);
> +	ns->ns_security = NULL;
> +}
> +
> +/**
> + * security_namespace_install() - Check permission to install a namespace
> + * @nsset: the target nsset being configured
> + * @ns: the namespace being installed
> + *
> + * Check permission before allowing a namespace to be installed into the
> + * process's set of namespaces via setns(2).
> + *
> + * Return: Returns 0 if permission is granted, otherwise < 0 error code.
> + */
> +int security_namespace_install(const struct nsset *nsset, struct ns_common *ns)
> +{
> +	return call_int_hook(namespace_install, nsset, ns);
> +}
> +
>  /**
>   * security_ipc_permission() - Check if sysv ipc access is allowed
>   * @ipcp: ipc permission structure
> -- 
> 2.53.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>
