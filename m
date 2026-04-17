Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CD333F8B7
	for <linux-security-module@vger.kernel.org>; Fri, 17 Apr 2026 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442243; cv=none; b=gJyzZC1rKP+Yr7fa1qIPfCf8Al0d/GKA/5NSykgctdU3AjeYkFUdjMr0pP/mBg9NIOnZlCh09uV9xmskC5EAfA3iQJGkQyk95sXDIUU5cFV4a6fnB8fKV/DoAdbGxdmk3VexWB/f0R28mBJYXzepsJIvL0Akya/B9rTLMe7+NA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442243; c=relaxed/simple;
	bh=XuJXEpu0aKvc85JG7EApCC3CRfSpOkMFDMwAyfRfCeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xznm++qts2Hto+comqtmkvu/xnTSTDD8nH6CMfQuOLXOo6uQ51Rl1o0sxXQ4Vf6LNtR0jNpepaTDkUI/mTpEohWagYGa7FKVotLvZ6oBrOM7jpA4eu49pVO6jVAH51ETqUY6W8ocQtgvQ8HjMWMxBXp3Gwl5niTAuhtlVT4MMSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uO+y02bx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uO+y02bx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90969C2BCFB
	for <linux-security-module@vger.kernel.org>; Fri, 17 Apr 2026 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776442243;
	bh=XuJXEpu0aKvc85JG7EApCC3CRfSpOkMFDMwAyfRfCeo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uO+y02bxIUtTOEFtMbmbQQl9yNDwhh96BoV5fW6tjDiZU5cMzJtJKj6R4YUXc4aPa
	 z2J5Ru76+e1/XSmjfTXyzltS4KBsW/1uQYLAp/tv5mOHYzeLIguqac9+vRLJtaQmr7
	 tMNzl84rKZ7ZdPedFQvhTD0uAYYNEBbHp6yHBJdfq9qjc5eXxPSoG5SkMemYE5pnkR
	 i7xTpNBApijI0ZHJgNv0tHL513eI9TvKs+aSNZV3kFFIFjqkTn2JKQXO+DWOA+3GVs
	 JCpfVkaZwW+iaZWOSGfvJWQwEQJqZkajfmjaOy+6e9BqlFES6O/RptxVhaFQMjYMcN
	 L1Z4vrK1RDXQg==
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8aca2726f61so10157026d6.0
        for <linux-security-module@vger.kernel.org>; Fri, 17 Apr 2026 09:10:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/kRblkBQ70u5MQ1Ar8qmyn+nmxtEhGn/jFm4gOCnD4GSIQ0vxza7kJaKFH9aYw3GBKeloZEStpsK0o7mJOPR7FpAAegAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCVlsq1mN2oo1kgJM1+phYVL5lSjpgEE17WXQokGfRNF1Eh5kw
	TrvMiOjKmGlhj0j5BRe5xH6AJ/eHFPgUAXvTY0nXrzDRsYwNcFf4FyNKgKBlRCJmvoZPX/LgTJP
	E5CiYOWoxVQTitQ+auH7HSqirv73C1iA=
X-Received: by 2002:a05:6214:2f03:b0:8ac:af0d:c101 with SMTP id
 6a1803df08f44-8b027fd9d3fmr54364896d6.10.1776442242620; Fri, 17 Apr 2026
 09:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-9-utilityemal77@gmail.com> <CAPhsuW7zzXXd6-d86B-rpGr-wfSzmEoCYNKhTMP_pXnybtA27A@mail.gmail.com>
 <aeFaQXkKNHFeE-oC@suesslenovo> <CAPhsuW648HdcCbXWMHaJ4uirPWq2WX3Ggx3AGMU6CGzhNYUREg@mail.gmail.com>
 <aeI_CXj6F-nI_DCL@suesslenovo> <20260417.ohgoh0Eecome@digikod.net>
In-Reply-To: <20260417.ohgoh0Eecome@digikod.net>
From: Song Liu <song@kernel.org>
Date: Fri, 17 Apr 2026 09:10:31 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4g3Q4rK8GD=wCYi0iAGhcHcdh-ynsvC44f8rE8OuTqTg@mail.gmail.com>
X-Gm-Features: AQROBzDGBSiT121PHW-UB_rcUdN4Gaz5rncLKRCi24TJMuRNJwq28aGp4x7Zpn0
Message-ID: <CAPhsuW4g3Q4rK8GD=wCYi0iAGhcHcdh-ynsvC44f8rE8OuTqTg@mail.gmail.com>
Subject: Re: [RFC PATCH 08/20] bpf: Add Landlock ruleset map type
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Justin Suess <utilityemal77@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, kpsingh@kernel.org, paul@paul-moore.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, 
	gnoack@google.com, jack@suse.cz, jmorris@namei.org, serge@hallyn.com, 
	yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	eddyz87@gmail.com, john.fastabend@gmail.com, sdf@fomichev.me, 
	skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 8:18=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Fri, Apr 17, 2026 at 10:09:13AM -0400, Justin Suess wrote:
[...]
> > > A new type of map for each FD referenced kernel type is non-starter.
> > > It is impossible to add UAPI for a specific use case.
>
> This new map type is only about one file descriptor type, similarly to
> socket FDs.  From a UAPI point of view, it looks clean and safe,
> especially to deal with underlying object lifetime (e.g. reference
> tracking).

We have changed the UAPI policy. New program type, new map type
will not be added for a single use case.

> > >
> > You've convinced me. I could see a lot of problems if everyone wanting
> > to add their specialized maps, it would be difficult to maintain.
>
> Is there another way to properly handle kernel object lifetime (not tied
> to the caller) and pass them as file descriptor?

bpf_kptr gives same life time promise.

> >
> > It's probably best to keep the specialized map types to core kernel
> > interfaces only that are unlikely to change.
>
> File descriptors are a stable interface.

Maybe we can add a new map type that can handle file descriptor of
any type. I haven't thought about all the details. Maybe we don't need
a new map type for this either. Instead, some new kfunc may be
sufficient to make bpf_kptr work.

OTOH, adding a new map type just for landlock rulesets is not gonna
happen.

Thanks,
Song
