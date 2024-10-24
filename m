Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3934C2170BC;
	Thu, 24 Oct 2024 20:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801696; cv=none; b=gqmTe7pun9QqSQLkXtb4UXpKYiJ8UZRCa2Ur7cbuYcy+WTkdHG0gpDj6uF8sZr6KaiokDoVwvZYSTiDhy2ZkR73jO6AwLLmvkN8zuflEM2dTp3fO3OZ0kZ4qE2zxd1RgviA5a7gYzQ1vhAGgVDDRk8KeyIYtcCxx4Lr611Ka8Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801696; c=relaxed/simple;
	bh=DcE6NAwnE7Vp+mfdLRCEr0jK6SJKDbVQNlu1DU/5Knk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEI3BJCrplKoHGD8u/Xf8pGeHBxBEu9UdIwlZ3e8kJjreeSRUrkjTzbyodIb5avgnTo6vz/lAwfsBDJt6okbKQW1BVvJcarSfmI2z96kD7X39Hl0TaAGNsjcg8qN1le+TCzu3hmhzOym4xp5oAXjD6zVqkJurC3LwMPlrSQ6b0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ff+DpKk1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ff+DpKk1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27265C4CECD;
	Thu, 24 Oct 2024 20:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729801695;
	bh=DcE6NAwnE7Vp+mfdLRCEr0jK6SJKDbVQNlu1DU/5Knk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ff+DpKk1fsAgK675JQXlB36GNbt62N5rUeQhDTx2fspnZ0Zcpw+KD/Bk+vy0fpgyR
	 TDEJRauuyv/vhXmZ8RQKR8lC3/Xd5CdbVOVZWtt+CUfrEncHG4NMQki26bZGMJK30N
	 beWxuDpdosDEp+GyKQyPOoaQlLtLmPcRaLuxghTV/i5oLG+vT/MNCL3+bNhIHx3PEh
	 Yx1UwylRYqsEusvnBRrbsVyhJKV1kxQIiH4FaLm2ZOzrpD2Wvo/63kbMtXVPrWPGY8
	 Zr+Z5Mzx268mRW9+2z2CRyI+HiPTfyCets1AEnEUvL70N4eSZjmZaEHp/AEQYI0Uz0
	 R/V18ymnwn6lg==
Date: Thu, 24 Oct 2024 20:28:11 +0000
From: sergeh@kernel.org
To: Jordan Rome <linux@jordanrome.com>
Cc: linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>, Serge Hallyn <serge@hallyn.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [v1] security: add trace event for cap_capable
Message-ID: <Zxqt29vYukIGw8QV@lei>
References: <20241024104012.1815022-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024104012.1815022-1-linux@jordanrome.com>

On Thu, Oct 24, 2024 at 03:40:12AM -0700, Jordan Rome wrote:
> In cases where we want a stable way to observe/trace
> cap_capable (e.g. protection from inlining and API updates)
> add a tracepoint that passes:
> - The credentials used
> - The user namespace which needs the capability

"the user namespace which needs the capability" is not quite the
right way to put this.  It's the user namespace against which the
capability is needed.  It's an object, not a subject.  Or maybe
"the user namespace of the resource being accessed".

> - The user namespace that actually has the capability (if one exists)

How about "the user namespace in which the task has the
capability targeted at the resource"?  (It's not the user
namespace itself that has the capability)

> - The capability to check for
> - Bitmask of options defined in include/linux/security.h
> - The return value of the check
> 
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  MAINTAINERS                       |  1 +
>  include/trace/events/capability.h | 58 +++++++++++++++++++++++++++++++
>  security/commoncap.c              | 21 +++++++----
>  3 files changed, 74 insertions(+), 6 deletions(-)
>  create mode 100644 include/trace/events/capability.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc40a9d9b8cd..210e9076c858 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4994,6 +4994,7 @@ M:	Serge Hallyn <serge@hallyn.com>
>  L:	linux-security-module@vger.kernel.org
>  S:	Supported
>  F:	include/linux/capability.h
> +F:	include/trace/events/capability.h
>  F:	include/uapi/linux/capability.h
>  F:	kernel/capability.c
>  F:	security/commoncap.c
> diff --git a/include/trace/events/capability.h b/include/trace/events/capability.h
> new file mode 100644
> index 000000000000..092b8e77063a
> --- /dev/null
> +++ b/include/trace/events/capability.h
> @@ -0,0 +1,58 @@
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
> + * capable - called after it's determined if a task has a particular
> + * effective capability
> + *
> + * @cred: The credentials used
> + * @targ_ns:  The user namespace which needs the capability

