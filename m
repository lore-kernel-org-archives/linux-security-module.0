Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633A92253FC
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jul 2026 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691790; cv=none; b=eHg9jf9sBPZQAb6R8PsYCaTqAy87DHL6yZeQn6WBjZ8gcsInmvKCKip3RyqL60wDT2dL+SAt1gmwRwSuQIPMExaVQ5O6+loFjugd89phYUo7htxoOgOVSMaK5OaRU4+NfTlFRbQnkNgKywxrJ1kB22Z4qZQqDEqP9GiV0qtVXAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691790; c=relaxed/simple;
	bh=MN0jeAeRuLI4OlwF1jD4ZJXbWPsVaY1dPRLGglXs4lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WumhsS8ke2rjkK1hmX6gjsPOuHsNXvTjE7VUrPO3WYfV/gE5OiEuJcbiOmSbIGPx/axIkdvZn4DClp+Y1/iqHwoJHAu5cL9pXrU5mnM6FrFMR2ahZJ5hdA5xfYwvGvGunSocfdceCwvtJkvwM3nI5SVcEBtPKTezoQtgyVaqSD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILzkMlZx; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILzkMlZx"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c0ecfaee7so5585571cf.0
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jul 2026 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783691787; x=1784296587; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TXMvXX/jP4mvrYVBYKyqGFnwGIBT9JJQZ8vzFKmPYvU=;
        b=ILzkMlZx6GvHzj7nNumpbfQ+rSQaUQ+nWlNMvZWwl5ogKJYwKPRXv+db4YBRJprwk5
         mRIVZkfdN1s68JejbXGRiMXoAMHyGpEpr4dZS4TTrz8ZULbwsk47U9n2esXjvdAYVqZm
         4FbYJOS5uCvGcwfVCQX85A6R8SASk3kDnisGsXxGBnHPgsL7kr9O0zQG1Kx02J58/dI7
         ywjJ6UAzys2FfAyy2FfVMs1mPmD1DIH9QZeOv9Slzo3XtTg+RnkXrea6JKHmGPjlT61v
         BU1DbfgX75GNrMBKf7mkKP87qM/rOORXOM2maz0Os0gc7XGgNUEklHRbjTkzXrBSEkOK
         OIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783691787; x=1784296587;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TXMvXX/jP4mvrYVBYKyqGFnwGIBT9JJQZ8vzFKmPYvU=;
        b=aTsUmS7pKWUHm3Pbv7i4J5vpZLEsjquXtLoYg6vHW9VCTLgipQ9kU/AJJYqwwndRhR
         VJ5MWr4H8uAfx99z4/37gA6TBu251oe/iEy+3OBUq0I0ovq1i1I+1udqbGUWxsEqwwhG
         jp7h0clneSkiN7RfpizeXJu1KG7TRKpHX2yiGYHvMID/Ox2oxxw9WhKcyBMf4WdWE3fh
         HtIqNyBQzXnnfK42xv1NynqjG+wMBvEt1XlwmrL8I6zY2rWGe07FDLD4zhSAuNcGOEOI
         tVl15AxgP6Q4L1KXkkkFjUa7HbohUQkdYCzlOUwF3wTm+QVfLs/fKzvPHn4OavOGwLoU
         WFCg==
X-Gm-Message-State: AOJu0Yz1OgcoBYKSK4cMpUtBL4oYJoWm32Crtsh6HW1wDiuf1gHGoBU4
	bDp90KDuGCC+AQEVavdIZyTCUOW0v3F0qMjgeyr0TpdyqTWx0SDiIZm+
X-Gm-Gg: AfdE7ckpIQ5S5PLztPLkZuW+nQOMEyTD37LtS1twUHMHAIsPBQjFO5xrKR+4b7/DoCK
	+R6yFpzZqhy7Vmg86E13XEH7VdoaDHcjeIOnq5pYZWzuEQGU7RJFp1nqk2LB7/EFQYeCWxhPIiR
	1+vny/K1z0wh29IqBxjXYxxnQ5VlecdspPOYxC+Fu0Ox2U+OEjKH/tCrQrGz1WBX0zxRrPUDcyp
	/KgSDc3vPnlo2WaYhLtbv9IBSb2mbCyayZYtzmfisW4EmRnvMyViIZSQC81uHdXmn4h7dE/unCI
	SQZdHHyfbdGjQgEdQmTUBP30Gbr1hmS9IU5zuYPARN0SzZNsq9vxmpciFvFsyndbedr4B8wyjJA
	RjTv8Jhw841DemmKnu4JkGWuqzRWXgLS+WD3ncoP1pdiV172jCa4ydkGqzOIElRco0tOSdanVxX
	BzQvnaZQAZfsmDFtOugoen13s0QtFiZ6/DFHRorDUOzMnU08I=
