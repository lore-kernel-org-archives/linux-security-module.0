Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E870189BBA
	for <linux-security-module@vger.kernel.org>; Thu,  1 Aug 2024 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511598; cv=none; b=hkTHtFPZgZLundL0mHce3YbBTugPMFuPySsbAtAkOIgQh5f5XZPytHHxMQZVUJw837TLKmbh4o8IQ40TfIteiRa07f/5KUu7RHNqrv7PLh/cUjfuMPd/cUdJqO6qWjHae3+EfjnEEHQnudVc93YJ0W0vUBoMT6/VEUrYsw15gU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511598; c=relaxed/simple;
	bh=YB7E9+6r7PMOi7Xp/YGD46NfB9XBz/LOjzQs4MkOHeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0smMPvYdcB/YhmDdYEjFWAeINUxMC8LAVphZ4mpHSNo56vyloD7G0XfcAsuCJVyE+77Di1lYm49G08wT7/9LcaccQ/QTmvf7he1cTVzlnhOXkKnXP4FBDvzrxckyj7o3VIK7yRudIeNKrNjitvV7qy3O/moaFux2GbKWQEFxJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCeERQC3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCeERQC3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CCEC4AF13
	for <linux-security-module@vger.kernel.org>; Thu,  1 Aug 2024 11:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722511597;
	bh=YB7E9+6r7PMOi7Xp/YGD46NfB9XBz/LOjzQs4MkOHeE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PCeERQC3wJoaegDNozfQcqTjfIJHQx5W8i4opEiuk1Uv/Pas97qB5FBLduVMlVoJS
	 3LyTErSYb75kCn3924v5h4AzEyovXjuXnAozQl6k5pjJwbgPCnCmiHTMvcZEbWt21Z
	 NavHHCVi2OsNRCVhzIoVf30djZzJ9AWvZj6Cpfy5yriGS8uNhHKH5ZrLVa01eYHZMb
	 IEWvQLCR3Sr3ck4Okt9tlom16UIKrNyqOrEdNEns1VPkvxI+PldGBwljeynVZCKWa4
	 gLvVuKicTwwGY2S8voz9VyHm9Op9ynNFGPt51i070RJiAVm5FjcU+y6pCdawRJg0Ju
	 Tz/C232ByzbCA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5b214865fecso5706931a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 01 Aug 2024 04:26:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5+cDEdd3OljJr6NtZs5FEbgz07aOano6MIN2YxBL7XhGCtAZbeg+yp8yjqf5Q3wv2UdhsFaSjgwCqne/JTKq2NZn61y6ihHKB6ip6L9XBlFMRG9Ey
X-Gm-Message-State: AOJu0YwhYr5e/u8KqAnKQn5BVE+Cs96PpKbqXEJbcHGyZYbE5Bk46bwJ
	h0F4Q5/GW7cM7IWwTc8d2Aszj9vgJ+1eoRDbgR62y5mVH64HOWzu98iJm9Ax912gzH4KIVPsRcx
	4/BTnDWsH18aUK6fcddKp8outixMsjF9YILU1
X-Google-Smtp-Source: AGHT+IE6eI090/VSwIKbss3Mkvx4/Yoy6N8fsdbd3CNDdWpYZYI6rsMa04kEYUcZMFbv4fjzECURghzGRAdAHNeq0z0=
X-Received: by 2002:a05:6402:5154:b0:5a2:2654:7fd1 with SMTP id
 4fb4d7f45d1cf-5b7008ac4bamr1080394a12.36.1722511596491; Thu, 01 Aug 2024
 04:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731213429.2244234-1-kpsingh@kernel.org> <CAHC9VhQEYutCiAMitEv0JY4PRY4tdLdqEy76qvY1xB5q8Y13mg@mail.gmail.com>
 <20240801083441.GL33588@noisy.programming.kicks-ass.net>
In-Reply-To: <20240801083441.GL33588@noisy.programming.kicks-ass.net>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 1 Aug 2024 13:26:25 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7JP86O9DD8EBG9aHiUeK1FZGz5LFbzRG-_x+9SHavhiQ@mail.gmail.com>
Message-ID: <CACYkzJ7JP86O9DD8EBG9aHiUeK1FZGz5LFbzRG-_x+9SHavhiQ@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Do jump_label_init before early_security_init
To: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Moore <paul@paul-moore.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 10:34=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Jul 31, 2024 at 09:15:04PM -0400, Paul Moore wrote:
> > On Wed, Jul 31, 2024 at 5:34=E2=80=AFPM KP Singh <kpsingh@kernel.org> w=
rote:
> > >
> > > LSM indirect calls being are now replaced by static calls, this requi=
res
> > > a jumpt_table_init before early_security_init where LSM hooks and the=
ir
> > > static calls and keys are initialized.
> > >
> > > Fixes: 2732ad5ecd5b ("lsm: replace indirect LSM hook calls with stati=
c calls")
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > ---
> > >  init/main.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Does this look okay, static call folks?
>
> Are we confused between jump_label/static_branch and static_call ?

Not confused, just rushed, from my side, we need both static_call_init
and jump_label_init() before early_security_init(). It fixes the error
for me but as you folks mentioned, we need to check with the arch
folks if this okay.

>
> > > diff --git a/init/main.c b/init/main.c
> > > index 206acdde51f5..5bd45af7a49e 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -922,6 +922,8 @@ void start_kernel(void)
> > >         boot_cpu_init();
> > >         page_address_init();
> > >         pr_notice("%s", linux_banner);
> > > +       /* LSM and command line parameters use static keys */
> > > +       jump_label_init();
> > >         early_security_init();
> > >         setup_arch(&command_line);
> > >         setup_boot_config();
> > > @@ -933,8 +935,6 @@ void start_kernel(void)
> > >         boot_cpu_hotplug_init();
> > >
> > >         pr_notice("Kernel command line: %s\n", saved_command_line);
> > > -       /* parameters may set static keys */
> > > -       jump_label_init();
> > >         parse_early_param();
> > >         after_dashes =3D parse_args("Booting kernel",
> > >                                   static_command_line, __start___para=
m,
> > > --
> > > 2.46.0.rc2.264.g509ed76dc8-goog
> >
> > --
> > paul-moore.com
