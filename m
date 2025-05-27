Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BEC275861
	for <linux-security-module@vger.kernel.org>; Tue, 27 May 2025 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357586; cv=none; b=THRA2owFcfh8S3VtJsZbl8CJAg+5P+pt6jsrniBWnRdhxoV8D5wIyig1rKzSdBMBqIca0jzm2u/FjyB+vtISS0VPJ3tO8YKOqj0x40/Rln8FuOpQjaypGXk7tz1neASF6n09b/nMHCUklBbwrgaR7AJatGz64rSIdE2p/9OQXww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357586; c=relaxed/simple;
	bh=9HAVGlFIX/JYEWRBeEZIvY9UFOX70BjYYPdGiZ/Y7cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cb6VJcsMpExHLbLh8UcWDWGwdpSB4fof8L4S0o7tdxVNwCRyo5yfQEnTVl1EyvScQ84q+SRyrdx3NR6+HHbE3nNhj69RmZ0O9MNdpnTbU3CLJDIkdCqikcHf1Smw03I3WEK4JrC5FFOvTtTvawiRjnmSpI4L1W1SfRJxU+ptgbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=VNhsXuKm; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="VNhsXuKm"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b6Fx17432zjKJ;
	Tue, 27 May 2025 16:52:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748357573;
	bh=hM2848gzLaiP+HIZKcDCPJQWC8M1cqobtz6hhFh/Bk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VNhsXuKmuTNy/AlEYqi4co2V2VjRQaHzgPmisKO9pawPwzpQ8nUXK+Fx3rC9RE0vY
	 rOFSfCBS8erODudOakMClXLFn5icdnXn7nWeGoRQrvAndhCecC3MEKwkePQW4j8FpL
	 c2BQblMebQYQURrB6lcujLJWsXzmwpCY/we9MsnQ=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4b6Fx02p1Rzm6F;
	Tue, 27 May 2025 16:52:52 +0200 (CEST)
Date: Tue, 27 May 2025 16:52:51 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Kees Cook <kees@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Ryan Sullivan <rysulliv@redhat.com>, 
	Shervin Oloumi <enlightened@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/5] Landlock tracepoints
Message-ID: <20250527.Jo9reu7zaeco@digikod.net>
References: <20250523165741.693976-1-mic@digikod.net>
 <b6f1e330-6a9f-4359-a221-bec30d94fb20@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6f1e330-6a9f-4359-a221-bec30d94fb20@maowtm.org>
X-Infomaniak-Routing: alpha

