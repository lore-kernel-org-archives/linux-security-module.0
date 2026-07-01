Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0A134678C
	for <linux-security-module@vger.kernel.org>; Wed,  1 Jul 2026 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931102; cv=pass; b=fBIFaA1v/YYiSd0MCAgW3iNOb5h6w50N24b8eXLqbCdT8Q7FF3MJV35Ky+VWnvaIzYmhzNtVqL1hONpJVcu6pEfVcQmTW/jR8vvT6elKDug39QDbh7AzkySo0LODxSlj/sK4NBzrqR90Mh4BrDalkN3DCLlrCDXuhlV8McoR8sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931102; c=relaxed/simple;
	bh=Mnap1+UlUnWBZOkHLxLWqTkUukirAeI9f8hVRIb1NQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HctzeObpGnim7o+4Hrcgg0xTl5uPtPvm1XKs1GcMjBYQq8veSbSHpl+fefSuyzqG0zrUUSojJPq+haWzsfySOe27QlDKSC4tmP6Ppt+7E63pBIqw28IiosKUPZG4WpztLgiKX/ldF35sh7Eg3XSWLCy+GjQmtrTOwnklNUQTiyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FGI4z83k; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FGI4z83k"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c9cb97e178so11282425ad.3
        for <linux-security-module@vger.kernel.org>; Wed, 01 Jul 2026 11:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782931100; cv=none;
        d=google.com; s=arc-20260327;
        b=Q73pqEaHQ3M1mC+Js1alMxNjNhZAT/K75AMQdYYvW3jkm4gdBYO+wATXPtNBS1j1wl
         YUuPTolW+Xv+j6ECT3PaFlnDOCyiWJ/FJTQ2YEMB7HtcaxqStXCl5gcQqHwNhe5iXtRx
         3oDsMuIxN8BOss0LixgFzV0ojiu7LMkHfRBuX8LccFfb5C7vNnv3r0q6paOWlLC6Wf2a
         wA4exB55rNLWxVN/MRq7Uk+YYgH720lcurWHzl2Jo7Xte+G07NizWjJ6qpbujxmgRlWZ
         tMOPslrRWjRYgiEg/obzIzwp0P1FnWvaAOLNdA95EqxG76pKp2on/391xgsMgMAHWiV7
         nLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I2MBQaboQ7ps8knbKKihnH5tB9CDYcCm7037HrSOtgY=;
        fh=qhNx4kwvuTKYtTPS9hzBBoVTcX55IBjBcmd+iioRHic=;
        b=SdVoibDE7uS1Mb8+q/ECx9oXN5JWvU5b6OxKmXrWB4Cv01tS0KiJ1ZclPJZnqJSw3P
         1pYL1bz065YsfoMVLuSgprrHvfuoVjTOc3W8MZHVz5PWCtfBSBWUyTmFnYOU9sqkoj37
         CfOS8kQERRZU0f4swYt4r33YtdkdWRteRbQtCi7NQQ7PSuqcMP3VUCuNchQosxdnlX46
         VtRmC2DIUSwgEF1h4B4dCE64GwqqJtYEZNVeEUZEpsTFrnyHfQtfCvhFSX4j0QsubZXk
         rzwok4hLfVx20rYGuRd+kM9Jn2w6445v0zgxeRc/igk62DkqjSDc3ecYqsME06ZoUgVH
         sk7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782931100; x=1783535900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2MBQaboQ7ps8knbKKihnH5tB9CDYcCm7037HrSOtgY=;
        b=FGI4z83kN+qAC+C9+mZweeWYl+jCXfzakwgLVz2prRWPIaBY1lJMiknL7SP4ahntMy
         0+S6YraixQTDa87ytYhqx2+H2QObG18wPGxT2d3GL8PAR/g0+MzcaLssnP2SsjlZMcHD
         91nEdUg7Nu+ITl7egpXTelR8xCkgATx8Oa9MrGlzgTwd4tayYHmBC0OR9auhc0pC3/9h
         7tcDmmrfPRm1llaR4LwRc4hMB5/ofd2pPCPXydCaFFCw7R9nIr7o+k7su1AMyOy/+qF3
         SIrFfdJsd9AkTO/HhJorWHZYXjuTGo2KW6JU53a0W2VuI7mAHhLDZW82XW+5kUXj2bm8
         tExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782931100; x=1783535900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I2MBQaboQ7ps8knbKKihnH5tB9CDYcCm7037HrSOtgY=;
        b=mBtgvC++B7iJVp/JEqv93sQCtSIICFH7S9VwGVInPQojsqlmRsZVB5vDN55Q6ZQcsS
         JDUjdE30ef6ZTK2BPfQpk2CYWx5HC/zSa3JQPeWDYhg1Q/CB1As7npWGeJVJu9uhF1OH
         GMYEyDnZ7etI1Dee+4qCp5eod6NEoHxkoIsaeNSYrR69nH/xWkUV2GZzqp40ZlCrx03l
         3w48XrDqwQQpd7vvEymHu98QoePbmXik0l0+47OEpK4GZomZQecpciu/MtQKeYRLVUMW
         J6NRljhgMBeHEcRcjlCjSLV00D6N4KteFZAHG4JEPLMJ187AtNcTENKUYFwkaGgGd1eH
         Ojrg==
