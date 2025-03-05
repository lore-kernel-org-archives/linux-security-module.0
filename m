Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5619D06A
	for <linux-security-module@vger.kernel.org>; Wed,  5 Mar 2025 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741205579; cv=none; b=cueesMz4G2TJyuC4R5T+oIdmlbAxhRmMDhvLN5gEc6bPfp9oP+YilhIQm+5pk/C1+J31NAEUaZUuNzVuwd4zgJHNz0FijOG9GZdYyJbmXexrLOVsXFhSYPY1HUSqdD8m4jVYPWUcdbnWGSDz2rRHtDNcS4a0km/fOd8fIQ4ngC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741205579; c=relaxed/simple;
	bh=zNu+uO+qVUH2lHjGc7UpYzRsUdmyNBFYkU3NKGrAkMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMTGeGza8E9/lpmjU9pOkHGu7Nucjk0bIHXUKVG9+TwSfS9kfdNnHFxHpQgy44SxcxtO2jzv3z4SnHFocYjY4u82q6pZMEIwXaobe3njU9i2huzFvx52x3HaiXkAO3Sk/fBrQ9ubWqfsPFZvBWDn+jO4enjpXFtfcjSISnyKBtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PV6p5hz8; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PV6p5hz8"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so5403813276.0
        for <linux-security-module@vger.kernel.org>; Wed, 05 Mar 2025 12:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741205577; x=1741810377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20bCxuGfaDVAOpC3W+MtKdxzg/x4LtoR169fsBOSxiQ=;
        b=PV6p5hz8QrMFrM47dGnoPz1YwgyU82UYK5Kmu04FwnzTrDH4creMEB21e9+BqTaTBm
         2tml2F3kDrKZ9Os1fGqrnSvIh7xHTSarCHECwjCUvQZw4vAQr4RXQbbpqY90dA/eAFQl
         tp7BktFTuEHnEaDgfT25PSRLH2kiKL41BGR0J0yKbfxJALYPD2nNE0aW9n95QuEdPaje
         jEcO5xxEa2Ro/EhA10NfRKGLTDcVNz/71bsyyDYVJW1pnmIlu32pZHq3QywQ7hdnJ6XS
         MBUf9cduaVdehx5/dp9HNgo+5JZgpxzKYgm38Vg8Kr8LS2PuAWKK/1904Z0QFXWl7KGJ
         q7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741205577; x=1741810377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20bCxuGfaDVAOpC3W+MtKdxzg/x4LtoR169fsBOSxiQ=;
        b=Bk9e82hSJPQxdGgzoBJDTaOXy+E72cPEAcTEi6BWiM7ksQHtVg7eZoOBLMLYRab21m
         IAqg1u/4hl5nPoUUFhP173S0m6aPM+n2nLst6cN17YVCK11MoWYchfbfDvNxwEwRmspx
         gUZjpFcsC7N4O+aIMdwPs15TKbUUFlIVUmAvc2UlxJLWEok2eHS5/7ZYnHXZ25wRe4WZ
         vXBKR+z+GE0DIt1HgrESOnM2FAN/JRUwFK3nRsaXmU/MRjUNJuZfoRtbndfpC1quZzFJ
         7SM+TMx3fgejCeS77+Ge4WnrcF2YEGTfThbc0RpmfumxOUhfvyGDir81kYgM6yFaKjbd
         wmjw==
X-Forwarded-Encrypted: i=1; AJvYcCWzgm/flPdMmACk3Ke3me3V+MrPMnx1Ven8hgrahbCvtIUlmjOjo/z+iqSVi949IoocUJLzVRVRhC9hAg1z4uRmgmJhDGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyMfYhMcuQOBwpxc5GGvyCm+AIU+dkg0EePV+D1gwgtbX026MV
	mUB2RgRKWMYIVUbgyLVZ+fxZpLBAv7U/N1KwCdLh2WpGAm4K9O9jd8nldKRvvtPekAq5DGw0oQ/
	rKEYlS7cEpc9dni1Xmk3QyZgbMS/1xLPb8gKT
