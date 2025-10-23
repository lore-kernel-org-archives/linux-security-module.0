Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3B3267B02
	for <linux-security-module@vger.kernel.org>; Thu, 23 Oct 2025 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241995; cv=none; b=ExcMl2MZMvjfz4rc/7aMB+ncEFMw8ssKUst6p3MJEra/77d7I6L0kniHMHLuqJpz+ykOc1bOWPRZapLZF5u8+80Bj99hRn0QYujZdC4BnmqwgHI2+OBfiJhSxfP7/pzRTa9p/KNzc32yhb1DPi/QNS/IAc3koRyQjFe4h0uPGyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241995; c=relaxed/simple;
	bh=wdaLAd16LppfjVQq785BZz1MgPEClo1kKwgxRzyNeDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unZEbEefp3yTJDwEbjrrQBGGjesPcN0K8iaYSnQPuIL4O6WpnLFYYRnThwNrmt+y7U9lpky9FEjmMn1BaNwxxph6F+qwacNeSMreTliOulTCdHcaeuWGIvtxVnwUhUQkN8D17fHODaawpbaKFqyaVpYvJ61eyr8ekccXyy3a3Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PVGlHUmR; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PVGlHUmR"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33067909400so862209a91.2
        for <linux-security-module@vger.kernel.org>; Thu, 23 Oct 2025 10:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761241993; x=1761846793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAN/q9LKWL7MIY4mx8u90/xgVaIVlAYrpKHTrcfpJ+I=;
        b=PVGlHUmR6xONLaAqSKpaxiMOufUUTyyPargLMooL2JSCZaTATaA9tTntS4MeCzSdeh
         F0QtB71Wl1o0HJzVOirwRDLR2RjMwloWUTcvAYq/SOgBqoK4HXthGdwXYhpUFMN1Pady
         nMNzew3KB/KiP+fJDllmqvf35GOKs37wdBgzZzbzNJxV8TJp0sKfD5dq79i70S0ZGKuh
         gmrJ2vhpb31WutCrbTEY9FVrJJ3HCJgNoUcyeAk2RTNN30Q3ZNhc/kQk44XM/xKVjQhN
         oyxtXoSZ/rGO8oEI19efAUZn7uKEOoKTKtaDr/18qIbVw5EuVKpiO6r/EJvLkZljJR8o
         gNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761241993; x=1761846793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAN/q9LKWL7MIY4mx8u90/xgVaIVlAYrpKHTrcfpJ+I=;
        b=jZcL27XEpLZIgZg6xWv+zO11PYitYw0HtPmEQUF0+mKJq+O/2tc3atRUT864dTObD8
         PduyF+JeDvAxlRHETvFNFFqqcnba/qDwZtT2rMDi3NiWN8ipOlB/44IAgUUAlueLzpjw
         LVHsPUoXnK/vF4SbtfAzseZAmdG2cxt0EKfRX8Wb+50fAFWvJXZ3wn4ekJzfwyCqgArm
         aMaUczYWNf5oo8l82YzqSkgqi+97KxagToB8rQR8N3miBZ42om+/5qwDlzMjjqrY/i1R
         XZJTL5ShtM0BuD+tZ48uVpHLPafqzS4/pAmBKsnKF6Ni0kT+jjH9cb63f0sqXMFo26Sw
         c4NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs2J6SmSZL79RTIzMgXAx/yrK6T4bnbSlodXWWds78Q2Rbm6kX/IIrvAYt5QfXBN1JJ9OgckqECGmtaZNahEzS2fYqGw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8eoRi2qVixfdYm2DXTP8cio6mkhG3/IipxX3VCUfse7/XZffA
	3munXRqzQC0uckUFJ9RzVD4dUrZhnvA7fjEkMMmQMjBCwOKVGghzskqZuzLUs+MKCrbHRX8yxSh
	crQyDbSapXQaKs6LK4L/sO8o6PwqR5wqGU5q4MRD8
X-Gm-Gg: ASbGncvo7Co1CkyqrgkXeAPSSefGAaUWDdEoHMor0dpgdU5yAOOXYavDB3rmE//T/Cf
	azTlTDtmeyReECkPv0wyHXCSPyp5lz8pW5uLi9BsR2+rgKClqAdOViwzwxk8yzqvXKCj1d600Ku
	oq48i0cdsGBnoqxD4Mg/FsFy8QDEy65BFc69FQhffuDRZ807JDSihybhIZR+DjD8kcP98nO4ERh
	sae5yv0TZ85JCoPMskbFi7kkwFOP00+CxyucbsIPFJQ5D6As8CRzAmteHrf
