Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6EE2376E4
	for <linux-security-module@vger.kernel.org>; Tue, 21 Oct 2025 01:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761009943; cv=none; b=j8tBRW9UhFzLC8C+jrZVfIdodJ4o60XfwstFub87HiBiHX+di1Gc/1+DU5DjCFalxw8gyfIBL5LO74BIMS3VtkIT+n53SbsjJzIVK7D0jL88nJHOl4FfECJErJC2Y3OrKHM5zIBmiE7GaLJjPkml87HoN+XA/0kmLTxWQGX36us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761009943; c=relaxed/simple;
	bh=obZyh28T1kEuHwDo1qQ0dE5xkjKP5NGUzZ7YcPZwn7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VN02sgIdhXOqqPeS7VKeT9+AYZiG51MnuRkYFZVVGkmKW70m8+5S8Mj5vBqNsBW6RY6OZ/MPgZlaCDSm7KXN9Z3KjpM8fXh6c6sTH196b1Z8kQgOfPo4fDScMa6LBGtFb5ltiOKjAfYm80QXa26pTiR4uWYVK3a1n1u3e7sSxIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q46iPFSA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q46iPFSA"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46fcf9f63b6so27061675e9.2
        for <linux-security-module@vger.kernel.org>; Mon, 20 Oct 2025 18:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761009940; x=1761614740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cl1wUBBnyil8OGcGyfseqMas2ZRtqJsCAvfwe+Y9okY=;
        b=Q46iPFSAa6RKI/Txq5joZZ39gH8OX86lmV3Psx9W9gtKuBF+3E5Vyr6uCS3/wb2bVk
         MHkzWM/Xs4MotlKCEccpPEZ40faAkTh2/j9YFazCsOAsatx+y+DQOFdiu7bw3mNxYDDO
         3deYh0lg4j25B5zafPXYy6DtBxc0rfAgVMGBaoKSkPKxFUhIxKq02I1cAVmSmjSLZXFC
         ULaFu45cMwTf/d57G6ziYnNWHeXL7EsL/VBerrhXyTseBfDAWJtWUaocbhw5/qSkTVeN
         kDbJEGHbWCW1TtT1PVTGASzeB9E3Y+FCgUPI3+J+VHAEXVmDvujWIT0X++UcU3zlov7P
         gaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761009940; x=1761614740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cl1wUBBnyil8OGcGyfseqMas2ZRtqJsCAvfwe+Y9okY=;
        b=I8XGYHzAwWCdIjVEPZJUQ8YttsxwVIVeDLYWhA7hmxnGxNVg0Oj+GYSN6fQtj2CIsS
         /RsFIAfLC7422rq7vT1YqlKEBhLqtgmbqYWUkCG6p8aF/Ku2EY8dtEBT4jEzkWD7EwON
         PGwuHwBBmSKNVAG1CeE3zF1XVX7DI19IlACEofgn8HHUCKLIX6wMvYeeoiUOAgf0j1Pw
         2f3dNP7u2SbPDU1PY2fiBTGi/Dh5HUd1TNc4bECbCpJl+YFsuq/41lUGRLrh8lz2FS61
         npJWIkT/5SoR/SLPB+MCWKhpqWiALPvKnAuWzASIJpqaMU2xXOcvKYlr/UBq7fdwbhch
         8uzw==
X-Forwarded-Encrypted: i=1; AJvYcCWfZBz7w/Ohbuw/SHgf9z2GxJli0jKoyyoq68W2/UNNj5weG50P01nzB5WSk8xRqhUlhiSzzp4J3VjCHzeU1K+QI9RfP2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5qC+UH+G8DvIUnr4F9owVqswJY0Rih+jPWmNC/dLuqy/Gj4Rg
	e4WgGtJNx+BjfkiyLNuLE0D2TaDMW9CsUcQKKV5+zljGJvqGeIFlMRXvreHetKQMF2TJBkEBsAI
	khVcguhPYzShkyLBfZ+ynN5tqIt9FDs8=
X-Gm-Gg: ASbGncvJ23Ipye+qcHVv51zUv2PDOpntRUTpDps/KXagErb9uNw0C9GvoOGVzdWS3FV
	/1do1E8cUMZn5W8svWauffG4vSU+8XjjVSpaZGbdwBzalqS0Nr9Xe4FVQEu1hoZ2V7Lwej84ilx
	u5y7WFcas1QTl6s0FUa4jCGE1nU/Uzr8QrwBalu0ggIrXsVI+swPfFYGjVxnhImlksIMsgw4jnT
	3Z4vxmc9zBxvnToGg/xjGOv/XyAijbSzQx5TcsnlHFcBjHrGEvhEECcLV1FOYGsbZ1lLsyszpbi
	jkChi31gn3+Hjs4ZCA9o/ZIytPmO