X-Received: by 2002:a05:622a:8cd:b0:51c:7b12:6009 with SMTP id d75a77b69052e-51c8b58148cmr123102801cf.85.1783691786969;
        Fri, 10 Jul 2026 06:56:26 -0700 (PDT)
Received: from suesslenovo ([65.215.34.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caacdacf7sm16386811cf.11.2026.07.10.06.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 06:56:26 -0700 (PDT)
Date: Fri, 10 Jul 2026 09:56:25 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, gnoack@google.com
Subject: Re: [PATCH 0/3] Implement LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
Message-ID: <ak-d2RiJDubT5SVB@suesslenovo>
References: <20260708133928.852999-1-utilityemal77@gmail.com>
 <20260709.Eaphooyoh6sh@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260709.Eaphooyoh6sh@digikod.net>

On Thu, Jul 09, 2026 at 12:09:25PM +0200, Mickaël Salaün wrote:
> Hi Justin,
> 
> Thanks for this patch series, I like the underlying idea, but I'm not
> convince we should mix NNP and ON_EXEC.  Why not a
> LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS flag instead?
> 
tldr I think your idea is better, see below.
> One issue with this NNP_ON_EXEC is that it might be confusing for one
> thread to set it and expect the next exec to be NNP, but if the exec is
> requested by another thread that would not happen.  With a
> LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS flag, we could have an atomic
> Landlock and NNP enforcement, which can also be combined with the TSYNC
> flag, both useful cases.
>
> If we want an enforcement to happen at exec time, we could add a
> dedicated flag, similar to the TSYNC one, but I'm not sure it would be
> useful for now.
> 
> On Wed, Jul 08, 2026 at 09:39:24AM -0400, Justin Suess wrote:
> > Good morning,
> > 
> > This series adds a new landlock_restrict_self(2) flag:
> > LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC.
> > 
> > This flag stages a bit in the Landlock credentials indicating that the
> > next successful execution will set the no_new_privs attribute while
> > committing its new credentials.
> > 
> > Differences from prctl(PR_SET_NO_NEW_PRIVS):
> > 
> > PR_SET_NO_NEW_PRIVS takes effect immediately: it prevents gaining
> > privileges through set-user-ID, set-group-ID and file capabilities
> > starting with the very next execve(2).
> > 
> > LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC instead only sets the task's
> > no_new_privs attribute once the next execve(2) is guaranteed to succeed
> > (past its point of no return, in bprm_committing_creds), after any
> > privilege gain through set-user-ID, set-group-ID or file capabilities
> > has already taken place.  The executed program then runs with
> > no_new_privs, so subsequent executions cannot gain privileges.  A
> > failed execve(2) leaves no_new_privs untouched.
> > 
> > Use cases:
> > 
> > Enforcing a Landlock ruleset requires that the calling process either
> > already has no_new_privs set or possesses CAP_SYS_ADMIN.  This series
> > does not grant any exception to this rule; for a caller that already
> > has no_new_privs set, the flag is effectively a no-op.  It is therefore
> > mostly useful for CAP_SYS_ADMIN callers that need to execute programs
> > that legitimately escalate privileges (e.g. transition to another
> > user), while ensuring that further executions cannot gain privileges.
> 
> That's a good point, but why not just set NNP for the whole process at
> landlock_restrict_self() call time? There is a partial answer below
> but...
>
Atomically with respect to the ruleset enforcement I presume?
I guess that makes this even easier... just run it at the end after all
possible errors in the landlock_restrict_self path.

In this case then, we must consider whether this would be sufficient to
serve as a substitute for NNP || cap_sys_admin check.

> > 
> > Consider a sandbox launcher that depends on a set-user-ID helper, such
> > as launching applications through bubblewrap on distributions where
> > unprivileged user namespaces are disabled and bwrap is installed
> > set-user-ID root.  The launcher cannot set PR_SET_NO_NEW_PRIVS before
> > the execution, as that would neuter the very helper it depends on:
> > 
> >   sandbox launcher (CAP_SYS_ADMIN)
> >   |
> >   | landlock_restrict_self(-1, LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC)
> >   V
> >   /usr/bin/bwrap (set-user-ID root: honored for this execution;
> >   |               no_new_privs set once the execution is past its
> >   |               point of no return)
> 
> This should only be allowed if the launcher has CAP_SYS_ADMIN, otherwise
> it would be like changing the state of a more privileged process.
> Anyway, even with this safeguard, this approach looks risky.
>
Yes, and it does have CAP_SYS_ADMIN in this example. It "feels" risky
though to mess with further escalations. But if you are CAP_SYS_ADMIN,
you can load kernel modules, potentially write to any memory, etc.

So that is less the argument I would make.

I think the main argument that hasn't been highlighted yet against *my
proposal* (I like to red team my own proposals) is that this whole
thing has nothing to do with Landlock. My feature doesn't touch Landlock
rulesets, or anything Landlock specific, so if this were implemented,
why not just make it a prctl? Why tie it to an LSM at all?

So I like your proposal better (atomic nnp with Landlock) because it's
actually relevant to Landlock rulesets.

The last remaining questions:

1. Shall the NNP || cap_sys_admin check remain in place for the NNP Landlock flag?
2. Should we allow enforcement with ruleset_fd being -1 (would basically
be equivalent to the prctl version of set no new privs)?

Justin

> >   V
> >   sandboxed application (runs with no_new_privs; cannot gain
> >                          privileges through any further execution, and
> >                          may enforce its own Landlock ruleset without
> >                          CAP_SYS_ADMIN)
> > 
> > This flag also closes a gap for CAP_SYS_ADMIN callers of
> > landlock_restrict_self(2) itself.  The no_new_privs/CAP_SYS_ADMIN
> > requirement exists to keep set-user-ID programs from running confused
> > inside a sandbox they do not expect.  However, a privileged process
> > that enforces a domain without setting no_new_privs leaves that hole
> > open for all of its descendants: anything running in the domain may
> > still execute a set-user-ID binary, which then runs privileged under a
> > restricted view of the system.  A privileged process that needs one
> > legitimate set-user-ID/set-group-ID transition currently has to choose
> > between breaking that transition (setting no_new_privs first) or
> > leaving the hole open for the lifetime of the domain.
> > LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC allows the one intended transition
> > and then closes the hole.
> 
> In a nutshell, not setting NNP might be risky, even when not strictly
> needed.  We might want to update the Landlock doc with that.
> 
Yes, I  
> > 
> > Design:
> > 
> > This flag is implemented simply: a bit is stored in the Landlock
> > credential blob (struct landlock_cred_security) indicating whether the
> > next execution should set no_new_privs when it commits its new
> > credentials.
> 
> Also, if we don't have the ON_EXEC part, there is no need to store
> anything in the cred.
> 
> > 
> > The bit is not coupled to any ruleset and, like
> > LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF, may be passed with no
> > ruleset (i.e. ruleset_fd = -1).  It may also be combined with
> > LANDLOCK_RESTRICT_SELF_TSYNC to propagate the staged state to sibling
> > threads, each thread then setting no_new_privs at its own next
> > execve(2).
> > 
> > The staged bit is inherited across fork(2) and persists in the
> > credentials until the next successful execution.  To consume it,
> > Landlock handles the bprm_committing_creds hook, which runs while the
> > credentials of the new program are being committed: if the bit is set,
> > task_set_no_new_privs(current) is called and the bit is cleared.
> > 
> > Again, this flag does not bypass the requirement to either have
> > CAP_SYS_ADMIN or no_new_privs already set to call
> > landlock_restrict_self(2).
> > 
> > The Landlock ABI version is bumped to 11.
> > 
> > Test coverage:
> > 
> > The new nnp_on_exec fixture generates a shell script that reads the
> > NoNewPrivs value from /proc/self/status and exits with it.  The
> > variants select the conditions under which the flag is tested (with
> > and without a ruleset, with and without CAP_SYS_ADMIN/no_new_privs
> > already set, with and without TSYNC, etc.), then compare no_new_privs
> > before the execution and in the executed script.  The ruleset variants
> > also check that a ruleset passed along the flag is enforced
> > immediately, unlike the staged no_new_privs.
> > 
> > Justin Suess (3):
> >   landlock: Add LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
> >   selftests/landlock: Test LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
> >   landlock: Document LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
> > 
> >  Documentation/userspace-api/landlock.rst     |  21 +-
> >  include/uapi/linux/landlock.h                |  36 ++-
> >  security/landlock/cred.c                     |  22 ++
> >  security/landlock/cred.h                     |   8 +
> >  security/landlock/limits.h                   |   2 +-
> >  security/landlock/syscalls.c                 |  54 +++-
> >  tools/testing/selftests/landlock/base_test.c | 259 ++++++++++++++++++-
> >  7 files changed, 382 insertions(+), 20 deletions(-)
> > 
> > -- 
> > 2.54.0
> > 
> > 
