Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D325617993
	for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 21:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771278178; cv=none; b=bZNWUKqE9s1P3Hhu+GyJlOhXhiBAmBqQBqlc90SyfITfM5Io1UmxVHpRIxiHILScdv05YpyOKhM3yriLQB6mQgIUJxB1Tj8kAkrkMBUQdWgSDV2N0bTp0iSmRbexv8mnRP3puYiYkIhlR0YhXiO0kTs/eL86SHWbHY7bqKsUQ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771278178; c=relaxed/simple;
	bh=7sAFABGkVO8ARn4V+VHcmNZWaVJr/6QpbB26KsczG1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4rrH8TLXvFILcdiaIxM6+RuYTpGwE8nlCnrEduvudZ8BYV8399iuWnQ/lOdCaL1ECMRD/ct9MftdMoz2u7gAEbz2KJVJwTWdUP1bLkQB4KIaZN1XR+WH+y47bIDpEBa/XvCh0MGOF0nHddfKffIJPbadgyOP+qeXDEXGEWii4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5J85f44; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5J85f44"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-483487335c2so34068455e9.2
        for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 13:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771278175; x=1771882975; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v3ej/G/JArOiKhfqCd2T4yNs2SXb3xqfhOBsqU4PgoU=;
        b=W5J85f44iSk+xZqSt8fuyIJjJI1R8VXPqbV0wSc2EStRHhTi69tC3aADojOuyFyu9/
         f+CleZ5XOkuozB94WxV+v2IfJdPbTRcqLOMhqxFMsAvDiKB1zvesb6Ofbz3ycQjyPCZi
         /jQhvg76w8R0XubpEU3JL7QkIl1HzC19PmXpEX2Zt2nl4RKIvj0+IiuVaYZ8u6dYk8EH
         x2qSDB8qO4qAcBkcyQ/Js5wcbI3PFBtGRBeZHQWy/Gkfxz7da+342A6MB4FZ+XtTOPTc
         1pCcknHQBVnVwCxrIvTDYrhxnbt+fPU015EVdQ76zGW1cvB4T4qDp/KVvAj2V0wr0bnP
         pb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771278175; x=1771882975;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3ej/G/JArOiKhfqCd2T4yNs2SXb3xqfhOBsqU4PgoU=;
        b=apn80IZdEr/lZS8Gd+q3YkPXlO3Wdk+L3jQ0ln3xgCAzqmeo9udGMyEiVmk3LLuLoI
         xpIjduPfoQXak10ZYBnPBSH3rAkpAq1nAit7QHwJsWd4hRwtfCECKGI1OvYQBpzc9ox5
         V2yKidG/Khil+bZOB6v/vIq3qHNobpuJ6W8sGd9KoJnrSEjNbgrH4DohmhC/1u2s+3B1
         RxWvE6aLlL4x5oiSvVgYJvI7m8u/plMXK65RLGyiLLAGSOqg87Gb6M7nNFSKJ9UGx5nJ
         aW4QztlKlcVZu0T3dPBq7z6Z3LufcMDVdJmkYwL5T2w1R3/TAYV+cxIVku9GWTC0FQEH
         gJzw==
X-Forwarded-Encrypted: i=1; AJvYcCWZVuqgJKo3rW6fkDQHQAafF8Ni3IA7qubVD97mlX+wmXW4fi3rSDdCJpc8o3Yta7tFarupHe5/5+dgjpnYQwZqz+IVHZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMUZDyX4KChX5ogTx/kyq9fcFpVB3LdS1qEjn/NFNYFXqGssJo
	1GIgHxHRpT+fplzgu/elrEDvYXd44qdi79dK8HxPPrbfalJ5PWB+KdRtfE8uTsq1
X-Gm-Gg: AZuq6aLpgmPgxGQ6PCa9qGQLDQ1Pyj62yPsRn2kDC3pmHTB0zOqEiLNIrS8oEHjCdWz
	ExDZNBfA7eez/yRgumQBXptamyp5JXGg6kVMJvOwgkuhGcg5dwEXlEYakjj0ecWF4TDUeqpK6r3
	MwKlzznUet0SRWPlx52Hnl/dt/Vf2tZqjDsuNvNcfCS2AySFeVgYUnOjHQsHCABXpioKZhjY0fZ
	Vp5aiBYcGD321r6AkHyJzEo1lDlO0+KYE5VaQqM2aJRH2GBKW92uSoza7xdo4rm5KA/oYBYE9Di
	L+E43gwav2H5K1MMBIZ1I0bsDS8LbppQ/x2B7L95dDyxW71ou03Ldhl7Poc2Ew1CHnRNWZ5LNWj
	BTZZjiv0rkvVWwIhLjRbLm9nYEx5fn6u2UipaoYG67xNV/UZ0fY2qOVMYpUDMeJ8IDx2DLvS2Eb
	WN8APYqX907852KegyJKGgIqj7qrvWWRt5DhgyATg9Vp3zV5qA
X-Received: by 2002:a05:600c:5294:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-48380620cf2mr115387645e9.6.1771278175020;
        Mon, 16 Feb 2026 13:42:55 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5b07fsm28888356f8f.2.2026.02.16.13.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 13:42:54 -0800 (PST)
