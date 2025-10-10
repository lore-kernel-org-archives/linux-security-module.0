Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765672367D7
	for <linux-security-module@vger.kernel.org>; Fri, 10 Oct 2025 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760137593; cv=none; b=fSgEUBTavTlittQfhvhohT/0ss7l9ZU5zV/1YvZDnuB1pzGpNve07gv2SXd1WSVAR7WvK/LLSIDKHOe4XSx0L+zWMjXFRVQI2Hjn8/N+PrmBIDdJO05fXRXZNJrakK7fV10d6h3j1Dkp5+dbnjzgrDgCpiIzsXpyyhZ+pV0FhNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760137593; c=relaxed/simple;
	bh=hCloG0Y93a0M9tkJ3ZDB55IPaaeolLL8R7dD98P47qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/or+ARK+wvPZ1Qt38GgmvFekU7/HbBJDwkXCSiAQ9lWMvnoOGuEp74lKumU9s8IGeaGcPev6GbnpNlEkvzqbJnal2nGf4v+22gk176FAEi8DAitDPTXrMKsS+vSrLGy/vtV12jx280bwT0wJ0ewmmn11ZfQsoj5t1dReuSgO8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbmz8voW; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbmz8voW"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-41174604d88so1164740f8f.2
        for <linux-security-module@vger.kernel.org>; Fri, 10 Oct 2025 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760137590; x=1760742390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jyuZL+/MDOZjAb6IRfhgTHKVHN22swRIR7driYUFLs=;
        b=bbmz8voWp3XzjD5iljvDEPwF+PMsj1L1Szbhi4rom6r2v9ozDOhbKFpATyjWOrVMfH
         B66w7GVI+Ntcb28xUBUQ/AGoPdr92sudp+CxHyLZGXUApYnzOULKD6eayp0oBvrksaZt
         sb7PODwXMgjyFDNWzDiEtON9xeVhyM+N9A3UA5yGQzz/gXedNO9hipUGlxEVgpeO5xyU
         t0YIdUE/6OJN22oAI0DlcW8ejrzyH307OSxAFTl+J1K7j99OPdN7nQGy0QL7WYtrXi2s
         zZkYgHocr++twKR3PUvLrexDdovcA5T9V/SPTdY3B4K/zSoKY1R0TlPOf8IJNIq60KD+
         fACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760137590; x=1760742390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jyuZL+/MDOZjAb6IRfhgTHKVHN22swRIR7driYUFLs=;
        b=ePn9JLcwSJOTIiCn0smVx6MN4/bIUeiyRqdN3qrFcjzt+1I5WD158O0PRwcLsNqmCr
         cA8hC3T2suFLD3uVrgBX+T5tGT41p4WtkZrjdEt+MXV9nQLnncv6WvEr+07yN/ZCH5Ip
         Tt56yhSoKlRIYJvWGgPo2fM0C5xdVh7gPuHk7PqfoGDc2FmxH4x84u5l+JwhxxU+VAG/
         Or+6/0ndjFAOmJAnLbxteMi57I1BRAQ7nbnvsf1aYrQ48B4WUjQpy+eW/9Yzc/I2OxRr
         LNz+Byvdp30XgHe0UHRbkdChTqx0cmPwR66Hg/635DTRJ1BtgrhEAt72Gwbku4vXu5gN
         vVCA==
X-Forwarded-Encrypted: i=1; AJvYcCWwMtIlvZOeyvQUFdwjiCTxf+51gwUcpUaRpnM9LmT9VGbk9lT4mj3089eHKbvnb065LkMVDK+MVDjcsHPPm50hp81+XoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc3VLEtI1qDpmy4qiaEOLNHX4E1Yv74SWL+dK49G72V10wKlXp
	w123tDEu8njGqvMkySkk9CJUzUWVDzSub8NR95VMqtz/Cj1zyz7nsb57HDwjFv76lAb/oPKfgfO
	i9BSw9BONGCaq9+/IcQiVMdAgQeYFHUA=
