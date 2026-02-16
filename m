Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EB6236A73
	for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771270394; cv=none; b=tV/Z+V+1DMPLV06E9wmc6tPHcYOU/jqQOJJ+cOJepP/10TEnEVe6aIZJT2v82fsr3vXigpq4rKSX5DXAnkC3UrEDJTxxxv13nn4wtaD+eIPehgFXzglMjJ8/Yw1gYOc/eva8Wi25HQkAIsGzp68O2P9/ABzIg4h/Gw7kZ20QhVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771270394; c=relaxed/simple;
	bh=aFwHoUa/xXlynGsv5bhb74fy3BMSKJ7XnElPfvxsyD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihg5NHWudOITtGaCtOydyAqaT9pMSbaZCch53jB8jZ5pi8jbg4NdTVl+w8/Sg7jJuxgt2wXclC2NH0hrV/bf/iwgh0Xesjsulu/uyBtb85TLPfAr/qnFhW/B5w7WtHRcyCBc+DRzR6XdXldEt5Y6qJHDdbAEjsXQMSy4OrPppNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6KdEQIp; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6KdEQIp"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43626796202so3253623f8f.3
        for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 11:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771270391; x=1771875191; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A2RE9+nHzCQCP4uSlt2Lg6OP9K9Ee/j2pRwAIiZltKY=;
        b=g6KdEQIpIXFr24HgAS4LLjelwNjsE8oQx0QsZmrG33Tu50svlExxvmDDwGK3Ll23il
         qbOQiaaV10b4nR2WCjc3ix7zJtpKMKtZklXcuXzQ7sVL9c/VVWUkwj4gFSMB0ZIFT3OO
         MTQuawiErh63EftF+qIZGQUCzuV7QTX9qpzDu+IRfiLsgweHLTLMgEZZBks/mWQmlkv3
         /xpVDVGh5cLGM5djJF5lFiff50wnFGYyhHIHaOXVb0Fzp+Ynw1xSjSouAb/cwWo5T6H4
         tsZSpIyXRs6IZqT1wiXIEpDlH1CnKHiNvyASNjpp/RCpK6K484pSO31B2t6RVS8Bjw25
         ln0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771270391; x=1771875191;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2RE9+nHzCQCP4uSlt2Lg6OP9K9Ee/j2pRwAIiZltKY=;
        b=CTZgmASK0pq0FOfdeMJk/VZhcvIFJN2t6DsHY8MAZahX4TUcZkHnXOgHr6BPa5Hn7K
         mCSEmfoVAv7MXq1apn17vlqIR2J7iUu4OhBeqZmfAKegvl3CPATfT0R9HFG7S5Nv0f8e
         lXz09kMUjeWe6/tnofrdXCftyDC0i0qz/E83o17tw6y5ziQYfgTFA3RhtkW2Vyb3dMcR
         qMPwYwc2ax43p5PrdCUGzuBOvemaUpwj6xKus5U/tM7eAoyWkvtZsy3EYHnD0wRRYKmh
         /x7L4Pnf1ujy5MOqfS5qxxesnlPNUlqXwyyIzj2s2cIKy8s+2OOhKmUERoPxc3ca9Dgi
         HL8w==
X-Forwarded-Encrypted: i=1; AJvYcCUGG/kemCFAJ06ISdkInqnsKQvk+YcU9vwW8LZ/5rzIkdpmzQ0/6iv7aEFbp76FQG+1/ol7YvU/EVid+TkXEYrYBZdXMmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJrYutmxfmhuVLNIbzskPSc7Z6LlnjmN9aVj52qpkb1iu3iHma
	h7g1XwlFmDHcWkNG6bp/DbZZpK5dL/ZBUJWmVS1EVUGUonqGDL15+xnz
X-Gm-Gg: AZuq6aJaPH7T/S8GMo2y6h17hvA1Uup0O2VewilaBS2uR1Rjjk6VcoVE4gjLgB1fc0L
	+uTiubNl9qT/rXUGTabYYpsp5hq0mnXicd/ZATJijmPDSczc4Df5G7wK37P3lG2x1ZIuW4wO7TY
	H45Xs9i/cNyEotMGvkD1uz0qBUAUxK3F8+SaMRks66wkWWA/kubSgnLdr9JyG7zk0axmkkNGT2t
	Vzkf6MYm5PUj5Z1z/WVMbaj/XJ1NHSNYmplcNIsqhDB5/gHM2QGMgoaPAgM7+uM5wYENpCQ+Zot
	I2sja7Rd/0+q5FtCV//ZcOm6emPXkGScX1u2H6SzZIAt/+06/Y7N2CQIJgQ6ER+tr87RPYMkaY+
	RWTkLpkOfLCmjEENVq6cCZLwUzZ9x6l/UihZMUoCYEqJnmUdmTFPdCBvjWz/gqarQc2EOqU13hC
	4fs1kADkh2JxWrcPr2wUnCvdIv0aoszgZK2B0YNyeO1DL8iVA3
