Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C562A30146C
	for <linux-security-module@vger.kernel.org>; Tue,  5 May 2026 01:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777943279; cv=pass; b=nFoPYZ8tAQt32pQSjNxYjAKailrd1a+yFjLpqTPcufnm+GvMag2jCZp8PDQV2QId5/68JG+Dg/sTsaVL6gNUlsiwX9U0y4rIOJUI3XXNgMI7rsahMesfGMA9MaoWKJgqWEsjiok8OS/MLZ0nxnNvWrX4lSmdqVXWWxrS4/kYHwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777943279; c=relaxed/simple;
	bh=h25CviPPheRk/GDUJ4W9hQ0/45Mh6Y0yTtuThhLME2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ie0PD717rJzoS9V1Q/mad5erTsor0M3Q0OxUuXs7iru8N3V05yqPxegvhwweQKNtGyonCNgAxtEzpwbW1fdrUBuFQSZK68/ElvHzc0LMcMg+pwFfV45cb0SqouSCLXawu0g5T47dRJz9ysiRDzH/BpxwHR1djhLg7WaHUDkCX+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qTVpH+gh; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTVpH+gh"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8b701756684so19391706d6.1
        for <linux-security-module@vger.kernel.org>; Mon, 04 May 2026 18:07:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777943277; cv=none;
        d=google.com; s=arc-20240605;
        b=JsBgR5fhzmYjWxPSIh73+rv+gFiW/0ZzLBGtYqCjLKeJS0PWt+3RNEF1aAPFqkOF14
         WBjacZciExndFO5oJ9Ah5cLHk06tF5VXFS/d0fg7WSgZYO8G8gjXiKwkB/j6FrTQ63Dn
         mb45N/NOqh7PttTNOAkaH9by1ZL+2FezzUGGUkFS9s0Z8/3z3pGwYmZMBAs84NZ87bRf
         i7fOM2ZXLCJhVdvMer20cdksAcvbzLJnyKyafoxYBHQQspOepBExUTd337GuG/yrGMHO
         ArIDskGeI1wUBkn5W/1lcyCv/Bs1OMwBIf78291ta3u0Q1cBool6zVS8w3WnDDE7c2Pp
         wGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hBjcwpnTtESMydnEYbNcBRuOTt7JQKpfxpc/oQOpx+s=;
        fh=vGE38ygcy5tYdzPmMP+yakin5FQy+IOEkXyMWNth33w=;
        b=dHGyycqxBegZxP4YlpTBjbN+8vV6l6F/slNh/1SdsFmfCbLODLoON3PGUwY/0DCfQe
         kBmILlIxUlcVUk+7AEvcA26quGcezCVMi4TDliubz/mAnLjEtJaTQJYdFeqbP9I1qAPy
         I7qLq7guvqYGpUfM/Z4sjM5y5qNx9r5o62lCAkomoum/ivkM3bRJ2tTEKartFDAXSc/c
         LdvROVlgYZG/J8rOpH2ZRM+bs6NzMyY76QQQQHTVJj9+PcXrYnlMsWw8hrFuqu+UaiSu
         ivCRLlX5OpjidYADK8egk9kwRTiN4Twmt2os7vrRKCpHXdVfeWNhCzx3d0WCpjdrsgLx
         YwFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777943277; x=1778548077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBjcwpnTtESMydnEYbNcBRuOTt7JQKpfxpc/oQOpx+s=;
        b=qTVpH+ghIW+/XDi+RUUfZXIYXca2uui6Y3kQjl7dpab9CnbohPRqTtY61ha6Pfw0dF
         /74/B/feQnq7guYOFCAUg031sk91U/WQe+BOPqubaszqRlgYLTXnCReddRjNexwcGYLJ
         HO6jhE1QudPeuO9oMC3TGGT8AqlYW9ebmTH+cgVxpWglLLhK4W5KthSHbrrBEs6LrECG
         1BbgBA+cUOg9skzw/GjyX5Q8/FPAuHJ1QcX/fdXcFtQbyaZFE41gHp0gueQL+O1WTyun
         aZx0cKVG3YxGx6qJjsjyke0idcF5LJNhvhP7FLpiOFf0OlVwfn9NhTMMtW+8ROf9KGAz
         iUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777943277; x=1778548077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hBjcwpnTtESMydnEYbNcBRuOTt7JQKpfxpc/oQOpx+s=;
        b=gX6L6bxAMvjqb8lifLG8RpaFDud7PkOQZ8XuKjRo8gemnzr9OcvK32NYc7dHsjc5jj
         AhqyBPVNhMQi0RjF99AWMqyNXcveNfHzHm9hvSnDdIBGIzgto9ZXftGtncicCIJCBg1l
         z0iSxrumtwFly5j47qQmWdUR0pjHrBPbo8g3Q+PGFvpEM3FnR9pF7PDqsOzdO8nrXxPY
         N7dref7B2VMAkU+Rvs44T3OlL9zXF7wdwQnwhbs9/X4kgJIlDJcuAxJ8dS79dokUCUon
         APBEQ/2U0CCJvshm+e0cZ13lwjyDUeejHm4PNkTEG4O2ziFYe6dvMRmwLbynwegABosq
         zN0g==
