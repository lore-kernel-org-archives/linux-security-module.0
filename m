Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF943D6CD9
	for <linux-security-module@vger.kernel.org>; Mon,  6 Jul 2026 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783365664; cv=pass; b=gYeVZ4wERVGt4bG8QWvP6vJQzKpR3ujQLnJl5hY4kgspx37yxtQmUWJPjTilTjPYwsxjFAySCjiMY9PoCvYOMIo1TmBQvUmKR5XaUWASBqH4tD6kk0ydI8CiIz+TGJ2gl+b2Nyylb/E9A9dxJx3RwHI7N0f2FuE9FvZ6fSfG1u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783365664; c=relaxed/simple;
	bh=Wmcq0d/uw2MfjwXGNSoG37Hnq+tsOpNC2Cb1/t/o7hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dj2O9k+q2yusYFRG+asGaFIHGHyIMeJJ+0eu2lze6TTfQ1mQzcUmpmGxRKSHHltOFw6ZWi2wr0IWku2J4qCsv/USIsKNYLph++3L8gzQZ66B2bzO64aFwmImS0eugRwBIK22E59etzMFAlQsO1UyJDOcWRqqGepWt0Zm8Wm7C04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BgC+kDoB; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BgC+kDoB"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-845c92bc464so2418546b3a.2
        for <linux-security-module@vger.kernel.org>; Mon, 06 Jul 2026 12:21:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783365662; cv=none;
        d=google.com; s=arc-20260327;
        b=i1tquPtMMnWenfycD6hoQwaUzUXcWn6bmBUfqYnLAu5yXu9E3nmthryGRMhnDe5Ppc
         HMcOw867/+NN9A6vdc/JJ3EcXArtZjqmximZo0801ZxVhtI0/Eg6RD8MuHVxl8YbVKuK
         zQoWFPN1o2dNOKPnyowA3d1LWhVswgmXITsfUvEVHu/1KCQ+JkkQqQ2fCtJgTJ3J6GRj
         Okt6XwbNFixNGZPaA2FrfROgaUWtOKsmCQIWO4YfQtvh94Dd8TV4e/bhTmpYMF8R0ofe
         NRwI63+O4sR6EPnJrlPMCOg2AJwpF2jKcSLeF0rINxn9zBAbf03V3YZj0KUh1kB9Xba1
         W8XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Va6D3P5xYft1yzK5q2p21jfKRtd4zXStfUbyiE1/8Ew=;
        fh=oZw6OfYjS6yQl2Ft0GSD0xrQqbW6RxPFhwmCqAp2wo4=;
        b=QGQafbBkHTbBRoMP5EOd8Md/fCeNk30HgpBHvoqddgyfzeLO+XTRR/G2+YqU7Cgqk8
         RE35Gk+tqiH/QabQTUPMLTYi/AuLEf+x+8NqQnB36DQL4PTh+xLNVPP+xI0d/XUa6lAH
         crafT1dIINy3jB3RnmHKgR6496PT5Id6HCnt7ebixN1tye8cK6Ci5WeVKd5AHNlV4U3U
         gpjoAY/1uVwEAp0LfI9b2o1sQox7YmEsd63n+E/lr+s853i+Mvtbz0ZWhHV1Kj0y2RBk
         cQC4fAoL9pZIlS2jiadhmRcTb5/JrhLGzwy02EPSRU4xgCm1znTyrYufJ6JvEmcEmvrh
         m2Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783365662; x=1783970462; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Va6D3P5xYft1yzK5q2p21jfKRtd4zXStfUbyiE1/8Ew=;
        b=BgC+kDoBhbavydwnXkdFVZScmeUCmPPxEn2VFRha6iAtbm3/lu2ImHx8yBxj5pQDai
         K/agvf/pU3frrfJ805g7efeUsFfEHxVKPhV3plbAGO9AzRZABJN/36h6B8unZihIlTzy
         ckeovW2Xj11mGB6Oy8uBp8llSbfdUYqqIjIeSez0+tx7/y89kNGPEKe6alVRDNboXUrW
         HAoDyBiukUzZuVSiHdC8KpuCEtPjXlO7weykJOQ1cXokmEjS3zlkC+xQv9ewAlTF1cIv
         jWtkf4zbtfOnUSqT4itBA1jOuTVvRe7UB1pu+aGEudN2bx69RWQtZsow59DaEE8U6dbt
         N88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783365662; x=1783970462;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Va6D3P5xYft1yzK5q2p21jfKRtd4zXStfUbyiE1/8Ew=;
        b=UClMMfT8nhj9fbf1/CIhz0vsZm3LOw+Zx9/re3ooZ0VY0hpEIg9WjKw21YwwRVAhPH
         slReHzPIx6LgfhzMcRQgpZ7ptItVBvjQ9mtCT/so1EJTtVNMwHYMixW6dbdKJy8OfvB6
         FzmhNhoJrPYQdc1kMFnRmqVN/+4cIhuZU0XYXKsvpzRgh7xD+qUZLW9Bi2GZxMLEl7oO
         F/YYRjsnl3iCtHBgbbA6oYWaTsRzM8Z1L0D1mIrbRWjvCtogZwt6lpZ5RtWkD1ig+hSf
         6/jpDAIXkOq1ZBneQi2TGwBhWsGHQBmrqbLJQ50ay1sS8ouW8rvtOE8hTB7D/gZ7jw1b
         K03g==
