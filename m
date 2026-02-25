Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6810E33C182
	for <linux-security-module@vger.kernel.org>; Wed, 25 Feb 2026 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772058837; cv=none; b=BR4+XpI9ZYMdEaJwBh5xQwYJ5zWteOcCgtoiUpOg3J/9pzeEFxIBye7r9YnZCQwBlj1l1al5rOVVeUmr79V2/7Vfa50r8wZ/rjOWDJ7Ywy6/8e20WwngS6T2FBj2YqpubcmwAeJcPocTYRi157l6rGofYsp+PGJhP91Ypft5Ut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772058837; c=relaxed/simple;
	bh=B6+N1rlexK/378DaQUsJAd95CBZhwRfjwprFPzY/f+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mP6KZJplJZFPrhBgm/Xrt9ADY2xHZ7j057N/ZIWKlU79Kup5z3QTGnzmuoLCI4kxqz0r1iN26dYqcAuTkoyd+8lh1+OOzpAAv7OreUUqP4BU3aUOSfhKpkCwiirO/NSL5lFPp3TWhIgl5P0jNUaRtBEL4NhcWNibHaZ2pybr9/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/5Hpqvs; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/5Hpqvs"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48336a6e932so1427215e9.3
        for <linux-security-module@vger.kernel.org>; Wed, 25 Feb 2026 14:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772058834; x=1772663634; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YLqsjFGaTAomOM6oIdhV2ENKyEdrq9mkRamWZMAgaKQ=;
        b=D/5Hpqvs7Bh+FlhQReQQucDWufgJygjm0sRWxayA8K58/eQIkXKd1YUMVm8U1SrWzl
         odF0xInAzY6sOgFvU/gx/RegeclehulLV1l6nLvi0jiI+T/GTzEV2ANELp1JiPwe2C9P
         f+ZQuASaWiCgZ920insuN3m+tmE0vKLCvyGNeqBPm40BPbUrS4bDD6GMzMIROMRz2Pnj
         Po8ElkXs897XBuzYe9LSx37CDXW5khyTEIU4BZOK30Jfy+FUt9xBlZS9knzEDgajHcXf
         gJ/KgNhXT6QbQ1iVZgtSeRD/Yi1TAwZsI7OKDwXtu2wOfKNUUXjdn96oADzwpr1hnrj4
         RFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772058834; x=1772663634;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLqsjFGaTAomOM6oIdhV2ENKyEdrq9mkRamWZMAgaKQ=;
        b=tteQ7zGf5Q70eyu63QZOY8VN72k1s96NXa5xHmoA8pgJudGI9DYqCbBDuZm+FxJ9N4
         PsICBEiXBJMmeJ+tzl1Y34cBqQpwvrGvdgLT9fX/yLZufOBUHSMUZPBKV8ZxNGRr16Uz
         lTJXl4+fauDsOlbSdyYwnFojaeABiUr2YVP6cIZTyGrgR6PDOFlSMVc24KWKny7m/KTB
         eL1BhArj11I327YUbzUE33+guIFlaQqDsNXBpVZKZb9v8+qMV9j7A3KeMmiaA9bWMrJv
         gSpsVWzl3niobxl2CBff5/XX2vGD+OuB5ixhsDq0FtCTsyFoJBLZzBqWTZZnyAiE0dWL
         pktg==
X-Forwarded-Encrypted: i=1; AJvYcCXMElsXnn42uSJ8x/GHVQ+Lc2WnL+IofGO6PKaUG5fFhwWAnBNHfTh2P0MW7xUFLfpPCqgX23ZnThpQ8d6aanH3D4982pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCvMP16Uq0ZrejpobQ+yio/XJQXcAhPCgBnkYLvefC0XpIFUkO
	sWLG98BhP9vj5/eE2U47nNLPkZ1NdSGiBKmp8bUVnjxALVRPnySlBydI
X-Gm-Gg: ATEYQzyNZI81VnCy5lx83PRi0RzOYgGkvo04DCuBjrSn1JXGuWjKZ0znGsMqQsTVvhj
	TdwD52oWEZ+9axBxVxGpD9S2EBP9ONWhcjuT2fEakfRKFdeE4cZT8WQ68j1CMebq/HALKq+S5y4
	sl421rC+DS8453D7gShPkCb5Do78LU2pR2RVDgAsME80LmMCS2b1Q1M0cbGcO/SADBQQSthYS2v
	10XLbP3OOWPA/QDSPGMcoiUnGVyq2GLQ0DRc+v1kRsiLzH/zTO4FjvtOCGmT5oJxNZ9Q8dt0EsE
	fBwMWFl0EaylfzX4ACUdO2KJMPKwTesHDGzTBclUD99eDz+GgnBA/leIxuN6LHUE/qZAIKb9wxT
	dCR2bO25BkeMs4fpcnEc+9Nqqq0/MEbHRQqrDR2BIz96cuyVsySK5Pn1HwBENK69mBzLhHuNiV9
	rLbRQLztE0k57hey+i8ESJDiRfWXZxIT8Bkv5GaTrBojB1oivNozLGctRLn0I=
