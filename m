Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7218B28D8DB
	for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771272678; cv=none; b=dOwbGnMMXJjpsmYgjW0LyCYtQMXGPYS2Ype6tl0CmEaL9M0oyHigoXKlm7KKWAMNDdG89WvVZZftWj4Fwzlhkzr/OzuAQjvJJsEPOJMtNr6/URRSTnTSWwQcbCP2slkvBGAjddMAExk9sVaeP8wXRm2ylq+1BKCsvmIL9RxwYlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771272678; c=relaxed/simple;
	bh=TPEDsCsCEBsXUmuIc2ALBMSDEu2z8BjCfflrfnUpBbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLJaaKPDnpPTAy3LM69rdo9hgk9hCo6clfrZ6KtvQuUGG72eXvy+QcgI7oCWbrx9Ou0LZW9XTTTdwWEvelY4R/XQHGlqHv6TphV/vGgRqPbh5HhO2UhWZ3EhrYmXGAWqRUCnlI55yUkOu1+suG52Bu4C9NGjQWler9OyMyysPTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=W600EHA3; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="W600EHA3"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fFDRv6d7Czdx7;
	Mon, 16 Feb 2026 21:11:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1771272667;
	bh=BwixazDp14hur32KbkxMgjHQAjj13pyb+cZC7j08W5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W600EHA3bOTKdeYzw+Hd1a5q0lju1cDNxHmzc8gxv2jX6tJgDqPaJvaSoyVdhProT
	 2/9Dm5VRwmWq3F+Xosf/DJ5pFbf0tN4IDbuXm1S5PQsm0LvbnyaXDnnknkf9sgVBky
	 IMk1QCaqTp8VBb8jfphxsoxy7Dn1+RML0UF15/N4=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fFDRv3tZszTwG;
	Mon, 16 Feb 2026 21:11:07 +0100 (CET)
Date: Mon, 16 Feb 2026 21:10:59 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v1 1/2] landlock: Fully release unused TSYNC work entries
Message-ID: <20260216.chunooXu4ahl@digikod.net>
References: <20260216142641.2100407-1-mic@digikod.net>
 <aZM3Ab6QJ8WR84J1@google.com>
 <20260216.iep2jei5Dees@digikod.net>
 <20260216.b2c8aaab9a80@gnoack.org>
 <20260216.deiM1cuphohZ@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260216.deiM1cuphohZ@digikod.net>
X-Infomaniak-Routing: alpha

On Mon, Feb 16, 2026 at 08:57:34PM +0100, Mickaël Salaün wrote:
> On Mon, Feb 16, 2026 at 08:33:05PM +0100, Günther Noack wrote:
> > On Mon, Feb 16, 2026 at 06:43:25PM +0100, Mickaël Salaün wrote:
> > > On Mon, Feb 16, 2026 at 04:25:53PM +0100, Günther Noack wrote:
> > > > On Mon, Feb 16, 2026 at 03:26:38PM +0100, Mickaël Salaün wrote:

> > > > > @@ -389,6 +389,15 @@ static bool schedule_task_work(struct tsync_works *works,
> > > > >  			 */
> > > > >  			put_task_struct(ctx->task);
> > > > >  			ctx->task = NULL;
> > > > > +			ctx->shared_ctx = NULL;
> > > > > +
> > > > > +			/*
> > > > > +			 * Cancel the tsync_works_provide() change to recycle the reserved
> > > > > +			 * memory for the next thread, if any.  This also ensures that
> > > > > +			 * cancel_tsync_works() and tsync_works_release() do not see any
> > > > > +			 * NULL task pointers.
> > > > > +			 */
> > > > > +			works->size--;
> > > > 
> > > > Looks good.
> > > > 
> > > > [Optional code arrangement remarks:
> > > > 
> > > > I would recommend to put that logic in a helper function
> > > > "tsync_works_return(struct tsync_works *s, struct tsync_work *)", to
> > > > be in line with the existing implementation where the manipulation of
> > > > struct tsync_works is encapsulated in the "tsync_*" helper functions.
> > > > 
> > > > The scope of that function would be to do the inverse of
> > > > "tsync_works_provide()" -- putting the task_struct, decreasing
> > > > works->size, and then, to be safe, also clearing the contents of the
> > > > tsync_work struct (although that is strictly speaking not required if
> > > > we decrease the size, I think).
> > > 
> > > Should we move the atomic_inc() to tsync_works_provide() and the
> > > atomic_dec() to this new helper?
> > 
> > No, I would keep the atomic_inc() and atomic_dec() calls in the
> > functions where they are now.  
> > 
> > The atomic counters belong logically to the synchronization scheme
> > between the different threads, and I think it's clearer if we keep
> > that synchronization code outside of the struct task_works
> > abstraction.
> > 
> > I see the struct tsync_works and its operations (functions starting
> > with "tsync_works_") as logically belonging together in an
> > OO/encapsulation sense, and I think it's useful to have a clear
> > boundary of responsibilities.  These functions are only in the
> > business of managing the direct values stored in the "struct
> > tsync_works", and in the business of allocating the memory for that
> > data structure and incrementing refcounts to the struct task_struct.
> > (The latter is mostly useful to have in tsync_works_provide() because
> > the inverse put_task_struct() is useful to have in
> > tsync_works_release(), and then it is symmetric.)
> 
> This makes sense.
> 
> > 
> > 
> > > > The only unusual thing about the tsync_works_return() function would
> > > > be that it is only OK to return the very last tsync_work struct which
> > > > was returned from tsync_works_provide().
> > > 
> > > What about renaming tsync_works_provide() to tsync_works_push() and this
> > > new one to tsync_works_pop()?
> > 
> > I think I would find that naming slightly confusing: When a function
> > is called "push", I would normally expect to pass a value to it, but
> > we're getting one from it.
> 
> Well, it pushes the thread and returns the wrapped object.
> 
> > And when a method is called "pop" I would
> > expect to get a value from it.  But the inverse is true here.
> 
> Fair
> 
> > With
> > the names "provide" and "return" it feel that the directionality of
> > argument passing would be clearer.
> 
> I don't understand the logic with "return": this tsync_works_return()
> would not return anything.
> 
> What about something like tsync_works_shrink()?

tsync_works_trim() may be better.
