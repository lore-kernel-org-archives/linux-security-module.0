Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6835F391E66
	for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773147658; cv=none; b=kMTLnvBGZSB9HJz35rm8DwEQ5i1FvmL5o5tS2f8pk/lA2iyy72XhwYo07ovqAoo+sHC89+Hae+LopdShVeFWLFgkgrI2xpo6xMJGHc29Vf7Yxzbl224TUujdxSTEcHsiOU4/B3L2x2OC8qw9WSMqJzJ7dv+dBugqQLlB8gGIdmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773147658; c=relaxed/simple;
	bh=KiqEIvJC2XxaOt4+odDse+yl5KBjrbJEyiiL2mgH6fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grV3Zu9KaOu1pUZz0d6tadAvoivgzxM1L9FRQB+iGD8JyTffhqMLQ5hzveaskdKFK7OTvH6lXjJXMifewR1Qk2zqkR5+6573HkZi2//yqrgP0h9CX+gicTxYG4kWt3zml1+ZYm7LcmS2tRgvTKda0F882IpUR3K4CjDdOlxuYHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AUHCnirJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AUHCnirJ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso104602145e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 06:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773147656; x=1773752456; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3EoP276khAoPelDBterGyQsswyPNkZdGPT+DJMFh/sQ=;
        b=AUHCnirJvW1SbsB/77I+9FswMHjDrRP7bAaQoggSJjVA1m/dVvH+eN8oRL+I/IVTvP
         UEXQO7pmpYYZOAUEHxyGYVY0Bm2T0NkiI8t+XZeMo68/8WZLNCm3oytMpIPDe4YoohF9
         sNVKkrNgdvYyMzhsLXEPkUlekbBYGTg6CrtY0NIqIHknEH3iAgx4QDDGAvsP/TaKJkJj
         0XrGoFnB7eqmdug6qXMd4Zxiy7dwIRLTVvgvA3UaoOchZ6jzzKbz4WFH+fRVBvX5godk
         HO16s49kXUztCH6FDTOPAqiOUXOLM3VOmCa/E9EmTnZI38SVcRVbRjdixwwXBhWygQwn
         kVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773147656; x=1773752456;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3EoP276khAoPelDBterGyQsswyPNkZdGPT+DJMFh/sQ=;
        b=SkwoFOCXo3y8jkeXRABWY2rTysr4vdtDg6Y8Ds7YwkdkWzqrUb5sFso9jdumzesPgD
         MjVF/OfNaIKokpPXLvqwa1xKacu2fJePZbVI/Qt2ABuF4vu2j6iK5t/nKdP3SfYyKBjq
         VVjygGBTu0f9TtKEDuuHMIJIx2f5/38Qp6G8sSvMG3BPJdmsUVh6zYryuXFxAnFTPKvb
         wD5FvY+Ys0jwHLJdkKTt9jcTAZc0szhebiQt8eDB84sAIwSp33tFe/y52BD50BSik8J8
         HnNtfqMPUGdCouEXJqPh52GbCmuBTo1ODPQ39q3alOl8Jp5W9XCbSqHJb5hvemOTPSzb
         pj0w==
X-Gm-Message-State: AOJu0YyqW7ZQLat6aUGp7wybUAhjfRdnoGyJuNfprh6nl73GkFoBXRNW
	fsqom1oxzrHK3xaYpgs4x9iBuO8yvZrKyQqbyzj7cbmslunU/zpR8muw/n/zWf8G9A==
X-Gm-Gg: ATEYQzy8aZ8cRpEgQMvfGvWZsEljquOYIocRpVcxOyqRuSG817NdOTwji/+C/EkjUGy
	A43HWNlV4fYTJteE39hkS1VlELt6Cp2lGMI+6U3Z9Dd1mNU3HLbGtc79k0bl6uWy0LsTpkuy44a
	lCEMvFAnu4hXQf/c6++pEDbLNoR2snuZ66Q61VJqMUCMczZ+c5X94cEfS+w3MR1S2cDnKtEagwJ
	QPdowtQ6IDwHmj32rNAESisxYBcee8XMs3pQ46GnJlO5YcAK1UmlTmjIyW03P1rYz/7FyH4Q8Jy
	JJVGmhNglLVQyb6tHSJRWlfU4tqkM8kWmkI8nn2voAiz9pMgKNnFBMXD64MVzLJUE1NXJdxCGGd
	3NFRy6/8n+fVGwj+8gdoJbtkOeibRo27eNu0erOJCbi8L0ywdWOMmTAU/XBzQsNgarkCie/KtiY
	dPbQytrJubZhlcZ2oZ5EOM/8auvPmWJNjUfleAljV+8HgO0PFC54pLrQ==
X-Received: by 2002:a05:600c:3b92:b0:485:3b00:f939 with SMTP id 5b1f17b1804b1-4853b00fa43mr136361525e9.8.1773147655234;
        Tue, 10 Mar 2026 06:00:55 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:43dd:a0ed:65ba:bc74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae3a20fsm35346168f8f.28.2026.03.10.06.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:00:54 -0700 (PDT)
Date: Tue, 10 Mar 2026 14:00:49 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-security-module@vger.kernel.org,
	syzbot+911d99dc200feac03ea6@syzkaller.appspotmail.com,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] landlock/tsync: fix null-ptr-deref in
 cancel_tsync_works()
Message-ID: <abAWAauogoaaa4kN@google.com>
References: <20260306092214.63179-1-jiayuan.chen@linux.dev>
 <aarYeYrXnp3PmrFy@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aarYeYrXnp3PmrFy@google.com>

