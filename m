Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278CA31B131
	for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 20:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778789731; cv=pass; b=aVCOFSFQSUkWYviwUs2Ym/oerVUpGWo4BxlZ7kmHSumZHSOzySckSWoizEvukXdnI512oQqVaHzYalb6Q2VRwjnxzxaYA1LoZJMDYTZsGtkwwfKAuYM4bdLIp67R7UwDgAlo6tw5NvEH/xLJkNYLRPOR5sQNPfYRp9k4NmmmFd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778789731; c=relaxed/simple;
	bh=L23g/GV6s5dbwKzNwqZYuRfdnx5W42pO/aIZUxIvmnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gs5jHh8McRUAJMAkKtrs9vMx0h0KwYyG30hw92u0v9eys2wc9SO1ZRwFWTKktP+fBceatusu0oBLCa50kFrtm27pHKy6+CfZpRv+/ErkRleJlW80AkHTUQ0E31j2ketsVV7jqo7g5tXoSJFLR6TR0rxVeBIoYdQCCpSDLkyCJP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SStkBo0I; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SStkBo0I"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2baca4df358so51361245ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 13:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778789729; cv=none;
        d=google.com; s=arc-20240605;
        b=YDn9HFCHkkV2b2rCVh1w2Jenajk/Ozcpf27xxxxxN+BNKy+0KCeubUHhngd8UhtdHF
         +ycQvYTnGQpDWN74i8dOID2iaMNqSkABDj3nTg8j+MMiJkE92FcKb8mUYqgYlioHJHsV
         ycGw2dYxFsGauYq/4gQS+es/qDDgG0HrSblrNI6MjnFz1lsuq26RwdljTrkyE7XqKcTs
         lgK9XkrdVWEWHjsUAZfa2g+IrM6lJKKz6fX8QQoa3aUPGiEW5gUXPhpZ/ogn0Em6ZxsT
         U10eS0m4puqSutDEMzDRlwt8W6LM9l0hhl+XxBY4/dK9lFU0zjFzNQqxjDU3SQe7Ajd5
         M9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dSkJycESPksBK1TkswZjGhIZC6pa0KpxZLEtY/1MYi0=;
        fh=DQNEOSRO1ABSt8BT+s9V9Rt3n8fjlDnqRsGPoMGIwis=;
        b=fbKxDB9sMVRXLruYWPD+m27cmx1AytzusoJFdSJvMAPbRVJ4AbYAFtnua9DDIm5pFy
         QuiQXV9OKrBYjp0tYoAXKHF3xRvcHklKH+5HV8nmSnd70OegoLMOBZBuJQkNvV+dhZSb
         96zQ3+hj0rzrFQMtfEy/X4sIJ3zAFRY9nzqNLGEkVmQzUWFN59KdOhe0Z+z879h2u4yW
         i9mBjWAXqjypHtmiaFjNQFVxE5pCZ58pgzG3ERVUK8P9p8fSp9nPaIhFcKFnuk+ylrxE
         4lxSOhTuISuUPDowo5+SBsa8UsiHVhMFPq80+KCb/3rzOyUQ1GhBR0Gs0KtwT5vJ9iCh
         AJuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778789729; x=1779394529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSkJycESPksBK1TkswZjGhIZC6pa0KpxZLEtY/1MYi0=;
        b=SStkBo0IShj1FOW3eRP8bphCx31rwPomyT0tK1vnCXpmXw6GbWsLjbQEgsuTL4gScK
         Zc63iWvd8FUZnFbJgiBATeHv1WghGA6K0K3zXq/hXAZ1a3x+ZSJFla8HTcY+9Gi33Gbe
         yS01HZO6xnl9qE6yXWUyO/AMo7NeFEx2RdcsXemZN7yG3S8wJj4PpDZ674ai2m9NskSI
         0eh+s65GGN2XVjxHZzXKRmBpFLcNuE8gHuNVs+XfQ/f6TfoK1/Caf7zUaaLVp3c+lo4p
         4LS6fMy24yVMGLL00PTiNpzIFLBP24rkRShcLT1rBkkNcZAEKlmADhrtn3zisrPMTngl
         qGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778789729; x=1779394529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dSkJycESPksBK1TkswZjGhIZC6pa0KpxZLEtY/1MYi0=;
        b=CaMpOX7UkXpNQiBuHU7hjNvp2s+YQgWb/bmRdNn0ciW4RzWurthIOaEIVNs65oo5KH
         41zQmrHYnZz9f4wqigdAd7fvdOSUaOYM22nw0JtzyUFQdy2iX43DisUBVBKupt0AQpmP
         /6F/5d45zfxE+tBJ6tCptySqSYRgKJ2RdPtRvpO0qI9IlX2uhJX/pJD/qi9/T8djoFBD
         +cueulXbyUI4lBPm5SQoVy2lqH1AZSidx4ao50WZv9nVstzSBK1PBS+ublnw8AnjjF5z
         PkVT0nfeep/GLVs8ZyKc53OrDSgrOddMGAUv/X3sMdLE5iMxaPpLjOP/xs6bZ9mQujpU
         paaA==
