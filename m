Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44B8348C45
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 03:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780025116; cv=none; b=sHRueDFTuR3VzQUCoA23q5pJT9+ZDBwwKKZAMxlvlfyPJj3hLPsMKwrhJMGfqWgAK2hzTZted61goLyHypztTnjyvlXlb30lTdk3PKgnNi1lvWrZybhwEZrDEoBK6XHSqPAZTZMs3ULACqPeYyNJ6Hr0K/2SctDKKxiOY2a6E4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780025116; c=relaxed/simple;
	bh=fRkjzdlKFB3G8cz1eLu7lHkI1z6MwLqtYeN2gFmkY3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMw+tXyXBBO9rhGd9U0K/u3Z0kpCmVDbiWYqgf0zhY059N90ENp/SXTUNHcSfO5AL4gysG7LX1qHEZc6qjdnr/xkKsUmGRyOdF0BKAuHt7m9Q7prJxeEbZkjMr1KkBj2CFe4bOl/0yXBK9MfxKGUK+owBAEt1lYDDe2TyOQE3XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nl1eTYQr; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl1eTYQr"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69d8b7aeeecso2250027eaf.1
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 20:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780025113; x=1780629913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vVUdE1OE+AlbBfL0FVFGoI0GSH8ihfJl0i4B0BNMBWI=;
        b=nl1eTYQrQZ/y6W3+9K9oLmpQrKoyp9DbYLkkGVmx2LCHd/hN5cTuLo2Bu07c+Hh08c
         BaUOY0fWX/bd9AN3LMdG0cE0yEMLTj522FjcyRXHxwEoaIsmC41+AlCNcE7YFH8Hp3A+
         O6fRXGO3iz5nS2mU+Bar+NZ4gjAEjBjtXyhxts5Y0gz8fx85SPRJ4yosVC3Yua1mrMvD
         zKai7diPde98BrmdXotxB/oUmlb7l+vHZ/H0qj/BzY3YetU7PDw0TczHOv4yEFen52n4
         3+C0pML85+oWrQif6kp5rn1mXlJHLp9yRGn54MrItp77ifctDolA9natq8agE06UI70p
         0ZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780025113; x=1780629913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVUdE1OE+AlbBfL0FVFGoI0GSH8ihfJl0i4B0BNMBWI=;
        b=aP4m30OKhKhYOBWvttvrHKhuwfm5IP+I1Z/t99Wy20yTPo2E4r1qMBA6wFsO6pxhz0
         V3EYLzQKvt3by5s0PiarvEd77GXGGCpdLYn7DsnRvjqNeq+YGx1GkLk8ZRRkPeWXp0CH
         +84AEQH3wGuDGidJ4XJFqsO4Juhhkj9Ld5d61JRAWBCdluYflXKHB23nujgUcbaJ00d2
         n0HYSd5itTI9InVawtYhntM73JbSHNqUCn2A6JNTzxm81hGlXIg5IMm4jU0w17oSCz2L
         o5XEWx52nZsRTn/mgjfXMaTlNsMypfoOCwtOXnCO2B8Nk4+JrKDomiC3VSKRJqpr8cyl
         CwGw==
X-Forwarded-Encrypted: i=1; AFNElJ9K/jKF6Q3hrHX2DqIqN4QwqmGRrFpD/jGxNOt6XGfQBbS8Ku0PbOH9C8/rMF4Fv1Rdx8ZNlOt1n1//06XBaVtEHtTx5x4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzizGf0QU5WYHjOBITf55WYMDmLwoMA0rdpAjgNKQ7SQhMYV1Y0
	jxTjv1LfIhznEwT7uKr9rqM1T3xXKXBoK3FMcTOLoixXxU/di6PDR2Q7
X-Gm-Gg: Acq92OEzvZwiLZJzxIKKSyR/v87Fr0WXM38EHsnJWPabLNYtZl1V/XYdFgHN8i1o+k+
	R3YJl1lBaF3S2kSj+xHdWorN5N/QYnLT2zZaHneD5TOZ0FPnujj3FrN/2fIoHWq8DdikeFW2gw/
	QRk+1P6LsAs19ZpaTAZUsIKfaSedjw20CQJUp+9laLhFG/2A1Qck4GIB35BSaSgC+v+v2A07mTa
	hfMKuZfNqF/0HSppCmxYqNJT57PEZ2FxlQzOIhvTvmnrcBfoevZEWlCAW2qqnL31miyX3Ex6HUk
	vUAH5Jz3fU6wh6BVlAtNGcCXiBOLbw0cDzHuAkWGCmYT6VURsdElsqpmuEolJqewKnA1Eay7WB9
	HgHPiJatmA47rXvqRgulEw0R3dsPmb9E/gg57ayb7RxYYVWhD+PKDf5FAqZDhYG1/8Ae54hKru8
	IM7oc5KDDLDgZ2izMfQC7xuzTKoo21p87sU3NIZHx0H+Pkoinav6+bwGN+C6s7VqdV26VjGDz7d
	g==