X-Gm-Gg: ASbGnctGEcq3qCMw6KpEWD7lmt7gOukKuO/6B4/zkiVDHOpCoIQOkT3OzyenFTma6+h
	lYWqujOLx9sjWGorWhHmzpn7z7Uu8G7tBvGaG58ah9r1Yt7v+NQl6fRSt4XXrqk/ttTQJNmyLZl
	ZrMfUdotWSPpnt485wEc5umKh4LQ==
X-Google-Smtp-Source: AGHT+IFb1lQWxZfA+3Fj3IIMOvkgMjpy++obS3VPsP4HPWlePPjHMEfo/RAlFL+2ENHWUfAYeV2u1UeTQGpoYyph5bM=
X-Received: by 2002:a05:6902:161b:b0:e5d:d2ce:a40a with SMTP id
 3f1490d57ef6-e611e30582dmr6534407276.34.1741205576740; Wed, 05 Mar 2025
 12:12:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com>
 <20250304203123.3935371-3-bboscaccy@linux.microsoft.com> <CAHC9VhS5Gnj98K4fBCq3hDXjmj1Zt9WWqoOiTrwH85CDSTGEYA@mail.gmail.com>
 <877c54jmjl.fsf@microsoft.com> <CAHC9VhQO_CVeg0sU_prvQ_Z8c9pSB02K3E5s84pngYN1RcxXGQ@mail.gmail.com>
 <CAPhsuW6RrUiXaQe1HBYOvwUx2GFaA-RKx22955A2StsP2erTeA@mail.gmail.com>
 <CAHC9VhQ1BHXfQSxMMbFtGDb2yVtBvuLD0b34=eSrCAKEtFq=OQ@mail.gmail.com> <CAADnVQJL77xLR+E18re88XwX0kSfkx_5O3=f8YQ1rVdVkf8-hQ@mail.gmail.com>
In-Reply-To: <CAADnVQJL77xLR+E18re88XwX0kSfkx_5O3=f8YQ1rVdVkf8-hQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 5 Mar 2025 15:12:44 -0500
X-Gm-Features: AQ5f1Jp_oXF4bydH-aIRtYZmN6RTF7YwHfbbSgRNBrjTiC_WlFGzFQqTRg_361Q
Message-ID: <CAHC9VhR5NmSU+eanprCk-osSMZnZ+ODwLJKWuqd8e1qDobim7A@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add is_kernel parameter to
 LSM/bpf test programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	LSM List <linux-security-module@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 12:08=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Wed, Mar 5, 2025 at 8:12=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Mar 4, 2025 at 10:32=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> > > On Tue, Mar 4, 2025 at 6:14=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > > On Tue, Mar 4, 2025 at 8:26=E2=80=AFPM Blaise Boscaccy
> > > > <bboscaccy@linux.microsoft.com> wrote:
> > > > > Paul Moore <paul@paul-moore.com> writes:
> > > > > > On Tue, Mar 4, 2025 at 3:31=E2=80=AFPM Blaise Boscaccy
> > > > > > <bboscaccy@linux.microsoft.com> wrote:
> >
> > ...
> >
> > > Do we need this in the LSM tree before the upcoming merge window?
> > > If not, we would prefer to carry it in bpf-next.
> >
> > As long as we can send this up to Linus during the upcoming merge
> > window I'll be happy; if you feel strongly and want to take it via the
> > BPF tree, that's fine by me.  I'm currently helping someone draft a
> > patchset to implement the LSM/SELinux access control LSM callbacks for
> > the BPF tokens and I'm also working on a fix for the LSM framework
> > initialization code, both efforts may land in a development tree
> > during the next dev cycle and may cause a merge conflict with Blaise's
> > changes.  Not that a merge conflict is a terrible thing that we can't
> > work around, but if we can avoid it I'd be much happier :)
> >
> > Please do make the /is_kernel/kernel/ change I mentioned in patch 1/2,
> > and feel free to keep my ACK from this patchset revision.
>
> My preference is to go via bpf-next, since changes are bigger
> on bpf side than on lsm side.

Fine by me, the patch has my ACK already.

--=20
paul-moore.com
