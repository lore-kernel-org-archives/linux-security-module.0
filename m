Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0363727560B
	for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603128; cv=none; b=hWJYHtlVt0NEg82Zg1oPD1fHb/iHo7DzjWDGW+gWjdp3xZEr1HAwkKNft/D2JB2TL1fGBnD278JEXFUinyXjZO+Cjopbv4IWzjV2KBuhe6kzrBnsCpqeSVac+z3bmK9kDVrlptLZloCcOMpO3iMGW0VINcjs9cRAmI8IRGmz7rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603128; c=relaxed/simple;
	bh=qLeNzGiffa3FQiNPh+WMIQvPoNGqN5UQ8vdCJV/ZsBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n811f/jD0wtM+E4J6QiuJJl53TxmmwJv540hb9OdqLPqx3Jo1F0rmpFeRGgjjmkI2bQ/rOwWISjpZKAEJZH8Of4XylT2bREgUerkSEwXpt3CvM63jkAK8PVUHTPfnWXeDOxVr2DpHVaPSQB4bytwYPqptA3CYQIxHarqCYFUJIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bb6rcsi4; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bb6rcsi4"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-aa6b904a886so15465866b.0
        for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 12:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740603125; x=1741207925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nfo6LOVIBgaxVEOIiwKzecjyhsJ5Uqb27G7+Hmwtfv8=;
        b=Bb6rcsi4ceTJE/rsFADysXNjLXJHsM4fquasOpWoBJkJ4+F4PuHxwKthcogJtFlMKd
         4THbqHyXX1rHl6v0si1Lba+GIy6JTqzhMGiUB0IXUaJv07wHu5eM9jeA/RXEkGt9jyDC
         KPVg0KKiVfJ2UotRC36705VyLzVQRctJ0jKXScfV/iXLU/OdInJoI14U1IJfHPz4ZVqm
         E4fzIAFrps1zWj77yjNqdIV4sS3aMK6a+gdJaneG9rLgv1IaP/gxuIJ6STfU5p8Nz5ij
         Dxxsi1/gGrum7BGTzyvCr4rS0pOHrscI2p8INRLK2bPntVsVDndeBmcxivSTZ2TVjfFC
         ac+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740603125; x=1741207925;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nfo6LOVIBgaxVEOIiwKzecjyhsJ5Uqb27G7+Hmwtfv8=;
        b=ZWxUcavio+wujnYXaBfpJHxM06izzmivcmNjpODjhyzbIbUfulQkBND8fcGjT2U60w
         K/FAjDVMZFl99VwYknqKJkSUpGjWgSQnPKzmhgWaTwKIt04KyOZfI2CMbght+VY3vnxU
         s4OJHwcZnmJCvnxGv1mAB36E3no8GMA6rxtFxQREt/C70sAtcFWrqdNbi116UHJQXIFp
         Go0dCu9ha4/4FBE2P9tv7l4VQtggqkguSJW0IkPDk8O9XI4KnJE5eRL9t/pmlx3tDeMH
         GYsJjo5FTiHLkhgiKxpj39HuIVBO0dY3cjEsom8PIS/WtKdt8SR2AaQv3BeCLc23dibV
         WcNg==
X-Gm-Message-State: AOJu0YzqMoOPa9V3muRuL/uQrtm7jKPrupVvmZDkREENsSzFhieIXovB
	fEbYxuiWpJ5iVBkBCC8rnnjOP4udClrhJmIYn87fZhNqSLL1lwoF/mOCbVt3r0V6K7Ku/nv8/Z3
	7jw==
X-Google-Smtp-Source: AGHT+IEw51xQGb3kVX2bWPS9Yd6yv9U50vQX32a6s3TTn3NTtwUzePxM2yNlhDPbwDzeYycc677lIdrCANA=
X-Received: from ejbps3.prod.google.com ([2002:a17:906:bf43:b0:aba:fab7:ee3a])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:970c:b0:abc:b96:7bd2
 with SMTP id a640c23a62f3a-abc0d97d421mr2451975666b.11.1740603125355; Wed, 26
 Feb 2025 12:52:05 -0800 (PST)
