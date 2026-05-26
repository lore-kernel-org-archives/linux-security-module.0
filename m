Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7771E3BFE38
	for <linux-security-module@vger.kernel.org>; Tue, 26 May 2026 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779831305; cv=none; b=udo7Me734f/TIfLIV5ilcDMWq8DZTzy8ggbnoM4T6VEJkYEBtAdlR1IYd+PeoYviRvzp9DOyUIME0JqXIB91QVu+1Ctu3feBrN2wrF1pO7oEw9tq31kubU7okXz4I1Y8SYn1bakVoNkXsnuanhXbg6fRZhUCn47W4STDH5OBOHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779831305; c=relaxed/simple;
	bh=4ul+x3iYzWjC5uGKrrxbeCrsBFxwzzRDAx8mz6g/TPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDQmn0P+S6eHH3lgkK0EBu3LW+0rn1vkSwtnmWgMsS8d4QCaC2QEy3hM5UFzOfHrkDvsA9NZJuYqjJQ7NjQIFCVZFb1B5slJvTjGh+5MpC8r/Ws9qdtz3p/Wj5SD9AMiUKzZM0JQswT1q40UFVc/WQI7ReBAhkG6UF3GyqBx0h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMn7PAG/; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMn7PAG/"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-48543ae6e39so2977571b6e.0
        for <linux-security-module@vger.kernel.org>; Tue, 26 May 2026 14:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779831302; x=1780436102; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9RmoLJIZdhkPvUS0ZmRFmyljS9yxdSd+DHvK0Ww0jpg=;
        b=MMn7PAG/JQkRUoFtuz+nPasMDEob1o4YKE3BW6TCnVQtAl9/YPdSQCpXN1wTObttAC
         +eqEs4S4PumlR5urJzszUfTh9EhcpV8MDVV/wBeUTYSIyjswj/XMg9rzPAVa0UpBJeEc
         ejKzNXmQKnUY90QqBCvUHsl47KfBj4DLjnsmpnFi0CfXWIBjmhOueSFPUCJuk/97ThNS
         tb+2/PFvZtmTPZIgeYtWOVokUVEBuV+Rch3GKVY9tuN1p9frhnHGQ9xgtMnTuozF5VEt
         uJvwEulcov7tgX79ez56xG0UmyzzpkFOPXzWyWj6It8/cpEqP2euwhiK+hpnpPi1RRpv
         t/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779831302; x=1780436102;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9RmoLJIZdhkPvUS0ZmRFmyljS9yxdSd+DHvK0Ww0jpg=;
        b=qrEKMxXsEiFffOI3s8W9F5eoD0mcyEyDQuWDJyOjU4O26K8cz5zWtVYNAZLOGLk/qF
         QnDJDb1CXi6egQCmsyCANBf2Bb/Ip0eZhS57rXmE0xy1SnUDSk5DrCG5DWbQiVf3+Pvl
         72GaQhsbbm1xcprh/A/JCzyaKX68ZoYBU91aQ2kgbhiCIktCjevRnvOh50wEBg4bRauL
         k7BR1Pac8bfJMswYnpcoX1kNSCtmLRW1RDDGgAT5Tyly4TfOQq3cO4TeELp5CNBGl0mm
         LqFQqdq6n9I80Gd4XyYsR7ZoqYQfOJ1UGw5iCIGCXkLuOejUYMZ+p+PkFZ22rEkfseHa
         BiOw==
X-Forwarded-Encrypted: i=1; AFNElJ/eOxVO4L6EPxuwlU3GYPIrT7fTDbvV6GuAx8uDZHpac7hln5JhsLCOZcqOojcaZ48G7uNc3hLhEoXjh7OGDNmTXw3etn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJXofvqQta36CMP6wKn3SU7y6bbDM9s2KZmW3sgTkLGKaTGVE9
	XRyGi31sdZZIfZs8vuWiNsx2fUwk1E4yFu79fv6KSTgt4uFcrz0Drngu
