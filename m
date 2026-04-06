Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574101DED40;
	Mon,  6 Apr 2026 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775487619; cv=none; b=O1j2/eCu7hZfeUVb2NvgVi15+eusx+Abw/L8Jvlxk3Rb1RzbMhDcQv8BkkvI8WTKj236cG0zGKFoB4cKhK+1v/VRc1/QzdSHiBOeCwBdLAeC7zQMf4qUKXZl/rEmlY7tCdH8FpH7+18nkQ8uKfJJFeS9etQLsbR9OszsGQ2wwYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775487619; c=relaxed/simple;
	bh=fWsGmb1Fw37OxBHg4rHYiZ57RuO0n0OIC3nqp6NAhAU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzBfRv23N+1iGXv+zayTbCosVn+pfelTh/lGh0svf147uckIgVJSHYwD47pPsqYjhgPSNAIQ24q3UNVgWBYp65XAoenunmQUQvaCK6Tm2vHMk6r8jQlNEW1HBDsIlOGvyh3GS66u0+Hg62JlqdXQ9dr8FPs9H1qrBBi+aQNUwyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id CDCE7140476;
	Mon,  6 Apr 2026 15:00:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 82BC360015;
	Mon,  6 Apr 2026 15:00:11 +0000 (UTC)
Date: Mon, 6 Apr 2026 11:01:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, =?UTF-8?B?R8O8bnRoZXI=?= Noack
 <gnoack@google.com>, Jann Horn <jannh@google.com>, Jeff Xu
 <jeffxu@google.com>, Justin Suess <utilityemal77@gmail.com>, Kees Cook
 <kees@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Matthieu Buffet
 <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/17] landlock: Add tracepoints for ptrace and scope
 denials
Message-ID: <20260406110123.4072a765@gandalf.local.home>
In-Reply-To: <20260406143717.1815792-13-mic@digikod.net>
References: <20260406143717.1815792-1-mic@digikod.net>
	<20260406143717.1815792-13-mic@digikod.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: gwnxd6j845pikyrfe6c6z9qip457uz1j
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 82BC360015
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18rtP2BghMwmlrtx2qAWEFbjUEnEf4mmow=
X-HE-Tag: 1775487611-32422
X-HE-Meta: U2FsdGVkX1+VAppAuFeAFAjIyqYgaDFfLssgTYp556s0ZvwVmjq3yZTVi2E59j+UzcVVSghO7YKl1+rgKKFUDuPLkmeAGhcNa6DUCBycRMeE9u9PaGPVHLmamFQrLLyWwVF5wDyZPxiAefu2aMHrBibVTonhMDI3912zBmU2Ppke9SHuR0D2tcjpkTWH+kJ4VZSCBxHK2GFJ9CRKhhDwTxBVP4VVOOtZTNy3HW0EkiCcajJIqK/cbirP4Y1wZM45GdUVC0cj31B7ZJUU7JK5PBJqFTmtoUFJf7PFJuTIebAMvI4IyIG1e55jWMpmOXaJZY9BYDv2idbfpeeTiR+5j2j5g8RfmH2O1XUonxA6prE9HT7kbwNswIgvjrM2bQQf

On Mon,  6 Apr 2026 16:37:10 +0200
Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wrote:

> ---
>  include/trace/events/landlock.h | 135 ++++++++++++++++++++++++++++++++
>  security/landlock/log.c         |  20 +++++
>  2 files changed, 155 insertions(+)
>=20
> diff --git a/include/trace/events/landlock.h b/include/trace/events/landl=
ock.h
> index 1afab091efba..9f96c9897f44 100644
> --- a/include/trace/events/landlock.h
> +++ b/include/trace/events/landlock.h
> @@ -11,6 +11,7 @@
>  #define _TRACE_LANDLOCK_H
> =20
>  #include <linux/tracepoint.h>
> +#include <net/af_unix.h>
> =20
>  struct dentry;
>  struct landlock_domain;
> @@ -19,6 +20,7 @@ struct landlock_rule;
>  struct landlock_ruleset;
>  struct path;
>  struct sock;
> +struct task_struct;
> =20
>  /**
>   * DOC: Landlock trace events
> @@ -433,6 +435,139 @@ TRACE_EVENT(
>  		__entry->log_new_exec, __entry->blockers, __entry->sport,
>  		__entry->dport));
> =20
> +/**
> + * landlock_deny_ptrace - ptrace access denied
> + * @hierarchy: Hierarchy node that blocked the access (never NULL)
> + * @same_exec: Whether the current task is the same executable that call=
ed
> + *             landlock_restrict_self() for the denying hierarchy node
> + * @tracee: Target task (never NULL); eBPF can read pid, comm, cred,
> + *          namespaces, and cgroup via BTF
> + */
> +TRACE_EVENT(
> +	landlock_deny_ptrace,
> +
> +	TP_PROTO(const struct landlock_hierarchy *hierarchy, bool same_exec,
> +		 const struct task_struct *tracee),
> +
> +	TP_ARGS(hierarchy, same_exec, tracee),
> +
> +	TP_STRUCT__entry(
> +		__field(__u64, domain_id) __field(bool, same_exec)
> +			__field(u32, log_same_exec) __field(u32, log_new_exec)
> +				__field(pid_t, tracee_pid)
> +					__string(tracee_comm, tracee->comm)),

Event formats are different than normal macro formatting. Please use the
event formatting. The above is a defined structure that is being created
for use. Keep it looking like a structure:

	TP_STRUCT__entry(
		__field(	__u64,		domain_id)
		__field(	bool,		same_exec)
		__field(	u32,		log_same_exec)
		__field(	u32,		log_new_exec)
		__field(	pid_t,		tracee_pid)
		__string(	tracee_comm,	tracee->comm)
	),

See how the above resembles:

struct entry {
	__u64		domain_id;
	bool		same_exec;
	u32		log_same_exec;
	u32		log_new_exec;
	pid_t		tracee_pid;
	string		tracee_comm;
};

Because that's pretty much what the trace event TP_STRUCT__entry() is going
to do with it. (The string will obviously be something else).

This way it's also easy to spot wholes in the structure that is written
into the ring buffer. The "same_exec" being a bool followed by two u32
types, is going to cause a hole. Move it to between tracee_pid and
tracee_comm.

Please fix the other events too.

-- Steve


> +
> +	TP_fast_assign(__entry->domain_id =3D hierarchy->id;
> +		       __entry->same_exec =3D same_exec;
> +		       __entry->log_same_exec =3D hierarchy->log_same_exec;
> +		       __entry->log_new_exec =3D hierarchy->log_new_exec;
> +		       __entry->tracee_pid =3D
> +			       task_tgid_nr((struct task_struct *)tracee);
> +		       __assign_str(tracee_comm);),
> +
> +	TP_printk(
> +		"domain=3D%llx same_exec=3D%d log_same_exec=3D%u log_new_exec=3D%u tra=
cee_pid=3D%d comm=3D%s",
> +		__entry->domain_id, __entry->same_exec, __entry->log_same_exec,
> +		__entry->log_new_exec, __entry->tracee_pid,
> +		__print_untrusted_str(tracee_comm)));
> +
>