X-Forwarded-Encrypted: i=1; AHgh+RrxOMwR/+aVPleFbNI6UEqesr9QD01Wy7KmvEI8yhrHScFVmO9o6HgSNdq+/nE0HX1JJlx0DsPzhXyfIsGSPOTahC+lzZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuUy7RxcnUKGdqzOHMsInH3xDYIesy+D6wH4LFTndP8z4a/KzY
	PT8MjNv94nD//T4UheaQNm+3y3PzrlOSvdhUt0aUrUpIggfzhiMLFH4bFXjfRNpEGiQjI9w6DhU
	L0hc38uBcfWat5/PbUB5KoT06zw6kMVbXxKoHBmsk
X-Gm-Gg: AfdE7cljF/obXMwWXU+82rITIdE0yxzt4fBAQytJHuVDVDn1CKl61J1L3awi8q9VRVj
	TT7Svjrz50ovPnnsUN3oLHcHyMV+k5in0V9Vq25ZYc5V27COpA1rJ51vCwOsd9WwKLhEtVki65v
	iJgDyEMs4P6v7GHspnA6ok5hoHdqxm+PcJjd8mtmdYYG+XYHWs4KteQ3n/PrI3mr3wktqmwCms3
	FnSu4ZK1pL4JADp0zqDdNEIJAayTvVD/enCMnx4VEliMhxBGDvPdlx5/fQFLx3lRbWtxaCj
X-Received: by 2002:a05:6a00:b51:b0:845:62ce:d5ae with SMTP id
 d2e1a72fcca58-84826cd3e72mr1761763b3a.18.1783365662496; Mon, 06 Jul 2026
 12:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706135644.326006-1-daniel@iogearbox.net> <CAHC9VhQbqxJFBX+3-JiHR7+QqgWsiAAak7J4-q3QykdGqB7g+g@mail.gmail.com>
 <35678f78-2068-4c2a-a1aa-19abf007067a@iogearbox.net>
In-Reply-To: <35678f78-2068-4c2a-a1aa-19abf007067a@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 6 Jul 2026 15:20:50 -0400
X-Gm-Features: AVVi8CdYmkp-jFjuMNXzFwDyD_5UdbfESzf1mAJABSftWGoBgMOWIZTCA_ajHL0
Message-ID: <CAHC9VhRmhwCzJRgw+QikBcXFWB0ju1gYvi8h4K3=fARf-sO34w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/9] Verify BPF signed loader at load time
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, kpsingh@kernel.org, James.Bottomley@hansenpartnership.com, 
	bboscaccy@linux.microsoft.com, memxor@gmail.com, 
	torvalds@linux-foundation.org, a.s.protopopov@gmail.com, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 1:47=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
