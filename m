Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E92F3D349A
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054006; cv=none; b=Ene1othrYTpLYt4PQZPat1/BeHeYqN7GToGNGFXd5HkGi/88KnmvgnGpf9SItp+jce/buP7Bpcc/PNTpiMhr+NhQAVAEjhCq34lJ/2Q+22WgPPxUFgnKM1ba+a4ZIT3g4sj/7R3jAbjfDFPjUqLQ8M1LpUuTe8NcxO4KIn3RYc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054006; c=relaxed/simple;
	bh=aMygToLeOxGeO5FigwLlA4k0q7CHT2fqHHJdUgRhqdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xre21mzMlcqNPe988QibmP09HgQipOSEspxNa0fbmzHi6x5YQFdsCkI1frMdkq2itlnfGVjgVYUZQ6X9vVgOSk8qQcXdZ/L/r7PxNLeAIOlWFk2olmrCLcPb6auShhSg5r56qw28DlpHggopTBgfKL7i5yVwascGqsd4nhYTlQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FtgiZ1ZT; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="FtgiZ1ZT"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gRgbH5PP1zZkq;
	Fri, 29 May 2026 13:08:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1780052939;
	bh=bGZ93Hxkd6LVM6Ol3c8K72NCSoggbnlPV6UFU0WAgUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FtgiZ1ZTh/oSGYU6xfNB2UAmBJfoCuxQ4/UVyW62UOB52gpg1vixOeU6FTO0Biybs
	 S2MvvdUnGi18fmzG/J8xZmL/Uunvvznco9v2whc1t/YcUvK+JZFsv2XcQcMz5vZ+PD
	 xpbWUZeYViP1zJu4uLxt8ywxzAS/FPgBGh/Ksh10=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gRgbH0jmdzYZr;
	Fri, 29 May 2026 13:08:59 +0200 (CEST)
Date: Fri, 29 May 2026 13:08:54 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: hexlabsecurity@proton.me
Cc: Justin Suess <utilityemal77@gmail.com>, 
	"gnoack@google.com" <gnoack@google.com>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [REPORT] landlock: SCOPE_SIGNAL bypass via F_SETOWN to invoker
 pgid -> SIGIO/SIGKILL to non-sandboxed targets
Message-ID: <20260529.li6kaiDaim4B@digikod.net>
References: <TSwHGN3I-u6p6xv7CqnvDOhR3la_kQWq0rdjBdA0gt30AsYLwddoxjCCFmqXcQMxWHS4ShULEp7sO_8HdFRGPLk30rIQHy3EurwJyrjP3NQ=@proton.me>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TSwHGN3I-u6p6xv7CqnvDOhR3la_kQWq0rdjBdA0gt30AsYLwddoxjCCFmqXcQMxWHS4ShULEp7sO_8HdFRGPLk30rIQHy3EurwJyrjP3NQ=@proton.me>
X-Infomaniak-Routing: alpha

Hi,

Thanks for the report.  Could you please replace the reproducer code
with a proper kselftest?

That would need to be a new email patch (v3) as explained here:
https://docs.kernel.org/process/submitting-patches.html

Regards,
 Mickaël

