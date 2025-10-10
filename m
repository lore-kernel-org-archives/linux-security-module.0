Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E032FE571
	for <linux-security-module@vger.kernel.org>; Fri, 10 Oct 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760125213; cv=none; b=lIqd3P+8zvgAtRxzdUvAuF+rpvK3XbiVl/W3HsNga0ncMVnMLOuq1cifgScpYiNNTp2/se7i/SoM6ordgvdVN2iSpfHSJINXlacF0WkKbaaz2Upu4QHRkAwBwAL8mLkPg5ETUfv1/EQOLRQwasdfc4Tn9d1GZOqN0bkTIxl99VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760125213; c=relaxed/simple;
	bh=hrUSn+ceAo+GDbSa1VXTf4EuSMfDG3/UBPjYHHpRlXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRKeVFLCpBFsICYo4EUPQKYejIdJhMBeABGRb5nphvNR3ZmX4Qi8G7or5We7XxAOhybVjVHx0nx8DNAfNP6VzLAY+pKxnTmgQafwQIZBxGUewAV2m6mMd+nH32CZwt6BbVD4xfdexJEOOGgNYTy6+yMIHD//RmnXQGQfPQplaVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fvH+mQlM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fvH+mQlM"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-269af38418aso29833815ad.1
        for <linux-security-module@vger.kernel.org>; Fri, 10 Oct 2025 12:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760125210; x=1760730010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1spZuaYn2ibXuyFhDGwY3YmGssLxNzwFenv1C1bnCyw=;
        b=fvH+mQlMyodIhAHG0OiGgWTJreP4jDvCHhbQtIzqdrV/uRidTE3H4b7LH005Ce6aLo
         PgWbPj/ejx04/0HcU7cEuwMJ1qOGNK8psjTjdoQ2gKdQlJGFd7hQlCXRHKvGrn1OBING
         lE/qDIr/dqzBifMqcXS48eAfaU2DABLcYCoh8vmVjQSpOt9+mdZYTGthXuuwpKvFNXIu
         D13Q72ge/T0BKNhV6wv2+2RcBg0PGawDf/y2ZxiCXWpDqGRm0gHS/EplPE6y09ouGntE
         Kx5ziGAONnxZeKV56F6dm6cZtXydwjA3ET0f+pP+3DdW6BZs0MrfCEa9ejtPzvnCPcZl
         LmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760125210; x=1760730010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1spZuaYn2ibXuyFhDGwY3YmGssLxNzwFenv1C1bnCyw=;
        b=cqefVdP38JbetkNN4tLjRdGZFTo6KnKbLl0wWVf9qXN43aLpNxa/rjANNs3y3lWGKm
         kr1rKaO4+QXXPQ90Y6tKHirILAC81J7cYoDsbrXx365KGMJzfGSAwUjXTPSJWY+z83GW
         FHHjCtf7hQpzDMmIx+tbZAyAD0vH/S6iHtYbGdhPlKt7yttS3X/zILHrCmOpDJ08QFw3
         uprUFu8cIE2Uvxx1YjqsLgLsHsrzlFKaaBKOFMDq+D4iLmQZ6aL/v15Vc9kJY1OCMIsS
         fbuLDRspU46a9qrHDGq/doH5in+UBeuTmZt44s+mW1pcITP/i+2jwciQe4Iadz+ooskJ
         mIbA==
X-Forwarded-Encrypted: i=1; AJvYcCXV85tUP82a1swR1W7yytyGRpKlJlkNOPOFLqO8icsVkhttRB3jcGBlZNxSOFsJo7YxS64yG3qTpvWjo0dqejZh6O3BlEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1SzmqSiXzBIK1c1athOegePoJapqLqJeR+/JdF6s8PTpEK2Oi
	y7INayBIUx2e9v9kyWSREzM58iMIvyblruYV6MaxKZI2SJsKDZHpm8sthSaoXckHeoFkuB8xaLr
	3NGvgNDVjKHs5lWirokpVrzCf1RjLtpPU70cgNr5v
X-Gm-Gg: ASbGncvjS8gmaPxlw3yxtv5Nndk1uwv8Jg38b4ZkyNnMYYx7RuSgPre7+C7xRjwNrB2
	B/9jqAxcnkza0E55zpE0FYWcocOt6xQwFkoZ6ttiBL37hXnE6sSwoBK4LcM0w3Rp1xjkHUiAg5u
	tkO6TkVUN22JvDP7rJ2341dWINCvoNk61RWqIlRhVSbdHFYjIHjuuhaya9oqA2uw/EvoXhxj8Yd
	qTZGWyd5YTF6A6X2q99yFF2Uxv5kQCtb07A
