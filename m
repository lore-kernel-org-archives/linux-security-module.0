Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59C12F9998
	for <linux-security-module@vger.kernel.org>; Fri,  6 Mar 2026 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772804391; cv=none; b=rSPvdG/EB24vQH+Ij5JGevTpDs4AOr+08sszb56C7maRL4itgfyHuECTj+VOfk6kruX47K/dzxQ0Hw5zAWhbUT5V26hu9xc3DagkOmSV2NgzxiKHYMFOOTNHfhHloqYICPoiTwc4LqunspTHk9/T0t5KyBQNEAIJDo5Sarp97tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772804391; c=relaxed/simple;
	bh=dSPN6JYf8aXz88RxLJ+1KaYKy1cI2VeWPv7fY79Wix8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mktu6Bz8cZkmaAeNeF6FqKHcBkd2UHvecIvH8n0ywm6MD2kxF+JuLbaxhrgTF+lpla9Rj61f3jWxXiXIGB7kNeacizWXuiLEZC1e+R0sOW/7u1StShd/F+YZuw64rB5lqMr2s1b6Erd1+oCCxmXNX+J1frtRvUsOhih3m1hX5zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bsuZ053C; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bsuZ053C"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4806b12ad3fso80742865e9.0
        for <linux-security-module@vger.kernel.org>; Fri, 06 Mar 2026 05:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772804388; x=1773409188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rl98ha3JHx+qGRqBBjXoaGncNHMrS0OxF0sNmP/5fHU=;
        b=bsuZ053Cj4T48xvjiCaq3R42KyzmYrMQzWevIC/3Y1jGlt1QtS5WPLN4vkRM4iSGOr
         7cGyDomPAvizCVWRPiQFWZgUvo/XVi2suRnOw0AAfE6Nvz3aWY1M9mzEGdu8djF8h2Z0
         Tf1SoKNagqzSN0SrNucql8Q/15/ebDdv0BLmnYixWA9NF0JcBlUgjtNOIKAMdBjFs1Je
         C2TS6lIADgpr2k+xZO6arRQWvCEJ0oa6bTLgSpSjgBOzO9RCMRUUxaJfFljxhqEoq1Rp
         nFmdP52jrEk1X3znI1N423fsIsLDfQRwbbfrBDt02P+YNTySuCJsIM4xUaqjQA/YOpRg
         y8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772804388; x=1773409188;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rl98ha3JHx+qGRqBBjXoaGncNHMrS0OxF0sNmP/5fHU=;
        b=wGmEaPXAgYXFJafE9mNaLYIX3hXcJJcAycdfBwXfD4aXgMzi1pCre1hgWZVyxMM8LX
         2IbAQMIE8UUML/lXaCjTc3XT+vMpJUvXSfgmdPsxJdRPEN5VHqr3FsT8pt2opTr8+GCy
         lwg7mv88xBNj+3aij5Cpbxmwa2gn8NuZtdg78ChWC6Gh2jc5fjOC5IMjKJ2tZoGIw2Ct
         F8vABi44cYobTXDo4woGZNG615h2tSAkO8BVxOm7p5VUpGxC8WQ141l42MYUCgStQIyS
         OW6uoRvAxYZ0YL8mrRZzvOCTX2M+Kd+YrpE0ezC0NZOD0LsaESVDvBYR9gbDxVHRa+5C
         7hNQ==
X-Gm-Message-State: AOJu0YxFgAmpDVF62KbURGBGeKTkoykON4C2AvVic6epBQbGQHbbOhRa
	C71baGSUy5Aymu0RRBtT5KupLDn8tOVTA/LHEUTNhtzzCqqEHYbrX19Ml+SHJxLpB/ORV39hPj1
	MjYNMrQ==
X-Received: from wmo8.prod.google.com ([2002:a05:600c:2308:b0:483:7039:5733])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1e2a:b0:483:c771:10e
 with SMTP id 5b1f17b1804b1-48526957d6cmr31843815e9.20.1772804387837; Fri, 06
 Mar 2026 05:39:47 -0800 (PST)
Date: Fri, 6 Mar 2026 14:39:45 +0100
In-Reply-To: <20260306092214.63179-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306092214.63179-1-jiayuan.chen@linux.dev>
Message-ID: <aarYeYrXnp3PmrFy@google.com>
Subject: Re: [PATCH v1] landlock/tsync: fix null-ptr-deref in cancel_tsync_works()
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-security-module@vger.kernel.org, 
	syzbot+911d99dc200feac03ea6@syzkaller.appspotmail.com, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2026 at 05:22:13PM +0800, Jiayuan Chen wrote:
