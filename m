Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F9A40D566
	for <linux-security-module@vger.kernel.org>; Thu,  9 Jul 2026 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592122; cv=none; b=OVLAJBQ4NsH7AULcfnmnf7EV40GAu2eUsCTDryl1Enz26TQS10XylFyLCK8RoB0chAbzGtFvOj/7hWVii0ywAFJdfyCmOrl7ecb20j6TOH+wIVFQKIBVAQAuA6y49hivQE5cPP7TxokBxp/QegsMbM/u5VhzG9oOHj42ygjXQDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592122; c=relaxed/simple;
	bh=7FzgRlkMPjXu1MWgWe+05BbQp7/4jXe+RK4DkfmLEc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgddUUvLYD5Y6QU4BbhxVjL7KXrAnfVDyldXr5W+G/xcuERnVuhOPm34n5CUCbbGDAw97r21JZu5m1nqDq/oJXDNlkCfAa1ezWm7apE9qQd/bzti2vdlDZBk8CqpqGrl0sDa38qP4XGSAnGYifaAcJ2CPo/mnZosDvCtHtp8+Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=g+Pf3jXe; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="g+Pf3jXe"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gwrKk0Nqnztty;
	Thu,  9 Jul 2026 12:09:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1783591769;
	bh=W54Q0ab94/VdvLfgnNFOTYX3LBX0gIGv2NAXhAOVoY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g+Pf3jXeFsaPfVQ9pcsOCID3NPlBLtxiJtBV8zytc4fvNwX0BfKqzDuMTsYCMSxRJ
	 1hLSpp0mVRM1yG3r9ir2xODmTO/YYsORw0GIWMQLPjRyFLk3fVBYS5/clxNynCPkig
	 +5U4Hok4rsKYfmMj/o4T/RfVuDiSGe24jD07Qs/Y=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gwrKj3tw4zhJl;
	Thu,  9 Jul 2026 12:09:29 +0200 (CEST)
Date: Thu, 9 Jul 2026 12:09:25 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: linux-security-module@vger.kernel.org, gnoack@google.com
Subject: Re: [PATCH 0/3] Implement LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
Message-ID: <20260709.Eaphooyoh6sh@digikod.net>
References: <20260708133928.852999-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708133928.852999-1-utilityemal77@gmail.com>
X-Infomaniak-Routing: alpha

Hi Justin,

Thanks for this patch series, I like the underlying idea, but I'm not
convince we should mix NNP and ON_EXEC.  Why not a
LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS flag instead?

One issue with this NNP_ON_EXEC is that it might be confusing for one
thread to set it and expect the next exec to be NNP, but if the exec is
requested by another thread that would not happen.  With a
LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS flag, we could have an atomic
Landlock and NNP enforcement, which can also be combined with the TSYNC
flag, both useful cases.

If we want an enforcement to happen at exec time, we could add a
dedicated flag, similar to the TSYNC one, but I'm not sure it would be
useful for now.

On Wed, Jul 08, 2026 at 09:39:24AM -0400, Justin Suess wrote:
> Good morning,
> 
> This series adds a new landlock_restrict_self(2) flag:
> LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC.
> 
> This flag stages a bit in the Landlock credentials indicating that the
> next successful execution will set the no_new_privs attribute while
> committing its new credentials.
> 
> Differences from prctl(PR_SET_NO_NEW_PRIVS):
> 
> PR_SET_NO_NEW_PRIVS takes effect immediately: it prevents gaining
> privileges through set-user-ID, set-group-ID and file capabilities
> starting with the very next execve(2).
> 
> LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC instead only sets the task's
> no_new_privs attribute once the next execve(2) is guaranteed to succeed
> (past its point of no return, in bprm_committing_creds), after any
> privilege gain through set-user-ID, set-group-ID or file capabilities
> has already taken place.  The executed program then runs with
> no_new_privs, so subsequent executions cannot gain privileges.  A
> failed execve(2) leaves no_new_privs untouched.
> 
> Use cases:
> 
> Enforcing a Landlock ruleset requires that the calling process either
> already has no_new_privs set or possesses CAP_SYS_ADMIN.  This series
> does not grant any exception to this rule; for a caller that already
> has no_new_privs set, the flag is effectively a no-op.  It is therefore
> mostly useful for CAP_SYS_ADMIN callers that need to execute programs
> that legitimately escalate privileges (e.g. transition to another
> user), while ensuring that further executions cannot gain privileges.

