Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F631E485
	for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652045; cv=none; b=efhBfqcNvuI6/5wRE1twBh6XqzS1S1nsolHpA+ArWn2sL3fd1JsYzg1B/O940LFiazBl+EbYI/KPPk2Ft+KP3g+JqrnR3TbXAy3eUxuRNVpzfRJscC4xf8P1pR92MdatHPpkx8/kqQ1VDs2/+AAswrGXivI0XGeQSd7mwh/Dwyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652045; c=relaxed/simple;
	bh=w33/us8MO7JoKDOMj1K2I4Qq4KGGb7O/8X5yxnTWJ6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUB/eF2yBBxhg1fXFF+SsCuUG+6gYroCOIVjuszqNph/2Q+qVjv3KNWkLki3iO9tpUKILLQxmbg4iCQugYoGT9rH3xJA53X8uHH7OppmeAVt4reonmauVZ6HsFxC44rhnnoVv6x7RNLE2ZjoyxGuHtPNUj9kq4BJWBXV2UPGl3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dP1JWndB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dP1JWndB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C1BC4CEEA
	for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 14:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749652044;
	bh=w33/us8MO7JoKDOMj1K2I4Qq4KGGb7O/8X5yxnTWJ6g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dP1JWndBC0OjYfce3oxKJttP/HoI41nlS9QMOKmCpgjaDpZmUwziQI/EpNOFKoRbz
	 bfZOdxEd8nBQrWGAPydpEfsZSlPvA4j8otw13rTfB9J0J5OR7cuRNyLZyngn2ufDKa
	 6T04P3TTehCEpMglmm5m5khLYJxq1z/MdqT4+KNZLfdNznIF32KI+I7nTSRQ/8UgSy
	 y8dgxaPQH1pINYzEqVGYdGFOwIVLklQApRECAWdQbQVm0PpANS6amQehdlTrudXkUp
	 sPpKBT3pTalDoQrc6HtP5YmAIYBrKkWS0V+41mkOh/vYyHiKx3BY1cNN6KM1MTMMqV
	 jklP8UQW6szWA==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-606fdbd20afso13259054a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 07:27:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGYLdhJ8swoZoXaIRo640UXvfw5C5h0VWkQu7v7zS6vAs49Q94I8OpQF91K8BMz/WatJ4lxjXzi2kdw/0VjlE174uojQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4kNv7eeOgHwgL3BzcVHdo/yypFWX8BY0WcD4t55wc38hVZIzD
	kjm1qHdzff9s2hVrscBbufpDol+MZWa7g7aS7Ns+5Ens6XeeIL/50vWIbfEiBDQos545SJyjq05
	/5UrUzy/pFU3cHyQSiLOCk89L8KKBacUxuluhqkY/
X-Google-Smtp-Source: AGHT+IHGnA8bdlBdkDNy5fbaGg55TsdC2JxCgtHudUuSFaKj5HiqDT6/Peo047X/zIVd10Y833hP47vguHQeBQG8AEQ=
X-Received: by 2002:a05:6402:4309:b0:607:f61f:cc2a with SMTP id
 4fb4d7f45d1cf-60863ae5802mr10202a12.18.1749652037181; Wed, 11 Jun 2025
 07:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-8-kpsingh@kernel.org>
 <CAADnVQL7Roi1gmAWZFSx-T4YVLtHu2cDneKCkLdBvB2+y_S1Uw@mail.gmail.com>
In-Reply-To: <CAADnVQL7Roi1gmAWZFSx-T4YVLtHu2cDneKCkLdBvB2+y_S1Uw@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 11 Jun 2025 16:27:06 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4_NL=U525D56mVcyfxX64BDrkP3FiFotNPQ8+EDKNRQQ@mail.gmail.com>
X-Gm-Features: AX0GCFu-SkJ_wE_J4tRZNu2bXqfL8mEQrDouEmkjjBSbHwvtq1KTbS3AQoyqKNw
Message-ID: <CACYkzJ4_NL=U525D56mVcyfxX64BDrkP3FiFotNPQ8+EDKNRQQ@mail.gmail.com>
Subject: Re: [PATCH 07/12] bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 11:30=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 6, 2025 at 4:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:

[...]

> >
> > +       if (map->ops->map_get_hash && map->frozen && map->excl_prog_sha=
) {
> > +               err =3D map->ops->map_get_hash(map, SHA256_DIGEST_SIZE,=
 &map->sha);
>
> & in &map->sha looks suspicious. Should be just map->sha ?

yep, fixed.

>
> > +               if (err !=3D 0)
> > +                       return err;
> > +       }
> > +
> > +       if (info.hash) {
> > +               char __user *uhash =3D u64_to_user_ptr(info.hash);
> > +
> > +               if (!map->ops->map_get_hash)
> > +                       return -EINVAL;
> > +
> > +               if (info.hash_size < SHA256_DIGEST_SIZE)
>
> Similar to prog let's =3D=3D here?

Thanks, yeah agreed.

>
> > +                       return -EINVAL;
> > +
> > +               info.hash_size  =3D SHA256_DIGEST_SIZE;
> > +
> > +               if (map->excl_prog_sha && map->frozen) {
> > +                       if (copy_to_user(uhash, map->sha, SHA256_DIGEST=
_SIZE) !=3D
> > +                           0)
> > +                               return -EFAULT;
>
> I would drop above and keep below part only.
>
> > +               } else {
> > +                       u8 sha[SHA256_DIGEST_SIZE];
> > +
> > +                       err =3D map->ops->map_get_hash(map, SHA256_DIGE=
ST_SIZE,
> > +                                                    sha);
>
> Here the kernel can write into map->sha and then copy it to uhash.
> I think the concern was to disallow 2nd map_get_hash on exclusive
> and frozen map, right?
> But I think that won't be an issue for signed lskel loader.
> Since the map is frozen the user space cannot modify it.
> Since the map is exclusive another bpf prog cannot modify it.
> If user space calls map_get_hash 2nd time the sha will be
> exactly the same until loader prog writes into the map.
> So I see no harm generalizing this bit of code.
> I don't have a particular use case in mind,
> but it seems fine to allow user space to recompute sha
> of exclusive and frozen map.
> The loader will check the sha of its map as the very first operation,
> so if user space did two map_get_hash() it just wasted cpu cycles.
> If user space is calling map_get_hash() while loader prog
> reads and writes into it the map->sha will change, but
> it doesn't matter to the loader program anymore.
>
> Also I wouldn't special case the !info.hash case for exclusive maps.
> It seems cleaner to waste few bytes on stack in
> skel_obj_get_info_by_fd() later in patch 9.
> Let it point to valid u8 sha[] on stack.
> The skel won't use it, but this way we can kernel behavior
> consistent.
> if info.hash !=3D NULL -> compute sha, update map->sha, copy to user spac=
e.

Here's what I updated it to:

    if (info.hash) {
        char __user *uhash =3D u64_to_user_ptr(info.hash);

        if (!map->ops->map_get_hash)
            return -EINVAL;

        if (info.hash_size !=3D SHA256_DIGEST_SIZE)
            return -EINVAL;

        if (!map->excl_prog_sha || !map->frozen)
            return -EINVAL;

         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
         I think we still need this check as we want the program to
have exclusive control over the map when the hash is being calculated
right?

        err =3D map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, map->sha);
        if (err !=3D 0)
            return err;

        if (copy_to_user(uhash, map->sha, SHA256_DIGEST_SIZE) !=3D 0)
            return -EFAULT;
    } else if (info.hash_size) {
        return -EINVAL;
    }




- KP
