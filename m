Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAEA1A0732
	for <linux-security-module@vger.kernel.org>; Tue, 13 Aug 2024 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564593; cv=none; b=kh9gI4qHTHird3rfLyGiBMe+Yf9gBjCpf9oRMcP5EtsEk6QiS0CnattrYLwelXWIRAMQPdNO69GaiV+otOXhB4TOSJu74zwdrIUCCqyv61mgtVIrq2DojKogfTgZ0/mS7LFWoO65x+RFVeOBOYnMQIrZFyLR3xDr2R0ebJYcy6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564593; c=relaxed/simple;
	bh=3zW0n2w2QVfloPYCYYl/UF5OwhbG9EcTRphaq9+k7jE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aR68cVgJp9eCcuuaW8/4y3cs2yX88pc+Nj5NOGWHB3R5dA/mogXN8tXHqmPPtXY1MzYS3mucbdb3O0DHHHWHJp34meZgYgkSwQYTbGmzm7RePBUpN671nPx8jlS9durepJ5fx47H2Z7BzbEBZbXypwvj+Bd2KbRei6Qvuj/zPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjvfWiDv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjvfWiDv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F3AC4AF16
	for <linux-security-module@vger.kernel.org>; Tue, 13 Aug 2024 15:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723564592;
	bh=3zW0n2w2QVfloPYCYYl/UF5OwhbG9EcTRphaq9+k7jE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DjvfWiDvfABLpLpzbIjVlpxgRJdvhHxD+NKu9G/tf1CjEj7TylwPMZcZbRjzRxiwr
	 EccakfHJ434ur7XSEbQc9zvewTEq02zwo05kmokMe3IOjrApW2jt1Ur4Zm2iSjieYN
	 yZjlXlb+fjtrO8RHm4DgozrMS/1DH7IM7SgPJuBowA9v0WHo15SSuDuRhFed1zs6Ki
	 KNlRhqOdPZrsOtzCcsq/kA9adA4pa/PSo6IHqhS+6/aX88odCDkSgfmIglZVGWncqa
	 wO6N//3dXgyJ+XlDP7YmOOiMKVo8OJvE0d1BYTzvzSckfXtfckIuHm8ADZJ0LBzOpY
	 +eEKegQ9wVWCA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135eso7079a12.0
        for <linux-security-module@vger.kernel.org>; Tue, 13 Aug 2024 08:56:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjmjQzji8xSb12mtkw36qn5NNHWbV9SUUhyutjr9HEn8HRW1xbSNlCJIpaHg+bLQL9yPHoehOjvY7DVIDgOctKYu5chzpQRToTE0DHIqN1lCNzQKYQ
X-Gm-Message-State: AOJu0Yw7CJcFokYMzUrMqcn0zI912sad4ND++sCXhC0uPHMzgUDs3wcS
	ep2WOcWPSRVdPgL7yjDJfgvoHOMIC4gvCi+wGi9WJ+OHmlLooKZkYNi/QwNxd4Z57MMCAYPBkiS
	Spbp9Ha/SE56ZBwcC0JCTAvnc3CWl/wZ7ZB4+
X-Google-Smtp-Source: AGHT+IEoccaNChcOKrH4yV7UVrRWGO1c3dtiERqart7IKHJrf1vUXhXn/JNnmMB1oIBZwRAc6N4ouC4NWBr5UlZtj+4=
X-Received: by 2002:a05:6402:354c:b0:57d:4409:4f48 with SMTP id
 4fb4d7f45d1cf-5bd462178a9mr3149592a12.15.1723564591218; Tue, 13 Aug 2024
 08:56:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
 <873b04da-7a1e-47b9-9cfd-81db5d76644d@roeck-us.net> <CAHC9VhTd0MKVXsZ7J_b_Mmr2vP+RMJtxzfsgpH1rZ_hoHY1D3A@mail.gmail.com>
 <779dfb7f-d690-432e-8461-b26935974ac6@roeck-us.net> <0673d2b2-ad78-46f4-93b2-73ea3acd70f7@roeck-us.net>
 <CACYkzJ63DRLtDy6DAsGhz8_mM1pUSaC-DjbCtTBtEMP0c-=yRg@mail.gmail.com>
 <d9fc949a-6945-4c41-83de-c3717d536c15@roeck-us.net> <CAHC9VhRGt-b8PmtR-hZwOWB1zfmuhfftoppjacqrjq60tm0mag@mail.gmail.com>
 <8061553f-6bfc-4ee6-a8f1-e3741cf5ae6c@roeck-us.net> <CAHC9VhSKzxknTgKQu6ODoyxhc3skcjh_h11wSQrEvWb_vP5Ziw@mail.gmail.com>
 <CACYkzJ6NuGQchRaj-QD_XzQWNT8c3zb0ZEBXWjzjAckQdNDCWw@mail.gmail.com>
 <CAHC9VhQjCHBii=CwMMnbs0hiiN-Dy49S+3gpDvaXp-YQyEHTGw@mail.gmail.com>
 <CACYkzJ7vC7OJWdgm6LbOL82eO=27cn7Gh8i6-HOp_A94-SU-gA@mail.gmail.com>
 <CAHC9VhQPHsqnNd2S_jDbWC3LcmXDG1EoaU_Cat8RoxJv3U=_Tg@mail.gmail.com>
 <CACYkzJ5J8K2D8xqT+CCrbvp57P=GbCB+XYXkAaKXojsFhuaWEw@mail.gmail.com> <b3c04f8a-b7e9-4dc7-849e-aeaed508b8cf@roeck-us.net>