X-Gm-Gg: Acq92OFaRQKZF4oOeKmk90aFEv5FDASKTu8FAHnB+cgz3y4SwmLfUXR33HkJxa2rFlY
	ZXUJ9Wx82+oUWqQCG1DX2QKk0wnvYbbueALAp4CKlEfWUsWcW4iOdXRhndHS8t3o23QWndzTCHJ
	pAuzm443gqiBGXekXjikxkEv/NMM0Yrr7WabPij+eb41lW6k3qUC14MHpjTfsiKaZJtxFbfviKF
	7c2BkhwG9epjZGS/5IGqNhzP00OPaoexBUA4i8Nhy3wvCFktf9l85oM38taYjxGWctBXStHVjqI
	u51CeDP5Dlikf9Z05QLNyiZBCZF1P86hQscC1n674cZpssirDafOivKSGBgViYPXaRkzgH6kn7p
	qqlk/4FpIbYIsu/kNJ41X+eZhKNJvipN2KkA509THDm8SltXfvGQYlo0j1IhTkjSCa8BI8s/rx6
	IzpVk/BuvwTYa4fFxuauaxoP9snGOfzPF7xjh1BxXbqEHmmzWkWGtdIfeffP8WCYatyVyBkNKrj
	g==
X-Received: by 2002:a05:6808:1719:b0:482:c65c:457e with SMTP id 5614622812f47-4854a0ead12mr11762348b6e.11.1779831302231;
        Tue, 26 May 2026 14:35:02 -0700 (PDT)
