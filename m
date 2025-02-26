Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BFD25A63D
	for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605890; cv=none; b=jvqU7rfesrHDJtDpIXLOrZBjs0BJb5S3oBkqHAgtVuyZy/Ob161I7SjBQ6zjzEXRBzITsLZT4OUHO2DkwVXIFH6aRL70J22srYx+Q5idM+zvwgyi8zlGw03yzRCvTnJgrdznx48MQ2r1B0/QrjraaRkOyZhNPVh7378U8uuBUVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605890; c=relaxed/simple;
	bh=ZqBestMUPFwTqZdVmhC1VxizcqbeFwZ7xmoJVpNXomU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SMTV/NnNvZhlObbQCHzcv+1ialsOvApJj1SdlppH/+E//b3X5IhroYjeAGBfRiSCNlK8wXjXs1GMJiSQsWUJSDzdOZftL4Mgx2Co/s004O7wJEkHjU49PSMLsU5tmW/6A5mwWDG6PkIQcpqa7T1fyWxRj4GS7TmpvNM6LgZtw/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tCjBSDSS; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tCjBSDSS"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5e4b6eba254so133788a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 13:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740605887; x=1741210687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGqPzZNS1V+n4kBOnix0o1ofeCkSUT4nSjjh84WDIMU=;
        b=tCjBSDSScsAJZnWQMLIv3orWGISk7pf8yoN5yvwmQt0gohbtxgzUx4Jjyg5wtWMp3p
         mywwNiHe1fqwpkjL9rF5Lh50tT01YFnp99M1W9P5gjyH/CpXa9BvFTje1bISIpVQIydH
         8dcT9J909fxu3uG5QmmZZZBuD3flT6sOwc1cub/wJFXt+A+AHzxiN4uXA6rB84WBHoJz
         tXoAuQcnbnLYcPLyvyS4UQTDwtkN+LvtUmsrItEqNsXM9siokneRowpy+/XyWmbQ9apC
         HH10/bjhgpBw4AtAfqtXFe6c5axxYEMraWHvyQzMr3lqq5ixVr7aurnYKayzqSe1lFh6
         SYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740605887; x=1741210687;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mGqPzZNS1V+n4kBOnix0o1ofeCkSUT4nSjjh84WDIMU=;
        b=StoNnz42TD5+0EyTePewRgRoFH/+fSsuUNIANt8WQqLiocYQ59j3YQcz1gkcrJAvlR
         l0yBPfUFiE5lGd2p1sy9nOagCdJwUZR9IWBtIQ8NtUehqFspiYflByWbQVYERg+/8J4q
         j21zlcFrkJ0JoDHRe9/omhtlhZ0R7aW+5wiQS+0ZxhXAN6HLNr7Uw1gtHzjUjkIHDTks
         V5IDT7rnwLK9k4T9GtRmr3wMWOIwwSNZtpAfwbLeNg5Z44Wv7NCdmtD7VP/hGgqTQSP/
         X5KX35b8t59VHrgPBOAcv39ZJ9PJLKrNdp+8gGOmJRJPW/GFBzItEC6cwYrbCFq+JQpl
         plmg==
X-Forwarded-Encrypted: i=1; AJvYcCU93RFWmhqty0iaSdqbnaM3idsZD+XS5VTXD7tyB8BFxf/wU2Ttf6MOBJAa0rTQXKRvNz+s3ClztqE03iZRilD+wLaaHNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyksqo0HkFKYha9LR3ENVzqPGQezdnbAArT6MQPsKfM/n3NS8WH
	hvW66CzWyP/cL0aas8U3//7KGuw+YfL8RYrxd9nPdvsLF9QcC9OFxNF2nLRNiO6GpVoppBIeXj4
	Y6A==
X-Google-Smtp-Source: AGHT+IHLcGqlDtLI8Hl2GI2lBKNlphlk5lHlGNFGlyXSH6D0Fyvmh2EVwHw6XlBi6AYMqakwrDecEE1k1u8=
X-Received: from edat28.prod.google.com ([2002:a05:6402:241c:b0:5e0:9ff2:9ffd])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:2347:b0:5e0:8064:b42e
 with SMTP id 4fb4d7f45d1cf-5e0b7223106mr23870685a12.25.1740605887315; Wed, 26
 Feb 2025 13:38:07 -0800 (PST)
Date: Wed, 26 Feb 2025 22:38:05 +0100
In-Reply-To: <5xijgm2hkedx2tu6fjt67ozf2rmvjz6z4zvvcvokymc3hlc6of@xqpnvf23ia2s>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250124154445.162841-1-gnoack@google.com> <20250211.Ree5bu6Eph2p@digikod.net>
 <22olfm76rcgjfs4vrr3adtbznsnz47kaehlr3ljn6e5jkc6waq@ue7azstxlwfv>
 <20250211.ieSoo7Phe5oh@digikod.net> <3unkhxarmiddobfjvojx4sdpgitjld26udcagka2ocgrb6c2jc@dcg4w5yk5mut>
 <20250211.oavooPhap9OX@digikod.net> <7vl6uylhzgkokl42bz36d5g3krcusqf7mdy4bd7tblcjckatrw@ullu2kblovji>
 <Z794dm_xmViQ_lFF@google.com> <5xijgm2hkedx2tu6fjt67ozf2rmvjz6z4zvvcvokymc3hlc6of@xqpnvf23ia2s>
Message-ID: <Z7-JvY4DP-CswCyF@google.com>
Subject: Re: [PATCH 1/2] landlock: Minor typo and grammar fixes in IPC scoping documentation
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, linux-security-module@vger.kernel.org, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tanya Agarwal <tanyaagarwal25699@gmail.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, tools@kernel.org, linux-doc@vger.kernel.org, 
	linux-man@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Wed, Feb 26, 2025 at 09:57:58PM +0100, Alejandro Colomar wrote:
> On Wed, Feb 26, 2025 at 08:24:22PM +0000, G=C3=BCnther Noack wrote:
> > On Wed, Feb 12, 2025 at 04:06:06PM +0100, Alejandro Colomar wrote:
> > > So you could really use man9 for internal Landlock stuff.  Even if I
> > > think generated documentation isn't ideal, it's better than nothing.
> > > Being able to use man(1) for reading kernel documentation would still=
 be
> > > a nice feature.
> > >=20
> > > And while I can't run all the linters that I run on hand-written docs=
 on
> > > generated pages (because generated source necessarily triggers many
> > > false positives), I could still run some, which would trigger some
> > > accidents in the docs, and would also detect bugs in the software
> > > translating the docs from one language to another.
> > >=20
> > > So, I'd still recommend you considering man9.
> >=20
> > This is different to the BPF helpers; Landlock's existing man pages doc=
ument
> > user space APIs, and the largest part of the kernel-side .rst documenta=
tion for
> > Landlock also covers only user space.
>=20
> Huh!  Why does the kernel duplicate what's already in the manual pages?

That duplication is *precisely* the problem we have in Landlock. :)

(If you look at the patch series I've been sending with both the patches se=
nt to
linux-security-modules@ and linux-man@, you'll see the duplication,
e.g. https://lore.kernel.org/all/20250226211814.31420-2-gnoack@google.com/)

Documentation of user space APIs is not unusual in the kernel documentation=
,
there is the entire subdirectory Documentation/userspace-api for it.

=E2=80=94G=C3=BCnther
