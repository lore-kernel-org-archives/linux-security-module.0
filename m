Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5FE231842
	for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760726361; cv=none; b=lwC0N5UvihWc76ESKeE6zxsPi1jQgm5P1esPj03tMF6zBRMfYNcoywqigJtGrN9YnEgoER4m4aEwPrxNHxZvSKGwcnc5UP+w1cZHF2cUa1ED30rrgKowLkwjnqliQOoyuNTRVsZFMt6dd5w0oqWFGJTKuHWcLYqlUbFYjlw/JRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760726361; c=relaxed/simple;
	bh=ZeCLWOrpH5IhJON1itRPaXqiOh3UWfa3p6Ur9r7Pus8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfYUC+L+OLoG19SPTHHWGg/yFCCQOJTVJZ3IUHpG9oQUHSbfPcIyA3n95xJwnQDDWDN4+JHOrfeq2VNdgfmkTI3pgmB8rt3L9c4iETyET6q5OwSk1cZTlzsOWyhW2umzjxvppyJk7a9SCpzt/8LxTrX21TSJId5SZwRw+ihNDmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z9J5Vlsv; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z9J5Vlsv"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so2175944a91.1
        for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 11:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760726359; x=1761331159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUbfA/iP/S6XkM0cploZangZp3HA78XZRnfVGgYINQc=;
        b=Z9J5Vlsv1zxRVek16BQs4OPwjjIU5GEV1WcbKQ4jIcmjo7SYC0RwwVrf2R/tzrpD9r
         cx7/O5PdtH+Yzu4m4yovfFgYe06i+cAmcAf9PC83JmfpiZKEM/WA2bkGyTQOkpZKOlx1
         PHy70n37gsZsPBEmDO1Gir8ZlmDXYzB9nmcWfSzct5HczgiJdAzDtzlGQbfnvpqdbrW7
         al/HV5P+9A1HtY35IiipIrdF50PsF5mHzOK4X+ctKuxo3o3/XZOCBm5FZUzgCeC2f/8B
         Osknc4686kXVLZvzPAoU9yyXnK+MbVmqPHuwnYl6UzrTn6cY8pQ7MWZgwH39HPGvFK4w
         qWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760726359; x=1761331159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUbfA/iP/S6XkM0cploZangZp3HA78XZRnfVGgYINQc=;
        b=Ln+a8LHhD2Q9LxVmTB8wilgFg+oU8jQ/c8aNWchqxzH8fwuX3LvR90CCoiSb0twnfG
         4Agdlrt0XQfAfagwNjqUc0KtSH9cCp46oe6AD5Rc8SpsLdh8hbuoq0yf/axoRPSoYDu/
         vElbLokShd7K/ZfClNDuc/IFtstLI/2U1nKsnDszoX5+yizNQ6VnFQ/bB3orIeyQZ/JK
         R3+vHUdELqY1cl1w4v28eNN44uTGEcSBsm0FqezXA9Xt2I8MD5Glo1Mt9ynuuPdIUkyX
         H7iRUsQaJ0RtKxIQsOZ7njlBE/6MwfSu74sSNIwPFZNu6CG6Ubl7xRYB/mdkteJfC5E1
         Ig6A==
X-Forwarded-Encrypted: i=1; AJvYcCVijUMJXq3NlUdBV9p9spUrKjCv5lQaSVPIG2OhZduyQNmNJUJd2ITr7JqgOoBBppi0eBMHeXY9xLZC+U0CbXZHj5D6GJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFJZTmetSnwcZERg24r/ghUKO1qRUnjt2MiQy+2bWzS9qg54xe
	C0WnPfpvbDuYgyTB8MF++RaFM53fxDJ/aYazI0/FDq5hT7NiE9bud/0VjWsy8nILCRHktuejDS9
	sVFG8CGdgOqnZ8puRt5dpbMXNhRm88AWwZkQ+iih8
X-Gm-Gg: ASbGnctuWAsiuFOmyMvjBvPGD2h3EpMO1PC+HryjLPjMjyr0kBONQLvra3LaFby9Xdh
	No1kcL0kAqFsCVQ+w0nnTRkZcvsjlHKepmQ57IoaCEn+NLzQLk4R7pGgVr6ah4Ut9qyBqYb5Jhc
	uzS7DMEK+WyndMp3gRXzUMY1YgafzPE4NHDsCeUxD7uqezu5grQdxyxZlvtcMdnHXS9hlEUct71
	UFygdzPTI31ThbyGrfL4/81VwzJqWDtSP21a8sJkVeFVTSBJ4PCelNfYiIf
