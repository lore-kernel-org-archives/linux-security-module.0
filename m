Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2BD25A645
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 21:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533325; cv=none; b=oOvDZ6Fpi1brssGt0n8ZQm7Rjd8OuTioFI8OYHaljWjy9mq+dJ06RNYJBRkO2GuGtCFQLH7VCB0lGbKq2TJ+J4mNGh4xZngFvNy9tizddeeWPwR4V/UYztvjdUluI5xrRpEHAk84Z5icHU0UD8+4gSn8FfK1rZQzqmykvjhPvDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533325; c=relaxed/simple;
	bh=B8msuMQAYYvZCb7GgKBIKpOdnZtU3cVRwuQ5FnXv+2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjH+mdrdc4QJTUHaFIdcY0kKSafAr6MNUzoIiVpk2Dc2vhQ5zDGEyRVphNb3cptIQAcfVsarsI3MXisEOYn2BeORwpa0+uob9HQfs/XcqmewWa2BZ01p/9E09Ua42jMM6lYfIn1+gkGSyY4HcZJnmUjwncK1UtJY6BlOp57gzIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XMtMZVOL; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XMtMZVOL"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hBfMC01h4zfkl;
	Fri, 31 Jul 2026 23:28:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785533318;
	bh=cke+5UBfzcHcPlxUolzeeKyvGKG6W+rSkhQah/BnTfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMtMZVOLGDyB11SZveGrXtx1R2YUzkc9L+4MJodPTVIXwidkaA8kktfaZAO8YixfI
	 oJvZ2HaXeTqHcG+dL7hzrliJN69CxOGxwo+dNEjdVTof9S0NHHy56mp/w95M4HkYlb
	 fJFHZa0brMTVKRBGaYY9saxXTaonhB4nl5630ncs=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hBfMB31brzkt9;
	Fri, 31 Jul 2026 23:28:38 +0200 (CEST)
Date: Fri, 31 Jul 2026 23:28:37 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: linux-security-module@vger.kernel.org, gnoack@google.com
Subject: Re: [PATCH 0/3] Implement LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
Message-ID: <20260731.oogh6ieV9Fei@digikod.net>
References: <20260708133928.852999-1-utilityemal77@gmail.com>
 <20260709.Eaphooyoh6sh@digikod.net>
 <ak-d2RiJDubT5SVB@suesslenovo>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ak-d2RiJDubT5SVB@suesslenovo>
X-Infomaniak-Routing: alpha

On Fri, Jul 10, 2026 at 09:56:25AM -0400, Justin Suess wrote:
> On Thu, Jul 09, 2026 at 12:09:25PM +0200, Mickaël Salaün wrote:
> > Hi Justin,
> > 
> > Thanks for this patch series, I like the underlying idea, but I'm not
> > convince we should mix NNP and ON_EXEC.  Why not a
> > LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS flag instead?
> > 
> tldr I think your idea is better, see below.
> > One issue with this NNP_ON_EXEC is that it might be confusing for one
> > thread to set it and expect the next exec to be NNP, but if the exec is
> > requested by another thread that would not happen.  With a
> > LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS flag, we could have an atomic
> > Landlock and NNP enforcement, which can also be combined with the TSYNC
> > flag, both useful cases.
> >
> > If we want an enforcement to happen at exec time, we could add a
> > dedicated flag, similar to the TSYNC one, but I'm not sure it would be
> > useful for now.
> > 
> > On Wed, Jul 08, 2026 at 09:39:24AM -0400, Justin Suess wrote:
> > > Good morning,
> > > 
> > > This series adds a new landlock_restrict_self(2) flag:
> > > LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC.
> > > 
> > > This flag stages a bit in the Landlock credentials indicating that the
> > > next successful execution will set the no_new_privs attribute while
> > > committing its new credentials.
> > > 
> > > Differences from prctl(PR_SET_NO_NEW_PRIVS):
> > > 
> > > PR_SET_NO_NEW_PRIVS takes effect immediately: it prevents gaining
> > > privileges through set-user-ID, set-group-ID and file capabilities
> > > starting with the very next execve(2).
> > > 
> > > LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC instead only sets the task's
> > > no_new_privs attribute once the next execve(2) is guaranteed to succeed
> > > (past its point of no return, in bprm_committing_creds), after any
> > > privilege gain through set-user-ID, set-group-ID or file capabilities
> > > has already taken place.  The executed program then runs with
> > > no_new_privs, so subsequent executions cannot gain privileges.  A
> > > failed execve(2) leaves no_new_privs untouched.
> > > 
> > > Use cases:
> > > 
> > > Enforcing a Landlock ruleset requires that the calling process either
> > > already has no_new_privs set or possesses CAP_SYS_ADMIN.  This series
> > > does not grant any exception to this rule; for a caller that already
> > > has no_new_privs set, the flag is effectively a no-op.  It is therefore
> > > mostly useful for CAP_SYS_ADMIN callers that need to execute programs
> > > that legitimately escalate privileges (e.g. transition to another
> > > user), while ensuring that further executions cannot gain privileges.
> > 
> > That's a good point, but why not just set NNP for the whole process at
> > landlock_restrict_self() call time? There is a partial answer below
> > but...
> >
> Atomically with respect to the ruleset enforcement I presume?
> I guess that makes this even easier... just run it at the end after all
> possible errors in the landlock_restrict_self path.
> 
> In this case then, we must consider whether this would be sufficient to
> serve as a substitute for NNP || cap_sys_admin check.
> 
> > > 
> > > Consider a sandbox launcher that depends on a set-user-ID helper, such
> > > as launching applications through bubblewrap on distributions where
> > > unprivileged user namespaces are disabled and bwrap is installed
> > > set-user-ID root.  The launcher cannot set PR_SET_NO_NEW_PRIVS before
> > > the execution, as that would neuter the very helper it depends on:
> > > 
> > >   sandbox launcher (CAP_SYS_ADMIN)
> > >   |
> > >   | landlock_restrict_self(-1, LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC)
> > >   V
> > >   /usr/bin/bwrap (set-user-ID root: honored for this execution;
> > >   |               no_new_privs set once the execution is past its
> > >   |               point of no return)
> > 
> > This should only be allowed if the launcher has CAP_SYS_ADMIN, otherwise
> > it would be like changing the state of a more privileged process.
> > Anyway, even with this safeguard, this approach looks risky.
> >
> Yes, and it does have CAP_SYS_ADMIN in this example. It "feels" risky
> though to mess with further escalations. But if you are CAP_SYS_ADMIN,
> you can load kernel modules, potentially write to any memory, etc.
> 
> So that is less the argument I would make.
> 
> I think the main argument that hasn't been highlighted yet against *my
> proposal* (I like to red team my own proposals) is that this whole
> thing has nothing to do with Landlock. My feature doesn't touch Landlock
> rulesets, or anything Landlock specific, so if this were implemented,
> why not just make it a prctl? Why tie it to an LSM at all?
> 
> So I like your proposal better (atomic nnp with Landlock) because it's
> actually relevant to Landlock rulesets.
> 
> The last remaining questions:
> 
> 1. Shall the NNP || cap_sys_admin check remain in place for the NNP Landlock flag?

