Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79F53B636E
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775566838; cv=none; b=T9sY6zVJTt8SOKltkXLxS4QtnP4J2rr0pjEVO4sv1NM1zdRoRsWZVKB0DKQKcnpwScB535qWMlEgZ5jWiSH7iTv/Ud/vzN0bL01smlV2HzKXj2DOl1pzY7jeVgsKsyG7ne4vJ9me9to6ALU8m7N4P+RRNv2v9gHekeUSwn1qems=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775566838; c=relaxed/simple;
	bh=n69LQER+gpzAtUXozptn9ySUKii4kDCxgzw5XwT4DRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXi4bMOQOQF7oIUvkfB+AuP6PhV/nb4AY+gETvlFCTrDguohXzZT8ewEyEkib32ERs01w/jUVJHHJwATWuL+ndDuVjyCd1/bqzBXaJfi09q/ncl6EVHJvQ9BuxjUuq19oioa5pr17d0MRY4MCOf9PrIa+5D7jcYpWy2EuWK+RcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=X1HQ/Mft; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="X1HQ/Mft"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fqmX06NxFzNjv;
	Tue,  7 Apr 2026 15:00:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775566832;
	bh=8ZxPSXWDIoiuY5G2zijl5txUNOYBhI92nA1iVSSfllo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X1HQ/MftNpwfQzzWsM/qUT8sNrr4dRSGYIVauVfY8Vb+O3i8VT1Fwkj0ZXmxUdkrC
	 athEYlil+TY5HuCphBRyRBIDpL2ZMOqX/q6dRPOGEq+PAKbJ0t7+28kjOpAjAy9KE0
	 +yAfw9LOy6zjg4ulROelMcOBQtX2yPlLAYjU86sQ=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fqmWz5bgFzCQy;
	Tue,  7 Apr 2026 15:00:31 +0200 (CEST)
Date: Tue, 7 Apr 2026 15:00:27 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Justin Suess <utilityemal77@gmail.com>, Kees Cook <kees@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/17] landlock: Add tracepoints for ptrace and scope
 denials
Message-ID: <20260407.Aesoo2sairai@digikod.net>
References: <20260406143717.1815792-1-mic@digikod.net>
 <20260406143717.1815792-13-mic@digikod.net>
 <20260406110123.4072a765@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260406110123.4072a765@gandalf.local.home>
X-Infomaniak-Routing: alpha

On Mon, Apr 06, 2026 at 11:01:23AM -0400, Steven Rostedt wrote:
> On Mon,  6 Apr 2026 16:37:10 +0200
> Mickaël Salaün <mic@digikod.net> wrote:
> 
> > ---
> >  include/trace/events/landlock.h | 135 ++++++++++++++++++++++++++++++++
> >  security/landlock/log.c         |  20 +++++
> >  2 files changed, 155 insertions(+)
> > 
> > diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
> > index 1afab091efba..9f96c9897f44 100644
> > --- a/include/trace/events/landlock.h
> > +++ b/include/trace/events/landlock.h
> > @@ -11,6 +11,7 @@
> >  #define _TRACE_LANDLOCK_H
> >  
> >  #include <linux/tracepoint.h>
> > +#include <net/af_unix.h>
> >  
> >  struct dentry;
> >  struct landlock_domain;
> > @@ -19,6 +20,7 @@ struct landlock_rule;
> >  struct landlock_ruleset;
> >  struct path;
> >  struct sock;
> > +struct task_struct;
> >  
> >  /**
> >   * DOC: Landlock trace events
> > @@ -433,6 +435,139 @@ TRACE_EVENT(
> >  		__entry->log_new_exec, __entry->blockers, __entry->sport,
> >  		__entry->dport));
> >  
> > +/**
> > + * landlock_deny_ptrace - ptrace access denied
> > + * @hierarchy: Hierarchy node that blocked the access (never NULL)
> > + * @same_exec: Whether the current task is the same executable that called
> > + *             landlock_restrict_self() for the denying hierarchy node
> > + * @tracee: Target task (never NULL); eBPF can read pid, comm, cred,
> > + *          namespaces, and cgroup via BTF
> > + */
> > +TRACE_EVENT(
> > +	landlock_deny_ptrace,
> > +
> > +	TP_PROTO(const struct landlock_hierarchy *hierarchy, bool same_exec,
> > +		 const struct task_struct *tracee),
> > +
> > +	TP_ARGS(hierarchy, same_exec, tracee),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(__u64, domain_id) __field(bool, same_exec)
> > +			__field(u32, log_same_exec) __field(u32, log_new_exec)
> > +				__field(pid_t, tracee_pid)
> > +					__string(tracee_comm, tracee->comm)),
> 
> Event formats are different than normal macro formatting. Please use the
> event formatting. The above is a defined structure that is being created
> for use. Keep it looking like a structure:
> 
> 	TP_STRUCT__entry(
> 		__field(	__u64,		domain_id)
> 		__field(	bool,		same_exec)
> 		__field(	u32,		log_same_exec)
> 		__field(	u32,		log_new_exec)
> 		__field(	pid_t,		tracee_pid)
> 		__string(	tracee_comm,	tracee->comm)
> 	),

I was using clang-format, but it doesn't make sense here, I'll fix it.

> 
> See how the above resembles:
> 
> struct entry {
> 	__u64		domain_id;
> 	bool		same_exec;
> 	u32		log_same_exec;
> 	u32		log_new_exec;
> 	pid_t		tracee_pid;
> 	string		tracee_comm;
> };
> 
> Because that's pretty much what the trace event TP_STRUCT__entry() is going
> to do with it. (The string will obviously be something else).
> 
> This way it's also easy to spot wholes in the structure that is written
> into the ring buffer. The "same_exec" being a bool followed by two u32
> types, is going to cause a hole. Move it to between tracee_pid and
> tracee_comm.

Actually, the log_* field should be bool too.  Anyway, is it a concern
that the ring buffer leaks (previous event) kernel memory or is the
concern mostly about avoiding wasted space and making easy to spot holes
even if it's OK?

> 
> Please fix the other events too.

Sure. Thanks!

> 
> -- Steve
> 
> 
> > +
> > +	TP_fast_assign(__entry->domain_id = hierarchy->id;
> > +		       __entry->same_exec = same_exec;
> > +		       __entry->log_same_exec = hierarchy->log_same_exec;
> > +		       __entry->log_new_exec = hierarchy->log_new_exec;
> > +		       __entry->tracee_pid =
> > +			       task_tgid_nr((struct task_struct *)tracee);
> > +		       __assign_str(tracee_comm);),
> > +
> > +	TP_printk(
> > +		"domain=%llx same_exec=%d log_same_exec=%u log_new_exec=%u tracee_pid=%d comm=%s",
> > +		__entry->domain_id, __entry->same_exec, __entry->log_same_exec,
> > +		__entry->log_new_exec, __entry->tracee_pid,
> > +		__print_untrusted_str(tracee_comm)));

Are you OK with this new helper?

> > +
> >
> 