On Fri, May 29, 2026 at 04:43:02AM +0000, hexlabsecurity@proton.me wrote:
> Thanks Justin -- much appreciated for reproducing on mic/next and for the
> Tested-by.
> 
> v2 below addresses your review:
>   - the commit message is trimmed to just the bug and the fix;
>   - the reproducer and the A/B verification are moved below the --- so
>     they become git notes, not part of the commit;
>   - added your Tested-by.
> 
> The fix hunk is unchanged. I agree the concise statement of the defect is
> "we fail to check the subject on fan-out signal types (PIDTYPE_PGID and
> PIDTYPE_SID, i.e. type > PIDTYPE_TGID)". The patch keeps the explicit
> PIDTYPE_PGID / PIDTYPE_SID test for readability and to stay robust if the
> enum is ever reordered -- happy to switch to "> PIDTYPE_TGID" if you
> prefer. I'll follow up separately on the erratum entry and a regression
> test, as you suggested.
> 
> Independent security researcher. HEXLAB SAS (registration pending) --
> Cali, Colombia.
> 
> Thanks,
> Bryam Vargas
> 
> ----- v2 patch (inline, plain text) -----
> 
> From 75f801309cd64f74d04ef86236bd973314dd7d94 Mon Sep 17 00:00:00 2001
> From: Bryam Vargas <hexlabsecurity@proton.me>
> Date: Thu, 28 May 2026 23:33:13 -0500
> Subject: [PATCH v2] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass via F_SETOWN to
>  invoker's pgid
> 
> A Landlock-restricted process can bypass LANDLOCK_SCOPE_SIGNAL on the
> SIGIO delivery path and deliver arbitrary signals (including SIGKILL via
> F_SETSIG) to non-Landlocked targets that share its pgid, by exploiting a
> producer-side cache-vs-live evaluation gap.
> 
> The SIGIO path in hook_file_send_sigiotask() consults a cached subject
> stored in landlock_file(file)->fown_subject at fcntl(F_SETOWN) time
> (via hook_file_set_fowner()), instead of evaluating the live Landlock
> domain of the invoking task at signal-send time. The capture is gated
> by control_current_fowner(), which returns false (skipping capture)
> when pid_task(fown->pid, fown->pid_type) is in current's thread group.
> 
> This is correct for PIDTYPE_TGID / PIDTYPE_PID, where the target is a
> single task sharing current's cred. It is unsafe for PIDTYPE_PGID and
> PIDTYPE_SID: when current is at the head of its pgid hlist -- the
> default placement after fork(), hlist_add_head_rcu() in kernel/fork.c --
> pid_task(pgid, PIDTYPE_PGID) resolves to current itself,
> same_thread_group(current, current) is true, the capture is skipped, and
> fown_subject.domain stays NULL. hook_file_send_sigiotask() then
> short-circuits at "if (!subject->domain) return 0;", letting the kernel
> fan the signal out to every member of the group, including tasks outside
> current's Landlock domain that SCOPE_SIGNAL is supposed to protect.
> 
> The direct kill() path (hook_task_kill) is unaffected: it evaluates
> current's live domain on every call. Only the cached SIGIO path is
> broken.
> 
> Tighten control_current_fowner() to apply the thread-group exemption
> only when the target identifies a single task whose Landlock cred is
> necessarily shared with current (PIDTYPE_TGID, PIDTYPE_PID). For
> PIDTYPE_PGID and PIDTYPE_SID, always capture the current Landlock
> subject so the consumer's scope check runs against every member of the
> group at delivery time.
> 
> Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
> Tested-by: Justin Suess <utilityemal77@gmail.com>
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
> v2: per review, the commit message is trimmed to the bug + the fix; the
>     reproducer and the A/B verification are moved below the --- so they
>     stay out of the commit. Added Tested-by. The hunk is unchanged from
>     v1 (v1 sent to security@kernel.org 2026-05-28, embargoed -- not yet
>     in a public archive).
> 
> Reproducer (ordinary unprivileged user; sandbox active in the child):
> 
>   int pfd[2]; pipe(pfd);
>   landlock_create_ruleset(&{.scoped = LANDLOCK_SCOPE_SIGNAL},
>                           sizeof(attr), 0);
>   prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
>   landlock_restrict_self(rfd, 0);
>   fcntl(pfd[0], F_SETSIG, SIGKILL);
>   fcntl(pfd[0], F_SETOWN, -getpgrp());           /* PIDTYPE_PGID */
>   fcntl(pfd[0], F_SETFL, O_ASYNC);
>   write(pfd[1], "X", 1);                         /* trigger SIGIO */
>   /* every pgid member receives SIGKILL, including the non-sandboxed
>    * parent / supervisor / sibling workers */
> 
> A/B-verified on a 6.12.90 lab kernel (same .config, only this hunk
> differs): pre-fix the sandboxed child's SIGKILL reaches the
> non-sandboxed parent (SCOPE_SIGNAL bypassed); post-fix it is blocked.
> hook_task_kill's direct-kill enforcement and the intra-thread-group
> F_SETOWN cases continue to work post-patch.
> 
>  security/landlock/fs.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index c1ecfe239032..edaa52572cbd 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1909,6 +1909,18 @@ static bool control_current_fowner(struct fown_struct *const fown)
>  	if (!p)
>  		return true;
> 
> +	/*
> +	 * For PIDTYPE_PGID and PIDTYPE_SID, signal delivery fans out to
> +	 * every member of the group at SIGIO time. Even when pid_task()
> +	 * resolves to current itself (e.g., current is the pgid hlist
> +	 * head post-fork), non-current members of the group are still
> +	 * valid targets that must be checked by hook_file_send_sigiotask().
> +	 * Always capture the current subject for those types so the
> +	 * consumer scope check runs against the live fown_subject.
> +	 */
> +	if (fown->pid_type == PIDTYPE_PGID || fown->pid_type == PIDTYPE_SID)
> +		return true;
> +
>  	return !same_thread_group(p, current);
>  }
> --
> 2.43.0
