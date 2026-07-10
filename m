Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899B83A9D90
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jul 2026 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783716193; cv=pass; b=Nf2pwBc2AyjUTUvRoXMg66QEpIuhSu21m/YJaX/i3ajBLrEEiUoZByu3WoXlSEiFU7QCsmIVBIdCBEw9KAemmjTZf4WCFDRtTqaBWLyma8ak5uakPb7QzniZ5Ab2LnfpMhruw9lREEuyy75OVhvTxWSjlEXSheC8Gm0fbfBDZQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783716193; c=relaxed/simple;
	bh=AW4FkCD3SUXD8ZrW0GDFymuv20MYfPDUDhkF/gfjkRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0qYL9p1LtqvpviPKnF1H807Laj1+ea66l0erSWSdDght6Yb82/hgFo5k5ya8odKiYn8npYjchPziFG6PEkLZJQRYHnnS/U033Wfisc+D/Kuosq4bkbGANJYidm9if051ifRHdHETZJaytMTGYbav+RZlMF0Cj+GB54DN3k8Gjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f8RZNMRI; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f8RZNMRI"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso16495525ad.3
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jul 2026 13:43:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783716190; cv=none;
        d=google.com; s=arc-20260327;
        b=Q9q3STUND2KXdVfnMH5AcwHllF8A5UoAwpFr4kGZhaaAzkFQJTgE0Jl82n85FXWonU
         avr7BKzuNy2XE7Lzrzv445Wy8JAL+7DrHdvReSUoM5MVP1S7kwegU7nQUdh/P8jR62L9
         VzQRJ/san7AwK0XCtPDVSXznH52GIA2yMSYqihaoheDFSrrLnhhXIZLUiINN0HDd7eom
         LMUiwTnbg68lOLG/miwcuUvi+Brd9+MOnNzlVhbax5OjSq/W7XB3N7y88xvt62XZErBR
         Nu2njxlfE7RZC0f9hPwHaxMl2yMAfmOyomJKZ3qDDFp+5ZWbz9S0gHe6a3M29d6a3NfT
         A5hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rij+tAThPG/Dx8x9D29mBGM0V6OzQVOOyrCEOYUJZtQ=;
        fh=Q0OD+EpTx5JV6fwKxscf3mnCw5gkGLDMM2OtzB522h4=;
        b=mta3n56nh0FUeB2dgNhJ0Fcop+vDlkAet4e9xRKBUhldn7sKCu/usLD5fmuzG1/l0N
         PH9qEtkI3DB2KuYq5p9WzDz7MRCi65I74rqnxDqr2Byii3vm4VQC8StdC0Ne6RSlrCWi
         meFmTZ6pZE/Av+EsCLeEe0QQ/Cle1K5RHTj/HXm9Tl2XQXn0YVNhvZdHlh2Np8SBxt7T
         FcmJub3o/X9uaR4Kq8ghprvEGuQgLQ+emZXjvSrgxLU74Gt9ofC+Rt/7U0d9AvO1yrS/
         K6RTXzxfWfRRZdGY/2iTvMPDHG2PNRJYYhFhhrk152b968s5ysHCONuZGM06BTHg1hyi
         bfIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783716190; x=1784320990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rij+tAThPG/Dx8x9D29mBGM0V6OzQVOOyrCEOYUJZtQ=;
        b=f8RZNMRIwV8cXYXWMl7FZYx0azi9koz5gL8rCTdmi1yEDtGU3a48yowexrdENIYP80
         djFfJ1hBVHR/TlTdJT3yE7WTkhEQlhYtIN8LIBZJqXP4dLaLksWCKarTEKnp5nzEEvxU
         58NcAFJvwIVNl5imaBIZIYXPxM2swqfxDuhe4Es+YTX8q/LR2fkfcRcxQ1VMEAcadX8G
         lxYU7423gmaK/tixP+DOxEMGQjU/HZecdKhXkrTK9qlMagerGNzQhZgv2T0prCrGxXey
         D9kn6+/M9NzUZins1wWGTlmyVR1Si2F6bkaLFWNqyg63+LQLI5cHXJvRxypfQClwhwdd
         XRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783716190; x=1784320990;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rij+tAThPG/Dx8x9D29mBGM0V6OzQVOOyrCEOYUJZtQ=;
        b=BsyL9VYqi++DKkeKCXcJa93Ej0egYU3Ijf1CP2TlEp9r2h7AaiplWStuKRutT0KP8u
         18S5yvsvUd+r9ThMDGf2ybeq8p8+90N2RevUKIYMAQq0LdGcMYL1GScrhOAt39dv/Ciw
         ynsp+xgAm8xN0mE4Qab4xL0mtKfKChsJVQzKjNzXN5ZCUEjYPYEzzCBy1ALDJrkxKhja
         CzD/lSfYYiLY+Kt91X/o1Ox5/gPdlTiZ24oZY4/R0dXHtjUp1ZnuqFEp7Cku9zEFmYfD
         +kcbhPvntJhYcjGzy7LPVJl1o7yR+42IVFfgVQQP6cnADyJXGq8kcld2kTjn7OWfw0DM
         CFOQ==