X-Received: by 2002:a05:600c:a086:b0:47d:3ffa:5f03 with SMTP id 5b1f17b1804b1-483c219b648mr35738415e9.21.1772058833615;
        Wed, 25 Feb 2026 14:33:53 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcb4f8bsm54181545e9.4.2026.02.25.14.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 14:33:53 -0800 (PST)
Date: Wed, 25 Feb 2026 23:33:39 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Cc: Yihan Ding <dingyihan@uniontech.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/2] landlock: Serialize TSYNC thread restriction
Message-ID: <20260225.42330125301c@gnoack.org>
References: <20260225024734.3024732-1-dingyihan@uniontech.com>
 <20260225024734.3024732-2-dingyihan@uniontech.com>
 <aZ7l6jU7XJ1BYbN-@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ7l6jU7XJ1BYbN-@google.com>

On Wed, Feb 25, 2026 at 01:07:26PM +0100, Günther Noack wrote:
> On Wed, Feb 25, 2026 at 10:47:33AM +0800, Yihan Ding wrote:
> > syzbot found a deadlock in landlock_restrict_sibling_threads().
> > When multiple threads concurrently call landlock_restrict_self() with
> > sibling thread restriction enabled, they can deadlock by mutually
> > queueing task_works on each other and then blocking in kernel space
> > (waiting for the other to finish).
> > 
> > Fix this by serializing the TSYNC operations within the same process
> > using the exec_update_lock. This prevents concurrent invocations
> > from deadlocking. We use down_write_killable() to ensure the thread
> > remains responsive to fatal signals while waiting for the lock.
> > 
> > Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restrict_self()")
> > Reported-by: syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=7ea2f5e9dfd468201817
> > Suggested-by: Günther Noack <gnoack3000@gmail.com>
> > Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
> > ---
> >  security/landlock/tsync.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> > index de01aa899751..420fcfc2fe9a 100644
> > --- a/security/landlock/tsync.c
> > +++ b/security/landlock/tsync.c
> > @@ -447,6 +447,13 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
> >  	shared_ctx.new_cred = new_cred;
> >  	shared_ctx.set_no_new_privs = task_no_new_privs(current);
> >  
> > +	/*
> > +	 * Serialize concurrent TSYNC operations to prevent deadlocks
> > +	 * when multiple threads call landlock_restrict_self() simultaneously.
> > +	 */
> > +	if (down_write_killable(&current->signal->exec_update_lock))
> > +		return -EINTR;
> > +
> >  	/*
> >  	 * We schedule a pseudo-signal task_work for each of the calling task's
> >  	 * sibling threads.  In the task work, each thread:
> > @@ -556,6 +563,7 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
> >  		wait_for_completion(&shared_ctx.all_finished);
> >  
> >  	tsync_works_release(&works);
> > +	up_write(&current->signal->exec_update_lock);
> >  
> >  	return atomic_read(&shared_ctx.preparation_error);
> >  }
> > -- 
> > 2.51.0
> > 
> 
> Thank you!
> 
> Reviewed-by: Günther Noack <gnoack@google.com>

Hello Yihan Ding!

Apologies, I have to take this back -- applying the patch in this form
would be a mistake.  When I tried this out with the Syzkaller test
case, I noticed that the tests started taking multiple seconds per
run.  The way I reproduced it was by running the Syzkaller reproducer
under Qemu and looking for the frequency of the "executing program"
lines that it prints for each test run.

When I looked deeper, what was happening was actually that we got
ourselves into a deadlock again, which, in hindsight should have been
obvious: When two threads call landlock_restrict_self() roughly at the
same time, then the one that grabs the lock first will (a) keep the
other (killably) blocked on the lock acquisition, and (b) later ask
the other thread to run a task work.  But in order to run a task work,
the blocked thread must first return from the syscall.  However,
down_write_killable() only returns when either the lock is available
or when the thread was killed.

To resolve this, we need to actually use a lock acquisition that
respects other ways of interruption as well; we can either use a
down_write_trylock() and return -ERESTARTNOINTR, or we can use
down_write_interruptible().

Sorry for the poor advice to use the _killable variant earlier.  Could
I ask you to please send another revision using _trylock() or
_interruptible()?

Thanks,
–Günther
