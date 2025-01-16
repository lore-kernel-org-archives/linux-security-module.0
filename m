Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F45823243D
	for <linux-security-module@vger.kernel.org>; Thu, 16 Jan 2025 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737059059; cv=none; b=HWlPohtHYfMGiLqWHmdjo3WMpQY2PGVgg6IivwpgbT+j7IReV5Lt3hrKLnFZX+9S9sMOZ3bhuEhjTV+k/e16sR9h9zjcdiSzZ/ld8cPlK5WGbsTjevRkhzgCyA2IN+JojWm4IxzdppZLeaG0G3GDMHuu8b/cINIXFonGgWW8tbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737059059; c=relaxed/simple;
	bh=Ce/Kp0zV1hAbK5Z9ebXol2O4puwXgqpgNhSLdSibnA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnhUN6QmfzXSlFWl7ofwg/MODNpUyDMdJsY0CyQszshVE1D0BN6e0G035RRiaA0r03eLV7b8JMuW6KMW6zmng1wisskbH2W+SWh7rASk0yo1WrtyW3Ac//FX/wJoTLnxN2YpdYJhZmM/1apwEm8t6GqTXLfGg6MWev9eUdrr2lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UNUdpLRL; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UNUdpLRL"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e54d268bc3dso2746777276.1
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jan 2025 12:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1737059056; x=1737663856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyWQqNI14AFvv/FsJyoknx1z12jGrHDHRADBsDgqFJI=;
        b=UNUdpLRLm+vML1oTNDCoVRy4+a7hC3LxKDD/s6sT9nXMmRof2421S7ktHYSGhhnIBD
         3PM35v1tIpWEYtc2ButG08ief5hUDtJbvmyN+lEivGHYjC2iVmqVdM/Plxf5fjaop4n6
         Dqm5eP5hcggWp2wixIhKU+B/kYjBE/GBUqePPrq5+UPq1TEz5Jixr5zhJXewX0r1Bs7d
         gZ8d1ppJBu9CNL/LeNbXHYZyyJWH1LpnnmHNxqdrYmj34LZLHw0MyjMdPtGWFmQ7701O
         v8ru6x0f9youIGtHZpuLzH7K7EjEDi43sWZTEiq377PwmArRAw9gZ4JXNQmij+Ds+Lk1
         7a/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737059056; x=1737663856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyWQqNI14AFvv/FsJyoknx1z12jGrHDHRADBsDgqFJI=;
        b=xFRd/HNtg/bmcslI6oG59tJcmYhRs3jtPe2npTut/e3NxT2RHavNaG0L+MOnk70/FL
         Oj8ss6Ew1FWM7dzpWzUxD29d3gIuYqq1iceGSm3MgoLAx4kBw583fN9FWwIBI+IYlxDd
         BLrgAYm8Q4asycF75ZfAA8U1CymsopGS9s4pPRtO8JYjQlroR8TCEQY8yMiVLj5rYJm7
         Z+arbZ5iqMBr/pex8es3PzRiCAuuDtGyNEL+BNdSVYjhweisgltO/xGCkB+jI4WChi08
         WGEEjwJGQ16WowAxmQFXLHz+lYaBHyWZcmiPvbbCjBRymyg+jMEnQbHespfKA9urERCX
         eGew==
X-Forwarded-Encrypted: i=1; AJvYcCUlj2Q4g2HKypgmHIl7qhJYBdQLVeUYSdjZzjcKRhvt6vyPByeHZ5TYWIYEW/rWtnmIljIum3qmLPO+ObxQPKbMsGYgdMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl9NQQtZWrr3nGG7WsNPhuqWJpVRoYLWzk6XBF5fot74nJnU0y
	61YnnNkXXY8o+aNUFYWcqnYXpSLWK2rPOeKiMvaEF01GfZh1mfR3FKJ7WYpekRWlPexYWOSxIli
	nD4svnCRTQZyu8nCjXFbOXGmkTI/v0j+56MHi
