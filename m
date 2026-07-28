Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAF83859FD
	for <linux-security-module@vger.kernel.org>; Tue, 28 Jul 2026 20:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272190; cv=none; b=LVzVuo8nM9b26qr+7RoNSAG3ZO1LuanlE7kI5c1OzVvkkO2TGS1jtSB48qM/re0IhLLL4CZsUxsF2/ry9QK3p+2G8W/7koHfPOVKLO/GLhfHwaxanymGW/JRSW9Q6BcDq/IHQ9SN1fcqUve6qQJxRa62g8iuvIKdwsLz2rrm26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272190; c=relaxed/simple;
	bh=6iUZmm6qrKgFsq2bi4hOFtwAJAGI4cvL/vsBYFJyss4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boV7YtTkqL1hd2PX0zeaCO/qYpIuvjcq+3VuAYgP1eBjzJuPsox0sYMCz9GJjIwZwOB1NT4Dfy9beZANKjRjW5FFRkH+e5kzugEuG6iVmI32aq2Im2V+R4Exnh6wI2OpC5XueMPz4Es4ZxfxUGwgYUoxhm1RcnykjCpRx+goK9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=HznXHuiZ; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="HznXHuiZ"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h8nnM0zXbzdM4;
	Tue, 28 Jul 2026 22:56:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785272182;
	bh=QSt3sW7Q/4VKylm31kmU2O4xQ5UTDoyVkDceL/gh9D4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HznXHuiZ6lmBnTC0LJsBbJnufcMK/GE42xn3h4XPJwGGs8n3jL5coRmOElKXcXpj7
	 ctVN+IyEPpInJ/suAFeYX98q+wWwMVedzd9xZe9ZN+f+aJ8wL8YIU2nRVnKwgdmEEY
	 QoiZj7JokeGGFTJlFIbC7Avsr6Qt0uNZylyA1ROE=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4h8nnK2LxSzYBL;
	Tue, 28 Jul 2026 22:56:21 +0200 (CEST)
Date: Tue, 28 Jul 2026 22:56:16 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Kees Cook <kees@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/17] landlock: Add create_ruleset and free_ruleset
 tracepoints
Message-ID: <20260728.nohNgei7Nei9@digikod.net>
References: <20260406143717.1815792-1-mic@digikod.net>
 <20260406143717.1815792-7-mic@digikod.net>
 <ahYOJwpiEI-gGx1Z@suesslenovo>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahYOJwpiEI-gGx1Z@suesslenovo>
X-Infomaniak-Routing: alpha

