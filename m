Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF248329C40
	for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255562; cv=none; b=Oxr9pmMju27OAWLau1yKht7WxQr3xO/3jmmMyI8vYA9IZwYe4u2WPYw005ymectG/God4xDtcHUBSyZmALnHcwAh0ipOsEZNJ/zFDvY1gTYRxeSaIhXLHpHhCnee0JLp6MJdpRHhsNU5Y/fG/hye5cS8fAuYUL8MrVp8JAdMNm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255562; c=relaxed/simple;
	bh=CIo9WUxHwNE3PlYFwQ1oxVeXiPfL9ol0I7yTul7xTlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcX8tllIuP1OzM5rZIRB713La20yaQrWyWv+trm6ZFVwdL2xHuTydhk+QAUcGlE57cF0JflmKdqf8AUSkYIyULpiGwix8l01Vg68L+Bf4fMimGCSQZJPGzqd7Gqy4z4YlsrfrOu3gn9KRseK26shtxe8EDNA6LVDAe3Jl9jFIi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SHK352to; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SHK352to"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4834826e555so34043485e9.2
        for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 07:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771255559; x=1771860359; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Wxk+YLdn5hS9/9d84VjZHRWwHM0FMb9w89U7kdeqMw=;
        b=SHK352to6ed1brV7JKMghVc7LWPmwpXtjDU1dBRgBkASx5WzeO35UEdrHdY/iizWtt
         Dc55Mou3BAOG6+vhOSaiu+J1Jr8Hm/IBbTCop/wjXv+jLprn8yEqczrz1/YOp8fHiGLd
         8oLQI/3n2/ZEqJtL9NI05dY9lQF9MyRh/Dm/4oyU8u0W8NGwSI9fI03vAO5kb2lzdNm0
         oHve8ksorYRQgSU6FSp8KXHAmnsUd3meSufuATxN0msa28gU0QgKjqm0zfTtBoX5YdVx
         g12NYsKH1nY55T/0ttvbaDpj8/arPh20pDwXmkw4RtAO7fAw74w6RbthenqNVy/gC+Lr
         mftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771255559; x=1771860359;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Wxk+YLdn5hS9/9d84VjZHRWwHM0FMb9w89U7kdeqMw=;
        b=kIddqxy+ybqX/HE4/qZqJLaxCGCgG2qQTRxX5wFPVXG0QEVTCo4NSwd6gxL1Shzhpf
         b1MeMsz+fa518i2OTQ/IKIzPN58nuWJY0obzykARVanwIZyvg/d2RRsNZDmuw5Fjo0DD
         QL57FwZvvZO6L6M0kGg0GKsSyIuyL8uHuo1eNAwLE22XjHVi1pAOQo9OedB4KwUl6sCF
         2r0YSsy6jxHu37hvfEEQ9tuerLAYx2DINUEhPGPGClkmEd2L0CcBBTUwM0m9c/9aHUoe
         5VQu+iIW/m/8paYf52Q1rlIi4984qO60KrMN8bWdhurPKZoIDTbgvJKzEJurvyqKiKFt
         0oMg==
X-Gm-Message-State: AOJu0YxSEmlD8ZoqbBjfiAxSnAXlPGki8qVnckvZ1G5Y+y9NQb0w3jbD
	sV+mkcg1FUWkddugx6McfYR6yD+oDTS8IPxAoNf7PJi/AaABDFOeBSrJ50h3D8GG/Q==
X-Gm-Gg: AZuq6aKk1zoScY7tTxexsw8ABdkMEo5wl/oh5kxXpNZsZKklmrNhf2evGl/Y5iQY51I
	UwoyIdsLsW8Ko2wvce35aVCIKYfrLlMlnr4mDwJv5o5iTVJ1NqGxabLtfbfl9xBIkZhPGI8I0js
	9CNB5ywdmCySABStOt7hCVEhAU25Uh/V4pcA3E2T0dOdmCkBTLxPhVrEhluCZsnbHG/QOwL59T3
	8LfmlJXLhB379tuydOzxvifSpMIn0zNcbrY615H78I3ENRqkA8a+PgH3fTL9w656pCCN3bHkDup
	xqxmnz6s+8wam9fgw1LG5NHQhgqoEF7XDKg8NpV5iK4SnGJpbQW5l1Uh+oRRK7dMMlPBDxOL6Xg
	clnwy+AJU3no+JT3jkXRYsFQAnhDzpfbeoRnZFzNh4sm6DdkvnjI9b4sHLtQr7NrGJ/Y7PmyuRv
	YRa1tirw0OrLaUc1PoqBzaiY3AlzIYaSsL/YaXX5NmomwxZCmZiyhpEg==