No because the Landlock NNP can only be stronger than the
always-one-thread NNP.

> 2. Should we allow enforcement with ruleset_fd being -1 (would basically
> be equivalent to the prctl version of set no new privs)?

I don't think so, see my other reply.

> 
> Justin
> 
> > >   V
> > >   sandboxed application (runs with no_new_privs; cannot gain
> > >                          privileges through any further execution, and
> > >                          may enforce its own Landlock ruleset without
> > >                          CAP_SYS_ADMIN)
> > > 
> > > This flag also closes a gap for CAP_SYS_ADMIN callers of
> > > landlock_restrict_self(2) itself.  The no_new_privs/CAP_SYS_ADMIN
> > > requirement exists to keep set-user-ID programs from running confused
> > > inside a sandbox they do not expect.  However, a privileged process
> > > that enforces a domain without setting no_new_privs leaves that hole
> > > open for all of its descendants: anything running in the domain may
> > > still execute a set-user-ID binary, which then runs privileged under a
> > > restricted view of the system.  A privileged process that needs one
> > > legitimate set-user-ID/set-group-ID transition currently has to choose
> > > between breaking that transition (setting no_new_privs first) or
> > > leaving the hole open for the lifetime of the domain.
> > > LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC allows the one intended transition
> > > and then closes the hole.
> > 
> > In a nutshell, not setting NNP might be risky, even when not strictly
> > needed.  We might want to update the Landlock doc with that.
> > 
> Yes, I  

Something is missing but you sent a dedicated series, so let's continue
there.

> > > 
> > > Design:
> > > 
> > > This flag is implemented simply: a bit is stored in the Landlock
> > > credential blob (struct landlock_cred_security) indicating whether the
> > > next execution should set no_new_privs when it commits its new
> > > credentials.
> > 
> > Also, if we don't have the ON_EXEC part, there is no need to store
> > anything in the cred.
> > 
> > > 
> > > The bit is not coupled to any ruleset and, like
> > > LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF, may be passed with no
> > > ruleset (i.e. ruleset_fd = -1).  It may also be combined with
> > > LANDLOCK_RESTRICT_SELF_TSYNC to propagate the staged state to sibling
> > > threads, each thread then setting no_new_privs at its own next
> > > execve(2).
> > > 
> > > The staged bit is inherited across fork(2) and persists in the
> > > credentials until the next successful execution.  To consume it,
> > > Landlock handles the bprm_committing_creds hook, which runs while the
> > > credentials of the new program are being committed: if the bit is set,
> > > task_set_no_new_privs(current) is called and the bit is cleared.
> > > 
> > > Again, this flag does not bypass the requirement to either have
> > > CAP_SYS_ADMIN or no_new_privs already set to call
> > > landlock_restrict_self(2).
> > > 
> > > The Landlock ABI version is bumped to 11.
> > > 
> > > Test coverage:
> > > 
> > > The new nnp_on_exec fixture generates a shell script that reads the
> > > NoNewPrivs value from /proc/self/status and exits with it.  The
> > > variants select the conditions under which the flag is tested (with
> > > and without a ruleset, with and without CAP_SYS_ADMIN/no_new_privs
> > > already set, with and without TSYNC, etc.), then compare no_new_privs
> > > before the execution and in the executed script.  The ruleset variants
> > > also check that a ruleset passed along the flag is enforced
> > > immediately, unlike the staged no_new_privs.
> > > 
> > > Justin Suess (3):
> > >   landlock: Add LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
> > >   selftests/landlock: Test LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
> > >   landlock: Document LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
> > > 
> > >  Documentation/userspace-api/landlock.rst     |  21 +-
> > >  include/uapi/linux/landlock.h                |  36 ++-
> > >  security/landlock/cred.c                     |  22 ++
> > >  security/landlock/cred.h                     |   8 +
> > >  security/landlock/limits.h                   |   2 +-
> > >  security/landlock/syscalls.c                 |  54 +++-
> > >  tools/testing/selftests/landlock/base_test.c | 259 ++++++++++++++++++-
> > >  7 files changed, 382 insertions(+), 20 deletions(-)
> > > 
> > > -- 
> > > 2.54.0
> > > 
> > > 
> 
