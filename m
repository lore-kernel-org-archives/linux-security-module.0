Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD382339B3D
	for <linux-security-module@vger.kernel.org>; Tue, 28 Jul 2026 22:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279143; cv=none; b=dhO9sDIrKFTh891Psz0pulJrNyPqhFpzWfMdVfl+hrfJwvQR2oozEB6Onu7ilrsd5PaYBWSGidYFfX4bQXn0S7aR6dty0KVTOEO2cAE2RYzdszeHZN0c889unKgS+dw9fsJEUEX7IWpQZN2+Q7eiZmlPXHCc91FRrOxPCzbPOu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279143; c=relaxed/simple;
	bh=vbG/afS2jM+6Mi8MVhFOFthV7zYwQoqpXdlIshgOJS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RofiurF/EdU4Eu7LA5jmLZVMeE4rf1OxuVaSkctOp7vWYAe+EX6j5Ya7Iv5QYt7LQegy33HJkn5mir0ImnBmI+IicaEIIW/MEDeXsGtHO+Him8+csf46+TdzJvitpDKNo4w4Pk11PAFUKZ/G0TEo83yZNApDiiRR8AnVeLQ0Bq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFooTWbc; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFooTWbc"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81e9d8f3289so6031757b3.1
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jul 2026 15:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785279141; x=1785883941; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uPumpig1LSNZCbOMr/7Ory4bimOiAIYjHcwSmavCl04=;
        b=LFooTWbcr9tTqj3gu2w9AhREGksMnPD0QtAmln2MLvCzvKJXePL5G7MzanSihNIxCK
         1Wk6Qu2NOvL6qxRPwehq/tzV9mkCd00hxw8OuvEFOS4KuOOMdNqerb3u5qDIHeNR99CK
         ZPU6LoZxVDdmHOINZSJKn+ANHUEXBMYIfqVB1DXdxqheW7gyYY8SScjFseUmJKpQHiRb
         16++fr/HCzOO0dSBDsV62kGB/7AZoiZdfr0hbmT0pIehzn76HH8fzBmiabMsW+tO5Gs8
         I2mLlXT5Xu2uYQeymgje4N7EVRg0iH6aBYBBS+WmT9k16VGE1W3IskcfREgXs/DKNPwb
         0QTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785279141; x=1785883941;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uPumpig1LSNZCbOMr/7Ory4bimOiAIYjHcwSmavCl04=;
        b=NG3M2Jk1B2l2RWjKroFB4c9v1ke6dzOxfMeoI39ce95am05yb4jjwHUhXcAtxnCU7W
         1b7Uovhyj323KumWG7iJedyNvNA8fLX3tIC2TkUI/U1pfQlBre1I+rpZP8lE+XzQDpwr
         usAgHRDNdjsFVhJoWFC5YXgKAnH9J//vtPjXwnWO0kpCdjVGCAvSvk1V7jGUpXr2okte
         aojs5UnS2utwtvahSJznVsIun9A2TSmDYbG60Fgi/NgT9C88qKD22voVVTi8m11oLV4x
         zk5XCWqMOQFJW0nwz3ZcWEUfEqXCiofCHzjF/f4/+TYDNzaQ+zQjRpHMb2DRJjyRQii+
         vncg==
X-Forwarded-Encrypted: i=1; AHgh+Rp36zYFzLWhmmlTBP/iWs6qcKsqA69j2lFhgec643tbsg/ysnzP2N26iWju/z+cvQHRODsaDGMkPdsRouOwk2wjvPcWGSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2/xjDAwqXPg+di0t490KJfX2Uw6xmJnzpK0t9T/DJxpN4u7eT
	z3VJa1bZHzvc6GmlZNna52TReRkzJI8Za4TaF0iStrfsPRYbUkw3ovUj
X-Gm-Gg: AR+sD10kIqb9Mvma6Y4ogzUvzz/S58fAF2wkWV/hrhK2u8F/A6RqSjL/BqT3TMs3GXV
	usUMJZ12UzB8x/NCGsle5IaEJKR85Zgv7f6u8JxmSjCVzbPMxlABRPDe/RNIsPg82hyCAL+2JZQ
	rQKNSp1Sck6u8BOqCUn60qYKeJqJ7sv5nITfpBBZXC7AbttN8mBHg4Ti0ZE+pIc2i6rHeB3ZXMF
	AT1v4EppXWMvt4zZZIVNd+sZ/i+ATpjov2Yr8moPz+drpkJkQkp2327tt0QXwwxxl1c8P6Lng8o
	6g2SOjbXwX+oaMaFpyswachx/QBg/c0g4e3M/xWI9hHnchWOJ8lCCje8IIVIQfNdm0H1J9i5GfK
	dp631HUXokshy5W3xYVWYVy980KbqRE5UkNSQ4nq4o5nrnuUTdecWtatkGvjZUMHKFs9hG2qD/c
	Wlr0x/gNCggkVJKjn8ddxWydQRUDp1IvjKuy9vM+6IWnqkiDNBRIOHEyGax1dh036JBmxC+QIst
	A/Hq1hdoI8+fJvbnMkyPpw=
