Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03022372B23
	for <linux-security-module@vger.kernel.org>; Thu, 16 Apr 2026 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776383274; cv=none; b=CR8/0OLQqhr08ogCJar4Cubq6G1qNIpeb1hBij7givJ4lSFGgSRKXazw4yZLfQtGmLj0njUhgLPFWlHIIpMVhJYdNdJgTEtZKfgIajI5vTbj6J1yr372spzQmstTWe9KQO56Fvu5xCEBLk7yS7RSjjVyiySEi6OVgasjROSX4fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776383274; c=relaxed/simple;
	bh=C5WAELTVBhjyFEhNaeXPis1p6w2t0pIcbw7WfXDAdoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6NqTQF2VKCAIerrWVKk8dbiyZRztHWVos/nLsqESBinRp2HBNId5F0YWu+jzZPwyLmd7mhamfd5kIxT0Vt5R5G9EWl4gBWa3ZnNinfEzmCXZd7jbVFdRI1OWsW/mJ5/IHnZp9k+uzZhmPpzlHhunGXjN+rykMRdZSMknlmyjB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zvvj0cVy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zvvj0cVy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5CFC2BCB8
	for <linux-security-module@vger.kernel.org>; Thu, 16 Apr 2026 23:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776383273;
	bh=C5WAELTVBhjyFEhNaeXPis1p6w2t0pIcbw7WfXDAdoU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zvvj0cVyQQ2wyzlLb4eaQt7rSG6HFVdmufSZfGIyXkPlP9bYZooQzVCqgx8+WRm5K
	 vf+jsJYhh7T3Cm1wk2ycg91u4HCYj6HGXU0LGtUEOJglDsNuc5xyh7ntSywXVPbztw
	 clQ9VKwIxEuWRedy5FPZsb8Ywb6yMudZFsdLPBSDglSooUGcKZw24ShDzcwK3yne0j
	 j5wfnWKuwo7ywRgyUmZz0Pd9RsgrVoxp6H6gDcsBa8/bRcRKIuQ1+DyvfabVKDIzYX
	 8zHGpXA4vD7gGtPLoRB9/iTk0dFMxOd1pg2XuN4SFY9Sd7MIB5CXc1Sp04GZjLGMOE
	 r2IeAElTMW/uA==
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8d583bfc415so13167885a.2
        for <linux-security-module@vger.kernel.org>; Thu, 16 Apr 2026 16:47:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8UbklF6qmrGxd7GDCgHnjpG11LUssJN2X8ueSvqa1S+EOSuXqiMp6tpDod/feCOTBs97boMrBFdbSZGbeJ6Ik5J/BX+X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvXC+ErE2Dpf5Lf9aFAhwuSLeTsU5ArnY42PbGFqyskFmBnAqa
	+hgxc2Mm67kkbAeYXJTlqtvi3W3jDQeNZ4ZB8SCGVNdHoGk344lNcvnb6ADbyr0DprHuOi9I16K
	Bia5PIBpuq6uzQ8P7qwtXPlvRnfDtoJ0=
X-Received: by 2002:a05:6214:590b:b0:89a:116b:e67d with SMTP id
 6a1803df08f44-8b02816d14cmr11472166d6.37.1776383272731; Thu, 16 Apr 2026
 16:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-9-utilityemal77@gmail.com> <CAPhsuW7zzXXd6-d86B-rpGr-wfSzmEoCYNKhTMP_pXnybtA27A@mail.gmail.com>
 <aeFaQXkKNHFeE-oC@suesslenovo>
In-Reply-To: <aeFaQXkKNHFeE-oC@suesslenovo>
From: Song Liu <song@kernel.org>
Date: Thu, 16 Apr 2026 16:47:40 -0700
X-Gmail-Original-Message-ID: <CAPhsuW648HdcCbXWMHaJ4uirPWq2WX3Ggx3AGMU6CGzhNYUREg@mail.gmail.com>
X-Gm-Features: AQROBzBjp2CZyNelxoIb8OGY5jbxiGMArE6FN8nqGrHbNb-DuxdjTnWhkFkE_iU
Message-ID: <CAPhsuW648HdcCbXWMHaJ4uirPWq2WX3Ggx3AGMU6CGzhNYUREg@mail.gmail.com>
Subject: Re: [RFC PATCH 08/20] bpf: Add Landlock ruleset map type
To: Justin Suess <utilityemal77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, paul@paul-moore.com, mic@digikod.net, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, 
	gnoack@google.com, jack@suse.cz, jmorris@namei.org, serge@hallyn.com, 
	yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	eddyz87@gmail.com, john.fastabend@gmail.com, sdf@fomichev.me, 
	skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 2:53=E2=80=AFPM Justin Suess <utilityemal77@gmail.c=
om> wrote:
[...]
> I don't think we can pass the FD number via a map, since the FD is
> process specific. And it needs to be done in a way where we can lookup
> the specific ruleset the FD points to safely.
>
> So we'd need some other way to load the ruleset from a file descriptor,
> either through a new userspace side BPF call or similar mechanism.
>
> Is there some other common pattern for FDs --> kptr I can follow?

I didn't find an exact example like this. There must be a way to achieve
this. In the worst case, we can add a kfunc for this.

> Basically the pattern I need is userspace must create the file
> descriptor, BPF converts that FD into a refcounted kernel object, and
> even if userspace closes the FD BPF needs to hold a reference on the
> underlying ruleset structure.
>
> (In this patch this was accomplished through the map_ops)
>
> Let me know what you think Song. I do understand the benefit of having a
> __kptr instead, the refcounting is all there, and it would allow storing
> rulesets in multiple map types. (and one less map type to maintain).

A new type of map for each FD referenced kernel type is non-starter.
It is impossible to add UAPI for a specific use case.

Thanks,
Song

> Micka=C3=ABl, do you have any thoughts on this? I have v2 basically ready=
,
> although it uses the BPF_MAP_TYPE_LANDLOCK_RULESET it changes a lot on
> the Landlock side.
