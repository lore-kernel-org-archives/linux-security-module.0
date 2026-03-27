Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DF52DC344
	for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774635906; cv=none; b=NZZCQIv2hryDQ46qW9dXobtNoWMHGa5yGYkgaxJ/6gFpjUsZtfu3dgCCsXEV0OAhdgzCUg63ZhPc0Ql8FnD3+RCvTs4qnqO8vwW26T9Yurmf8XK6GK3L0mO7mMR007mAjJ86KKr6R9eoaDUTTt4XOwBDk9t1EFTRr9a0BsEpNV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774635906; c=relaxed/simple;
	bh=dei95JHy3V9OqufTCvi2OPSPgrsbZ+vC/ZWP6ltoW98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsK2UByrfOr2sWLiJVnL+3WMEAIG5zMsFzEr5Cp8TiwyLuYayLSjYaoZs/nRT+OxuUPp0EMv5VMlGcp6aESuJl74eqD/ptImHuUQJ5WGKlxpRdgXG0s0ng1PkxzE1dE4sCrrHkZdNDZ9rnWV37QgM10sBLr/+lo2skUyeQVwkeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJ8vhXgV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJ8vhXgV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0F5C2BCB1
	for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 18:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774635906;
	bh=dei95JHy3V9OqufTCvi2OPSPgrsbZ+vC/ZWP6ltoW98=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EJ8vhXgV7CuEZ15Rl7uyRDoCY6Pb9nZppDEl/1krGwNh78nnqOQKKPslqXUn2SvNp
	 B1EPLFnrYauFarDQ7uypzBfiz8GYe+oibA26Gkik2xwXuMDpXS6z6/3m0gv4znq5wc
	 4INq972Axx/dszGuyw60pFIB3d402TRXv3SvyLG6c8Yb+Q0O4VOybh43ySa0VGPoOo
	 I5WAC4LOfPaLv7jB/3oiCE5Dtdxpl6P6TtDIIHKyYpv9SrQsPrjnDwwHXP5q2nvSzJ
	 RoEHw9Lnz3PTJMj7d4sclX4SibOmy4ZC46grflvcro6Dq1+WK6tBxhShuf0qnMXH7J
	 9DT9D9ZjVe/ng==
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cfc2d1fdbfso207953085a.3
        for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 11:25:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdvs6oABEIxD0h7fwmyRwrA+xHnpVeJmtrQ7yFnE4zq9ZvGuJ2HZZ6+5GAc0hepo/lko1U/oFclzyUR2LRpbecp0F17eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ZQQfQQ6sNSgvJ+H9OOz8ciMXpsSGyyLH1vEUZgXbIihWeZ6d
	PpjM8mIKEaStlYPZ7O5VQ1KJ56o8OCjrBLgRklNuxAVWBNp7L9HR8c7PJMc22RP/Oi0BcnlQutZ
	WcUuWYGfNusoGVT8J/ZuO0irKx63Ak6o=
X-Received: by 2002:a05:6214:27cb:b0:89c:c84d:ea48 with SMTP id
 6a1803df08f44-89ce8f9f216mr47720546d6.59.1774635905152; Fri, 27 Mar 2026
 11:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326060655.2550595-1-bboscaccy@linux.microsoft.com>
 <20260326060655.2550595-5-bboscaccy@linux.microsoft.com> <CAPhsuW6P-K=nTPxBk0_Wd0E1wDCBqb=uUQzmzpEg2NJub=L+dg@mail.gmail.com>
 <871ph5f99z.fsf@microsoft.com>
In-Reply-To: <871ph5f99z.fsf@microsoft.com>
From: Song Liu <song@kernel.org>
Date: Fri, 27 Mar 2026 11:24:53 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6fWG8674+LOAACqb1LDAz17w-CxvwBaTf7JXQL6ip5Pg@mail.gmail.com>
X-Gm-Features: AQROBzAM1LwPFowF6Sd5vCudMZCHPwi-XqnORL1vLeyjvM0EI3RTiNiHhdeL39E
Message-ID: <CAPhsuW6fWG8674+LOAACqb1LDAz17w-CxvwBaTf7JXQL6ip5Pg@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] lsm: framework for BPF integrity verification
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andrew Morton <akpm@linux-foundation.org>, 
	James.Bottomley@hansenpartnership.com, dhowells@redhat.com, 
	Fan Wu <wufan@kernel.org>, Ryan Foster <foster.ryan.r@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 10:54=E2=80=AFAM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> Song Liu <song@kernel.org> writes:
>
> > On Wed, Mar 25, 2026 at 11:07=E2=80=AFPM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
> > [...]
> >> The first new callback, bpf_prog_load_integrity(), located within the
> >> security_bpf_prog_load() hook, is necessary to ensure that the integri=
ty
> >> verification callbacks are executed before any of the existing LSMs
> >> are executed via the bpf_prog_load() callback.  Reusing the existing
> >> bpf_prog_load() callback for integrity verification could result in LS=
Ms
> >> not having access to the integrity verification results when asked to
> >> authorize the BPF program load in the bpf_prog_load() callback.
> >>
> >> The new LSM hook, security_bpf_prog_load_post_integrity(), is intended
> >> to be called from within LSMs performing BPF program integrity
> >> verification.  It is used to report the verdict of the integrity
> >> verification to other LSMs enforcing access control policy on BPF
> >> program loads.  LSMs enforcing such access controls should register a
> >> bpf_prog_load_post_integrity() callback to receive integrity verdicts.
> >
> > bpf_prog_load_post_integrity() is weird. Some questions about it:
> >
> > 1. Is it possible to call it from other LSMs (not hornet)? Specifically=
, is it
> >    possible to call it from BPF LSM?
>
> There is nothing hornet exclusive about that security hook. If the BPF
> LSM folks wanted to use it they would probably need to implement a
> kfunc to invoke it.

Please also include the kfunc in v4.

Thanks,
Song
