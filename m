Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31B2331ED2
	for <linux-security-module@vger.kernel.org>; Thu,  9 Jul 2026 03:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783567342; cv=none; b=hkEaa7FUevN0VhL9FmD/qNVdJlSxZMdGZzheWkmjWbNPTxAQlTCyse4/Tfn173iorBq4HkDm1p28e5cxVnYOtYH9TpApU7zIE1Annp9+cNomHwQiDoPTfI5Tm2LytbJzdP1GmMV/TvTG2eguGztuoABQMaUHATh8023YE/nmowA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783567342; c=relaxed/simple;
	bh=ApWLrt3ItscwYdkqzNUs0xXhwY2Jfqh1s1l/ANzi+q8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=EyJR6IqSSjCGsYPKA4UikIj6VgBd1x1tiVnI4G+nRKRBSg0u5UKDTtBD7GvmDdF/pRAfd+dMOXeqhcT50vjgq1aE3aHH09Ivln7rRLMK3ymj1tiR1XWDDj+YEFA1UyRdRn2eWqRAapq7MsAeRL1risuaCU5yYsfep+3j6PWisiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XlC1/7dy; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XlC1/7dy"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c1805b8a7so13333841cf.3
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jul 2026 20:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783567340; x=1784172140; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kAbs0EahdnJaXnlyAWxuTPKuZ/aNyK//eRMWFG0Hz/g=;
        b=XlC1/7dyJw2jiEiaqKML1Ur5KeD1Py7A86cJUfSIOM6xWutBcRUDf+z/rHf5T5BdnQ
         7LpPGTav2WZGDcxFBQogaxcO5xZJcXJFlej+Q/j9Um1ioIeE92CtGIiyFsKdfwlzVf3M
         LhaOWUbI7cuW1pz9bBJoCZ7j8aoxUUz5fhmLTlgSvB+JjtZHFsoPo+43wtWd4yw82HMp
         txiAAp8r6cl8gNdZiyKnyklHo9IYNlH82PpGwjbhFZOOvE8lFssxAD27N0Ezio3oB4Xs
         5+EgCVdBQG94di2hbL1B6/TFqJA3KDaF6LYev/9cq/LoPvkb1lmGfqr5Eb5FT2VVfrJs
         av+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783567340; x=1784172140;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kAbs0EahdnJaXnlyAWxuTPKuZ/aNyK//eRMWFG0Hz/g=;
        b=MRbm4y+TIh2l3EB0r3/0YzXdcMfwS8P9hbKhSsESnsJz1Uk/vhoQJ/QjvvxsylhYpi
         NP5w7iA6nhC5RYIZobUuAbXoSwusL01iXXJJ0ZHCSR8IM46OkL/GcsvW/7g7P7JketPY
         ldesmz4d+00a5z1UDZYyqDco23qcuc3XpyHFxLw2R8JOWpJdyu4YIkAihYdSlBvOX3Uk
         txWfAzVZYJ4R8/tGMAd5Uj8CW6qJeByCaj2cAZCmkWgK20sb8xBg6Sq2slP4IbbkLVK7
         lP0IPVtiRXu72bWAwWSOpQ1uL+4u3eBae/zHynRX6+Tb7VGQxS+n3wb2GFaQUm1Z26gz
         ojsA==
X-Forwarded-Encrypted: i=1; AHgh+RragBrCNXx19UfZSbZ1NajvU0MUlvwUMboG59T68moZy+h7S5kY6PPAY9h/GlR4IZAl79HYLJr0HSD83FqL9OqqXZ5dMCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDSXtuOSIRZ6mnsgPiTrEaAWy+ZQb0i31j3gC1zppr9O5U6efP
	aCemZi3wUK8AUPg7BsA1K9NMMkvIKndjKDCk2pE1gTNgnpq5gC46eGnntgKq5I0p9Q==
