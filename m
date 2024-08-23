Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E0518892E;
	Fri, 23 Aug 2024 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427748; cv=none; b=gNzcyrHb9uKf2YfQtTfhyAaKNk+0jVsa2VmWgw39xt2B7MAXQIdUP0sueCovX3FBy0OnpLp25QesgxoGoFEi1I0sodaPNIgH7D5Kyz42ZsJTvCtknKvnal2VUx+0g76xPBomiFdbxR6/86ZaPanDhprZEWSRQG/kECGD72f41bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427748; c=relaxed/simple;
	bh=ozVaMZMzlEunYoalye+a5ILWxPlPLHjRr4DnIYFUsvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6ejNImELhb4xq+ok7TYPfd/E+pul1KzffC90uA3PJgef/Xnaz16ENC8zTC2OSrV+nmjsQxH/PQGtRyxDFCe0TC1mEVjSapb1D7GcnApkhr1EovOxviOhHZcgEqOP/pjpBG6pCHgoQJGwoRVko5YOAveOhvGXBNyO97PB+RWF9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIBQAKx1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIBQAKx1"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a869f6ce2b9so164459866b.2;
        Fri, 23 Aug 2024 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724427745; x=1725032545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TYS+xEsshX9UAS+TaWrNxlareZOo0Dp8nInchxHJ2I=;
        b=gIBQAKx1VJNoV8pjcgksZgLelDgpV3QSjw50NdzJcIEQWMpoOjPIgkjDt/sl29Y5J2
         SpqTm39vTMQCrGy8CA4cXkXDNa5FINuZMjzP/0DaMhAFeQgl8G58edpgDi2TwAH7g4ht
         Z69rBQv65XJVRok8NUQaMTIc/LusSis98lMMbPhtEivfvybaRSfegZWpVQkGhu/3wvwH
         iprUS+gtICodB4rsfbhvizCffldPLoyOsOoVRS72+FyvxZLegRzMvTBMyNVSTDcoxO/8
         fFlV6FHneM189HV8voUW+wTSFzbrEVLffbdU2tNv6uKmTH7Dda7UuKv/rupS4iP/JeDV
         FiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724427745; x=1725032545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TYS+xEsshX9UAS+TaWrNxlareZOo0Dp8nInchxHJ2I=;
        b=Mb6CX5inPZs7j6cz87+GYJQBGvcK6gdlqE1MMs51wAmLnFsP4RGD1bwgSuDtXybJfT
         VAOimVyew4cefu3aUtZnxEe6nbvB8pjOpt8BQEx1hbWp04VjW0L15Sv//h764mQrTj7d
         zVdOdYnc2VqxRPfqLp8+w0uREwOp+b3/qJf17W5C6VuQ2zofCXWAayHIvtGCV/Tnzou+
         mhlewt3G/MxcvsBkiaieDGKSURdiaxgKKE7OUCBL+Cx5h2FSlzIxrsrCYVCd8aE2hE0g
         PGwVRQ0FuFSEjzi5Tyd9zkVJ+37iegF8OvAlJOG3o7loViw3eWQp1rr4Y9NxlEHo/gYd
         nCEw==
X-Forwarded-Encrypted: i=1; AJvYcCW6PNv/xAdrgWvFd1K/Z81rzLmB+Rz1VMuSiQYO8hpe+1cfb1XR0nALoMiXmrZUiRRq8wgFOMj8703tr3AE/vW2n1ObMNEm@vger.kernel.org, AJvYcCXj2DJHCDPrKhZryIVh4juy1atWVAXaeJF3w/tjGi73Vhn114YH+5pky4+hbvnoKfFDvkwLOgkEC0TieDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm+Co6PyofRAiJpzJ+YjURF5dPlNYFGgL5F/jOvg0elvF/fbEq
	cTI9XKcJmgqCI5zD1ehA45AYn5UKq5IUddyOFJBVmZRbI13n0Jt240MCbmxhaJgrCkBINsQaBwQ
	FvEx4rq41k7Stpj3Ym53PtPx8PNU=
X-Google-Smtp-Source: AGHT+IE36zvLW744blLQ8uj+7EabB3QmizofjvMCYCI1USiH3IqIsUqxQKRNS5nJdNqbpIUGaDr/2f1EX4gqiJ7gUnw=
X-Received: by 2002:a17:906:cac7:b0:a86:9cff:6798 with SMTP id
 a640c23a62f3a-a86a52ec035mr192799266b.30.1724427744985; Fri, 23 Aug 2024
 08:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822131542.785546-1-mjguzik@gmail.com> <CAHk-=wj-UanKTT-NZKLVjK3mgQsC0Ptv8mK8AM7LfZhj2dVCUA@mail.gmail.com>
 <CAGudoHEjjuGOwf=KkZjNUTPXSr6E8w8Dvz6=_CiKVHsUOY8KeA@mail.gmail.com> <CAHk-=wh84ATUBUZG4DtoY-=Jo-WKwDcfNUdOGw0_PzEr85rLqw@mail.gmail.com>
In-Reply-To: <CAHk-=wh84ATUBUZG4DtoY-=Jo-WKwDcfNUdOGw0_PzEr85rLqw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 23 Aug 2024 17:42:11 +0200
Message-ID: <CAGudoHGBuSL2p_mWOcaY+T9TV_2zRrPjk+E3BFJu6o4iHcBL4w@mail.gmail.com>
Subject: Re: [RESEND PATCH] cred: separate the refcount from frequently read fields
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 5:26=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 23 Aug 2024 at 20:33, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > On Fri, Aug 23, 2024 at 2:06=E2=80=AFAM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > >
> > > Yes, it is rarely actually written to and as such can be "mostly
> > > read-only", but since it is both read and written next to refcounts,
> > > why do that?
> > >
> > > Did I miss some common use?
> > >
> >
> > It gets looked at every time you grab a ref.
>
> Mateusz - read my email. That's what I daid.
>
> But the *ref* is already in cacheline 0. With your change it looked like =
this:
>
>    struct cred {
>         atomic_long_t   usage;
>         struct rcu_head rcu;            /* RCU deletion hook */
>
> and if you had kept the union with that 'struct rcu_head', then
> 'non_rcu' would be RIGHT THERE.
>

Huh, it's been a while since I wrote this patch. the rcu thing used to
be at the end I forgot I moved *that* var as well (apart from just
keys stuff), but I still support non_rcu being elsewhere (see below)

> > Thus consumers which grab the ref and then look at the most commonly
> > used fields get the non_rcu + rest combo "for free".
>
> They'd get it for free JUST BECAUSE IT'S NEXT TO THE REF. In cacheline
> 0 - that is already dirtied by the reference count. Which makes a
> *store* cheaper.
>

The store to the non_rcu var happens at most once.

Suppose multiple threads open and close file objs, this results in a
stream of atomics on ->usage. With the proposed layout only accesses
there are rmw within the atomic.

If non_rcu hangs around in the same cacheline there is additional
ping-pong to check the field.

> And you also wouldn't waste separate space for it.
>

I agree space is getting wasted (or rather a hole is there when it
does not have to be), I just don't think in the current layout this
matters.

I am not going to die on this hill though, if you insist on non_rcu
going back to the union I send a v2, but as is this would come with
*some* loss.
--=20
Mateusz Guzik <mjguzik gmail.com>