Date: Mon, 16 Feb 2026 22:42:49 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v1 1/2] landlock: Fully release unused TSYNC work entries
Message-ID: <20260216.515c8c861819@gnoack.org>
References: <20260216142641.2100407-1-mic@digikod.net>
 <aZM3Ab6QJ8WR84J1@google.com>
 <20260216.iep2jei5Dees@digikod.net>
 <20260216.b2c8aaab9a80@gnoack.org>
 <20260216.deiM1cuphohZ@digikod.net>
 <20260216.chunooXu4ahl@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260216.chunooXu4ahl@digikod.net>

On Mon, Feb 16, 2026 at 09:10:59PM +0100, Mickaël Salaün wrote:
> On Mon, Feb 16, 2026 at 08:57:34PM +0100, Mickaël Salaün wrote:
> > On Mon, Feb 16, 2026 at 08:33:05PM +0100, Günther Noack wrote:
> > > On Mon, Feb 16, 2026 at 06:43:25PM +0100, Mickaël Salaün wrote:
> > > > On Mon, Feb 16, 2026 at 04:25:53PM +0100, Günther Noack wrote:
> > > > > On Mon, Feb 16, 2026 at 03:26:38PM +0100, Mickaël Salaün wrote:
> 
> > > > > > @@ -389,6 +389,15 @@ static bool schedule_task_work(struct tsync_works *works,
> > > > > >  			 */
> > > > > >  			put_task_struct(ctx->task);
> > > > > >  			ctx->task = NULL;
> > > > > > +			ctx->shared_ctx = NULL;
> > > > > > +
> > > > > > +			/*
> > > > > > +			 * Cancel the tsync_works_provide() change to recycle the reserved
> > > > > > +			 * memory for the next thread, if any.  This also ensures that
> > > > > > +			 * cancel_tsync_works() and tsync_works_release() do not see any
> > > > > > +			 * NULL task pointers.
> > > > > > +			 */
> > > > > > +			works->size--;
> > > > > 
> > > > > Looks good.
> > > > > 
> > > > > [Optional code arrangement remarks:
> > > > > 
> > > > > I would recommend to put that logic in a helper function
> > > > > "tsync_works_return(struct tsync_works *s, struct tsync_work *)", to
> > > > > be in line with the existing implementation where the manipulation of
> > > > > struct tsync_works is encapsulated in the "tsync_*" helper functions.
> > > > > 
> > > > > The scope of that function would be to do the inverse of
> > > > > "tsync_works_provide()" -- putting the task_struct, decreasing
> > > > > works->size, and then, to be safe, also clearing the contents of the
> > > > > tsync_work struct (although that is strictly speaking not required if
> > > > > we decrease the size, I think).
> > > > 
> > > > Should we move the atomic_inc() to tsync_works_provide() and the
> > > > atomic_dec() to this new helper?
> > > 
> > > No, I would keep the atomic_inc() and atomic_dec() calls in the
> > > functions where they are now.  
> > > 
> > > The atomic counters belong logically to the synchronization scheme
> > > between the different threads, and I think it's clearer if we keep
> > > that synchronization code outside of the struct task_works
> > > abstraction.
> > > 
> > > I see the struct tsync_works and its operations (functions starting
> > > with "tsync_works_") as logically belonging together in an
> > > OO/encapsulation sense, and I think it's useful to have a clear
> > > boundary of responsibilities.  These functions are only in the
> > > business of managing the direct values stored in the "struct
> > > tsync_works", and in the business of allocating the memory for that
> > > data structure and incrementing refcounts to the struct task_struct.
> > > (The latter is mostly useful to have in tsync_works_provide() because
> > > the inverse put_task_struct() is useful to have in
> > > tsync_works_release(), and then it is symmetric.)
> > 
> > This makes sense.
> > 
> > > 
> > > 
> > > > > The only unusual thing about the tsync_works_return() function would
> > > > > be that it is only OK to return the very last tsync_work struct which
> > > > > was returned from tsync_works_provide().
> > > > 
> > > > What about renaming tsync_works_provide() to tsync_works_push() and this
> > > > new one to tsync_works_pop()?
> > > 
> > > I think I would find that naming slightly confusing: When a function
> > > is called "push", I would normally expect to pass a value to it, but
> > > we're getting one from it.
> > 
> > Well, it pushes the thread and returns the wrapped object.
> > 
> > > And when a method is called "pop" I would
> > > expect to get a value from it.  But the inverse is true here.
> > 
> > Fair
> > 
> > > With
> > > the names "provide" and "return" it feel that the directionality of
> > > argument passing would be clearer.
> > 
> > I don't understand the logic with "return": this tsync_works_return()
> > would not return anything.
> > 
> > What about something like tsync_works_shrink()?
> 
> tsync_works_trim() may be better.

The idea with "return" is that we are returning the previously
provided tsync_work item back into the struct tsync_works.  But I can
see that it can be confused with C's "return" statement.
tsync_works_shrink() or tsync_works_trim() is also OK.

Other options, btw, include "reclaim()" or "recycle()", if you like
that better (these LLMs are useful as thesaurus... 8-)).

I'm fine with either name, as long as the function still puts the
task_struct of the returned task_work item.  (That would be good to
keep doing, for symmetry with the _provide() and _release()
functions.)

–Günther