X-Gm-Gg: AfdE7cnB+B88pxU4oFBnaiaq5ERbpcZImbQ15ILSYF3KE5bzmH5iWPR/1e2NBWcgI31
	f4yC30T/ObCx+BFUamxTI9qfGeJnViqigDx1U7697DGDi8CgyVS2y3EPctLDtcbtDNqfu7h++aC
	Wx+QRQwjs4omI9UroVdjIIoCcEGzzvvlhR9NVBYmUB6RtO8w+7Iq9VuLugD2pVjHaeESfCMPjAi
	iD9EMq6sIKpxKUKxjjau3J3kAW4GFmJdj0oh1bBbgr3ceLrNSHTFsfUDX8rCUlTrKeI4XKWvWNT
	eoBcwh884LHpZ1WPDqLxzX5aI0Tw8x7FttPheB3fPJjueH99bCLAZhKUPB25d/zMlz+g1SEtDDl
	tePKC/kBNzsEAXgYAqpJQqvV/vZ+nsojsCULT6XksouCCSfteSd6CoYdOwxOyrJkkuabCvpHHBs
	ZiJyjJTalrjsahWuWMNSq8IxqJil2QPaE2wsrTEzlJcjedauLEQ1VfIU/Z1w==
X-Received: by 2002:ac8:5989:0:b0:51c:83ee:e43e with SMTP id d75a77b69052e-51c8b422024mr71720241cf.75.1783567339597;
        Wed, 08 Jul 2026 20:22:19 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c9b0d4519sm5544311cf.10.2026.07.08.20.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 20:22:18 -0700 (PDT)
Date: Wed, 08 Jul 2026 23:22:17 -0400
Message-ID: <3d4fe99cd1665a1be0b36636aeeaf4ab@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260708_2258/pstg-lib:20260708_1328/pstg-pwork:20260708_2258
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Christian Brauner <brauner@kernel.org>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: Daniel Durning <danieldurning.work@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Justin Suess <utilityemal77@gmail.com>, Lennart Poettering <lennart@poettering.net>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/9] security: add LSM blob and hooks for namespaces
References: <20260527181127.879771-2-mic@digikod.net>
In-Reply-To: <20260527181127.879771-2-mic@digikod.net>

On May 27, 2026 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> All namespace types now share the same ns_common infrastructure. Extend
> this to include a security blob so LSMs can start managing namespaces
> uniformly without having to add one-off hooks or security fields to
> every individual namespace type.
> 
> Add a ns_security pointer to ns_common and the corresponding lbs_ns blob
> size to lsm_blob_sizes. Allocation and freeing hooks are called from the
> common __ns_common_init() and __ns_common_free() paths so every
> namespace type gets covered in one go. All information about the
> namespace type and the appropriate casting helpers to get at the
> containing namespace are available via ns_common making it
> straightforward for LSMs to differentiate when they need to.
> 
> A namespace_install hook is called from validate_ns() during setns(2)
> giving LSMs a chance to enforce policy on namespace transitions.  The
> LSM check runs before ns->ops->install() so the security module can deny
> the operation before any type-specific installation effects.
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
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> Changes since v1:
> https://lore.kernel.org/r/20260312100444.2609563-2-mic@digikod.net
> - Move security_namespace_install() before ns->ops->install() in
>   validate_ns() (suggested by Christian Brauner).
> - Only call proc_free_inum() on security_namespace_alloc() failure
>   when inum was allocated by this function (suggested by Christian
>   Brauner).
> - Fix anonymous mount namespace blob leak: move
>   security_namespace_free() into __ns_common_free() and make
>   proc_free_inum() conditional on dynamically allocated inums
>   via MNT_NS_INO_SPECIAL_MAX, so free_mnt_ns() can call
>   ns_common_free() unconditionally (suggested by Christian
>   Brauner).  Also reported by Daniel Durning while working on
>   SELinux support for these hooks:
>   https://lore.kernel.org/r/20260318201747.4477-1-danieldurning.work@gmail.com
> - Rename security_namespace_alloc() to security_namespace_init()
>   to match the caller-name convention and reflect that the hook
>   initialises LSM state attached to a constructed ns_common rather
>   than allocating the ns_common itself (suggested by Paul Moore).
> - Refine the security_namespace_free() kdoc to clarify that
>   RCU-safe blob freeing is required only if an LSM exposes data
>   within the blob to concurrent RCU readers, and document that
>   the blob memory itself is released with kfree() after the
>   namespace_free hooks return (suggested by Paul Moore).
> - Günther Noack's v1 Reviewed-by is not carried forward to v2:
>   the validate_ns() reordering and the anonymous-mount-namespace
>   blob-leak fix are semantic changes that were not part of his
>   review.  Cc'd instead.
> ---
>  fs/namespace.c                     |  3 +-
>  include/linux/lsm_hook_defs.h      |  3 ++
>  include/linux/lsm_hooks.h          |  1 +
>  include/linux/ns/ns_common_types.h |  3 ++
>  include/linux/security.h           | 20 ++++++++
>  include/uapi/linux/nsfs.h          |  1 +
>  kernel/nscommon.c                  | 17 ++++++-
>  kernel/nsproxy.c                   |  6 +++
>  security/lsm_init.c                |  2 +
>  security/security.c                | 77 ++++++++++++++++++++++++++++++
>  10 files changed, 130 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index fe919abd2f01..031ef3fafa48 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4179,8 +4179,7 @@ static void dec_mnt_namespaces(struct ucounts *ucounts)
>  
>  static void free_mnt_ns(struct mnt_namespace *ns)
>  {
> -	if (!is_anon_ns(ns))
> -		ns_common_free(ns);
> +	ns_common_free(ns);
>  	dec_mnt_namespaces(ns->ucounts);
>  	mnt_ns_tree_remove(ns);
>  }

