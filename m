Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D2246EF94
	for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2026 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787592543; cv=pass; b=gMPn8/3TfwvNMeXcMzOpLBslPTKn1QciDC75QZiUc+zQsPOrQUNZA9y4byZ2yGJ8B8A986U7Zg7n0WkMqQjm8KtCJn2sIkBgiKpDyC/Oob50ngV8tjaLrF5qER6eAP9OSI2vreuB+Skip9WabU0mBOzo86+qhBx96v+vf1IeCcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787592543; c=relaxed/simple;
	bh=cMo9Wf0m8H2wPLLbHbMj71h5nTiMNFrhZZOi0/3IlBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7kxbrGq3e5kTk4zKwingNEzwMM9+umJOUxrDok2I6jWY8SEE5D3SP/rFERt/ix+0Xq6pByTvaiTy5zpYdMERFCL+FSnlBmHalj49BuuoRLjbsjlfaQHsSWinnCcLji2qp3VL0gcMcK75r0v7oAMzmxCnr/WV2VDhHCAOa6zRXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sS2fsQA5; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sS2fsQA5"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d3b445a84fso9075ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2026 10:29:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787592541; cv=none;
        d=google.com; s=arc-20260327;
        b=iaF+ncf3bSIqCZFPt823PR+3ZzYbFcBS2/UmmLVUzWd19C7dXOHAETPjVfILpLfhWX
         pbkhhZFMRiOsHSEwuugFim23gnhBUITJMAamobSSeRJ0hOxZtonsgNroOz7MgrLGAJ7H
         YodHDv3jJPbo42vth6RRcfHRhnQG1Nb6bdZPd8Jb283yZ/hcc3FmGbh0C84ZhsXBV4Dy
         fJ86OTwehMl0wZxceeaIonikcjoQS0sMrLFm3ID3brIwdew/Hrv3ULwGr1lUE12vOcpE
         mJZpumcHWr1m2CM1y2Rre2ydcGFAl7ShG5xXPmeoXIuKjC047USIu7k3Fgg5FENn0CTs
         7gxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UfDdC/RWyrUaNw5va538e4PXp9Bi22FQE/a0vb8LJJg=;
        fh=uDuvD7KSnOyTNJWr6jag1MczQKofDyT1ExODwOqoLSs=;
        b=psJbmV6SOEAs/H4Lli7hBDdABcOa1vjx9tlnRbyPQ5wLv3lyV1tUH0rM6aV7S0BnyE
         CmavlIJLNT/4SLYzvCLKPn1FexZlfDQYPEneS4yYZraBT6oyTZPNqS0SabKMyealaEcT
         mo8B9XQLiHMREnali284dmgdrHoS1UvsLyjVbudR5bBXrv4qexZ9wKWsrXwP1wIdu00D
         DcRb3S0asx+pGITyN36/KQ73dXZ7/mbH3ytlkaff8pHBwUaQaTwE4PfEb320YGSs1dqW
         TgM741LJzwlazo3OhBEOfulr8HtYtlthIH+ICNCwEzj5rPnxTeb2tRieCGiOu7qtFzo2
         TI6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787592541; x=1788197341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UfDdC/RWyrUaNw5va538e4PXp9Bi22FQE/a0vb8LJJg=;
        b=sS2fsQA54rfiLXyMZPoRIjfKpEjMYPUH1qtECP6WckTpEPjeLDV7tpfvk/j4q30m59
         vG7xPB/Eyt9RlqmAUHVUeQ8r9oi8M7VXSvHbB6nT6lySCx1PUO95Yo7ZGC5JUxHu6mH9
         lS0Oz1iQPPasPm1UDFqXRGQconNgVmT8wnFv5IvdZYSmoCUrPXPMMqjZZfeNMgonS0W7
         8p0jT1KpA0guHh6OXN0Zv+0pc2sfXSIZHkt20ycUxpkrW2m4ex3a21FLDvLnRGaqBSe+
         Mt9jofl+7qsVhkiGxc7jCf7eJTFOseFtTmk5/+14v+AbG4reuiGPkhBEBTmXbRJBkhke
         RfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787592541; x=1788197341;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UfDdC/RWyrUaNw5va538e4PXp9Bi22FQE/a0vb8LJJg=;
        b=oYxixeKOTwnraOINuL4c2szhmtKLPR16isPAQCgyDSuEvhq19ziqcoQyjyyXXl7tOU
         TSYhm4neRayno4H0+X0pZprq9shtvMn1jumwkShxP2RPChXwQTEWz3rsYPDXK4Z2ky8u
         eHl1y+Utoe6y3klVAciyWGmwAMEyObFJB6WvXnzlNXyxenwHOriURheQJjdhDemabTBP
         8FK5iMcQrF7d/1PRdnth+3aQB23iv/KQcibF5LCWIonvm0rNMwLTJsReKg9eB7yQrMQO
         XZYKYkbr2HOoW5SdhPHYE7wqmr8blqAL+s4N51ejgLrmjkNcR4GfuvDPp1K9MpSOmB4a
         9Q5A==