X-Gm-Gg: ASbGncvB9hxDIMTxyYCQ2sngOEwWZQ12h1zrMgqvvFB27AzhtkUsxrbc6BOk3pBsLJP
	CGOyvaxlilvb7nD3kF5CCb/MSFPDjjkoSyl0x
X-Google-Smtp-Source: AGHT+IFRdjKAIsLJtAfeDNf8Z4dBBYv+hDTDBKjMzpxDhoyhHHPt6KvJPwEsFvBK2wrLIH2pD7an7L3kB5dCmpo/JVI=
X-Received: by 2002:a05:6902:2809:b0:e54:d1e4:fb0f with SMTP id
 3f1490d57ef6-e54edf102f7mr27837222276.7.1737059056552; Thu, 16 Jan 2025
 12:24:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108154338.1129069-29-mic@digikod.net> <1ac8548a7b42eaed3f4392690011eb8b@paul-moore.com>
 <20250116.tie4PhauzooC@digikod.net>
In-Reply-To: <20250116.tie4PhauzooC@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 16 Jan 2025 15:24:04 -0500
X-Gm-Features: AbW1kvYjyxc9pE58atFcKDqzn_m47bpJvbBtZCS3Co_h1H3qZ3tFFuJCTEG6VZA
Message-ID: <CAHC9VhQ-JU0UNtYO-8v16vEC2B7pKBdV3i9QK3Bek+AqByKXLg@mail.gmail.com>
Subject: Re: [PATCH v4 28/30] audit,landlock: Add AUDIT_EXE_LANDLOCK_DENY rule type
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 5:57=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Wed, Jan 15, 2025 at 06:53:08PM -0500, Paul Moore wrote:
> > On Jan  8, 2025 =3D?UTF-8?q?Micka=3DC3=3DABl=3D20Sala=3DC3=3DBCn?=3D <m=
ic@digikod.net> wrote:
> > >
> > > Landlock manages a set of standalone security policies, which can be
> > > loaded by any process.  Because a sandbox policy may contain errors a=
nd
> > > can lead to log spam, we need a way to exclude some of them.  It is
> > > simple and it makes sense to identify Landlock domains (i.e. security
> > > policies) per binary path that loaded such policy.
> > >
> > > Add a new AUDIT_EXE_LANDLOCK_DENY rule type to enables system
> > > administrator to filter logs according to the origin or the security
> > > policy responsible for a denial.
> >
> > For reasons similar to why I didn't want to expose the audit timestamp
> > to users outside of audit, I'm not very enthusiastic about expanding
> > the audit filtering code at this point in time.
> >
> > I'm not saying "no" exactly, just "not right now".
>
> Contrary to MAC systems which are configured and tuned by one entity
> (e.g. the sysadmin), Landlock security policies can be configured by a
> lot of different entities (e.g. sysadmin, app developers, users).  One
> noisy policy (e.g. a buggy sandboxed tar called in a loop by maintenance
> scripts) could easily flood the audit logs without the ability for
> sysadmins to filter such policy.  They will only be able to filter all
> users that *may* trigger such log (by executing the buggy sandboxed
> app), which would mean almost all users, which would mask all other
> legitimate Landlock events, then nullifying the entire audit support for
> Landlock.
>
> My plan was to extend these new kind of filter types to PID, UID, GID,
> and LOGINUID (a subset of the audit filter exclude list) to give the
> necessary flexibility to filter policy creators.
>
> We really need a way to filter policy creators, and that needs to be
> part of the (initial) Landlock audit support for it to be viable.
> What do you propose?

If I recall correctly, there are other patches in the patchset which
provide some filtering of audit Landlock messages using mechanisms
specific to Landlock, that may be an option here.  If not, perhaps the
audit log is not the best way to log Landlock events?

--=20
paul-moore.com