X-Received: by 2002:a05:6000:26cf:b0:437:a49:137d with SMTP id ffacd0b85a97d-437978e1929mr18833367f8f.21.1771270390988;
        Mon, 16 Feb 2026 11:33:10 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac800esm30839539f8f.27.2026.02.16.11.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 11:33:10 -0800 (PST)
Date: Mon, 16 Feb 2026 20:33:05 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v1 1/2] landlock: Fully release unused TSYNC work entries
Message-ID: <20260216.b2c8aaab9a80@gnoack.org>
References: <20260216142641.2100407-1-mic@digikod.net>
 <aZM3Ab6QJ8WR84J1@google.com>
 <20260216.iep2jei5Dees@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260216.iep2jei5Dees@digikod.net>

On Mon, Feb 16, 2026 at 06:43:25PM +0100, Mickaël Salaün wrote:
> On Mon, Feb 16, 2026 at 04:25:53PM +0100, Günther Noack wrote:
> > On Mon, Feb 16, 2026 at 03:26:38PM +0100, Mickaël Salaün wrote:
> > >  	for (i = 0; i < s->size; i++) {
> > > -		if (!s->works[i]->task)
> > > +		if (WARN_ON_ONCE(!s->works[i]->task))
> > 
> > Is this a condition we should warn on?  It is very unlikely, but it
> > can technically happen that a thread exits at the same time as TSYNC
> > and happens to hit that narrow race condition window.  As long as it
> > happens only sporadically, I don't think there is anything wrong (and
> > in particular, it's not actionable for the user - I don't think there
> > is a way to fix it if that warning appears?)
> 
> WARN() should definitely not be called if the condition can legitimately
> be true.
> 
> "task" is only set by tsync_works_provide(), so only by the caller
> thread.  How could "task" be NULL (within the works->size range)?

Ah, you are right.  This could have become NULL before, but now it
can't become NULL any more.  Please ignore my remark.


> > >  			continue;
> > >  
> > >  		put_task_struct(s->works[i]->task);
> > > @@ -389,6 +389,15 @@ static bool schedule_task_work(struct tsync_works *works,
> > >  			 */
> > >  			put_task_struct(ctx->task);
> > >  			ctx->task = NULL;
> > > +			ctx->shared_ctx = NULL;
> > > +
> > > +			/*
> > > +			 * Cancel the tsync_works_provide() change to recycle the reserved
> > > +			 * memory for the next thread, if any.  This also ensures that
> > > +			 * cancel_tsync_works() and tsync_works_release() do not see any
> > > +			 * NULL task pointers.
> > > +			 */
> > > +			works->size--;
> > 
> > Looks good.
> > 
> > [Optional code arrangement remarks:
> > 
> > I would recommend to put that logic in a helper function
> > "tsync_works_return(struct tsync_works *s, struct tsync_work *)", to
> > be in line with the existing implementation where the manipulation of
> > struct tsync_works is encapsulated in the "tsync_*" helper functions.
> > 
> > The scope of that function would be to do the inverse of
> > "tsync_works_provide()" -- putting the task_struct, decreasing
> > works->size, and then, to be safe, also clearing the contents of the
> > tsync_work struct (although that is strictly speaking not required if
> > we decrease the size, I think).
> 
> Should we move the atomic_inc() to tsync_works_provide() and the
> atomic_dec() to this new helper?

No, I would keep the atomic_inc() and atomic_dec() calls in the
functions where they are now.  

The atomic counters belong logically to the synchronization scheme
between the different threads, and I think it's clearer if we keep
that synchronization code outside of the struct task_works
abstraction.

I see the struct tsync_works and its operations (functions starting
with "tsync_works_") as logically belonging together in an
OO/encapsulation sense, and I think it's useful to have a clear
boundary of responsibilities.  These functions are only in the
business of managing the direct values stored in the "struct
tsync_works", and in the business of allocating the memory for that
data structure and incrementing refcounts to the struct task_struct.
(The latter is mostly useful to have in tsync_works_provide() because
the inverse put_task_struct() is useful to have in
tsync_works_release(), and then it is symmetric.)


> > The only unusual thing about the tsync_works_return() function would
> > be that it is only OK to return the very last tsync_work struct which
> > was returned from tsync_works_provide().
> 
> What about renaming tsync_works_provide() to tsync_works_push() and this
> new one to tsync_works_pop()?

I think I would find that naming slightly confusing: When a function
is called "push", I would normally expect to pass a value to it, but
we're getting one from it.  And when a method is called "pop" I would
expect to get a value from it.  But the inverse is true here.  With
the names "provide" and "return" it feel that the directionality of
argument passing would be clearer.


> > It's an improvement either way though; If you want to prioritize
> > fixing this and don't want to extract the extra function now, we can
> > also look into it in a follow-up.  From a functional standpoint, I
> > think your code works as well.
> 
> It's a small refactoring, so better to do it now.

Sounds good. 👍

–Günther