X-Forwarded-Encrypted: i=1; AHgh+RoFDvkhGT83xN/IU8/cCcq3uSmGsVzcVBW0j3B7LdcAIB+d7UGs2XWtDKkKbVB6pNzo9dJYY9nVdtpoAFVD1qa/Fk1vsYQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kBLDef4L1/Dn2jvfi6j8mT8xVur90J6uZrJQ631dvtti5Rigpb
	Mei4+6jTK5VE+KPLQmIMc/9AswgQdocCS7h8zF8OfSLyL7NlzPbuzflTDGIdnSL7Sxjs76UaunF
	4XRuc2/a09Hz6AdEPYsIlv6Tk8qxoLNHu78eaQ12t
X-Gm-Gg: AR+sD12n7w1qSMP1sz9y+fEPakrthy7GzAmnrfAQ6/csi1Quwi9JzoTIIxs6sdNelpO
	OXAN+hrS7UwY+JrslyC3OF0eWlRyHKqyNXowEZ93JHl0+pSSSIAKc9zwQkvpsg5aWBv2pgbnGSh
	mmPK5ZLPBFVeAsA5HscHtGJO7s2MfA3GkVD5xhYt0jHuqGWrKmmM+sXHNJehFlLxjMmhiW+P/Ob
	PaeaSzYylnU3FZHaPMVPHvd8TvW1SZGkBAVtnfTa9EfA78suH/CPnBBCTMfqObgtY72B9X9TW75
	U1s83JTTN5eLGXntNFQp1XgcFVt0ZrVCHb9GUIdJd8wkRR13SQBEf2udTGx38P41IxOAAiQzgcn
	YRcuDMxhAFd1renCPxPOkCStV5mgg1q4=
X-Received: by 2002:a17:903:1acd:b0:2c6:a078:bfb7 with SMTP id
 d9443c01a7336-2d673b9b705mr10399295ad.7.1787592540643; Mon, 24 Aug 2026
 10:29:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <aoifijlkCRzeO4bj@gremlin>
In-Reply-To: <aoifijlkCRzeO4bj@gremlin>
From: Jann Horn <jannh@google.com>
Date: Mon, 24 Aug 2026 19:28:24 +0200
X-Gm-Features: AcwNN1Vx1mdrG-hGZfBBtnczl0hD68Qs5NDgSLNpjnU_6pjoKXhzXOErcbktMiU
Message-ID: <CAG48ez1HA30JUi-R=6KydkQy2P3_ineM1ZzRMQC6QP1UAwjewg@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 9:00=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
> On Tue, Aug 18, 2026 at 09:51:06PM +0200, Jann Horn wrote:
> > If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently hav=
e no
> > good opportunity to block a process from overwriting read-only code in =
its
> > own address space through FOLL_FORCE writes via /proc/self/mem.
> > The security_ptrace_access_check() LSM hook is bypassed when a process
> > opens /proc/self/mem because this is considered "introspection".
> >
> > This causes a hole in SELinux EXECMEM enforcement, which tries to ensur=
e
> > that a process cannot create executable anonymous pages.
> >
> > PROC_MEM_FORCE_PTRACE prevents that and ensures that such FOLL_FORCE
> > accesses are only possible when the LSM allows ptrace() attachment; but=
 it
> > is unclear how quickly PROC_MEM_FORCE_PTRACE can be deployed in
> > environments running lots of third-party code, such as Android.
> >
> > So, introduce a new LSM hook that can forbid FOLL_FORCE specifically fo=
r
> > such "introspective" accesses.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>

> > @@ -886,6 +890,8 @@ static bool proc_mem_foll_force(struct file *file, =
struct mm_struct *mm)
> >               }
> >               return ptrace_active;
> >       default:
> > +             if (priv->introspection)
> > +                     return security_introspect_mem_foll_force(file->f=
_cred) =3D=3D 0;
>
> As per 3/3 I wonder if you need an additional parameter to cover the fd -=
> some
> other process case?
>
> Like:
>         if (priv->owned_by_owner) {
>                 const bool is_remote =3D current->mm !=3D priv->mm;
>
>                 return !security_fd_from_owner_mem_foll_force(file->f_cre=
d,
>                                 is_remote);
>         }
>
> (I'm not sure how LSM hooks are supposed to look :)

We could do that if we wanted to treat cases differently based on the
identity of the writer, but I think in general that's not a good idea.

In general, if you send an FD to some daemon, and the daemon writes
into the FD, this should not cause access control decisions based on
the identity of the daemon, because it can cause "confused deputy"
bugs - the daemon might think it is just writing log output into a
normal file, or something like that.

> > diff --git a/security/security.c b/security/security.c
> > index 71aea8fdf014..d0f790a534eb 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -595,6 +595,21 @@ int security_ptrace_traceme(struct task_struct *pa=
rent)
> >       return call_int_hook(ptrace_traceme, parent);
> >  }
> >
> > +/**
> > + * security_introspect_mem_foll_force() - Check if introspective FOLL_=
FORCE is allowed
> > + * @subject: credentials of the process accessing its own memory
> > + *
> > + * Check if FOLL_FORCE is allowed for a process accessing its own memo=
ry, which
> > + * bypasses the security_ptrace_access_check() hook.
>
> This should be updated to also explicitly mention the fd case. As surely =
in that
> case this is not true? Unless I'm missing something.

Yeah, I'll clarify this comment.