X-Forwarded-Encrypted: i=1; AHgh+RoknQPguEymyHyr3LM6FrBIgJQrIyKOUR/Ky/UDjS+l2u4GOG/NgvRfSWeUeUVInLOel7McCmbzjTk/tzoVebmWSz1gkpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygQuUsanz9dqfZ/DulxlDkBgDprRLv+K+n74OfBFXCt2h+p1XD
	uRoEnybWXaZVTzwKpdwnkOBSX6dl2qJeOVbrLG7kOWZvBEX97i4aHoptL7foRHt4KwsBeAgGttW
	ruValWqiU9ti6AFvu0nBMtPcRbd6NGh/nayo9+rU3
X-Gm-Gg: AfdE7cmEf59IjNNsjpLDUTd48ayCDCWNPI/IT18Ln+TW+C/AvzNw1tBcGW9AXMoIk7i
	b7OfYtbdnGjQaWY32Rd8U0p+V6WBywIG9EXXLvgsu1kxOFj6sLZ5cznwNS+fx07iCMozwoSQB9n
	X4iyPhsm/or8f/omWhCoXASkP1f+rLyTadhR+aqfO3UThTF426PbdFY2DYLA3v/UmrPrW2gpiPa
	V+03oaIjw9ASfHA+IzB5k61mesyKmtmKrCp7mgFRVRE8GgILgTn7XYGbvY2254gaS1iEEYV
X-Received: by 2002:a17:903:984:b0:2c9:97a9:2095 with SMTP id
 d9443c01a7336-2ca91229282mr17992775ad.41.1782931100271; Wed, 01 Jul 2026
 11:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-7-utilityemal77@gmail.com> <20260701.ze4eph1eKo7a@digikod.net>
 <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
 <akUH13qbsEnJLgQu@zenbox> <CAHC9VhSjRcMr9+5dMkep_TPKduYdob-bZ73FLfXd_o2xiWwOSg@mail.gmail.com>
 <20260701.jei4Paej3zen@digikod.net>
In-Reply-To: <20260701.jei4Paej3zen@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 14:38:08 -0400
X-Gm-Features: AVVi8Ce6qbJbJWCCH2p0_6_r7A1u2IFyNbmfvgc4fJ4aJEpixSgjGeJjZVE1e9k
Message-ID: <CAHC9VhRzZVUz8icZ2RD9OVvscJdZW3ivPERJLEkNi5poBeguxw@mail.gmail.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org, 
	john.fastabend@gmail.com, Justin Suess <utilityemal77@gmail.com>, andrii@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, 
	gnoack@google.com, jack@suse.cz, jmorris@namei.org, serge@hallyn.com, 
	song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	eddyz87@gmail.com, sdf@fomichev.me, skhan@linuxfoundation.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Frederick Lawler <fred@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 2:34=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Wed, Jul 01, 2026 at 09:28:22AM -0400, Paul Moore wrote:
> > On Wed, Jul 1, 2026 at 8:52=E2=80=AFAM Justin Suess <utilityemal77@gmai=
l.com> wrote:
> > > On Wed, Jul 01, 2026 at 08:12:34AM -0400, Paul Moore wrote:
> > > > On Wed, Jul 1, 2026 at 6:59=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mi=
c@digikod.net> wrote:
> > > > > On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrote:
> > > > > > Create 2 kfuncs exposing control over Landlock functionality to=
 BPF
> > > > > > callers. Export an opaque struct bpf_landlock_ruleset preventin=
g callers
> > > > > > from accessing unstable internal Landlock fields.
> > > >
> > > > Generally speaking we don't want to provide APIs, either in-kernel =
or
> > > > at the userspace/kernel boundary, that are specific to a single LSM=
,
> > > > see the LSM syscalls or the security_current_getlsmprop_subj()
> > > > function as examples.
>
> This patch series is not about the LSM framework, only about Landlock
> and its specific model and use case.  Landlock using some of the LSM API
> is not relevant here.

Based on a quick look the patchset enables BPF programs to call
directly into Landlock.  For the same reason we discourage other parts
of the kernel to call directly into individual LSMs, we want to
discourage BPF programs from calling directly into individual LSMs.

--=20
paul-moore.com