On Fri, Mar 06, 2026 at 02:39:45PM +0100, Günther Noack wrote:
> On Fri, Mar 06, 2026 at 05:22:13PM +0800, Jiayuan Chen wrote:
> > cancel_tsync_works() iterates over works->works[0..size-1] and calls
> > task_work_cancel() on each entry.  task_work_cancel() leads to
> > task_work_pending(), which dereferences task->task_works.  If
> > works->works[i]->task is NULL, this causes a null-ptr-deref:
> > 
> > KASAN: null-ptr-deref in range [0x00000000000009a0-0x00000000000009a7]
> > RIP: 0010:task_work_pending include/linux/task_work.h:26 [inline]
> > RIP: 0010:task_work_cancel_match+0x86/0x250 kernel/task_work.c:124
> > RSP: 0018:ffffc90003597ba0 EFLAGS: 00010202
> > RAX: 0000000000000134 RBX: 0000000000000000 RCX: ffffc900106b1000
> > RDX: 0000000000080000 RSI: ffffffff81d13236 RDI: 0000000000000000
> > RBP: 1ffff920006b2f77 R08: 0000000000000007 R09: 0000000000000000
> > R10: 0000000000000002 R11: 0000000000000000 R12: ffffffff81d12dd0
> > R13: ffff88802c045100 R14: dffffc0000000000 R15: 00000000000009a0
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000000110c3ea90c CR3: 0000000037f63000 CR4: 00000000003526f0
> > DR0: 0000000000000003 DR1: 00000000000001f8 DR2: 000000000000008e
> > DR3: 000000000000057a DR6: 00000000ffff0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  task_work_cancel+0x23/0x30 kernel/task_work.c:187
> >  cancel_tsync_works security/landlock/tsync.c:415 [inline]
> >  landlock_restrict_sibling_threads+0xafe/0x1280 security/landlock/tsync.c:533
> >  __do_sys_landlock_restrict_self+0x5c9/0x9e0 security/landlock/syscalls.c:574
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f859b39c629
> > RSP: 002b:00007f85991b2028 EFLAGS: 00000246 ORIG_RAX: 00000000000001be
> > RAX: ffffffffffffffda RBX: 00007f859b616270 RCX: 00007f859b39c629
> > RDX: 0000000000000000 RSI: 000000000000000a RDI: 0000000000000003
> > RBP: 00007f859b432b39 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007f859b616308 R14: 00007f859b616270 R15: 00007ffcff084488
> > 
> > The root cause is a race in schedule_task_work().  tsync_works_provide()
> > increments works->size and stores the task reference in ctx->task *before*
> > task_work_add() is called.  A thread can race to call do_exit() in the
> > window between the PF_EXITING check and task_work_add(), causing
> > task_work_add() to return -ESRCH.  The error path then drops the task
> > reference and sets ctx->task = NULL, but works->size remains incremented.
> > A subsequent call to cancel_tsync_works() iterates up to the stale size
> > and passes the NULL task pointer to task_work_cancel().
> > 
> > Fix this by decrementing works->size in the task_work_add() error path,
> > so the failed slot is rolled back and cancel_tsync_works() never iterates
> > over it.  The slot is naturally reused in subsequent iterations since
> > tsync_works_provide() always picks works->works[works->size].
> > 
> > As a defensive measure, also add a WARN_ONCE() guard in cancel_tsync_works()
> > to catch any future NULL task pointer before dereferencing it.
> > 
> > Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restrict_self()")
> > Reported-by: syzbot+911d99dc200feac03ea6@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=911d99dc200feac03ea6
> > Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> > ---
> >  security/landlock/tsync.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> > index 0d2b9c646030..e6d742529484 100644
> > --- a/security/landlock/tsync.c
> > +++ b/security/landlock/tsync.c
> > @@ -381,14 +381,14 @@ static bool schedule_task_work(struct tsync_works *works,
> >  		err = task_work_add(thread, &ctx->work, TWA_SIGNAL);
> >  		if (err) {
> >  			/*
> > -			 * task_work_add() only fails if the task is about to exit.  We
> > -			 * checked that earlier, but it can happen as a race.  Resume
> > -			 * without setting an error, as the task is probably gone in the
> > -			 * next loop iteration.  For consistency, remove the task from ctx
> > -			 * so that it does not look like we handed it a task_work.
> > +			 * task_work_add() only fails if the task is about to exit.
> > +			 * We checked PF_EXITING earlier, but the thread can race to
> > +			 * exit between that check and task_work_add().  Roll back the
> > +			 * slot so cancel_tsync_works() never sees a NULL task pointer.
> >  			 */
> >  			put_task_struct(ctx->task);
> >  			ctx->task = NULL;
> > +			works->size--;
> >  
> >  			atomic_dec(&shared_ctx->num_preparing);
> >  			atomic_dec(&shared_ctx->num_unfinished);
> > @@ -412,6 +412,11 @@ static void cancel_tsync_works(struct tsync_works *works,
> >  	int i;
> >  
> >  	for (i = 0; i < works->size; i++) {
> > +		if (WARN_ONCE(!works->works[i]->task,
> > +			      "landlock: unexpected NULL task in tsync slot %d\n",
> > +			      i))
> > +			continue;
> > +
> >  		if (!task_work_cancel(works->works[i]->task,
> >  				      &works->works[i]->work))
> >  			continue;
> > -- 
> > 2.43.0
> > 
> 
> Thanks for the patch!
> 
> This bug is already fixed on Mickaël's "next" branch.
> The code review has happened in
> https://lore.kernel.org/all/20260217122341.2359582-1-mic@digikod.net/
> 
> —Günther

#syz fix: landlock: Fully release unused TSYNC work entries

(See https://github.com/google/syzkaller/blob/master/docs/syzbot.md#communication-with-syzbot)