X-Google-Smtp-Source: AGHT+IFon2/kAEzg4D7o335oSJOu3JnJyuhjpqKWzc9tgtPk7h2RpcjxcBPCEBwKnvxnIq2nUhTUgLvk4OTEU9jdeg0=
X-Received: by 2002:a17:90b:35cc:b0:33b:ba50:fccc with SMTP id
 98e67ed59e1d1-33fafc1bc67mr4049778a91.18.1761241993567; Thu, 23 Oct 2025
 10:53:13 -0700 (PDT)
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
 <CAADnVQLRtfPrH6sffaPVyFP4Aib+e7uVVWLi7bb79d9TrHjHpQ@mail.gmail.com>
 <bc823ddbaf63e0e177eb46d1cc15076e4e2e689d.camel@HansenPartnership.com>
 <CAADnVQKcOS8iu0Nq5aYg+Lg_EAO8fFde0H3w8t0m_SXUy4iKAA@mail.gmail.com>
 <b21284e338846166804bd99bfc37186cf80f1b38.camel@HansenPartnership.com> <CACYkzJ4z4vzVEjtOmFHuC9tpDmWp0N-EH-xDK7Bs6YJ-x0W3Sw@mail.gmail.com>
In-Reply-To: <CACYkzJ4z4vzVEjtOmFHuC9tpDmWp0N-EH-xDK7Bs6YJ-x0W3Sw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Oct 2025 13:53:00 -0400
X-Gm-Features: AS18NWCj0tFUEVQGPAIiKpTaZZF4URx2jA1TyaXqoiWXc9pPvT7CL4XqkXQZqwg
Message-ID: <CAHC9VhRt_g7Ooap-WvSx8NkaodN4YZ03xAw2TX6N16kdrQrwzg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: KP Singh <kpsingh@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, wufan@linux.microsoft.com, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 11:39=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrot=
e:
> On Wed, Oct 22, 2025 at 11:10=E2=80=AFPM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > On Mon, 2025-10-20 at 18:25 -0700, Alexei Starovoitov wrote:
> > > On Mon, Oct 20, 2025 at 4:13=E2=80=AFPM James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> > [...]
> > > > The point, for me, is when doing integrity tests both patch sets
> > > > produce identical results and correctly detect when integrity of a
> > > > light skeleton is compromised (in mathematical terms that means
> > > > they're functionally equivalent).  The only difference is that with
> > > > Blaise's patch set verification completes before the LSM load hook
> > > > is called and with KP's it completes after ... and the security
> > > > problem with the latter case is that there's no LSM hook to collect
> > > > the verification result.
> > >
> > > the security problem with KP's approach? wtf.
> > > I'm going to add "depends on !microsoft" to kconfig bpf_syscall
> > > and be done with it.
> > > Don't use it since it's so insecure.
> >
> > Most Linux installations use LSMs to enforce and manage policies for
> > system integrity (they don't all use the same set of LSMs, but that's
> > not relevant to the argument).  So while Meta may not use LSMs for
> > system integrity the fact that practically everyone else does makes not
> > having a correctly functioning LSM hook for BPF signature verification
> > a problem for a huge set of users that goes way beyond just Microsoft.
>
> The core tenet of your claim is that  you need "LSM observability" but
> without any description of a security policy
> that cannot not be currently implemented. The responses I have
> received are generic statements that the loader verification is
> "unsafe"

As we've discussed this many times across various threads over the
past several months, I don't see much point in revisiting the
argument.  Instead I'll refer you back to my last response to this,
taken from earlier in this thread; the relevant portion is the last
paragraph:

https://lore.kernel.org/linux-security-module/CAHC9VhSDkwGgPfrBUh7EgBKEJj_J=
jnY68c0YAmuuLT_i--GskQ@mail.gmail.com/

> If you really consider this unsafe, then you can deny loading programs
> with relocations ...

This would require a LSM to inspect BPF programs and maps at load
time, something Alexei has previously rejected, are you now saying
that this would be acceptable?

https://lore.kernel.org/linux-security-module/CAADnVQJyNRZVLPj_nzegCyo+BzM1=
-whbnajotCXu+GW+5-=3DP6w@mail.gmail.com/

--=20
paul-moore.com