Date: Wed, 26 Feb 2025 20:52:03 +0000
In-Reply-To: <erjborzfvlvlczeahjt7esghr4v3slgxdht6efftekofxljhiq@mkw2ibzvpvsx>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250124154445.162841-1-gnoack@google.com> <20250124154445.162841-2-gnoack@google.com>
 <Z5O44dxg8y-QZV62@google.com> <erjborzfvlvlczeahjt7esghr4v3slgxdht6efftekofxljhiq@mkw2ibzvpvsx>
Message-ID: <Z79-87HoTPM94HWf@google.com>
Subject: Re: [PATCH 2/2] landlock: Clarify IPC scoping documentation
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-security-module@vger.kernel.org, "Micka??l Sala??n" <mic@digikod.net>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tanya Agarwal <tanyaagarwal25699@gmail.com>, 
	linux-man@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Alejandro!

On Sun, Feb 02, 2025 at 01:51:54PM +0100, Alejandro Colomar wrote:
> On Fri, Jan 24, 2025 at 04:59:29PM +0100, G??nther Noack wrote:
> > On Fri, Jan 24, 2025 at 03:44:45PM +0000, G??nther Noack wrote:
> > > -IPC scoping does not support exceptions, so if a domain is scoped, n=
o rules can
> > > -be added to allow access to resources or processes outside of the sc=
ope.
> > > +interactions between sandboxes.  Therefore, at ruleset creation time=
, each
> > > +Landlock domain can restrict the scope for certain operations, so th=
at these
> > > +operations can only reach out to processes within the same Landlock =
domain or in
> > > +a nested Landlock domain (the "scope").
> > > +
> > > +The operations which can be scoped are:
> > > +
> > > +``LANDLOCK_SCOPE_SIGNAL``
> > > +    When set,
>=20
> Do we need to say when set?  I'd say that's redundant (of course if you
> don't set a flag, its effects don't apply).

Removed, thanks!


> > > this limits the sending of signals to target processes which run
> > > +    within the same or a nested Landlock domain.
> > > +
> > > +``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``
> > > +    When set, this limits the set of abstract :manpage:`unix(7)` soc=
kets we can
> > > +    :manpage:`connect(2)` to to socket addresses which were created =
by a process
> > > +    in the same or a nested Landlock domain.
> > > +
> > > +    A :manpage:`send(2)` on a non-connected datagram socket is treat=
ed like an
> > > +    implicit :manpage:`connect(2)` and will be blocked when the remo=
te end does
>=20
> I think *if* would be more appropriate than *when* here.
>=20
> > > +    not stem from the same or a nested Landlock domain.
>=20
> This could be read such that send(2) is replaced by connect(2) on a
> non-connected datagram socket.  But you want to say that a connect(2)
> is implicitly executed before the actual send(2) (which is still
> executed, if connect(2) succeeds).

Thanks, that can indeed be misunderstood.

> How about this wording?
>=20
> 	If send(2) is used on a non-connected datagram socket, an
> 	implicit connect(2) is executed first, and will be blocked when
> 	the remote end does not ....

I think this would be misleading as well, because the send(2) on the
non-connected datagram socket does *not* actually perform an implicit
connect(2).  (If it were doing that, the socket would be connected afterwar=
ds,
but it isn't.)  But we *do* initiate a communication with a previously unkn=
own
remote address, just like connect(2), so we enforce the same Landlock polic=
y as
for connect(2).

(Remark, connected datagram sockets sound absurd, because there is no conne=
ction
at the network layer. On datagram sockets, connect(2) only fixes the destin=
ation
address so that it can be omitted in subsequent send(2) calls.).

Rewording it to:

  A sendto(2) on a non-connected datagram socket is treated as if
  it were doing an implicit connect(2) and will be blocked if the
  remote end does not stem from the same or a nested Landlock domain.

(P.S. I also replaced send(2) with sendto(2), which is a bit more appropria=
te in
the middle paragraph - you can not actually pass the destination address wi=
th
send(2), that only works with sendto(2).  I replaced it in the third paragr=
aph
as well for consistency. It still makes sense IMHO considering that send(2)=
 is a
special case of sendto(2).)

=E2=80=94G=C3=BCnther