> On 7/6/26 7:13 PM, Paul Moore wrote:
> > On Mon, Jul 6, 2026 at 9:56=E2=80=AFAM Daniel Borkmann <daniel@iogearbo=
x.net> wrote:
> >>
> >> The BPF signing scheme signs a light skeleton's loader program and let=
s
> >> the loader vouch for everything else: bpftool bakes the SHA256 of the
> >> metadata map into the loader's instructions, signs the instructions, a=
nd
> >> the loader compares the (frozen, exclusive) map against that hash from
> >> within BPF once it runs. The construction is sound as a trusted hash
> >> chain, but the kernel itself never attests the metadata, and that spli=
t
> >> has been the recurring objection from the LSM / integrity side since t=
he
> >> scheme was proposed.
> >>
> >> This proposal closes both gaps by having the kernel verify the metadat=
a
> >> at BPF_PROG_LOAD time, before the LSM admission hook and before the
> >> verifier, /without/ growing the UAPI. A signed loader binds its metada=
ta
> >> map(s) through the existing fd_array/fd_array_cnt, and exclusive maps
> >> are already bound to the loader's digest via excl_prog_hash. When a
> >> signature is present, the kernel collects the exclusive maps from the
> >> fd_array and appends their frozen contents to the instructions before
> >> PKCS#7 verification, so the signature covers ...
> >>
> >>      insns || metadata_0 || metadata_1 || [...]
> >>
> >> ... in fd_array order. The in-loader hash check is dropped from the
> >> gen_loader entirely: generated loaders carry no verification logic
> >> anymore, and signing or verifying a skeleton becomes an ordinary CMS
> >> operation over bytes that sit verbatim in the skeleton, reproducible
> >> offline. A signed program is either BPF_SIG_UNSIGNED or BPF_SIG_VERIFI=
ED
> >> with nothing in between.
> >>
> >> There is no new UAPI, we now have a single signature scheme, no LSM
> >> code reaching into BPF internals, no new LSM hook, and unsigned loads
> >> are completely unaffected. It is also less complex since the loader
> >> does not need to deal with BTF, an extra kfunc, etc, as proposed in
> >> an earlier series [0]. Tested against full BPF CI which came back
> >> green. For more details and examples, see the documentation patch in
> >> this series.
> >>
> >>    [0] https://lore.kernel.org/bpf/20260522023234.3778588-1-kpsingh@ke=
rnel.org/
> >>
> >> v3 -> v4:
> >>    - Fix upper limit in MAX_FD_ARRAY_CNT (Anton)
> >>    - Reject !fd_array && attr->fd_array_cnt (Anton)
> >>    - Add bpftool patch wrt ignored return value of EVP_Digest() (sashi=
ko)
> >>    - Fix setting of gen_loader_fixture_init (sashiko)
> >>    - Fix unused map_fd cleanup branch in selftest (bot+bpf-ci)
> >>    - Remove now unused map->excl member and adjust selftests
> >>    - Added more BPF signed_loader corner case selftest coverage
> >>    - Added Paul's Nack wrt bpf_prog_load LSM hook dispute
> >>    - Added patch 2 to move bigger allocations below fd_array
> >>      resolution (Paul)
> >
> > If you want to squash patch 2/9 and 3/9 together so that one can't
> > easily merge 3/9 without the vzalloc(program) relocation I'll gladly
> > drop my NACK on patch 3/9.
>
> Okay, I can do that and send a v5.

Great, thanks.

> Btw, I saw one sashiko complaint
> about the security_bpf_prog_load() internally not needing the:
>
>    [...]
>          if (unlikely(rc))
>                  security_bpf_prog_free(prog);
>    [...]
>
> since the security_bpf_prog_free() is already called via the regular
> teardown path now. While there are no in-tree LSM users that are
> affected by this, I'll include this as well into the squashed patch,
> so its really only called once and not twice.

I'd prefer to handle it like it was handled in commit 868d43cf8f97
("bpf: Fix security_bpf_prog_load() error handling").  Since
security_bpf_prog_load() acts not only as an access control point, but
potentially an allocation function as well, I think it is more
consistent in the error case to have the hook do whatever cleanup is
necessary before returning to the caller.

--=20
paul-moore.com
