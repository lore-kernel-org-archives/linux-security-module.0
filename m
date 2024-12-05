Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740A12F22;
	Thu,  5 Dec 2024 03:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733367864; cv=none; b=J0W1Dx8KN3gAM8RPV1FoakQXCTLQ+J1HAn5SBzZQhe+NS02EH0NmAMSg35KP5JETcG42H7xg2YjIiSYd81RqEjtuiFkyCNTAhvSE0zj4LFlQdtg9/MWiO8jvBrTij0+A+nhjkl7jAVR6eMuZssVb19/u8IVmUrcDdOFwqJK7Unw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733367864; c=relaxed/simple;
	bh=Sqjb9l3KmzFgthpQAVVIAFvtXmiJ79sbwKi7PSjj4mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcewdAhCQDSRBUHz5YyJzSGSiwTYsmrFmzYzpS7ATEE+fbahzcc9o/+4VnLKVF14wu3zZf3sqWnLg2FFitELV9YsbKOI5ybEephF3uZyTRPXwKhTZBldBXLwy4IS2iYz2UvQuxcVEb64NV55PHlVA5l+vNM5sWEbrf6WftgusOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id A9D2E8CC; Wed,  4 Dec 2024 21:04:13 -0600 (CST)
Date: Wed, 4 Dec 2024 21:04:13 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jordan Rome <linux@jordanrome.com>
Cc: linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>, Serge Hallyn <sergeh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [v9] security: add trace event for cap_capable
Message-ID: <20241205030413.GA150761@mail.hallyn.com>
References: <20241204155911.1817092-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204155911.1817092-1-linux@jordanrome.com>

On Wed, Dec 04, 2024 at 07:59:11AM -0800, Jordan Rome wrote:
> In cases where we want a stable way to observe/trace
> cap_capable (e.g. protection from inlining and API updates)
> add a tracepoint that passes:
> - The credentials used
> - The user namespace of the resource being accessed
> - The user namespace in which the credential provides the
> capability to access the targeted resource
> - The capability to check for
> - The return value of the check
> 
> Signed-off-by: Jordan Rome <linux@jordanrome.com>

Thanks, applied to caps-next.