That's a good point, but why not just set NNP for the whole process at
landlock_restrict_self() call time? There is a partial answer below
but...

> 
> Consider a sandbox launcher that depends on a set-user-ID helper, such
> as launching applications through bubblewrap on distributions where
> unprivileged user namespaces are disabled and bwrap is installed
> set-user-ID root.  The launcher cannot set PR_SET_NO_NEW_PRIVS before
> the execution, as that would neuter the very helper it depends on:
> 
>   sandbox launcher (CAP_SYS_ADMIN)
>   |
>   | landlock_restrict_self(-1, LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC)
>   V
>   /usr/bin/bwrap (set-user-ID root: honored for this execution;
>   |               no_new_privs set once the execution is past its
>   |               point of no return)

This should only be allowed if the launcher has CAP_SYS_ADMIN, otherwise
it would be like changing the state of a more privileged process.
Anyway, even with this safeguard, this approach looks risky.

>   V
>   sandboxed application (runs with no_new_privs; cannot gain
>                          privileges through any further execution, and
>                          may enforce its own Landlock ruleset without
>                          CAP_SYS_ADMIN)
> 
> This flag also closes a gap for CAP_SYS_ADMIN callers of
> landlock_restrict_self(2) itself.  The no_new_privs/CAP_SYS_ADMIN
> requirement exists to keep set-user-ID programs from running confused
> inside a sandbox they do not expect.  However, a privileged process
> that enforces a domain without setting no_new_privs leaves that hole
> open for all of its descendants: anything running in the domain may
> still execute a set-user-ID binary, which then runs privileged under a
> restricted view of the system.  A privileged process that needs one
> legitimate set-user-ID/set-group-ID transition currently has to choose
> between breaking that transition (setting no_new_privs first) or
> leaving the hole open for the lifetime of the domain.
> LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC allows the one intended transition
> and then closes the hole.

In a nutshell, not setting NNP might be risky, even when not strictly
needed.  We might want to update the Landlock doc with that.

> 
> Design:
> 
> This flag is implemented simply: a bit is stored in the Landlock
> credential blob (struct landlock_cred_security) indicating whether the
> next execution should set no_new_privs when it commits its new
> credentials.

Also, if we don't have the ON_EXEC part, there is no need to store
anything in the cred.

> 
> The bit is not coupled to any ruleset and, like
> LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF, may be passed with no
> ruleset (i.e. ruleset_fd = -1).  It may also be combined with
> LANDLOCK_RESTRICT_SELF_TSYNC to propagate the staged state to sibling
> threads, each thread then setting no_new_privs at its own next
> execve(2).
> 
> The staged bit is inherited across fork(2) and persists in the
> credentials until the next successful execution.  To consume it,
> Landlock handles the bprm_committing_creds hook, which runs while the
> credentials of the new program are being committed: if the bit is set,
> task_set_no_new_privs(current) is called and the bit is cleared.
> 
> Again, this flag does not bypass the requirement to either have
> CAP_SYS_ADMIN or no_new_privs already set to call
> landlock_restrict_self(2).
> 
> The Landlock ABI version is bumped to 11.
> 
> Test coverage:
> 
> The new nnp_on_exec fixture generates a shell script that reads the
> NoNewPrivs value from /proc/self/status and exits with it.  The
> variants select the conditions under which the flag is tested (with
> and without a ruleset, with and without CAP_SYS_ADMIN/no_new_privs
> already set, with and without TSYNC, etc.), then compare no_new_privs
> before the execution and in the executed script.  The ruleset variants
> also check that a ruleset passed along the flag is enforced
> immediately, unlike the staged no_new_privs.
> 
> Justin Suess (3):
>   landlock: Add LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
>   selftests/landlock: Test LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
>   landlock: Document LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
> 
>  Documentation/userspace-api/landlock.rst     |  21 +-
>  include/uapi/linux/landlock.h                |  36 ++-
>  security/landlock/cred.c                     |  22 ++
>  security/landlock/cred.h                     |   8 +
>  security/landlock/limits.h                   |   2 +-
>  security/landlock/syscalls.c                 |  54 +++-
>  tools/testing/selftests/landlock/base_test.c | 259 ++++++++++++++++++-
>  7 files changed, 382 insertions(+), 20 deletions(-)
> 
> -- 
> 2.54.0
> 
> 