On Tue, May 26, 2026 at 05:34:59PM -0400, Justin Suess wrote:
> On Mon, Apr 06, 2026 at 04:37:04PM +0200, Mickaël Salaün wrote:
> > Add tracepoints for ruleset lifecycle events: landlock_create_ruleset
> > fires from the landlock_create_ruleset() syscall handler, logging the
> > ruleset Landlock ID and handled access masks; landlock_free_ruleset
> > fires in free_ruleset() before the ruleset is freed, so eBPF programs
> > can access the full ruleset state via BTF.
> > 
> > The create_ruleset TP_PROTO takes only the ruleset pointer.  The handled
> > access masks are read from the ruleset in TP_fast_assign rather than
> > passed as scalar arguments, so eBPF programs can access the full ruleset
> > state (rules, access masks) via BTF on a single pointer.  No lock is
> > needed because the ruleset is not yet shared (the file descriptor has
> > not been installed).
> > 
> > Create the trace header with a DOC comment documenting the consistency
> > guarantees, locking conventions, TP_PROTO safety, and security
> > considerations shared by all Landlock tracepoints.  Add
> > CREATE_TRACE_POINTS in log.c to generate the tracepoint implementations.
> > 
> > Add an id field to struct landlock_ruleset, assigned from
> > landlock_get_id_range() at creation time.  Extend the CONFIG guard on
> > landlock_get_id_range() from CONFIG_AUDIT to
> > CONFIG_SECURITY_LANDLOCK_LOG so that IDs are available for tracing even
> > without audit support.
> > 
> > The deallocation events use the "free_" prefix (rather than "drop_")
> > because they fire when the object is actually freed.  There is no need
> > for allocated/deallocated symmetry because ruleset creation happens with
> > the landlock_create_ruleset tracepoint.
> > 
> > landlock_create_ruleset tracepoint.
> > 
> > Unlike audit records which share a record type and need a "status="
> > field to distinguish allocation from deallocation, tracepoints provide
> > one event type per lifecycle transition, each with a type-safe TP_PROTO
> > matching the specific transition.  This enables type-safe eBPF BTF
> > access and precise ftrace filtering by event name.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Justin Suess <utilityemal77@gmail.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Tingmao Wang <m@maowtm.org>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> > 
> > Changes since v1:
> > - New patch (split from the v1 add_rule_fs tracepoint patch).
> > ---
> >  MAINTAINERS                     |  1 +
> >  include/trace/events/landlock.h | 94 +++++++++++++++++++++++++++++++++
> >  security/landlock/id.h          |  6 +--
> >  security/landlock/log.c         |  5 ++
> >  security/landlock/ruleset.c     |  8 +++
> >  security/landlock/ruleset.h     |  9 ++++
> >  security/landlock/syscalls.c    |  5 ++
> >  7 files changed, 125 insertions(+), 3 deletions(-)
> >  create mode 100644 include/trace/events/landlock.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c3fe46d7c4bc..51104faa3951 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14389,6 +14389,7 @@ F:	Documentation/admin-guide/LSM/landlock.rst
> >  F:	Documentation/security/landlock.rst
> >  F:	Documentation/userspace-api/landlock.rst
> >  F:	fs/ioctl.c
> > +F:	include/trace/events/landlock.h
> >  F:	include/uapi/linux/landlock.h
> >  F:	samples/landlock/
> >  F:	security/landlock/
> > diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
> > new file mode 100644
> > index 000000000000..5e847844fbf7
> > --- /dev/null
> > +++ b/include/trace/events/landlock.h
> > @@ -0,0 +1,94 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright © 2025 Microsoft Corporation
> > + * Copyright © 2026 Cloudflare
> > + */
> > +
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM landlock
> > +
> > +#if !defined(_TRACE_LANDLOCK_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_LANDLOCK_H
> > +
> > +#include <linux/tracepoint.h>
> > +
> > +struct landlock_ruleset;
> > +
> > +/**
> > + * DOC: Landlock trace events
> > + *
> > + * Consistency guarantee: every trace event corresponds to an operation
> > + * that has irrevocably succeeded.  Lifecycle events fire only after
> > + * the point of no return; denial events fire only for denials that
> > + * actually happen.  This guarantees that eBPF programs observing the
> > + * trace stream can build a faithful model of Landlock state without
> > + * reconciliation logic.
> > + *
> > + * Mutable object pointers in TP_PROTO (e.g., struct landlock_ruleset
> > + * for add_rule events) are passed while the caller holds the object's
> > + * lock, so that TP_fast_assign and eBPF programs reading via BTF see a
> > + * consistent snapshot.  For objects that are immutable at the emission
> > + * site (e.g., a domain after creation), no lock is needed.
> > + *
> > + * All pointer arguments in TP_PROTO are guaranteed non-NULL by the
> > + * caller.  eBPF programs can access these pointers via BTF for richer
> > + * introspection than the TP_STRUCT__entry fields provide.
> > + *
> > + * TP_STRUCT__entry fields serve TP_printk display only.  eBPF programs
> > + * access the raw TP_PROTO arguments directly.
> > + *
> > + * Security: as for audit, Landlock trace events may expose sensitive
> > + * information about all sandboxed processes on the system.  See
> > + * Documentation/admin-guide/LSM/landlock.rst for security considerations
> > + * and privilege requirements.
> > + */
> > +
> > +/**
> > + * landlock_create_ruleset - new ruleset created
> > + * @ruleset: Newly created ruleset (never NULL); not yet shared via an fd,
> > + *           so no lock is needed.  eBPF programs can read the full ruleset
> > + *           state via BTF.
> > + */
> > +TRACE_EVENT(
> > +	landlock_create_ruleset,
> > +
> > +	TP_PROTO(const struct landlock_ruleset *ruleset),
> > +
> > +	TP_ARGS(ruleset),
> > +
> > +	TP_STRUCT__entry(__field(__u64, ruleset_id) __field(access_mask_t,
> > +							    handled_fs)
> > +				 __field(access_mask_t, handled_net)
> > +					 __field(access_mask_t, scoped)),
> > +
> > +	TP_fast_assign(__entry->ruleset_id = ruleset->id;
> > +		       __entry->handled_fs = ruleset->layer.fs;
> > +		       __entry->handled_net = ruleset->layer.net;
> > +		       __entry->scoped = ruleset->layer.scope;),
> > +
> > +	TP_printk("ruleset=%llx handled_fs=0x%x handled_net=0x%x scoped=0x%x",
> > +		  __entry->ruleset_id, __entry->handled_fs,
> > +		  __entry->handled_net, __entry->scoped));
> > +
> > +/**
> > + * landlock_free_ruleset - Ruleset freed
> > + *
> > + * Emitted when a ruleset's last reference is dropped (typically when
> > + * the creating process closes the ruleset file descriptor).
> > + */
> > +TRACE_EVENT(landlock_free_ruleset,
> > +
> > +	    TP_PROTO(const struct landlock_ruleset *ruleset),
> > +
> > +	    TP_ARGS(ruleset),
> > +
> > +	    TP_STRUCT__entry(__field(__u64, ruleset_id)),
> > +
> > +	    TP_fast_assign(__entry->ruleset_id = ruleset->id;),
> > +
> > +	    TP_printk("ruleset=%llx", __entry->ruleset_id));
> > +
> > +#endif /* _TRACE_LANDLOCK_H */
> > +
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
> > diff --git a/security/landlock/id.h b/security/landlock/id.h
> > index 45dcfb9e9a8b..2a43c2b523a8 100644
> > --- a/security/landlock/id.h
> > +++ b/security/landlock/id.h
> > @@ -8,18 +8,18 @@
> >  #ifndef _SECURITY_LANDLOCK_ID_H
> >  #define _SECURITY_LANDLOCK_ID_H
> >  
> > -#ifdef CONFIG_AUDIT
> > +#ifdef CONFIG_SECURITY_LANDLOCK_LOG
> >  
> >  void __init landlock_init_id(void);
> >  
> >  u64 landlock_get_id_range(size_t number_of_ids);
> >  
> > -#else /* CONFIG_AUDIT */
> > +#else /* CONFIG_SECURITY_LANDLOCK_LOG */
> >  
> >  static inline void __init landlock_init_id(void)
> >  {
> >  }
> >  
> > -#endif /* CONFIG_AUDIT */
> > +#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
> >  
> >  #endif /* _SECURITY_LANDLOCK_ID_H */
> > diff --git a/security/landlock/log.c b/security/landlock/log.c
> > index c9b506707af0..ef79e4ed0037 100644
> > --- a/security/landlock/log.c
> > +++ b/security/landlock/log.c
> > @@ -174,6 +174,11 @@ static void audit_denial(const struct landlock_cred_security *const subject,
> >  
> >  #endif /* CONFIG_AUDIT */
> >  
> > +#ifdef CONFIG_TRACEPOINTS
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/landlock.h>
> > +#endif /* CONFIG_TRACEPOINTS */
> > +
> >  static struct landlock_hierarchy *
> >  get_hierarchy(const struct landlock_domain *const domain, const size_t layer)
> >  {
> > diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> > index c220e0f9cf5f..0d1e3dadb318 100644
> > --- a/security/landlock/ruleset.c
> > +++ b/security/landlock/ruleset.c
> > @@ -22,10 +22,13 @@
> >  #include <linux/spinlock.h>
> >  
> >  #include "access.h"
> > +#include "id.h"
> >  #include "limits.h"
> >  #include "object.h"
> >  #include "ruleset.h"
> >  
> > +#include <trace/events/landlock.h>
> > +
> >  struct landlock_ruleset *
> >  landlock_create_ruleset(const access_mask_t fs_access_mask,
> >  			const access_mask_t net_access_mask,
> > @@ -49,6 +52,10 @@ landlock_create_ruleset(const access_mask_t fs_access_mask,
> >  	new_ruleset->rules.root_net_port = RB_ROOT;
> >  #endif /* IS_ENABLED(CONFIG_INET) */
> >  
> > +#ifdef CONFIG_SECURITY_LANDLOCK_LOG
> > +	new_ruleset->id = landlock_get_id_range(1);
> > +#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
> The addition of IDs to rulesets for logging makes sense.
> 
> But it is limited in usefulness without some form of introspection to be
> able to correlate it to a specific userspace ruleset.

The main goal for tracepoints is to correlate the created rule with all
the related updates with rule addition, and then the domain creation
from this ruleset.

> 
> If a program creates multiple Landlock rulesets, and wishes to trace and
> correlate which ruleset FD corresponds to the log/tracepoint, it is
> difficult when no form of introspection exists.

That's correct, and that's the same thing for the domain IDs, for now...

These IDs are designed to be available to unprivileged processes, so
we'll need a proper interface.  Tracepoints is the first interface to
use ruleset IDs.

> 
> Maybe a syscall flag or ioctl to retrieve the identifier for correlation
> would be useful?

An IOCTL is a good idea for rulesets.  Also, see
https://github.com/landlock-lsm/linux/issues/26 (I'll get back to it).

> 
> Justin
> > +
> >  	/* Should already be checked in sys_landlock_create_ruleset(). */
> >  	if (fs_access_mask) {
> >  		WARN_ON_ONCE(fs_access_mask !=
> > @@ -312,6 +319,7 @@ void landlock_free_rules(struct landlock_rules *const rules)
> >  static void free_ruleset(struct landlock_ruleset *const ruleset)
> > [...]
> 