X-Received: by 2002:a05:600c:4f16:b0:47b:de05:aa28 with SMTP id 5b1f17b1804b1-48379b939d7mr137309165e9.2.1771255558673;
        Mon, 16 Feb 2026 07:25:58 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:3652:d409:188c:c0b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dcfb28dsm403840405e9.11.2026.02.16.07.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 07:25:58 -0800 (PST)
Date: Mon, 16 Feb 2026 16:25:53 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v1 1/2] landlock: Fully release unused TSYNC work entries
Message-ID: <aZM3Ab6QJ8WR84J1@google.com>
References: <20260216142641.2100407-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260216142641.2100407-1-mic@digikod.net>

Hello!

On Mon, Feb 16, 2026 at 03:26:38PM +0100, Mickaël Salaün wrote:
> If task_work_add() failed, ctx->task is put but the tsync_works struct
> is not reset to its previous state.  The first consequence is that the
> kernel allocates memory for dying threads, which could lead to
> user-accounted memory exhaustion (not very useful nor specific to this
> case).  The second consequence is that task_work_cancel(), called by
> cancel_tsync_works(), can dereference a NULL task pointer.

I think it is very difficult to get into this situation, but this is
obviously not an excuse - if we already do the error handling, we
should do it right. 👍

> 
> Fix this issues by keeping a consistent works->size wrt the added task
> work.  For completeness, clean up ctx->shared_ctx dangling pointer as
> well.
> 
> As a safeguard, add a pointer check to cancel_tsync_works() and update
> tsync_works_release() accordingly.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Jann Horn <jannh@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/landlock/tsync.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index 0d2b9c646030..8e9b8ed7d53c 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -276,7 +276,7 @@ static void tsync_works_release(struct tsync_works *s)
>  	size_t i;
>  
>  	for (i = 0; i < s->size; i++) {
> -		if (!s->works[i]->task)
> +		if (WARN_ON_ONCE(!s->works[i]->task))

Is this a condition we should warn on?  It is very unlikely, but it
can technically happen that a thread exits at the same time as TSYNC
and happens to hit that narrow race condition window.  As long as it
happens only sporadically, I don't think there is anything wrong (and
in particular, it's not actionable for the user - I don't think there
is a way to fix it if that warning appears?)


>  			continue;
>  
>  		put_task_struct(s->works[i]->task);
> @@ -389,6 +389,15 @@ static bool schedule_task_work(struct tsync_works *works,
>  			 */
>  			put_task_struct(ctx->task);
>  			ctx->task = NULL;
> +			ctx->shared_ctx = NULL;
> +
> +			/*
> +			 * Cancel the tsync_works_provide() change to recycle the reserved
> +			 * memory for the next thread, if any.  This also ensures that
> +			 * cancel_tsync_works() and tsync_works_release() do not see any
> +			 * NULL task pointers.
> +			 */
> +			works->size--;

Looks good.

[Optional code arrangement remarks:

I would recommend to put that logic in a helper function
"tsync_works_return(struct tsync_works *s, struct tsync_work *)", to
be in line with the existing implementation where the manipulation of
struct tsync_works is encapsulated in the "tsync_*" helper functions.

The scope of that function would be to do the inverse of
"tsync_works_provide()" -- putting the task_struct, decreasing
works->size, and then, to be safe, also clearing the contents of the
tsync_work struct (although that is strictly speaking not required if
we decrease the size, I think).

The only unusual thing about the tsync_works_return() function would
be that it is only OK to return the very last tsync_work struct which
was returned from tsync_works_provide().

]

It's an improvement either way though; If you want to prioritize
fixing this and don't want to extract the extra function now, we can
also look into it in a follow-up.  From a functional standpoint, I
think your code works as well.

>  
>  			atomic_dec(&shared_ctx->num_preparing);
>  			atomic_dec(&shared_ctx->num_unfinished);
> @@ -412,6 +421,9 @@ static void cancel_tsync_works(struct tsync_works *works,
>  	int i;
>  
>  	for (i = 0; i < works->size; i++) {
> +		if (WARN_ON_ONCE(!works->works[i]->task))
> +			continue;
> +

Well spotted!

>  		if (!task_work_cancel(works->works[i]->task,
>  				      &works->works[i]->work))
>  			continue;
> -- 
> 2.53.0
> 

Reviewed-by: Günther Noack <gnoack@google.com>

Thanks for having another closer look at this!

—Günther