X-Forwarded-Encrypted: i=1; AFNElJ9Y6BEHA0LKWF4QReKoEWYYCaP+8jNlyzGgPoJbY9YsbiCKmzWZzFzgfjjZCj2qWvNhdE0cI5RdIzRHlSuYkAxDn1mlK44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXHHMgSBq0iL3lq1pfdWJWFoqCChhFnxBW+C+lYWX7DwLjZqLl
	vv+/qgbqkJnwtl2H7YJaiBt8NZv8DVI4IJxNEm6ihk84Y7dXoMkk0u1jfKJ/FSuLCTLd94fmehO
	q0iUORfZNHsp/3bGJq6wKR08emTjrNGU=
X-Gm-Gg: AeBDietCdAtyTk7H7r6C39+8W7z6LP88OhgKNZJ86h3xShCz7K+EdmZ/OzyfiyZO8Dz
	v1KUtojQWfJD1qJuNAP/+09aEmEeG2zB4tyVwp/mK43Y2cWzhjPy5CLxuO4pe9Wt2GkqdFEju3W
	NhnSJ/m7EG8lDK0ZKeOXefWI/WbLvhmTCSUbMJhZi6YvCURS8+fi0TD8Px3zRkGkoEFtl831HJR
	EFvXHpr5ZFHPuViv4/fJuWijhE904IvBedn1F7d4WptsgoWpa9mRe6TvF5F3tDGmjgb0/Y6dnI5
	C7e132RMaiIG23xYRSwZL+kjTVWsogp2KYLvhSOwVqzlSPL8IhVzQa8Tkox3Jg==
X-Received: by 2002:a05:6214:2b98:b0:8ac:dd87:b5b2 with SMTP id
 6a1803df08f44-8ba9ea852bdmr30666216d6.11.1777943276686; Mon, 04 May 2026
 18:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503211835.16103-1-dwindsor@gmail.com> <20260503211835.16103-2-dwindsor@gmail.com>
 <CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com>
 <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
 <CAHC9VhQLN5NA_ZMMNyUdMCZVdwC3VM4PUnzka8xDK5rpR2a3sw@mail.gmail.com> <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com>
In-Reply-To: <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Mon, 4 May 2026 21:07:45 -0400
X-Gm-Features: AVHnY4LpG15Ov5YRtOS0i0ZsEyHFvRUaNMxQ4C3yLGhd4sFsYnvO-3LzEMQWXWc
Message-ID: <CAEXv5_jp5wKgR_ZozL3n+4NgrLTg9FQ-HW1EHTtkyA_6GDMhgQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Song Liu <song@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 7:09=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Tue, May 5, 2026 at 12:42=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> [...]
> > > > Perhaps I'm simply not seeing it, but is there a check to ensure th=
at
> > > > there is only one BPF LSM calling into security_inode_init_security=
()
> > > > at any given time?  With the BPF LSM only reserving a single xattr
> > > > slot, multiple loaded BPF LSM programs providing
> > > > security_inode_init_security() callbacks will be a problem.
> > >
> > > I don't think there is such a check. Also, a single BPF LSM function
> > > may call the kfunc multiple times, which is also problematic.
> > >

bpf_xattrs_used() guards against this. The lsm_xattr_ctx is shared
between all callers, so xattr additions by another LSM (or by calling
it multiple times in the same function) will be tracked by this.

> > > I think we will need to make the default bigger, and also introduce
> > > some realloc mechanism for the worst case scenario. This should
> > > work, but the code might be a bit messy.
> >
> > Thanks for the clarification, that is what I was afraid of when
> > looking at the code, but I was hoping I was just missing it.
> >
> > Increasing the default is an option, but I don't think we want to
> > support a dynamic reallocation scheme for the xattr slots, that will
> > likely get extremely messy with synchronization between the LSM
> > framework and BPF LSM hook registrations as well as special code to
> > handle inodes with lifetimes that are disjoint from the BPF LSM
> > programs ... I suppose there may be a way to do it, but it will surely
> > be ugly and come at a cost.
>
> BPF trampoline already handles all the synchronizations, such as
> add hook, remove hook, etc. properly. So this is not that hard.
> All we really need is to allocate a new array, copy pointers, and free
> the old array. And we only really need this in the worst case
> scenarios.
>

How many bpf-lsm programs do we envision being attached at once? I'd
think that stacking of bpf-lsms would be difficult to reason about
(moreso than static LSMs) and won't work that well in practice, but
may be wrong. Most LSMs use 1 xattr, Smack is the only one who uses 2
IIRC.

> Thanks,
> Song