...

> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> index 3166c1fd844a..e72426bba29a 100644
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
> @@ -77,6 +81,14 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
>  		ret = proc_alloc_inum(&ns->inum);
>  	if (ret)
>  		return ret;
> +
> +	ret = security_namespace_init(ns);
> +	if (ret) {
> +		if (!inum)
> +			proc_free_inum(ns->inum);
> +		return ret;
> +	}
> +
>  	/*
>  	 * Tree ref starts at 0. It's incremented when namespace enters
>  	 * active use (installed in nsproxy) and decremented when all
> @@ -91,7 +103,10 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
>  
>  void __ns_common_free(struct ns_common *ns)
>  {
> -	proc_free_inum(ns->inum);
> +	security_namespace_free(ns);
> +
> +	if (ns->inum > MNT_NS_INO_SPECIAL_MAX)
> +		proc_free_inum(ns->inum);

The ns->inum check in the if-conditional above isn't quite the same as
the is_anon_ns() check it replaces in free_mnt_ns().  You touch on this
a bit in the changelog, but that really should be explained in the
commit description.

... or honestly, should that change be a separate patch?

>  }
>  
>  struct ns_common *__must_check ns_owner(struct ns_common *ns)
> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> index d9d3d5973bf5..0f1b208d8eef 100644
> --- a/kernel/nsproxy.c
> +++ b/kernel/nsproxy.c
> @@ -385,6 +385,12 @@ static int prepare_nsset(unsigned flags, struct nsset *nsset)
>  
>  static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
>  {
> +	int ret;
> +
> +	ret = security_namespace_install(nsset, ns);
> +	if (ret)
> +		return ret;
> +
>  	return ns->ops->install(nsset, ns);
>  }

In the previous revision to the patchset I asked about a
security_namespace_switch() hook as we don't know if a namespace is
actually attached to a process until we get to switch_task_namespaces().
Perhaps that was answered, but I don't recall reading any mail about that
and I'm not able to uncover any responses on lore.

> diff --git a/security/security.c b/security/security.c
> index 4e999f023651..21cc45d4bbd0 100644
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
> @@ -381,6 +382,19 @@ static int lsm_superblock_alloc(struct super_block *sb)
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
> @@ -3358,6 +3372,69 @@ int security_create_user_ns(const struct cred *cred)
>  	return call_int_hook(userns_create, cred);
>  }
>  
> +/**
> + * security_namespace_init() - Initialize LSM security data for a namespace
> + * @ns: the namespace being initialized
> + *
> + * Initialize the LSM security blob attached to the namespace. The namespace type
> + * is available via ns->ns_type, and the owning user namespace (if any)
> + * via ns->ops->owner(ns).
> + *
> + * Return: Returns 0 if successful, otherwise < 0 error code.
> + */
> +int security_namespace_init(struct ns_common *ns)
> +{
> +	int rc;
> +
> +	rc = lsm_ns_alloc(ns);
> +	if (unlikely(rc))
> +		return rc;
> +
> +	rc = call_int_hook(namespace_init, ns);
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
> + * Note: If an LSM exposes data within the security blob to concurrent
> + * RCU readers, it must use RCU-safe freeing for that data.  The blob
> + * memory itself is released with kfree() after the namespace_free
> + * hooks return.

I appreciate that you revised the "Note:" based on my previous comments,
but now it reads just like normal guidance on RCU and object lifetimes.
Do we need this "Note:" at all?

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
> 2.54.0

--
paul-moore.com
