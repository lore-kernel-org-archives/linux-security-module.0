Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61431F181F
	for <linux-security-module@vger.kernel.org>; Tue, 17 Feb 2026 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336924; cv=none; b=sPoANSEu4rQeE88Uvfrra9fHPsYEdHpvTPV0FXPyZfOz6ynQ6k74Suqm0tVZeLwWcCsIQxwIU4niTgGbprhrGGYQWOVyxvHuZY/DqzMcH5avQh/4vHgkM2/vzjplOc1qB8LyCzCxrp9HvInX0l2FOMvLNSt9Lu5/yYq7aMzwcSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336924; c=relaxed/simple;
	bh=pBDiREZsOxcZGqEkCvY7GKf5btswbg8LEj0GnTiAmHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCqawBtQelZxit6aZswzoegxe9Vwl3k0v0M1PaWRrSz8ejskgUbXRjFZwPuF1oa+vqAC9K46t7HbCay8PO4N4EqQNapYKiu4cEvwpMDdO2zixHGimEh/Hq7BP7+4vJnALBBzwaetKihOoxyXHG0Acd4YRTAfKXefWEo08LPnRTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=caA8eAO6; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="caA8eAO6"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fFh0y5Y7rzDNv;
	Tue, 17 Feb 2026 14:52:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1771336370;
	bh=MTk4u9H31oMgBRXGqVgzQRzk+R60rP5xoDhzp00bcQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=caA8eAO6XJ2kJP/oMTwdIHHc0KCpMs+XtHUMm1oPA6BDrtYAn89+JzpVl0T2Nor7C
	 1yWUjGiKCNUiogXy2nh/LxXB4yyViSkFYIaYaeW1QaS0f2fwuwrHSdeE/fmfMc3Mqf
	 50YyFujUfWDnIgChd5TpfblGL+P6R5OsUxAq8wlY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fFh0y2D1jzfM0;
	Tue, 17 Feb 2026 14:52:50 +0100 (CET)
Date: Tue, 17 Feb 2026 14:52:46 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 1/2] landlock: Fully release unused TSYNC work entries
Message-ID: <20260217.cheoghae8Ahh@digikod.net>
References: <20260217122341.2359582-1-mic@digikod.net>
 <aZRh52TIPAmMPJxc@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZRh52TIPAmMPJxc@google.com>
X-Infomaniak-Routing: alpha

On Tue, Feb 17, 2026 at 01:41:11PM +0100, Günther Noack wrote:
> On Tue, Feb 17, 2026 at 01:23:39PM +0100, Mickaël Salaün wrote:
> > If task_work_add() failed, ctx->task is put but the tsync_works struct
> > is not reset to its previous state.  The first consequence is that the
> > kernel allocates memory for dying threads, which could lead to
> > user-accounted memory exhaustion (not very useful nor specific to this
> > case).  The second consequence is that task_work_cancel(), called by
> > cancel_tsync_works(), can dereference a NULL task pointer.
> > 
> > Fix this issues by keeping a consistent works->size wrt the added task
> > work.  This is done in a new tsync_works_trim() helper which also cleans
> > up the shared_ctx and work fields.
> > 
> > As a safeguard, add a pointer check to cancel_tsync_works() and update
> > tsync_works_release() accordingly.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Jann Horn <jannh@google.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> > 
> > Changes since v1:
> > https://lore.kernel.org/all/20260216142641.2100407-1-mic@digikod.net/
> > - Move the return/release logic into a new tsync_works_trim() helper
> >   (suggested by Günther).
> > - Reset the whole ctx with memset().
> > - Add an unlinkely(err).
> > ---
> >  security/landlock/tsync.c | 47 ++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 41 insertions(+), 6 deletions(-)
> > 
> > diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> > index 0d2b9c646030..42cc0ef0c704 100644
> > --- a/security/landlock/tsync.c
> > +++ b/security/landlock/tsync.c
> > @@ -203,6 +203,40 @@ static struct tsync_work *tsync_works_provide(struct tsync_works *s,
> >  	return ctx;
> >  }
> >  
> > +/**
> > + * tsync_works_trim - Put the last tsync_work element
> > + *
> > + * @s: TSYNC works to trim.
> > + *
> > + * Put the last task and decrement the size of @s.
> > + *
> > + * This helper does not cancel a running task, but just reset the last element
> > + * to zero.
> > + */
> > +static void tsync_works_trim(struct tsync_works *s)
> > +{
> > +	struct tsync_work *ctx;
> > +
> > +	if (WARN_ON_ONCE(s->size <= 0))
> > +		return;
> > +
> > +	ctx = s->works[s->size - 1];
> > +
> > +	/*
> > +	 * For consistency, remove the task from ctx so that it does not look like
> > +	 * we handed it a task_work.
> > +	 */
> > +	put_task_struct(ctx->task);
> > +	memset(ctx, 0, sizeof(*ctx));
> 
> Minor (and highly optional) remark, this is the same as
> 
>   *ctx = (struct tsync_work){};

What about:

*ctx = (typeof(*ctx)){};

> 
> which I find slightly easier to read when resetting a struct value.
> Both is fine though.
> 
> > +
> > +	/*
> > +	 * Cancel the tsync_works_provide() change to recycle the reserved memory
> > +	 * for the next thread, if any.  This also ensures that cancel_tsync_works()
> > +	 * and tsync_works_release() do not see any NULL task pointers.
> > +	 */
> > +	s->size--;
> > +}
> > +
> >  /*
> >   * tsync_works_grow_by - preallocates space for n more contexts in s
> >   *
> > @@ -276,7 +310,7 @@ static void tsync_works_release(struct tsync_works *s)
> >  	size_t i;
> >  
> >  	for (i = 0; i < s->size; i++) {
> > -		if (!s->works[i]->task)
> > +		if (WARN_ON_ONCE(!s->works[i]->task))
> >  			continue;
> >  
> >  		put_task_struct(s->works[i]->task);
> > @@ -379,16 +413,14 @@ static bool schedule_task_work(struct tsync_works *works,
> >  
> >  		init_task_work(&ctx->work, restrict_one_thread_callback);
> >  		err = task_work_add(thread, &ctx->work, TWA_SIGNAL);
> > -		if (err) {
> > +		if (unlikely(err)) {
> >  			/*
> >  			 * task_work_add() only fails if the task is about to exit.  We
> >  			 * checked that earlier, but it can happen as a race.  Resume
> >  			 * without setting an error, as the task is probably gone in the
> > -			 * next loop iteration.  For consistency, remove the task from ctx
> > -			 * so that it does not look like we handed it a task_work.
> > +			 * next loop iteration.
> >  			 */
> > -			put_task_struct(ctx->task);
> > -			ctx->task = NULL;
> > +			tsync_works_trim(works);
> >  
> >  			atomic_dec(&shared_ctx->num_preparing);
> >  			atomic_dec(&shared_ctx->num_unfinished);
> > @@ -412,6 +444,9 @@ static void cancel_tsync_works(struct tsync_works *works,
> >  	int i;
> >  
> >  	for (i = 0; i < works->size; i++) {
> > +		if (WARN_ON_ONCE(!works->works[i]->task))
> > +			continue;
> > +
> >  		if (!task_work_cancel(works->works[i]->task,
> >  				      &works->works[i]->work))
> >  			continue;
> > -- 
> > 2.53.0
> > 
> 
> Reviewed-by: Günther Noack <gnoack@google.com>
> 
> Thanks for spotting and fixing this!
> —Günther
> 