X-Google-Smtp-Source: AGHT+IH1v4yTYh9hFY+GZYHVajE4mnFPafvC6wr8o3AHmTWAx1ZS9PvQ3QIG9cYTfrwrKhnmpqBf4NbUq72+A7lGSng=
X-Received: by 2002:a17:903:198b:b0:280:fe18:847b with SMTP id
 d9443c01a7336-290273ef0c1mr155175175ad.33.1760125210321; Fri, 10 Oct 2025
 12:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
 <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
 <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
 <CAHC9VhR2Ab8Rw8RBm9je9-Ss++wufstxh4fB3zrZXnBoZpSi_Q@mail.gmail.com>
 <CACYkzJ7u_wRyknFjhkzRxgpt29znoTWzz+ZMwmYEE-msc2GSUw@mail.gmail.com>
 <CAHC9VhSDkwGgPfrBUh7EgBKEJj_JjnY68c0YAmuuLT_i--GskQ@mail.gmail.com>
 <CACYkzJ4mJ6eJBzTLgbPG9A6i_dN2e0B=1WNp6XkAr-WmaEyzkA@mail.gmail.com>
 <CAHC9VhRyG9ooMz6wVA17WKA9xkDy=UEPVkD4zOJf5mqrANMR9g@mail.gmail.com>
 <CAADnVQLfyh=qby02AFe+MfJYr2sPExEU0YGCLV9jJk=cLoZoaA@mail.gmail.com> <88703f00d5b7a779728451008626efa45e42db3d.camel@HansenPartnership.com>
In-Reply-To: <88703f00d5b7a779728451008626efa45e42db3d.camel@HansenPartnership.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Oct 2025 15:39:58 -0400
X-Gm-Features: AS18NWDiHVbVvupnRrZkUxOiLJEK77lzoTL3P5996ZGup2QQARPuOxF1njKIzL8
Message-ID: <CAHC9VhTY=K6oQPgAHuj3rRm2+9sBwLvDjdZtM+cUfSeuiW8jMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, wufan@linux.microsoft.com, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 11:53=E2=80=AFAM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Thu, 2025-10-09 at 18:00 -0700, Alexei Starovoitov wrote:
> [...]
> > James's concern is valid though:
> >
> > > However, the rub for LSM is that the verification of the program
> > > map by the loader happens *after* the security_bpf_prog_load() hook
> > > has been called.
> >
> > I understand the discomfort, but that's what the kernel module
> > loading process is doing as well, so you should be concerned with
> > both. Since both are doing pretty much the same work.
>
> OK, so let me push on this one point because I don't agree with what
> you say here.  The way kernel modules and eBPF load is not equivalent.
> The kernel module signatures go over a relocateable elf binary which is
> subsequently relocated after signature verification in the kernel by
> the ELF loader.  You can regard the ELF loader as being equivalent to
> the eBPF loader in terms of function, absolutely.  However for security
> purposes the ELF loader is a trusted part of the kernel security
> envelope and its integrity is part of the kernel integrity and we have
> a this single trusted loader for every module.  In security terms
> verification of the ELF object signature is sufficient to guarantee
> integrity of the module because the integrity of the ELF loader is
> already checked.
>
> The eBPF loader, by contrast, because it contains all the relocations,
> is different for every eBPF light skeleton.  This means it's not a
> trusted part of the kernel and has to be integrity checked as well.
> Thus for eBPF, the integrity check must be over both the loader and the
> program; integrity checking is not complete until the integrity of both
> has been verified.  If you sign only the loader and embed the hash  of
> the program into the loader that is a different way of doing things,
> but the integrity check is not complete until the loader does the hash
> verification which, as has been stated many times before, is *after*
> the load LSM hook has run.
>
> There are two potential solutions to this: complete the integrity check
> before running the load hook (Blaise's patch) or add a LSM hook to
> collect the integrity information from the run of the loader.  Neither
> of these is present in the scheme you put upstream.

As a bit of background for those who weren't following the related
threads earlier this year, the idea of an additional hook was
discussed this spring and it was rejected by Alexei.

https://lore.kernel.org/linux-security-module/CAADnVQ+wE5cGhy6tgmWgUwkNutue=
Esrhh6UR8N2fzrZjt-vb4g@mail.gmail.com/

--=20
paul-moore.com