X-Google-Smtp-Source: AGHT+IEckAZjscvNP6j79zpVyVxPkTH0dsQCmDDbaUPgHbM3xrSO6FYwgt9D194ucNGrh2BqEtLjXN7NBNT1MDoTBuw=
X-Received: by 2002:a17:90b:48c8:b0:33b:ba55:f5dd with SMTP id
 98e67ed59e1d1-33bcf93ab88mr4641635a91.37.1760726358649; Fri, 17 Oct 2025
 11:39:18 -0700 (PDT)
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
 <CAHC9VhSRiZacAy=JTKgWnBDbycey37JRVC61373HERTEUFmxEA@mail.gmail.com> <CAADnVQLRtfPrH6sffaPVyFP4Aib+e7uVVWLi7bb79d9TrHjHpQ@mail.gmail.com>
In-Reply-To: <CAADnVQLRtfPrH6sffaPVyFP4Aib+e7uVVWLi7bb79d9TrHjHpQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 17 Oct 2025 14:39:06 -0400
X-Gm-Features: AS18NWDmH3vW2k-hgC1czCxwX721YTFV3Tr6thPKrN0n2onjVHdnHzUc1mFGYic
Message-ID: <CAHC9VhTwHjMa+-3q0appU=NcxKL+4yy9e8tbHNfLGpvy2RDkqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	James Bottomley <james.bottomley@hansenpartnership.com>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, wufan@linux.microsoft.com, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 2:03=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Thu, Oct 16, 2025 at 6:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, Oct 16, 2025 at 6:01=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Thu, Oct 16, 2025 at 1:51=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Sun, Oct 12, 2025 at 10:12=E2=80=AFPM Paul Moore <paul@paul-moor=
e.com> wrote:
> > > > > On Sat, Oct 11, 2025 at 1:09=E2=80=AFPM James Bottomley
> > > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > > > On Sat, 2025-10-11 at 09:31 -0700, Alexei Starovoitov wrote:
> > > > > > > On Sat, Oct 11, 2025 at 7:52=E2=80=AFAM James Bottomley
> > > > > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > > > > >
> > > > > > > > It doesn't need to, once we check both the loader and the m=
ap, the
> > > > > > > > integrity is verified and the loader can be trusted to run =
and
> > > > > > > > relocate the map into the bpf program
> > > > > > >
> > > > > > > You should read KP's cover letter again and then research tru=
sted
> > > > > > > hash chains. Here is a quote from the first googled link:
> > > > > > >
> > > > > > > "A trusted hash chain is a cryptographic process used to veri=
fy the
> > > > > > > integrity and authenticity of data by creating a sequence of =
hash
> > > > > > > values, where each hash is linked to the next".
> > > > > > >
> > > > > > > In addition KP's algorithm was vetted by various security tea=
ms.
> > > > > > > There is nothing novel here. It's a classic algorithm used
> > > > > > > to verify integrity and that's what was implemented.
> > > > > >
> > > > > > Both KP and Blaise's patch sets are implementations of trusted =
hash
> > > > > > chains.  The security argument isn't about whether the hash cha=
in
> > > > > > algorithm works, it's about where, in relation to the LSM hook,=
 the
> > > > > > hash chain verification completes.
> > >
> > > Not true. Blaise's patch is a trusted hash chain denial.
> >
> > It would be helpful if you could clarify what you mean by "trusted
> > hash chain denial" and how that differs from a "trusted hash chain".
>
> Paul,
> This is getting ridiculous. You're arguing about the code that you
> don't understand.

Alexei,
Asking for clarification on a phrase which is not commonly used is far
from ridiculous, it's part of a reasonable discussion.  We've talked a
lot about "trusted hash chains", with KP's patchset providing a rather
thorough explanation, but I don't recall a "trusted hash chain denial"
definition and it isn't a term I recall hearing in an algorithm
context, at least not outside of "verification of the trusted hash
chain failed resulting in the operation being denied", which doesn't
match with the context used in your comment.

> Stop this broken phone and let Blaise defend his code.

He has, in this thread and others.

James has defended the code, in this thread and others.

I've defended the code, in this thread and others.

Support, or criticism, of an idea shouldn't be limited to the original
author.  In fact I would say as contributors, and definitely
maintainers, we have a responsibility to review and provide feedback
on proposed changes; that's how this whole thing works.

--=20
paul-moore.com