On Mon, May 26, 2025 at 07:37:41PM +0100, Tingmao Wang wrote:
> On 5/23/25 17:57, Mickaël Salaün wrote:
> > Hi,
> > 
> > This series adds two tracepoints to Landlock, one tied to rule addition,
> > and another to rule checking.  With these new tracepoints, we can see
> > all steps leading to an access decision.  They can be directly used with
> > /sys/kernel/tracing/events/landlock/* or attached by eBPF programs to
> > get a more complete view of Landlock internals.
> > 
> > This new feature is useful to trouble shoot policy issues, and it should
> > also limit the need for custom debugging kernel code when developing new
> > Landlock features.
> > 
> > Landlock already has audit support, which enables us to log denied
> > access requests.  Audit is useful to identify security issues or sandbox
> > misconfiguration.  However, it might not be enough to debug Landlock
> > policies.  The main differences with audit events is that traces are
> > disabled by default, can be very verbose, and can be filtered according
> > to process and Landlock properties (e.g. domain ID).
> > 
> > As for audit, this tracing feature may expose sensitive information and
> > must then only be accessible to the system administrator.
> > 
> > This RFC only fully supports filesystem rules but the next series will
> > also support network rules.  Tests are also missing for now.
> > 
> > Regards,
> > 
> > Mickaël Salaün (5):
> >    landlock: Rename landlock_id to landlock_rule_ref
> >    landlock: Merge landlock_find_rule() into landlock_unmask_layers()
> >    tracing: Add __print_untrusted_str()
> >    landlock: Add landlock_add_rule_fs tracepoint
> >    landlock: Add landlock_check_rule tracepoint
> > 
> >   MAINTAINERS                                |   1 +
> >   include/linux/trace_events.h               |   3 +
> >   include/trace/events/landlock.h            | 124 ++++++++++++++
> >   include/trace/stages/stage3_trace_output.h |   4 +
> >   include/trace/stages/stage7_class_define.h |   1 +
> >   kernel/trace/trace_output.c                |  40 +++++
> >   security/landlock/Makefile                 |  11 +-
> >   security/landlock/fs.c                     | 178 +++++++++++++--------
> >   security/landlock/fs.h                     |   3 +
> >   security/landlock/net.c                    |  18 +--
> >   security/landlock/ruleset.c                |  65 ++++----
> >   security/landlock/ruleset.h                |  15 +-
> >   security/landlock/trace.c                  |  15 ++
> >   13 files changed, 365 insertions(+), 113 deletions(-)
> >   create mode 100644 include/trace/events/landlock.h
> >   create mode 100644 security/landlock/trace.c
> > 
> > 
> > base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21
> 
> Tested-by: Tingmao Wang <m@maowtm.org>
> 
> Here is an example output I got with `trace-cmd record -e landlock`:
> 
> landlock-add-ru-776   [001] 75134.554776: landlock_add_rule_fs: [FAILED TO
> PARSE] ruleset=0xffff88811a459200 ref_key=18446612686420679296 allowed=57343
> dev=21 ino=53 pathname=/tmp/test
> landlock-add-ru-776   [001] 75134.555336: landlock_check_rule:  [FAILED TO
> PARSE] domain_id=7838764077 access_request=4 ref_type=1
> ref_key=18446612686420679296 layers=ARRAY[ff, df]
> I suggest adding some more events which I think shouldn't be too difficult
> to implement and I can see them helping a lot with tracing / debugging
> especially by BPF programs or someone new to landlock:
> 
> - landlock_restrict_self: Currently we trace out the ruleset pointer in add
> rule, and the domain ID in check rule.  However there is no way for someone
> just looking at this trace (or a BPF program for landlock) to relate which
> rulesets are applied to which domains. I think a simple event we could add
> that will help with this is, on landlock_restrict_self, prints out the
> ruleset passed in as well as the domain ID newly created.  Maybe also
> num_rules and num_layers on the new ruleset since it's trivial to do so, and
> could be informative to someone analyzing a Landlock thing.

Yep, that was my plan for v2. :)

I was also wondering about adding a tracepoint for ruleset creation.
This one would print the ruleset's attributes as an array.

> 
> - landlock_check_fs: Distinct from landlock_check_rule, this will happen
> once the outcome of the access check is determined (maybe at the end of
> is_access_to_paths_allowed and collect_domain_accesses?). It would include
> the pathname of the target file (only allocated if this event is enabled of
> course), so something like:
> 
>   landlock_check_fs: domain_id=7838764077 access_request=4
> pathname=/tmp/test allowed=true
>   landlock_check_fs: domain_id=7838764077 access_request=4
> pathname=/tmp/test2 allowed=false
> 
> We already produces audit logs for denied requests so it is a little bit
> duplicating that, but I think this trace event shouldn't be too costly to
> include.  It has the benefit that
> 
> 1. If an access is denied because no rules matched, we don't get any
> landlock_check_rule traces, and so there's no way for someone looking at the
> trace log to find out landlock denied something.

That would indeed be useful to see final access decisions.  It might be
a bit tricky to generically handle all the allowed access but I'll try
something.

> 
> 2. Having an event that represents an access check makes it possible for BPF
> programs to find out about all landlock access checks (most interestingly
> denied ones but we could expose the allowed ones too), and potentially
> relate the various `landlock_check_rule` events to an access check.
> 
> Actually, maybe it's worth having a "landlock_check_fs_enter", emitted at
> the beginning of is_access_to_paths_allowed and collect_domain_accesses?
> This could be useful for performance measurements, and also makes it more

Aren't kprobes/kretprobes enough for performance measurement?  They can
also be used with current kernels.

> explicit which landlock_check_rule resulted from which access check.  Maybe
> the pathname and domain_id could be printed on the enter event, and the exit
> event would just have the outcome?  (Just an idea, I feel less certain about
> this. "Enter"/"exit" naming taken from sys_enter_*/sys_exit_* but start/end
> also works)

This landlock_check_fs_enter event would only be called after the
landlock_get_applicable_subject() check though.
