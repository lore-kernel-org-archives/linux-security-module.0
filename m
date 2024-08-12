Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7152E16A92E
	for <linux-security-module@vger.kernel.org>; Mon, 12 Aug 2024 22:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723500175; cv=none; b=MgkIvH3X7woNwI1reycLfpLMNPQtiXoUMymLe476Foz5lKm/J87xZi7Q+apJreuwQrh3SAVcxB+x6Xpa75yZM8sFs6gTbxwzh3YClXbX2LLI1oYlSYlEllUqJi9X+wVn4XjlyQX5hdHgUO5ceiJunKCKmAUxq7kpz3+IGpBngFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723500175; c=relaxed/simple;
	bh=O2akboDJIEh8Nd3HZXbrNHkmzz+22fYpF1PWKSyWaQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OC+ObOzi96B7w0vIF42/idqZpckEL9BiuP1ykidlfTq9vlQWUdgzCzXEK+3Lr5+tjwrCuUaihGgfg8+pRyDSdJ1Rf37teVHhNZOprcHZZRPdwfnRQBrsgJc0FGvtj841y3Gf7PtMwPRBe0a9ubmedjn0T+KkFmwfp+PZ3EFC5ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2OqgoTE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2OqgoTE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18534C4AF13
	for <linux-security-module@vger.kernel.org>; Mon, 12 Aug 2024 22:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723500175;
	bh=O2akboDJIEh8Nd3HZXbrNHkmzz+22fYpF1PWKSyWaQc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l2OqgoTEKp4NmGqFi458SRI4gluNCiXgM5dmYMINAdYh45ZPFYi2YPTg77/DXLfOb
	 TzMngkSl+ud3CEk45VUZ4O5r0dqDJ7LtURp5tFfT9x1rx89OWI9hTx8AUD9E+kBZJU
	 8Dw9oiD6NZ0RGGoIKYvjqUXqs6LhhzxkR7tCNBT9M5I5WR98UAkQBO6LmRhghCHgWp
	 ZFp0O0gSSu5tT0cGpUL9EA1WDm4Ip8ZFJkut+EaIlaDDR60NpSJIxmokx3ySWZr7uq
	 vDIGYLQylAENq5wWntWBsi5jLQ9a/1dkkUflnmseHAt9vOE3G3s357s3vf1b+8QZrZ
	 vbru6yR6etjkw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5b9d48d1456so1133422a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 12 Aug 2024 15:02:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhQOArSwzqLyK4+BqW3zxiDV+itp2ylNtQyIaN2mN76HdXYCArwjmlsTJfG/cY6xRPkJFVwundIO6btpvlC5YvHi+bAsskgFxgZJXosicwulLQNlK7
X-Gm-Message-State: AOJu0YwqzzGBfUprx1snKLLZlbLSVzPT9MeBSCJA26NF579xvcNkSNiR
	gD8z7evZ4r96hOv9FfEuhUHoILFgNndakUwbOV86baXTiuPDc/EJbvcaQGaDgLAfO3UUppkfn1U
	NxYDWQzKoKVYRV1K4lXYTOq67J4XIx9j5KdBZ