Received: from suesslenovo ([2601:281:c981:d860:dd1e:c83d:3b04:e26b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b6350ad6bsm14691088fac.4.2026.05.26.14.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 14:35:01 -0700 (PDT)
Date: Tue, 26 May 2026 17:34:59 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Kees Cook <kees@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/17] landlock: Add create_ruleset and free_ruleset
 tracepoints
Message-ID: <ahYOJwpiEI-gGx1Z@suesslenovo>
References: <20260406143717.1815792-1-mic@digikod.net>
 <20260406143717.1815792-7-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260406143717.1815792-7-mic@digikod.net>

On Mon, Apr 06, 2026 at 04:37:04PM +0200, Mickaël Salaün wrote:
> Add tracepoints for ruleset lifecycle events: landlock_create_ruleset
> fires from the landlock_create_ruleset() syscall handler, logging the
> ruleset Landlock ID and handled access masks; landlock_free_ruleset
> fires in free_ruleset() before the ruleset is freed, so eBPF programs
> can access the full ruleset state via BTF.
> 
> The create_ruleset TP_PROTO takes only the ruleset pointer.  The handled
> access masks are read from the ruleset in TP_fast_assign rather than
> passed as scalar arguments, so eBPF programs can access the full ruleset
> state (rules, access masks) via BTF on a single pointer.  No lock is
> needed because the ruleset is not yet shared (the file descriptor has
> not been installed).
> 
> Create the trace header with a DOC comment documenting the consistency
> guarantees, locking conventions, TP_PROTO safety, and security
> considerations shared by all Landlock tracepoints.  Add
> CREATE_TRACE_POINTS in log.c to generate the tracepoint implementations.
> 
> Add an id field to struct landlock_ruleset, assigned from
> landlock_get_id_range() at creation time.  Extend the CONFIG guard on
> landlock_get_id_range() from CONFIG_AUDIT to
> CONFIG_SECURITY_LANDLOCK_LOG so that IDs are available for tracing even
> without audit support.
> 
> The deallocation events use the "free_" prefix (rather than "drop_")
> because they fire when the object is actually freed.  There is no need
> for allocated/deallocated symmetry because ruleset creation happens with
> the landlock_create_ruleset tracepoint.
> 
> landlock_create_ruleset tracepoint.
> 
> Unlike audit records which share a record type and need a "status="
> field to distinguish allocation from deallocation, tracepoints provide
> one event type per lifecycle transition, each with a type-safe TP_PROTO
> matching the specific transition.  This enables type-safe eBPF BTF
> access and precise ftrace filtering by event name.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Justin Suess <utilityemal77@gmail.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tingmao Wang <m@maowtm.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v1:
> - New patch (split from the v1 add_rule_fs tracepoint patch).
> ---
>  MAINTAINERS                     |  1 +
>  include/trace/events/landlock.h | 94 +++++++++++++++++++++++++++++++++
>  security/landlock/id.h          |  6 +--
>  security/landlock/log.c         |  5 ++
>  security/landlock/ruleset.c     |  8 +++
>  security/landlock/ruleset.h     |  9 ++++
>  security/landlock/syscalls.c    |  5 ++
>  7 files changed, 125 insertions(+), 3 deletions(-)
>  create mode 100644 include/trace/events/landlock.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c3fe46d7c4bc..51104faa3951 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14389,6 +14389,7 @@ F:	Documentation/admin-guide/LSM/landlock.rst
>  F:	Documentation/security/landlock.rst
>  F:	Documentation/userspace-api/landlock.rst
>  F:	fs/ioctl.c
> +F:	include/trace/events/landlock.h
>  F:	include/uapi/linux/landlock.h
>  F:	samples/landlock/
>  F:	security/landlock/
> diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
> new file mode 100644
> index 000000000000..5e847844fbf7
> --- /dev/null
> +++ b/include/trace/events/landlock.h
> @@ -0,0 +1,94 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright © 2025 Microsoft Corporation
> + * Copyright © 2026 Cloudflare
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM landlock
> +
> +#if !defined(_TRACE_LANDLOCK_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_LANDLOCK_H
> +
> +#include <linux/tracepoint.h>
> +
> +struct landlock_ruleset;
> +
> +/**
> + * DOC: Landlock trace events
> + *
> + * Consistency guarantee: every trace event corresponds to an operation
> + * that has irrevocably succeeded.  Lifecycle events fire only after
> + * the point of no return; denial events fire only for denials that
> + * actually happen.  This guarantees that eBPF programs observing the
> + * trace stream can build a faithful model of Landlock state without
> + * reconciliation logic.
> + *
> + * Mutable object pointers in TP_PROTO (e.g., struct landlock_ruleset
> + * for add_rule events) are passed while the caller holds the object's
> + * lock, so that TP_fast_assign and eBPF programs reading via BTF see a
> + * consistent snapshot.  For objects that are immutable at the emission
> + * site (e.g., a domain after creation), no lock is needed.
> + *
> + * All pointer arguments in TP_PROTO are guaranteed non-NULL by the
> + * caller.  eBPF programs can access these pointers via BTF for richer
> + * introspection than the TP_STRUCT__entry fields provide.
> + *
> + * TP_STRUCT__entry fields serve TP_printk display only.  eBPF programs
> + * access the raw TP_PROTO arguments directly.
> + *
> + * Security: as for audit, Landlock trace events may expose sensitive
> + * information about all sandboxed processes on the system.  See
> + * Documentation/admin-guide/LSM/landlock.rst for security considerations
> + * and privilege requirements.
> + */
> +
> +/**
> + * landlock_create_ruleset - new ruleset created
> + * @ruleset: Newly created ruleset (never NULL); not yet shared via an fd,
> + *           so no lock is needed.  eBPF programs can read the full ruleset
> + *           state via BTF.
> + */
> +TRACE_EVENT(
> +	landlock_create_ruleset,
> +
> +	TP_PROTO(const struct landlock_ruleset *ruleset),
> +
> +	TP_ARGS(ruleset),
> +
> +	TP_STRUCT__entry(__field(__u64, ruleset_id) __field(access_mask_t,
> +							    handled_fs)
> +				 __field(access_mask_t, handled_net)
> +					 __field(access_mask_t, scoped)),
> +
> +	TP_fast_assign(__entry->ruleset_id = ruleset->id;
> +		       __entry->handled_fs = ruleset->layer.fs;
> +		       __entry->handled_net = ruleset->layer.net;
> +		       __entry->scoped = ruleset->layer.scope;),
> +
> +	TP_printk("ruleset=%llx handled_fs=0x%x handled_net=0x%x scoped=0x%x",
> +		  __entry->ruleset_id, __entry->handled_fs,
> +		  __entry->handled_net, __entry->scoped));
> +
> +/**
> + * landlock_free_ruleset - Ruleset freed
> + *
> + * Emitted when a ruleset's last reference is dropped (typically when
> + * the creating process closes the ruleset file descriptor).
> + */
> +TRACE_EVENT(landlock_free_ruleset,
> +
> +	    TP_PROTO(const struct landlock_ruleset *ruleset),
> +
> +	    TP_ARGS(ruleset),
> +
> +	    TP_STRUCT__entry(__field(__u64, ruleset_id)),
> +
> +	    TP_fast_assign(__entry->ruleset_id = ruleset->id;),
> +
> +	    TP_printk("ruleset=%llx", __entry->ruleset_id));
> +
> +#endif /* _TRACE_LANDLOCK_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/security/landlock/id.h b/security/landlock/id.h
> index 45dcfb9e9a8b..2a43c2b523a8 100644
> --- a/security/landlock/id.h
> +++ b/security/landlock/id.h
> @@ -8,18 +8,18 @@
>  #ifndef _SECURITY_LANDLOCK_ID_H
>  #define _SECURITY_LANDLOCK_ID_H
>  
> -#ifdef CONFIG_AUDIT
> +#ifdef CONFIG_SECURITY_LANDLOCK_LOG
>  
>  void __init landlock_init_id(void);
>  
>  u64 landlock_get_id_range(size_t number_of_ids);
>  
> -#else /* CONFIG_AUDIT */
> +#else /* CONFIG_SECURITY_LANDLOCK_LOG */
>  
>  static inline void __init landlock_init_id(void)
>  {
>  }
>  
> -#endif /* CONFIG_AUDIT */
> +#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
>  
>  #endif /* _SECURITY_LANDLOCK_ID_H */
> diff --git a/security/landlock/log.c b/security/landlock/log.c
> index c9b506707af0..ef79e4ed0037 100644
> --- a/security/landlock/log.c
> +++ b/security/landlock/log.c
> @@ -174,6 +174,11 @@ static void audit_denial(const struct landlock_cred_security *const subject,
>  
>  #endif /* CONFIG_AUDIT */
>  
> +#ifdef CONFIG_TRACEPOINTS
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/landlock.h>
> +#endif /* CONFIG_TRACEPOINTS */
> +
>  static struct landlock_hierarchy *
>  get_hierarchy(const struct landlock_domain *const domain, const size_t layer)
>  {
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index c220e0f9cf5f..0d1e3dadb318 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -22,10 +22,13 @@
>  #include <linux/spinlock.h>
>  
>  #include "access.h"
> +#include "id.h"
>  #include "limits.h"
>  #include "object.h"
>  #include "ruleset.h"
>  
> +#include <trace/events/landlock.h>
> +
>  struct landlock_ruleset *
>  landlock_create_ruleset(const access_mask_t fs_access_mask,
>  			const access_mask_t net_access_mask,
> @@ -49,6 +52,10 @@ landlock_create_ruleset(const access_mask_t fs_access_mask,
>  	new_ruleset->rules.root_net_port = RB_ROOT;
>  #endif /* IS_ENABLED(CONFIG_INET) */
>  
> +#ifdef CONFIG_SECURITY_LANDLOCK_LOG
> +	new_ruleset->id = landlock_get_id_range(1);
> +#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
The addition of IDs to rulesets for logging makes sense.

But it is limited in usefulness without some form of introspection to be
able to correlate it to a specific userspace ruleset.

If a program creates multiple Landlock rulesets, and wishes to trace and
correlate which ruleset FD corresponds to the log/tracepoint, it is
difficult when no form of introspection exists.

Maybe a syscall flag or ioctl to retrieve the identifier for correlation
would be useful?

Justin
> +
>  	/* Should already be checked in sys_landlock_create_ruleset(). */
>  	if (fs_access_mask) {
>  		WARN_ON_ONCE(fs_access_mask !=
> @@ -312,6 +319,7 @@ void landlock_free_rules(struct landlock_rules *const rules)
>  static void free_ruleset(struct landlock_ruleset *const ruleset)
> [...]