(same here)

> + * @capable_ns:  The user namespace that actually has the capability
> + *               if ret is 0 otherwise this will be NULL
> + * @cap: The capability to check for
> + * @opts: Bitmask of options defined in include/linux/security.h
> + * @ret: The return value of the check: 0 if it does, -ve if it does not
> + *
> + * Allows to trace calls to cap_capable in commoncap.c
> + */
> +TRACE_EVENT(capable,
> +
> +	TP_PROTO(const struct cred *cred, struct user_namespace *targ_ns,
> +		struct user_namespace *capable_ns, int cap, unsigned int opts, int ret),
> +
> +	TP_ARGS(cred, targ_ns, capable_ns, cap, opts, ret),
> +
> +	TP_STRUCT__entry(
> +		__field(const struct cred *, cred)
> +		__field(struct user_namespace *, targ_ns)
> +		__field(struct user_namespace *, capable_ns)
> +		__field(int, cap)
> +		__field(unsigned int, opts)
> +		__field(int, ret)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cred       = cred;
> +		__entry->targ_ns    = targ_ns;
> +		__entry->capable_ns = capable_ns;
> +		__entry->cap        = cap;
> +		__entry->opts       = opts;
> +		__entry->ret        = ret;
> +	),
> +
> +	TP_printk("cap %d, opts %u, ret %d",
> +		__entry->cap, __entry->opts, __entry->ret)
> +);
> +
> +#endif /* _TRACE_CAPABILITY_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 162d96b3a676..675d40fbaa77 100644
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
> @@ -68,6 +71,7 @@ int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
>  		int cap, unsigned int opts)
>  {
>  	struct user_namespace *ns = targ_ns;
> +	int ret = 0;
> 
>  	/* See if cred has the capability in the target user namespace
>  	 * by examining the target user namespace and all of the target
> @@ -75,22 +79,26 @@ int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
>  	 */
>  	for (;;) {
>  		/* Do we have the necessary capabilities? */
> -		if (ns == cred->user_ns)
> -			return cap_raised(cred->cap_effective, cap) ? 0 : -EPERM;
> +		if (ns == cred->user_ns) {
> +			ret = cap_raised(cred->cap_effective, cap) ? 0 : -EPERM;
> +			break;
> +		}
> 
>  		/*
>  		 * If we're already at a lower level than we're looking for,
>  		 * we're done searching.
>  		 */
> -		if (ns->level <= cred->user_ns->level)
> -			return -EPERM;
> +		if (ns->level <= cred->user_ns->level) {
> +			ret = -EPERM;
> +			break;
> +		}
> 
>  		/*
>  		 * The owner of the user namespace in the parent of the
>  		 * user namespace has all caps.
>  		 */
>  		if ((ns->parent == cred->user_ns) && uid_eq(ns->owner, cred->euid))
> -			return 0;
> +			break;
> 
>  		/*
>  		 * If you have a capability in a parent user ns, then you have
> @@ -99,7 +107,8 @@ int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
>  		ns = ns->parent;
>  	}
> 
> -	/* We never get here */

With this change, I become less comfortable with us assuming that it is
the case that we'll never just drop off the end of the while loop.  I'd
be more comfortable if you set ret = -EPERM at the top, and set it to 0
in the last break.

> +	trace_capable(cred, targ_ns, ret == 0 ? ns : NULL, cap, opts, ret);
> +	return ret;
>  }
> 
>  /**
> --
> 2.43.5
> 