> cancel_tsync_works() iterates over works->works[0..size-1] and calls
> task_work_cancel() on each entry.  task_work_cancel() leads to
> task_work_pending(), which dereferences task->task_works.  If
> works->works[i]->task is NULL, this causes a null-ptr-deref:
>=20
> KASAN: null-ptr-deref in range [0x00000000000009a0-0x00000000000009a7]
> RIP: 0010:task_work_pending include/linux/task_work.h:26 [inline]
> RIP: 0010:task_work_cancel_match+0x86/0x250 kernel/task_work.c:124
> RSP: 0018:ffffc90003597ba0 EFLAGS: 00010202
> RAX: 0000000000000134 RBX: 0000000000000000 RCX: ffffc900106b1000
> RDX: 0000000000080000 RSI: ffffffff81d13236 RDI: 0000000000000000
> RBP: 1ffff920006b2f77 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000000000002 R11: 0000000000000000 R12: ffffffff81d12dd0
> R13: ffff88802c045100 R14: dffffc0000000000 R15: 00000000000009a0
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000110c3ea90c CR3: 0000000037f63000 CR4: 00000000003526f0
> DR0: 0000000000000003 DR1: 00000000000001f8 DR2: 000000000000008e
> DR3: 000000000000057a DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  task_work_cancel+0x23/0x30 kernel/task_work.c:187
>  cancel_tsync_works security/landlock/tsync.c:415 [inline]
>  landlock_restrict_sibling_threads+0xafe/0x1280 security/landlock/tsync.c=
:533
>  __do_sys_landlock_restrict_self+0x5c9/0x9e0 security/landlock/syscalls.c=
:574
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f859b39c629
> RSP: 002b:00007f85991b2028 EFLAGS: 00000246 ORIG_RAX: 00000000000001be
> RAX: ffffffffffffffda RBX: 00007f859b616270 RCX: 00007f859b39c629
> RDX: 0000000000000000 RSI: 000000000000000a RDI: 0000000000000003
> RBP: 00007f859b432b39 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f859b616308 R14: 00007f859b616270 R15: 00007ffcff084488
>=20
> The root cause is a race in schedule_task_work().  tsync_works_provide()
> increments works->size and stores the task reference in ctx->task *before=
*
> task_work_add() is called.  A thread can race to call do_exit() in the
> window between the PF_EXITING check and task_work_add(), causing
> task_work_add() to return -ESRCH.  The error path then drops the task
> reference and sets ctx->task =3D NULL, but works->size remains incremente=
d.
> A subsequent call to cancel_tsync_works() iterates up to the stale size
> and passes the NULL task pointer to task_work_cancel().
>=20
> Fix this by decrementing works->size in the task_work_add() error path,
> so the failed slot is rolled back and cancel_tsync_works() never iterates
> over it.  The slot is naturally reused in subsequent iterations since
> tsync_works_provide() always picks works->works[works->size].
>=20
> As a defensive measure, also add a WARN_ONCE() guard in cancel_tsync_work=
s()
> to catch any future NULL task pointer before dereferencing it.
>=20
> Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restr=
ict_self()")
> Reported-by: syzbot+911d99dc200feac03ea6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D911d99dc200feac03ea6
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  security/landlock/tsync.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index 0d2b9c646030..e6d742529484 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -381,14 +381,14 @@ static bool schedule_task_work(struct tsync_works *=
works,
>  		err =3D task_work_add(thread, &ctx->work, TWA_SIGNAL);
>  		if (err) {
>  			/*
> -			 * task_work_add() only fails if the task is about to exit.  We
> -			 * checked that earlier, but it can happen as a race.  Resume
> -			 * without setting an error, as the task is probably gone in the
> -			 * next loop iteration.  For consistency, remove the task from ctx
> -			 * so that it does not look like we handed it a task_work.
> +			 * task_work_add() only fails if the task is about to exit.
> +			 * We checked PF_EXITING earlier, but the thread can race to
> +			 * exit between that check and task_work_add().  Roll back the
> +			 * slot so cancel_tsync_works() never sees a NULL task pointer.
>  			 */
>  			put_task_struct(ctx->task);
>  			ctx->task =3D NULL;
> +			works->size--;
> =20
>  			atomic_dec(&shared_ctx->num_preparing);
>  			atomic_dec(&shared_ctx->num_unfinished);
> @@ -412,6 +412,11 @@ static void cancel_tsync_works(struct tsync_works *w=
orks,
>  	int i;
> =20
>  	for (i =3D 0; i < works->size; i++) {
> +		if (WARN_ONCE(!works->works[i]->task,
> +			      "landlock: unexpected NULL task in tsync slot %d\n",
> +			      i))
> +			continue;
> +
>  		if (!task_work_cancel(works->works[i]->task,
>  				      &works->works[i]->work))
>  			continue;
> --=20
> 2.43.0
>=20

Thanks for the patch!

This bug is already fixed on Micka=C3=ABl's "next" branch.
The code review has happened in
https://lore.kernel.org/all/20260217122341.2359582-1-mic@digikod.net/

=E2=80=94G=C3=BCnther
