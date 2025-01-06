Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4CD1E04B8
	for <linux-security-module@vger.kernel.org>; Mon,  6 Jan 2025 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736202604; cv=none; b=ml61Mvc6QGT9/swM4+X+WsdVubcax1jPHG4C/spAbG/t/gvHxmerkhcKcEvMitd9MUC/aCepOdrrCxGxQUuB/KdjXInqLNvnLU0LPkrWD9oYUZjPg1IilLUMDlxZCDKRMqoByudC6A5DCB8IQeYDdFi8gJoaeyv2q4aTcCQS6zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736202604; c=relaxed/simple;
	bh=eca6IxW+0l/PDvEdBRtVxLKo/mmc6G2o2HOHdx03jWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQTNpJufXkMDvg3KydApWTZxYDZyOc0KWA6SKnGhZ23sNZZJT14h7iUv2Gdb52ln4ebsBMF+UIEZ41d1KShq6NYfFFKj4+MeKE7sz7xG7mncGLe+swU+j9Gx4ZdjDuQdQll1fAdU9d2AwHTO1o1Ltv/ut1+mUt9n76ij0hd2Djc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RS6wlRcO; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RS6wlRcO"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e3983426f80so20681495276.1
        for <linux-security-module@vger.kernel.org>; Mon, 06 Jan 2025 14:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736202602; x=1736807402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85Mr2nSUkKINWwGhExEOZAniHV88apIn6C3yWYS1jJY=;
        b=RS6wlRcOR0uh9sdD9bdVWmH1C3pk5DcXw4WJCuCifvAm2cRnlKzsE8Y0vWY9h/EsKa
         VP/AWfdVjXwzG7e+QwqHbP6cPZy6y3t6dATwhD//yeyVc30GYXegIc8uU7LhqiIFIz6y
         IMSV9HIdz5oR8x4CIplDpaJMdNN7v3035g6e3U7cjuIiy5U8sN1szGPWx9XbttvDCCOb
         +Ca3JgoDiakiOP4j4f23XwBd3E1wkVnAInBr6OUgufThI7Xd/BIHA7hNkaMTZrQdahdh
         hvG2UkTXmHfq7OF0IqAHtATCbX12c1aTiJC4zhcTog9MGZStzbCYKdGzRlFASZCHWbzX
         FovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736202602; x=1736807402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85Mr2nSUkKINWwGhExEOZAniHV88apIn6C3yWYS1jJY=;
        b=qKFRceqvq/Z8XpKOjyrI1edpDBPWlisl+pkN5sEI/l3Ign07SEPx9JBszp11qWnl+y
         Kdjul3+IjUSKoSZvRg31PFblZgOFLSOwSyk6KD4jOl7JhR1GCF7JH/+6rA5Md9WaJr2p
         WHfamKApz58lY53uoSuBm94OS1M1KTDN+zCEm/HdfNdc4OyfVPoFD7SNQWmhzJi8o1VD
         fobl2/ckpRu9CUwB2jsBjc4hvSzZNEB3F/8ntddBeMM0jLyBbGgfgSawk1qFpUa1gdyD
         FBL+Wxa2Dv4KLUzTQ/TAW/n3hm14/WLiscjps5z52DZ+zD/TfTzvH4JnUGJV/isTJBX8
         ZEww==
X-Forwarded-Encrypted: i=1; AJvYcCXzysOvyHljDNx1T9it/vZa1G2E3fvgxvDwQsn2gTI/3Pv23FGMdmdNL42/LQpcICwJkAK+f9vQSfe9Ny6VgAoKBXDNcSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxINejXjRt7MQAWKo77me+wOP/3e4T2Cn0T09mpQtJg4Tj4yO6a
	Y6PUdfi69/5zbnGmzM9kGaSUuVaiD5BqhpnGBVkOM/cDLATxlIh92vUCmS0YDiHotCxqJ1FjALI
	LQCbuqWbsJqdBCAKsObIMwMbHKyjbCuPFV61X
X-Gm-Gg: ASbGncsKsqIavwsmUYpbmddELmnPSU1Vej7XP02+Olatd1XcMQAxXllBEgOTSl9TaTg
	KuorHqQDC0runtCG+drfS/w4/UkPbYqZ0yT8T
X-Google-Smtp-Source: AGHT+IFCGDAZ/3lfILcXv8R7tXGphEfEWUfm4JLOABY3D3/LkE5I7c6GclVjTfCzrbu3vRpcPGS9bRUgfDfCwb84xc0=
X-Received: by 2002:a05:690c:4986:b0:6ee:6c7d:4888 with SMTP id
 00721157ae682-6f3f8144f76mr452679147b3.22.1736202602340; Mon, 06 Jan 2025
 14:30:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122143353.59367-18-mic@digikod.net> <0055bef6843289ac8dc728a68326513d@paul-moore.com>
 <20250106.ea8aex7jai3O@digikod.net>
In-Reply-To: <20250106.ea8aex7jai3O@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 6 Jan 2025 17:29:51 -0500
X-Gm-Features: AbW1kvbztsFKO2Mp88ClYKhkTyTWboydIXOO6GsUlgClK-Zf32TGnEy8Sn3G2WU
Message-ID: <CAHC9VhRh+_CM5kVmuXkttCn-3f3X8TR4n2q7MzrxCBXhbb2n-Q@mail.gmail.com>
Subject: Re: [PATCH v3 17/23] landlock: Log TCP bind and connect denials
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 9:51=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Sat, Jan 04, 2025 at 08:23:52PM -0500, Paul Moore wrote:
> > On Nov 22, 2024 =3D?UTF-8?q?Micka=3DC3=3DABl=3D20Sala=3DC3=3DBCn?=3D <m=
ic@digikod.net> wrote:
> > >
> > > Add audit support to socket_bind and socket_connect hooks.
> > >
> > > Audit event sample:
> > >
> > >   type=3DLL_DENY [...]: domain=3D195ba459b blockers=3Dnet_connect_tcp=
 daddr=3D127.0.0.1 dest=3D80
> >
> > The destination address and port is already captured in the SOCKADDR
> > record for bind() and connect(), please don't duplicate it here.
>
> This does not show up when a connect or bind is denied.  I guess this is
> because move_addr_to_kernel() is called at syscall entry when there is
> no context, whereas a Landlock denial is created after that.  For this
> to work, users would have to log a list of syscalls, which would not be
> usable (nor reliably maintainable) for most users.

Quick question, can you share the audit filter configuration you are
using on your dev/test systems (just dump /etc/audit/audit.rules,
unless you are doing it by hand)?

One can make an argument that if syscall auditing is being explicitly
denied, then the user has decided that the syscall related information
is not important to them.  I'm somewhat conflicted on that argument,
but I believe the argument is at least valid.

> I guess this might be different with io_uring too.

There are other issues with SOCKADDR and io_uring related to how
io_uring wants to separate the work into different execution contexts.
In general I wouldn't spend too much time worrying about auditing and
io_uring right now, there are some general issues that need to be
resolved in io_uring/audit that are much larger than just Landlock's
audit usage.

--=20
paul-moore.com