X-Gm-Gg: ASbGncuMkKof+g42ABmQ/jn6ml1fEEo6PErr+YEYh+K+12+Ls9ImnbGraQ1gDkIOnaa
	sUhrNaX9B0CuPGn9l5zDmuxXyvX4tAn14mXMds+4QJxEAWId1EOhku60uiCUU0+68p0KjXKgk/Y
	67wguQB0uUdwrVkpZw3iomYhf/fJtaxley2dIoDLnc3vdglG3e9fK82KPoKoFP6wNSeAaomSJ3S
	Mukp3VHOaXVByPthhTT96yrYEMAyuZWcaYH/YxZzsJqQm0LS7nJD8eaoNvfSVh6iQE529E6xrb+
	uLd3
X-Google-Smtp-Source: AGHT+IFOyAwQQsRvhlctebtwsHlWP0aszVMJ1pSOfGIMa+JIUTffYCFVVZaO9CiunaGlcSGKBfr4a2TCh0qC9gaN/sw=
X-Received: by 2002:a05:6000:4308:b0:3e7:ff32:1ab with SMTP id
 ffacd0b85a97d-4266e8dd2bcmr8103640f8f.50.1760137589493; Fri, 10 Oct 2025
 16:06:29 -0700 (PDT)
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
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 10 Oct 2025 16:06:18 -0700
X-Gm-Features: AS18NWCINWZW_B_u9VdJ_nUTVc2tFIhkn7DWZ4gOvpV35oDwWvRLL4ekSbSipYU
Message-ID: <CAADnVQKdsF5_9Vb_J+z27y5Of3P6J3gPNZ=hXKFi=APm6AHX3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Paul Moore <paul@paul-moore.com>, Alexei Starovoitov <ast@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, wufan@linux.microsoft.com, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 8:53=E2=80=AFAM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
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

"integrity of ELF loader" is _not_ checked. It's part of the kernel
and you trust that the kernel is valid, because you trust the
build tools that compiled that kernel.
The kmod signature only covers the contents of the kmod.
Now, kmods are typically targeted one specific kernel version
compiled with a specific config, but some folks do load the same
kmod on different kernels. So by checking integrity of kmod only
you're skipping on the loader. If symbols are not versioned
and crc checked bad things can happen (obviously no one should
be doing that), but signature doesn't protect against that.
Compare that with the bpf signature. The whole package is signed.
The loader and what it is loading with one signature.
I argue that this is a more secure approach than kmod signatures.

Think of it as a self-extracting zip archive.
The whole .zip is covered by one signature. Inside it has the code
to self extract plus all the files inside.
The extracting code is a loader prog. Which is a normal bpf
prog that is subject to the same verification rules.
The files are other bpf progs that are also subject to the verification.

> The eBPF loader, by contrast, because it contains all the relocations,
> is different for every eBPF light skeleton.  This means it's not a
> trusted part of the kernel and has to be integrity checked as well.

...and the existing mechanism already does that.

> Thus for eBPF, the integrity check must be over both the loader and the
> program; integrity checking is not complete until the integrity of both
> has been verified.

The signature covers all components: loader, the map that assists
the loading and all progs and maps that are encoded inside that
loader/map tuple.

> If you sign only the loader and embed the hash  of
> the program into the loader that is a different way of doing things,

That's simply not true.
Please read the current code more carefully. There is cover letter
that describes what's happening. There are no hashes of programs.

> There are two potential solutions to this: complete the integrity check
> before running the load hook (Blaise's patch)

That's not what it's doing! Read his patch. It's adding pointless
signature to the loader/map tuple. It does nothing to progs, maps,
relocations that will be created at the end when loader completes.

You need to realize that single loader plus single map is
an implementation choice of tools/lib/bpf/gen_loader.c.
It can do the same job with a single prog and no additional map.
Hence any kinda hard coded extra map signature makes no sense.
We're not going to burden the kernel with one specific implementation
detail of gen_loader.
Tomorrow we might change the gen_loader to use a triple:
prog+map+btf or any other form.
The existing approach allows all that extensibility and freedom
to change the gen_loader.

> or add a LSM hook to
> collect the integrity information from the run of the loader.  Neither
> of these is present in the scheme you put upstream.

Neither is in cards as was explained countless times.
