Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863502D77E3
	for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 17:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771263823; cv=none; b=gLEmQSjaoACh7A4JcGyTEJjRwgd5Ep/Aew3wDj2IqsUypDD3FuWsNdFmwzy9QjNaFNN3ZFHUJHHYcoyNW2QNNGSkIql67i+IolFZtccCJPoQS2q4CYvhM35FALWOxZuaL3UFbowML/kasaEQH1qvi+AwLszYngJLlQbTD8dtY9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771263823; c=relaxed/simple;
	bh=Y0xiK/ogDWFDOJ/UjUoLGP3viZy845CXhzeOW6FJ7u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFRrEI85U2wMXhrdIHsOqx48TotNttS5tD99gSlnRWsThj5L2+AdNzp1InGgMLrVFtfR4h+Yfq5zo4jQ1TuzsnWwONOi+gEB+rvaC+pTF/ciEd9v+yubGeJDNWwERvtmjmsfDW1k3JNbzQJCGza/prXvV2G6tmg10wZGh6XugHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OV7dwyBq; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OV7dwyBq"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fF99b2MBSzmCc;
	Mon, 16 Feb 2026 18:43:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1771263811;
	bh=7vjtkv8EUraFTj6p7ww2uRxXWaD3R657W5DhO6BUn1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OV7dwyBqXamn6yPimMdp2WIa1eRlo9nPtWr+k9E3cE4GSVfqY4xqQ+AC6LpuEvIEH
	 w6nPWorqNVCgooX0mRZiHk6/rGUHBeoqQ9A1Gr1ZLOUI/+NtGiEx3OzAM1Vp98o2D+
	 DXn5hXeLCB7lBgs3nUDIxIR6XE1MUPI5T46Zon/M=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fF99Z6PN0z5K0;
	Mon, 16 Feb 2026 18:43:30 +0100 (CET)
Date: Mon, 16 Feb 2026 18:43:25 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v1 1/2] landlock: Fully release unused TSYNC work entries
Message-ID: <20260216.iep2jei5Dees@digikod.net>
References: <20260216142641.2100407-1-mic@digikod.net>
 <aZM3Ab6QJ8WR84J1@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZM3Ab6QJ8WR84J1@google.com>
X-Infomaniak-Routing: alpha

On Mon, Feb 16, 2026 at 04:25:53PM +0100, Günther Noack wrote:
> Hello!
> 
> On Mon, Feb 16, 2026 at 03:26:38PM +0100, Mickaël Salaün wrote:
> > If task_work_add() failed, ctx->task is put but the tsync_works struct
> > is not reset to its previous state.  The first consequence is that the
> > kernel allocates memory for dying threads, which could lead to
> > user-accounted memory exhaustion (not very useful nor specific to this
> > case).  The second consequence is that task_work_cancel(), called by
> > cancel_tsync_works(), can dereference a NULL task pointer.
> 
> I think it is very difficult to get into this situation, but this is
> obviously not an excuse - if we already do the error handling, we
> should do it right. 👍
> 
> > 
> > Fix this issues by keeping a consistent works->size wrt the added task
> > work.  For completeness, clean up ctx->shared_ctx dangling pointer as
> > well.
> > 
> > As a safeguard, add a pointer check to cancel_tsync_works() and update
> > tsync_works_release() accordingly.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Jann Horn <jannh@google.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  security/landlock/tsync.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> > index 0d2b9c646030..8e9b8ed7d53c 100644
> > --- a/security/landlock/tsync.c
> > +++ b/security/landlock/tsync.c
> > @@ -276,7 +276,7 @@ static void tsync_works_release(struct tsync_works *s)
> >  	size_t i;
> >  
> >  	for (i = 0; i < s->size; i++) {
> > -		if (!s->works[i]->task)
> > +		if (WARN_ON_ONCE(!s->works[i]->task))
> 
> Is this a condition we should warn on?  It is very unlikely, but it
> can technically happen that a thread exits at the same time as TSYNC
> and happens to hit that narrow race condition window.  As long as it
> happens only sporadically, I don't think there is anything wrong (and
> in particular, it's not actionable for the user - I don't think there
> is a way to fix it if that warning appears?)

WARN() should definitely not be called if the condition can legitimately
be true.

"task" is only set by tsync_works_provide(), so only by the caller
thread.  How could "task" be NULL (within the works->size range)?

> 
> 
> >  			continue;
> >  
> >  		put_task_struct(s->works[i]->task);
> > @@ -389,6 +389,15 @@ static bool schedule_task_work(struct tsync_works *works,
> >  			 */
> >  			put_task_struct(ctx->task);
> >  			ctx->task = NULL;
> > +			ctx->shared_ctx = NULL;
> > +
> > +			/*
> > +			 * Cancel the tsync_works_provide() change to recycle the reserved
> > +			 * memory for the next thread, if any.  This also ensures that
> > +			 * cancel_tsync_works() and tsync_works_release() do not see any
> > +			 * NULL task pointers.
> > +			 */
> > +			works->size--;
> 
> Looks good.
> 
> [Optional code arrangement remarks:
> 
> I would recommend to put that logic in a helper function
> "tsync_works_return(struct tsync_works *s, struct tsync_work *)", to
> be in line with the existing implementation where the manipulation of
> struct tsync_works is encapsulated in the "tsync_*" helper functions.
> 
> The scope of that function would be to do the inverse of
> "tsync_works_provide()" -- putting the task_struct, decreasing
> works->size, and then, to be safe, also clearing the contents of the
> tsync_work struct (although that is strictly speaking not required if
> we decrease the size, I think).

Should we move the atomic_inc() to tsync_works_provide() and the
atomic_dec() to this new helper?

> 
> The only unusual thing about the tsync_works_return() function would
> be that it is only OK to return the very last tsync_work struct which
> was returned from tsync_works_provide().

What about renaming tsync_works_provide() to tsync_works_push() and this
new one to tsync_works_pop()?

> 
> ]
> 
> It's an improvement either way though; If you want to prioritize
> fixing this and don't want to extract the extra function now, we can
> also look into it in a follow-up.  From a functional standpoint, I
> think your code works as well.

It's a small refactoring, so better to do it now.

> 
> >  
> >  			atomic_dec(&shared_ctx->num_preparing);
> >  			atomic_dec(&shared_ctx->num_unfinished);
> > @@ -412,6 +421,9 @@ static void cancel_tsync_works(struct tsync_works *works,
> >  	int i;
> >  
> >  	for (i = 0; i < works->size; i++) {
> > +		if (WARN_ON_ONCE(!works->works[i]->task))
> > +			continue;
> > +
> 
> Well spotted!
> 
> >  		if (!task_work_cancel(works->works[i]->task,
> >  				      &works->works[i]->work))
> >  			continue;
> > -- 
> > 2.53.0
> > 
> 
> Reviewed-by: Günther Noack <gnoack@google.com>
> 
> Thanks for having another closer look at this!
> 
> —Günther
> 