X-Received: by 2002:a05:690c:7205:b0:80c:85c6:898f with SMTP id 00721157ae682-81f99260de1mr18995407b3.62.1785279140753;
        Tue, 28 Jul 2026 15:52:20 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:722a:22a9:308b:2c35])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa29aeba6sm7138657b3.47.2026.07.28.15.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 15:52:20 -0700 (PDT)
Date: Tue, 28 Jul 2026 18:52:19 -0400
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
Message-ID: <amkx1TBWk6AieKuw@zenbox>
References: <20260406143717.1815792-1-mic@digikod.net>
 <20260406143717.1815792-7-mic@digikod.net>
 <ahYOJwpiEI-gGx1Z@suesslenovo>
 <20260728.nohNgei7Nei9@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260728.nohNgei7Nei9@digikod.net>

On Tue, Jul 28, 2026 at 10:56:16PM +0200, Mickaël Salaün wrote:
> On Tue, May 26, 2026 at 05:34:59PM -0400, Justin Suess wrote:
> > On Mon, Apr 06, 2026 at 04:37:04PM +0200, Mickaël Salaün wrote:
> > > Add tracepoints for ruleset lifecycle events: landlock_create_ruleset
> > > fires from the landlock_create_ruleset() syscall handler, logging the
> > > ruleset Landlock ID and handled access masks; landlock_free_ruleset
> > > fires in free_ruleset() before the ruleset is freed, so eBPF programs
> > > can access the full ruleset state via BTF.
> > > 
> > > The create_ruleset TP_PROTO takes only the ruleset pointer.  The handled
> > > access masks are read from the ruleset in TP_fast_assign rather than
> > > passed as scalar arguments, so eBPF programs can access the full ruleset
> > > state (rules, access masks) via BTF on a single pointer.  No lock is
> > > needed because the ruleset is not yet shared (the file descriptor has
> > > not been installed).
> > > 
> > > Create the trace header with a DOC comment documenting the consistency
> > > guarantees, locking conventions, TP_PROTO safety, and security
> > > considerations shared by all Landlock tracepoints.  Add
> > > CREATE_TRACE_POINTS in log.c to generate the tracepoint implementations.
> > > 
> > > Add an id field to struct landlock_ruleset, assigned from
> > > landlock_get_id_range() at creation time.  Extend the CONFIG guard on
> > > landlock_get_id_range() from CONFIG_AUDIT to
> > > CONFIG_SECURITY_LANDLOCK_LOG so that IDs are available for tracing even
> > > without audit support.
> > > 
> > > The deallocation events use the "free_" prefix (rather than "drop_")
> > > because they fire when the object is actually freed.  There is no need
> > > for allocated/deallocated symmetry because ruleset creation happens with
> > > the landlock_create_ruleset tracepoint.
> > > 
> > > landlock_create_ruleset tracepoint.
> > > 
> > > Unlike audit records which share a record type and need a "status="
> > > field to distinguish allocation from deallocation, tracepoints provide
> > > one event type per lifecycle transition, each with a type-safe TP_PROTO
> > > matching the specific transition.  This enables type-safe eBPF BTF
> > > access and precise ftrace filtering by event name.
> > > 
> > > Cc: Günther Noack <gnoack@google.com>
> > > Cc: Justin Suess <utilityemal77@gmail.com>
> > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Tingmao Wang <m@maowtm.org>
> > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > ---
> > > 
> > > Changes since v1:
> > > - New patch (split from the v1 add_rule_fs tracepoint patch).
> > > ---
> > >  MAINTAINERS                     |  1 +
> > >  include/trace/events/landlock.h | 94 +++++++++++++++++++++++++++++++++
> > >  security/landlock/id.h          |  6 +--
> > >  security/landlock/log.c         |  5 ++
> > >  security/landlock/ruleset.c     |  8 +++
> > >  security/landlock/ruleset.h     |  9 ++++
> > >  security/landlock/syscalls.c    |  5 ++
> > >  7 files changed, 125 insertions(+), 3 deletions(-)
> > >  create mode 100644 include/trace/events/landlock.h
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index c3fe46d7c4bc..51104faa3951 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -14389,6 +14389,7 @@ F:	Documentation/admin-guide/LSM/landlock.rst
> > >  F:	Documentation/security/landlock.rst
> > >  F:	Documentation/userspace-api/landlock.rst
> > >  F:	fs/ioctl.c
> > > +F:	include/trace/events/landlock.h
> > >  F:	include/uapi/linux/landlock.h
> > >  F:	samples/landlock/
> > >  F:	security/landlock/
> > > diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
> > > new file mode 100644
> > > index 000000000000..5e847844fbf7
> > > --- /dev/null
> > > +++ b/include/trace/events/landlock.h
> > > @@ -0,0 +1,94 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright © 2025 Microsoft Corporation
> > > + * Copyright © 2026 Cloudflare
> > > + */
> > > +
> > > +#undef TRACE_SYSTEM
> > > +#define TRACE_SYSTEM landlock
> > > +
> > > +#if !defined(_TRACE_LANDLOCK_H) || defined(TRACE_HEADER_MULTI_READ)
> > > +#define _TRACE_LANDLOCK_H
> > > +
> > > +#include <linux/tracepoint.h>
> > > +
> > > +struct landlock_ruleset;
> > > +
> > > +/**
> > > + * DOC: Landlock trace events
> > > + *
> > > + * Consistency guarantee: every trace event corresponds to an operation
> > > + * that has irrevocably succeeded.  Lifecycle events fire only after
> > > + * the point of no return; denial events fire only for denials that
> > > + * actually happen.  This guarantees that eBPF programs observing the
> > > + * trace stream can build a faithful model of Landlock state without
> > > + * reconciliation logic.
> > > + *
> > > + * Mutable object pointers in TP_PROTO (e.g., struct landlock_ruleset
> > > + * for add_rule events) are passed while the caller holds the object's
> > > + * lock, so that TP_fast_assign and eBPF programs reading via BTF see a
> > > + * consistent snapshot.  For objects that are immutable at the emission
> > > + * site (e.g., a domain after creation), no lock is needed.
> > > + *
> > > + * All pointer arguments in TP_PROTO are guaranteed non-NULL by the
> > > + * caller.  eBPF programs can access these pointers via BTF for richer
> > > + * introspection than the TP_STRUCT__entry fields provide.
> > > + *
> > > + * TP_STRUCT__entry fields serve TP_printk display only.  eBPF programs
> > > + * access the raw TP_PROTO arguments directly.
> > > + *
> > > + * Security: as for audit, Landlock trace events may expose sensitive
> > > + * information about all sandboxed processes on the system.  See
> > > + * Documentation/admin-guide/LSM/landlock.rst for security considerations
> > > + * and privilege requirements.
> > > + */
> > > +
> > > +/**
> > > + * landlock_create_ruleset - new ruleset created
> > > + * @ruleset: Newly created ruleset (never NULL); not yet shared via an fd,
> > > + *           so no lock is needed.  eBPF programs can read the full ruleset
> > > + *           state via BTF.
> > > + */
> > > +TRACE_EVENT(
> > > +	landlock_create_ruleset,
> > > +
> > > +	TP_PROTO(const struct landlock_ruleset *ruleset),
> > > +
> > > +	TP_ARGS(ruleset),
> > > +
> > > +	TP_STRUCT__entry(__field(__u64, ruleset_id) __field(access_mask_t,
> > > +							    handled_fs)
> > > +				 __field(access_mask_t, handled_net)
> > > +					 __field(access_mask_t, scoped)),
> > > +
> > > +	TP_fast_assign(__entry->ruleset_id = ruleset->id;
> > > +		       __entry->handled_fs = ruleset->layer.fs;
> > > +		       __entry->handled_net = ruleset->layer.net;
> > > +		       __entry->scoped = ruleset->layer.scope;),
> > > +
> > > +	TP_printk("ruleset=%llx handled_fs=0x%x handled_net=0x%x scoped=0x%x",
> > > +		  __entry->ruleset_id, __entry->handled_fs,
> > > +		  __entry->handled_net, __entry->scoped));
> > > +
> > > +/**
> > > + * landlock_free_ruleset - Ruleset freed
> > > + *
> > > + * Emitted when a ruleset's last reference is dropped (typically when
> > > + * the creating process closes the ruleset file descriptor).
> > > + */
> > > +TRACE_EVENT(landlock_free_ruleset,
> > > +
> > > +	    TP_PROTO(const struct landlock_ruleset *ruleset),
> > > +
> > > +	    TP_ARGS(ruleset),
> > > +
> > > +	    TP_STRUCT__entry(__field(__u64, ruleset_id)),
> > > +
> > > +	    TP_fast_assign(__entry->ruleset_id = ruleset->id;),
> > > +
> > > +	    TP_printk("ruleset=%llx", __entry->ruleset_id));
> > > +
> > > +#endif /* _TRACE_LANDLOCK_H */
> > > +
> > > +/* This part must be outside protection */
> > > +#include <trace/define_trace.h>
> > > diff --git a/security/landlock/id.h b/security/landlock/id.h
> > > index 45dcfb9e9a8b..2a43c2b523a8 100644
> > > --- a/security/landlock/id.h
> > > +++ b/security/landlock/id.h
> > > @@ -8,18 +8,18 @@
> > >  #ifndef _SECURITY_LANDLOCK_ID_H
> > >  #define _SECURITY_LANDLOCK_ID_H
> > >  
> > > -#ifdef CONFIG_AUDIT
> > > +#ifdef CONFIG_SECURITY_LANDLOCK_LOG
> > >  
> > >  void __init landlock_init_id(void);
> > >  
> > >  u64 landlock_get_id_range(size_t number_of_ids);
> > >  
> > > -#else /* CONFIG_AUDIT */
> > > +#else /* CONFIG_SECURITY_LANDLOCK_LOG */
> > >  
> > >  static inline void __init landlock_init_id(void)
> > >  {
> > >  }
> > >  
> > > -#endif /* CONFIG_AUDIT */
> > > +#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
> > >  
> > >  #endif /* _SECURITY_LANDLOCK_ID_H */
> > > diff --git a/security/landlock/log.c b/security/landlock/log.c
> > > index c9b506707af0..ef79e4ed0037 100644
> > > --- a/security/landlock/log.c
> > > +++ b/security/landlock/log.c
> > > @@ -174,6 +174,11 @@ static void audit_denial(const struct landlock_cred_security *const subject,
> > >  
> > >  #endif /* CONFIG_AUDIT */
> > >  
> > > +#ifdef CONFIG_TRACEPOINTS
> > > +#define CREATE_TRACE_POINTS
> > > +#include <trace/events/landlock.h>
> > > +#endif /* CONFIG_TRACEPOINTS */
> > > +
> > >  static struct landlock_hierarchy *
> > >  get_hierarchy(const struct landlock_domain *const domain, const size_t layer)
> > >  {
> > > diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> > > index c220e0f9cf5f..0d1e3dadb318 100644
> > > --- a/security/landlock/ruleset.c
> > > +++ b/security/landlock/ruleset.c
> > > @@ -22,10 +22,13 @@
> > >  #include <linux/spinlock.h>
> > >  
> > >  #include "access.h"
> > > +#include "id.h"
> > >  #include "limits.h"
> > >  #include "object.h"
> > >  #include "ruleset.h"
> > >  
> > > +#include <trace/events/landlock.h>
> > > +
> > >  struct landlock_ruleset *
> > >  landlock_create_ruleset(const access_mask_t fs_access_mask,
> > >  			const access_mask_t net_access_mask,
> > > @@ -49,6 +52,10 @@ landlock_create_ruleset(const access_mask_t fs_access_mask,
> > >  	new_ruleset->rules.root_net_port = RB_ROOT;
> > >  #endif /* IS_ENABLED(CONFIG_INET) */
> > >  
> > > +#ifdef CONFIG_SECURITY_LANDLOCK_LOG
> > > +	new_ruleset->id = landlock_get_id_range(1);
> > > +#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
> > The addition of IDs to rulesets for logging makes sense.
> > 
> > But it is limited in usefulness without some form of introspection to be
> > able to correlate it to a specific userspace ruleset.
> 
> The main goal for tracepoints is to correlate the created rule with all
> the related updates with rule addition, and then the domain creation
> from this ruleset.
> 
> > 
> > If a program creates multiple Landlock rulesets, and wishes to trace and
> > correlate which ruleset FD corresponds to the log/tracepoint, it is
> > difficult when no form of introspection exists.
> 
> That's correct, and that's the same thing for the domain IDs, for now...
> 
> These IDs are designed to be available to unprivileged processes, so
> we'll need a proper interface.  Tracepoints is the first interface to
> use ruleset IDs.
>
Makes sense. It need not be a part of this series, just something
to consider later on.

Justin

> > [...]