X-Received: by 2002:a05:6820:55dc:10b0:69d:521d:a4fc with SMTP id 006d021491bc7-69e03ebc621mr529610eaf.8.1780025113540;
        Thu, 28 May 2026 20:25:13 -0700 (PDT)
Received: from suesslenovo ([2601:281:c981:d860:ca50:ff10:ab81:cd2a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e0696e089sm212603eaf.9.2026.05.28.20.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 20:25:13 -0700 (PDT)
Date: Thu, 28 May 2026 23:25:12 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: hexlabsecurity@proton.me
Cc: "mic@digikod.net" <mic@digikod.net>, 
	"gnoack@google.com" <gnoack@google.com>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass via F_SETOWN
 to invoker's pgid
Message-ID: <ahkAS5S4SfMa4gJI@suesslenovo>
References: <cFjmBkbTY-D5pYl66NixBeqbhWBzS7kBEUHCWbhTQwkiuvKg8xNkSEf9rYqDQiD76er1gK8Q6t1YOJ4nIPuvILuwG42d8_rfMZpQ5VmJru0=@proton.me>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cFjmBkbTY-D5pYl66NixBeqbhWBzS7kBEUHCWbhTQwkiuvKg8xNkSEf9rYqDQiD76er1gK8Q6t1YOJ4nIPuvILuwG42d8_rfMZpQ5VmJru0=@proton.me>

On Thu, May 28, 2026 at 09:21:50PM +0000, hexlabsecurity@proton.me wrote:
> From 22a0086b44beaaef01883e047dd4a8b8bc3153e9 Mon Sep 17 00:00:00 2001
> From: Bryam Vargas <hexlabsecurity@proton.me>
> Date: Thu, 28 May 2026 01:30:00 -0500
> Subject: [PATCH] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass via F_SETOWN to
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
> single thread or thread-group leader sharing current's cred. It is
> unsafe for PIDTYPE_PGID and PIDTYPE_SID: when current is at the head
> of its pgid hlist -- the default placement after fork(),
> hlist_add_head_rcu() in kernel/fork.c -- pid_task(pgid, PIDTYPE_PGID)
> resolves to current itself, same_thread_group(current, current) is
> true, the capture is skipped, and fown_subject.domain stays NULL.
> 
> hook_file_send_sigiotask() then short-circuits at
> "if (!subject->domain) return 0;", allowing the kernel to fan the
> signal out to every member of the group, including tasks outside
> current's Landlock domain that the SCOPE_SIGNAL contract is supposed
> to protect.
> 
> The direct kill() path (hook_task_kill) is unaffected: it evaluates
> current's live domain on every call. Only the cached SIGIO path is
> broken.
> 
> Repro (ordinary unprivileged user; sandbox active in the child):
> 
>   int pfd[2]; pipe(pfd);
>   landlock_create_ruleset(&{.scoped = LANDLOCK_SCOPE_SIGNAL},
>                           sizeof(attr), 0);
>   prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
>   landlock_restrict_self(rfd, 0);
>   fcntl(pfd[0], F_SETSIG, SIGKILL);
>   fcntl(pfd[0], F_SETOWN, -getpgrp());           /* PIDTYPE_PGID */
>   fcntl(pfd[0], F_SETFL, O_ASYNC);
>   write(pfd[1], "X", 1);                         /* trigger SIGIO  */
>   /* every pgid member receives SIGKILL, including non-sandboxed
>    * parent / supervisor / sibling workers */
>
I was able to reproduce this on mic/next.

Great catch!

> Tighten control_current_fowner() to apply the thread-group exemption
> only when the target identifies a SINGLE task whose Landlock cred is
> necessarily shared with current (PIDTYPE_TGID, PIDTYPE_PID). For
> PIDTYPE_PGID and PIDTYPE_SID, always capture the current Landlock
> subject so the consumer's scope check runs against every member of
> the group at delivery time.
> 
> Empirically A/B-verified on a 6.12.90 lab kernel (same .config, only
> the patch hunk differs): pre-fix build exits with "BUG PRESENT --
> SCOPE_SIGNAL BYPASSED", post-fix build exits with "SANDBOX HELD".
> hook_task_kill's direct-kill enforcement and the intra-thread-group
> F_SETOWN cases continue to work post-patch.
> 
> Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
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
This seems right.

So basically we are failing to check the subject on fan-out
signals where type > PIDTYPE_TGID (ie PIDTYPE_PGID/SID).

But this fix seems good as is to me and closed the reproducer hole in my
test. Unless there are some edge cases I'm missing.

The commit message could use some cleanup and shortening. No need to
include the reproducer (though it was helpful) and the "BUG_PRESENT"/
"SANDBOX_HELD"/ AB testing stuff. Just explain the bug and what
it fixes :)

You can add the reproducer and stuff below the --- in the patch and
above the diffstat in the future to make it part of the git notes and
not the actual commit.

That way you can add anything else that doesn't belong in the actual
commit but is important for context.

This may need an erratum entry and a regression test in the future,
but that can be done seperately.

Again great job!

Tested-by: Justin Suess <utilityemal77@gmail.com>
> +
>  	return !same_thread_group(p, current);
>  }
> 
> --
> 2.43.0
> 