X-Forwarded-Encrypted: i=1; AHgh+RotU0xLHj/rVo9z+m4S6GKJ/s1tsVO2Z6v/KN4x94jKMhph3WWgRZ5LB+dEGhrqbyR7Z7Mbm5t85be44i3jwsm6B43X0cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUaYwAWsX4RGQ/kOwmHKkG1BtaOCG9Ulbjqn9gDcS49QpaUnuH
	HZLkrFjZ2l9YI7FCx7vwQFSrHXKvEKsunhQkpYHQ/qwWep/nYnGsud4RVEgOPzjNlkOTvt6BBnr
	lqnIG3iIC00GcLTR3SHc8PlgPco30lC2e/cAjxKfR
X-Gm-Gg: AfdE7cnmtu/WJHlsFFi14Nwz3+pQOzI2B7hwZqYRvBaAM/lWC5cH7FU3BYgVF09kB4N
	PtSu7F6YDwyr8P6tJcsu1aqLG66B5zrSEBf5xsOZ54Drh0lTT/uj6/XXCdid4enQCK10TO0EQO+
	rNn4vQLvtgWtfE2fNJ+oQX4ix/KaYuqQ/EXp/nFcD93RdNmMx5HgV2LIpmbvlvpuqwfFDBgQonR
	cDyzIBuG5erCORWd25lGc9mH3wdL+4rMZXtcm+NU0CBnGvKiP1JMzT8HtWbhOjjxie9IjLf
X-Received: by 2002:a17:903:94e:b0:2ca:ecf6:9119 with SMTP id
 d9443c01a7336-2ce9e7a508fmr6594825ad.5.1783716190473; Fri, 10 Jul 2026
 13:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3d4fe99cd1665a1be0b36636aeeaf4ab@paul-moore.com>
 <20260709.kaemaiTia6Li@digikod.net> <CAHC9VhSVQ0MLwU=C90FmohAThwaQj-mfB7L03fvkB5A0-J2jCg@mail.gmail.com>
 <20260709.paitheut7Ief@digikod.net>
In-Reply-To: <20260709.paitheut7Ief@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Jul 2026 16:42:58 -0400
X-Gm-Features: AVVi8CfYFlCh845UyHEVb8Qr54KnQveNcsFxDbygGSFQDOXSJFwUEPgwYvIp3eE
Message-ID: <CAHC9VhSrYUWkt0_kbOdEuoeKdj+oSaFcY0Fg8t2SuUwH-=MJXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] security: add LSM blob and hooks for namespaces
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Daniel Durning <danieldurning.work@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Justin Suess <utilityemal77@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 11:58=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Thu, Jul 09, 2026 at 09:03:58AM -0400, Paul Moore wrote:
> > On Thu, Jul 9, 2026 at 5:12=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@di=
gikod.net> wrote:
> > > On Wed, Jul 08, 2026 at 11:22:17PM -0400, Paul Moore wrote:
> > > > On May 27, 2026 =3D?UTF-8?q?Micka=3DC3=3DABl=3D20Sala=3DC3=3DBCn?=
=3D <mic@digikod.net> wrote:

...

> > I'm aware of the new hook guidance, I was the one who documented it :)
>
> I know.  I guess that means you're ok with that?

Yes.

Just a heads-up, and some of this depends on timing, but as we've got
multiple patchsets (there is a SELinux patchset that depends on these
hooks) I'll want to take this hook additions via the LSM tree.  I can
take the associated Landlock patches too if you like, or you base the
Landlock tree off the LSM branch; no worries either way, we can sort
out the details once the patchset is ready for merging.

--=20
paul-moore.com