X-Forwarded-Encrypted: i=1; AFNElJ+8YBgAX40pbWANwOkTZHFjvORPj13XFGyaCNkeI98O9WQ75nTKczsd+AEiILOWWiDDqojYAsHwoKoS8rsx1/Jw8Hab1cA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaWcJF3djQA2uLk3rNiy03KMwenVTy08eKlsawF6z7hmokFWx4
	syLbQ3Mo9ICxodbeLzjyQF8M4uhp/fZO+tUNBewTII2jpNMoNuRMkJI4sCoRC/Bqdz4cWlsG3bJ
	zEm3yh8QEwP9GXF5KluQFBIxw9BERVkMtyj/0kGOt
X-Gm-Gg: Acq92OE9p5fmTJZ1brWas3ScvWQuuQSPYyUsCn66X5PaNdNh61yZYA6pqPjQEjRFAaV
	kXmhqL2cMAicGNsKV2z6TKZsjgYHcvD+plyPGXpcuZNDrgmCHRv4IEcoKWxM5NJBmtkU1ruUYLo
	QXbz1VdhNOIi8B/AcFg5TrQGPnJnPtjNc+yXB3mDnBOK3+9W7yz7rWgPpqTUr3L4bwbozyeBBOH
	F2TRmc0X3yFLtqm0lnCzfWOiG6FBva/jmQbl2i6EIg5eKtBW8CIbj9pPKqRqto8aIQqR/aakLMq
	5RtD4cg=
X-Received: by 2002:a17:903:94e:b0:2b9:f59e:aca5 with SMTP id
 d9443c01a7336-2bd7e9e7777mr8938935ad.39.1778789727707; Thu, 14 May 2026
 13:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509213803.968464-1-atomlin@atomlin.com> <20260509213803.968464-4-atomlin@atomlin.com>
 <CAHC9VhQthq7y2akbQSdJwBEex1MQYWG49wcJK3b8gSQuQ_d1cQ@mail.gmail.com> <bscbywzzx4nmxzbuw2bkzltb7rrmgmzy5u4gqy5pfpmafcnlto@eznniiguusqb>
In-Reply-To: <bscbywzzx4nmxzbuw2bkzltb7rrmgmzy5u4gqy5pfpmafcnlto@eznniiguusqb>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 May 2026 16:15:15 -0400
X-Gm-Features: AVHnY4J6HtYDS9Lrpjl43i8SgHkaXzBYbs_PTjoO3Mw_C9TveMyo-g1mcK1Gb3Q
Message-ID: <CAHC9VhSWrJc=aE1Sg4xfv1ZMmh=JqZFLWGeG2SnzOFqXxcUbtQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] security: Expand task_setscheduler LSM hook to
 include CPU affinity mask
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: tsbogend@alpha.franken.de, jmorris@namei.org, serge@hallyn.com, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, stephen.smalley.work@gmail.com, 
	casey@schaufler-ca.com, longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, chenridong@huaweicloud.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, omosnace@redhat.com, kees@kernel.org, neelx@suse.com, 
	sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, 
	nick.lange@gmail.com, cgroups@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 3:49=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
> On Mon, May 11, 2026 at 04:28:09PM -0400, Paul Moore wrote:
> [ ... ]
> > > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> > > ---
> > >  arch/mips/kernel/mips-mt-fpaff.c | 30 +++++++++++++++++-------------
> > >  fs/proc/base.c                   |  2 +-
> > >  include/linux/lsm_hook_defs.h    |  3 ++-
> > >  include/linux/security.h         | 11 +++++++----
> > >  kernel/cgroup/cpuset.c           |  4 ++--
> > >  kernel/sched/syscalls.c          |  4 ++--
> > >  security/commoncap.c             |  7 +++++--
> > >  security/security.c              | 11 ++++++-----
> > >  security/selinux/hooks.c         |  3 ++-
> > >  security/smack/smack_lsm.c       | 11 +++++++++--
> > >  10 files changed, 53 insertions(+), 33 deletions(-)
> >
> > I haven't looked too closely at this patch yet, but based on a quick
> > glance, can you help me understand why it is included with the other
> > two patches in one patchset?  The other two patches look like stable
> > level kernel bug fixes, while this patch introduces functionality to
> > an existing LSM hook; one of these is not like the others :)
> >
> > Unless there is something critical that I'm missing here, I would
> > suggest splitting this patch out from the other two bugfixes for
> > separate handling.  If there is a patch dependency issue you can
> > always mention that in the cover letter.
>
> Hi Paul,
>
> Thank you for taking the time to have a look.
>
> You raise a perfectly valid point.
>
> Please note, the cgroup-related BUG fix will be dropped from the next
> iteration of this series. As per Waiman Long (on Cc), a solution for the
> BUG was already proposed here [1].

That's good news.  I saw some discussion on that but didn't follow it
very closely.

> However, I suspect the MIPS-related patch will need to remain coupled wit=
h
> this feature patch. Because the first patch fundamentally alters the
> signature of the security_task_setscheduler() hook, the MIPS FPU affinity
> code must be updated concurrently to accommodate the new parameter.

I generally dislike when bug fixes depend on new functionality; it's
backwards in my opinion.  I would much rather see the MIPS bug fix
patch submitted as a standalone patch and then have the LSM hook
modification patch come separately, perhaps with a note that it
depends on the bug fix patch.

--=20
paul-moore.com