X-Google-Smtp-Source: AGHT+IHgK2FoGg5yjOgPOTwlQsZPYZy4LmDiwcxyvZ+9MrvnNNmTeOVsYL3QOG4+KYpIwcdosomX5uXzCCUNgI10/UY=
X-Received: by 2002:a05:600c:a14:b0:471:15bb:ad7b with SMTP id
 5b1f17b1804b1-4711786d60fmr123133375e9.6.1761009939823; Mon, 20 Oct 2025
 18:25:39 -0700 (PDT)
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
 <CAADnVQLfyh=qby02AFe+MfJYr2sPExEU0YGCLV9jJk=cLoZoaA@mail.gmail.com>
 <88703f00d5b7a779728451008626efa45e42db3d.camel@HansenPartnership.com>
 <CAADnVQKdsF5_9Vb_J+z27y5Of3P6J3gPNZ=hXKFi=APm6AHX3w@mail.gmail.com>
 <42bc677e031ed3df4f379cd3d6c9b3e1e8fadd87.camel@HansenPartnership.com>
 <CAADnVQ+M+_zLaqmd6As0z95A5BwGR8n8oFto-X-i4BgMvuhrXQ@mail.gmail.com>
 <fe538d3d723b161ee5354bb2de8e3a2ac7cf8255.camel@HansenPartnership.com>
 <CAHC9VhSU0UCHW9ApHsVQLX9ar6jTEfAW4b4bBi5-fbbsOaashg@mail.gmail.com>
 <CAHC9VhTvxgufmxHZFBd023xgkOyp9Cmq-hA-Gv8sJF1xYQBFSA@mail.gmail.com>
 <CAADnVQJw_B-T6=TauUdyMLOxcfMDZ1hdHUFVnk59NmeWDBnEtw@mail.gmail.com>
 <CAHC9VhSRiZacAy=JTKgWnBDbycey37JRVC61373HERTEUFmxEA@mail.gmail.com>
 <CAADnVQLRtfPrH6sffaPVyFP4Aib+e7uVVWLi7bb79d9TrHjHpQ@mail.gmail.com> <bc823ddbaf63e0e177eb46d1cc15076e4e2e689d.camel@HansenPartnership.com>
In-Reply-To: <bc823ddbaf63e0e177eb46d1cc15076e4e2e689d.camel@HansenPartnership.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 Oct 2025 18:25:28 -0700
X-Gm-Features: AS18NWCk2N1IxU0y74xFIpK152vl2L2z7WvLcnP7uEcMg1aGBQhHImKvrC19Ai8
Message-ID: <CAADnVQKcOS8iu0Nq5aYg+Lg_EAO8fFde0H3w8t0m_SXUy4iKAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Paul Moore <paul@paul-moore.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, wufan@linux.microsoft.com, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 4:13=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Fri, 2025-10-17 at 11:03 -0700, Alexei Starovoitov wrote:
> > On Thu, Oct 16, 2025 at 6:36=E2=80=AFPM Paul Moore <paul@paul-moore.com=
>
> > wrote:
> > >
> > > On Thu, Oct 16, 2025 at 6:01=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > > On Thu, Oct 16, 2025 at 1:51=E2=80=AFPM Paul Moore <paul@paul-moore=
.com>
> > > > wrote:
> > > > > On Sun, Oct 12, 2025 at 10:12=E2=80=AFPM Paul Moore
> > > > > <paul@paul-moore.com> wrote:
> > > > > > On Sat, Oct 11, 2025 at 1:09=E2=80=AFPM James Bottomley
> > > > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > > > > On Sat, 2025-10-11 at 09:31 -0700, Alexei Starovoitov
> > > > > > > wrote:
> > > > > > > > On Sat, Oct 11, 2025 at 7:52=E2=80=AFAM James Bottomley
> > > > > > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > > > > > >
> > > > > > > > > It doesn't need to, once we check both the loader and
> > > > > > > > > the map, the integrity is verified and the loader can
> > > > > > > > > be trusted to run and relocate the map into the bpf
> > > > > > > > > program
> > > > > > > >
> > > > > > > > You should read KP's cover letter again and then research
> > > > > > > > trusted hash chains. Here is a quote from the first
> > > > > > > > googled link:
> > > > > > > >
> > > > > > > > "A trusted hash chain is a cryptographic process used to
> > > > > > > > verify the integrity and authenticity of data by creating
> > > > > > > > a sequence of hash values, where each hash is linked to
> > > > > > > > the next".
> > > > > > > >
> > > > > > > > In addition KP's algorithm was vetted by various security
> > > > > > > > teams. There is nothing novel here. It's a classic
> > > > > > > > algorithm used to verify integrity and that's what was
> > > > > > > > implemented.
> > > > > > >
> > > > > > > Both KP and Blaise's patch sets are implementations of
> > > > > > > trusted hash chains.  The security argument isn't about
> > > > > > > whether the hash chain algorithm works, it's about where,
> > > > > > > in relation to the LSM hook, the hash chain verification
> > > > > > > completes.
> > > >
> > > > Not true. Blaise's patch is a trusted hash chain denial.
> > >
> > > It would be helpful if you could clarify what you mean by "trusted
> > > hash chain denial" and how that differs from a "trusted hash
> > > chain".
> >
> > Paul,
> > This is getting ridiculous. You're arguing about the code that you
> > don't understand. Stop this broken phone and let Blaise defend his
> > code.
>
> That might be my fault: I told Blaise only to respond to technical
> issues and arguing about what you want to name an algorithm isn't
> really a technical issue with the patch.
>
> The point, for me, is when doing integrity tests both patch sets
> produce identical results and correctly detect when integrity of a
> light skeleton is compromised (in mathematical terms that means they're
> functionally equivalent).  The only difference is that with Blaise's
> patch set verification completes before the LSM load hook is called and
> with KP's it completes after ... and the security problem with the
> latter case is that there's no LSM hook to collect the verification
> result.

the security problem with KP's approach? wtf.
I'm going to add "depends on !microsoft" to kconfig bpf_syscall
and be done with it.
Don't use it since it's so insecure.