X-Google-Smtp-Source: AGHT+IGEzzK8lUbL2BKdbvhUGvMXkJafhinn84c+jnXZlrrZX4BZDnaa33VL18lOtCdmW7PtFGbbrSPRhGW/DlgOw44=
X-Received: by 2002:a05:6402:190e:b0:58b:bb69:763e with SMTP id
 4fb4d7f45d1cf-5bd4619735amr970724a12.7.1723500173628; Mon, 12 Aug 2024
 15:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
 <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
 <CAHC9VhQ1JOJD6Eqvcn98UanH5e+s6wJ4qwWEdym4_ycm+vfxmQ@mail.gmail.com>
 <873b04da-7a1e-47b9-9cfd-81db5d76644d@roeck-us.net> <CAHC9VhTd0MKVXsZ7J_b_Mmr2vP+RMJtxzfsgpH1rZ_hoHY1D3A@mail.gmail.com>
 <779dfb7f-d690-432e-8461-b26935974ac6@roeck-us.net> <0673d2b2-ad78-46f4-93b2-73ea3acd70f7@roeck-us.net>
 <CACYkzJ63DRLtDy6DAsGhz8_mM1pUSaC-DjbCtTBtEMP0c-=yRg@mail.gmail.com>
 <d9fc949a-6945-4c41-83de-c3717d536c15@roeck-us.net> <CAHC9VhRGt-b8PmtR-hZwOWB1zfmuhfftoppjacqrjq60tm0mag@mail.gmail.com>
 <8061553f-6bfc-4ee6-a8f1-e3741cf5ae6c@roeck-us.net> <CAHC9VhSKzxknTgKQu6ODoyxhc3skcjh_h11wSQrEvWb_vP5Ziw@mail.gmail.com>
 <CACYkzJ6NuGQchRaj-QD_XzQWNT8c3zb0ZEBXWjzjAckQdNDCWw@mail.gmail.com>
 <CAHC9VhQjCHBii=CwMMnbs0hiiN-Dy49S+3gpDvaXp-YQyEHTGw@mail.gmail.com>
 <CACYkzJ7vC7OJWdgm6LbOL82eO=27cn7Gh8i6-HOp_A94-SU-gA@mail.gmail.com> <CAHC9VhQPHsqnNd2S_jDbWC3LcmXDG1EoaU_Cat8RoxJv3U=_Tg@mail.gmail.com>
In-Reply-To: <CAHC9VhQPHsqnNd2S_jDbWC3LcmXDG1EoaU_Cat8RoxJv3U=_Tg@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 13 Aug 2024 00:02:42 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5J8K2D8xqT+CCrbvp57P=GbCB+XYXkAaKXojsFhuaWEw@mail.gmail.com>
Message-ID: <CACYkzJ5J8K2D8xqT+CCrbvp57P=GbCB+XYXkAaKXojsFhuaWEw@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: Paul Moore <paul@paul-moore.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org, ink@jurassic.park.msu.ru, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 11:33=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Mon, Aug 12, 2024 at 5:14=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> > On Mon, Aug 12, 2024 at 9:33=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Mon, Aug 12, 2024 at 1:12=E2=80=AFPM KP Singh <kpsingh@kernel.org>=
 wrote:
> > > >
> > > > JFYI, I synced with Guenter and all arch seem to pass and alpha doe=
s
> > > > not work due to a reason that I am unable to debug. I will try doin=
g
> > > > more debugging but I will need more alpha help here (Added the
> > > > maintainers to this thread).
> > >
> > > Thanks for the update; I was hoping that we might have a resolution
> > > for the Alpha failure by now but it doesn't look like we're that
> > > lucky.  Hopefully the Alpha devs will be able to help resolve this
> > > without too much trouble.
> > >
> > > Unfortunately, this does mean that I'm going to drop the static call
> > > patches from the lsm/dev branch so that we can continue merging other
> > > things.  Of course this doesn't mean the static call patches can't
> > > come back in later during this dev cycle once everything is solved if
> > > there is still time, and worst case there is always the next dev
> > > cycle.
> > >
> >
> > Do we really want to drop them for alpha? I would rather disable
> > CONFIG_SECURITY for alpha and if people really care for alpha we can
> > enable it. Alpha folks, what do you think?
>
> Seriously?  I realize Alpha is an older, lesser used arch, but it is
> still a supported arch and we are not going to cause a regression for
> the sake of a new feature.  As I mentioned earlier, once the problem
> is resolved we can bring the patchset back into lsm/dev; if it gets
> resolved soon enough we can even do it during this dev cycle.
>

Okay, more data for the alpha folks, when I moved trap_init() before
early_security_init() everything seemed to work, I think we might need
to call trap_init() from setup_arch and this would fix the issue. As
to why? I don't know :)

Would alpha folks be okay with this patch:

kpsingh@kpsingh:~/projects/linux$ git diff
diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index bebdffafaee8..53909c1be4cf 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -657,6 +657,7 @@ setup_arch(char **cmdline_p)
        setup_smp();
 #endif
        paging_init();
+       trap_init();
 }


and provide me some reason as to why this works, it would be great for
a patch description

- KP





> --
> paul-moore.com