> ---
>  MAINTAINERS                       |  1 +
>  include/trace/events/capability.h | 57 +++++++++++++++++++++++++++++++
>  security/commoncap.c              | 54 ++++++++++++++++++++++-------
>  3 files changed, 99 insertions(+), 13 deletions(-)
>  create mode 100644 include/trace/events/capability.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1e930c7a58b1..33fde7f660d0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5147,6 +5147,7 @@ M:	Serge Hallyn <serge@hallyn.com>
>  L:	linux-security-module@vger.kernel.org
>  S:	Supported
>  F:	include/linux/capability.h
> +F:	include/trace/events/capability.h
>  F:	include/uapi/linux/capability.h
>  F:	kernel/capability.c
>  F:	security/commoncap.c
> diff --git a/include/trace/events/capability.h b/include/trace/events/capability.h
> new file mode 100644
> index 000000000000..17340257946c
> --- /dev/null
> +++ b/include/trace/events/capability.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM capability
> +
> +#if !defined(_TRACE_CAPABILITY_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_CAPABILITY_H
> +
> +#include <linux/cred.h>
> +#include <linux/tracepoint.h>
> +#include <linux/user_namespace.h>
> +
> +/**
> + * cap_capable - called after it's determined if a task has a particular
> + * effective capability
> + *
> + * @cred: The credentials used
> + * @target_ns: The user namespace of the resource being accessed
> + * @capable_ns: The user namespace in which the credential provides the
> + *              capability to access the targeted resource.
> + *              This will be NULL if ret is not 0.
> + * @cap: The capability to check for
> + * @ret: The return value of the check: 0 if it does, -ve if it does not
> + *
> + * Allows to trace calls to cap_capable in commoncap.c
> + */
> +TRACE_EVENT(cap_capable,
> +
> +	TP_PROTO(const struct cred *cred, struct user_namespace *target_ns,
> +		const struct user_namespace *capable_ns, int cap, int ret),
> +
> +	TP_ARGS(cred, target_ns, capable_ns, cap, ret),
> +
> +	TP_STRUCT__entry(
> +		__field(const struct cred *, cred)
> +		__field(struct user_namespace *, target_ns)
> +		__field(const struct user_namespace *, capable_ns)
> +		__field(int, cap)
> +		__field(int, ret)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cred       = cred;
> +		__entry->target_ns    = target_ns;
> +		__entry->capable_ns = ret == 0 ? capable_ns : NULL;
> +		__entry->cap        = cap;
> +		__entry->ret        = ret;
> +	),
> +
> +	TP_printk("cred %p, target_ns %p, capable_ns %p, cap %d, ret %d",
> +		__entry->cred, __entry->target_ns, __entry->capable_ns, __entry->cap,
> +		__entry->ret)
> +);
> +
> +#endif /* _TRACE_CAPABILITY_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index cefad323a0b1..7b6984b27127 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -27,6 +27,9 @@
>  #include <linux/mnt_idmapping.h>
>  #include <uapi/linux/lsm.h>
> 
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/capability.h>
> +
>  /*
>   * If a non-root user executes a setuid-root binary in
>   * !secure(SECURE_NOROOT) mode, then we raise capabilities.
> @@ -50,24 +53,24 @@ static void warn_setuid_and_fcaps_mixed(const char *fname)
>  }
> 
>  /**
> - * cap_capable - Determine whether a task has a particular effective capability
> + * cap_capable_helper - Determine whether a task has a particular effective
> + * capability.
>   * @cred: The credentials to use
> - * @targ_ns:  The user namespace in which we need the capability
> + * @target_ns:  The user namespace of the resource being accessed
> + * @cred_ns:  The user namespace of the credentials
>   * @cap: The capability to check for
> - * @opts: Bitmask of options defined in include/linux/security.h
>   *
>   * Determine whether the nominated task has the specified capability amongst
>   * its effective set, returning 0 if it does, -ve if it does not.
>   *
> - * NOTE WELL: cap_has_capability() cannot be used like the kernel's capable()
> - * and has_capability() functions.  That is, it has the reverse semantics:
> - * cap_has_capability() returns 0 when a task has a capability, but the
> - * kernel's capable() and has_capability() returns 1 for this case.
> + * See cap_capable for more details.
>   */
> -int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
> -		int cap, unsigned int opts)
> +static inline int cap_capable_helper(const struct cred *cred,
> +				     struct user_namespace *target_ns,
> +				     const struct user_namespace *cred_ns,
> +				     int cap)
>  {
> -	struct user_namespace *ns = targ_ns;
> +	struct user_namespace *ns = target_ns;
> 
>  	/* See if cred has the capability in the target user namespace
>  	 * by examining the target user namespace and all of the target
> @@ -75,21 +78,21 @@ int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
>  	 */
>  	for (;;) {
>  		/* Do we have the necessary capabilities? */
> -		if (ns == cred->user_ns)
> +		if (likely(ns == cred_ns))
>  			return cap_raised(cred->cap_effective, cap) ? 0 : -EPERM;
> 
>  		/*
>  		 * If we're already at a lower level than we're looking for,
>  		 * we're done searching.
>  		 */
> -		if (ns->level <= cred->user_ns->level)
> +		if (ns->level <= cred_ns->level)
>  			return -EPERM;
> 
>  		/*
>  		 * The owner of the user namespace in the parent of the
>  		 * user namespace has all caps.
>  		 */
> -		if ((ns->parent == cred->user_ns) && uid_eq(ns->owner, cred->euid))
> +		if ((ns->parent == cred_ns) && uid_eq(ns->owner, cred->euid))
>  			return 0;
> 
>  		/*
> @@ -102,6 +105,31 @@ int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
>  	/* We never get here */
>  }
> 
> +/**
> + * cap_capable - Determine whether a task has a particular effective capability
> + * @cred: The credentials to use
> + * @target_ns:  The user namespace of the resource being accessed
> + * @cap: The capability to check for
> + * @opts: Bitmask of options defined in include/linux/security.h (unused)
> + *
> + * Determine whether the nominated task has the specified capability amongst
> + * its effective set, returning 0 if it does, -ve if it does not.
> + *
> + * NOTE WELL: cap_has_capability() cannot be used like the kernel's capable()
> + * and has_capability() functions.  That is, it has the reverse semantics:
> + * cap_has_capability() returns 0 when a task has a capability, but the
> + * kernel's capable() and has_capability() returns 1 for this case.
> + */
> +int cap_capable(const struct cred *cred, struct user_namespace *target_ns,
> +		int cap, unsigned int opts)
> +{
> +	const struct user_namespace *cred_ns = cred->user_ns;
> +	int ret = cap_capable_helper(cred, target_ns, cred_ns, cap);
> +
> +	trace_cap_capable(cred, target_ns, cred_ns, cap, ret);
> +	return ret;
> +}
> +
>  /**
>   * cap_settime - Determine whether the current process may set the system clock
>   * @ts: The time to set
> --
> 2.43.5