In-Reply-To: <b3c04f8a-b7e9-4dc7-849e-aeaed508b8cf@roeck-us.net>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 13 Aug 2024 17:56:20 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4eZWh2R_ZoeiNLLKFARWJOWo7Hkdp015fHEnmYLJaHGQ@mail.gmail.com>
Message-ID: <CACYkzJ4eZWh2R_ZoeiNLLKFARWJOWo7Hkdp015fHEnmYLJaHGQ@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: Guenter Roeck <linux@roeck-us.net>
Cc: Paul Moore <paul@paul-moore.com>, Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org, ink@jurassic.park.msu.ru, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 6:08=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 8/12/24 15:02, KP Singh wrote:
> > On Mon, Aug 12, 2024 at 11:33=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> >>
> >> On Mon, Aug 12, 2024 at 5:14=E2=80=AFPM KP Singh <kpsingh@kernel.org> =
wrote:
> >>> On Mon, Aug 12, 2024 at 9:33=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> >>>> On Mon, Aug 12, 2024 at 1:12=E2=80=AFPM KP Singh <kpsingh@kernel.org=
> wrote:
> >>>>>
> >>>>> JFYI, I synced with Guenter and all arch seem to pass and alpha doe=
s
> >>>>> not work due to a reason that I am unable to debug. I will try doin=
g
> >>>>> more debugging but I will need more alpha help here (Added the
> >>>>> maintainers to this thread).
> >>>>
> >>>> Thanks for the update; I was hoping that we might have a resolution
> >>>> for the Alpha failure by now but it doesn't look like we're that
> >>>> lucky.  Hopefully the Alpha devs will be able to help resolve this
> >>>> without too much trouble.
> >>>>
> >>>> Unfortunately, this does mean that I'm going to drop the static call
> >>>> patches from the lsm/dev branch so that we can continue merging othe=
r
> >>>> things.  Of course this doesn't mean the static call patches can't
> >>>> come back in later during this dev cycle once everything is solved i=
f
> >>>> there is still time, and worst case there is always the next dev
> >>>> cycle.
> >>>>
> >>>
> >>> Do we really want to drop them for alpha? I would rather disable
> >>> CONFIG_SECURITY for alpha and if people really care for alpha we can
> >>> enable it. Alpha folks, what do you think?
> >>
> >> Seriously?  I realize Alpha is an older, lesser used arch, but it is
> >> still a supported arch and we are not going to cause a regression for
> >> the sake of a new feature.  As I mentioned earlier, once the problem
> >> is resolved we can bring the patchset back into lsm/dev; if it gets
> >> resolved soon enough we can even do it during this dev cycle.
> >>
> >
> > Okay, more data for the alpha folks, when I moved trap_init() before
> > early_security_init() everything seemed to work, I think we might need
> > to call trap_init() from setup_arch and this would fix the issue. As
> > to why? I don't know :)
> >
> > Would alpha folks be okay with this patch:
> >
> > kpsingh@kpsingh:~/projects/linux$ git diff
> > diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
> > index bebdffafaee8..53909c1be4cf 100644
> > --- a/arch/alpha/kernel/setup.c
> > +++ b/arch/alpha/kernel/setup.c
> > @@ -657,6 +657,7 @@ setup_arch(char **cmdline_p)
> >          setup_smp();
> >   #endif
> >          paging_init();
> > +       trap_init();
> >   }
> >
> >
> > and provide me some reason as to why this works, it would be great for
> > a patch description
> >
>
> Your code triggers a trap (do_entUna, unaligned access) which isn't handl=
ed unless
> trap_init() has been called before.
>
> Reason is that static_calls_table is not 8-byte aligned, causing the unal=
igned
> access in:
>
> static void __init lsm_static_call_init(struct security_hook_list *hl)
> {
>          struct lsm_static_call *scall =3D hl->scalls;
>          int i;
>
>          for (i =3D 0; i < MAX_LSM_COUNT; i++) {
>                  /* Update the first static call that is not used yet */
>                  if (!scall->hl) {                                       =
       <-- here
>                          __static_call_update(scall->key, scall->trampoli=
ne,
>                                               hl->hook.lsm_func_addr);
>                          scall->hl =3D hl;
>                          static_branch_enable(scall->active);
>                          return;
>                  }
>                  scall++;
>          }
>          panic("%s - Ran out of static slots.\n", __func__);
> }
>
> A somewhat primitive alternate fix is:
>
> diff --git a/security/security.c b/security/security.c
> index aa059d0cfc29..dea9736b2014 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -156,7 +156,7 @@ static __initdata struct lsm_info *exclusive;
>    * and a trampoline (STATIC_CALL_TRAMP) which are used to call
>    * __static_call_update when updating the static call.
>    */
> -struct lsm_static_calls_table static_calls_table __ro_after_init =3D {
> +struct lsm_static_calls_table static_calls_table __ro_after_init __attri=
bute__((aligned(8))) =3D {
>   #define INIT_LSM_STATIC_CALL(NUM, NAME)                                =
        \

I think it's worth making it aligned at 8 byte, a much simpler fix
than the arch change. Paul, I will rebase my series with these
patches, better descriptions and post them later today.

- KP

>          (struct lsm_static_call) {                                      =
\
>                  .key =3D &STATIC_CALL_KEY(LSM_STATIC_CALL(NAME, NUM)),  =
  \
>
> Guenter
>
