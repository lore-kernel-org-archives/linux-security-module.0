Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7046A126BF7
	for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765559181; cv=none; b=LYFy2pKfB50Bfz0LQCHcoVxYxN/+Z5ZLJHWVpIfm2JwwD8ykg2uCzm+lyeOkldrJnUAKBTnvMAKZ+fjPNw2ESFrStdCExvWKLu3yXZ9PgC1vqBZqmzuHQEUbR5ykwxF9QH5um5Ut6gaiPVLEzRbGcmIe4BGcFmVP1AW4KQ6XFf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765559181; c=relaxed/simple;
	bh=cEfntIeajTL51kQ3r0606fOunDse80Ht326cLr5TqU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anLhn0MmavICKLLz+IAvWPlxBRsVw1Cg8r7jT0aCoTdwuguZ6G2ZUiBlXNuNmrad6VpiEC578q5Inq5OfgduLAqxaew/Bc/liuUYQ3w83Ad9CHOmnXpfN6+Ke3Yg4If+sLb9WEd+9zPax6lRDSqlOwd/R1JoV7kznFkwXVSkxVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aTdlKxes; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aTdlKxes"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-343d73d08faso774111a91.0
        for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 09:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1765559179; x=1766163979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3B6h+4SNc9pAAXdmJms6Dj2LNBPMl1Mg0NsoDQr2gRo=;
        b=aTdlKxesKxYlFiX6kOoE1ls0cyqZGJN9iG3/QK7e2CnDcX3ndybgsIp/y2APNqBE+9
         gf3m/i6K038kcgl+cMQvKt0LgkPrb4xjEHSsulLvjOD1lZsTAg9ipXAsq+ShTI0SUmQM
         aLnis7kwNbga064dz5x77rmLX0yRKmA7Vc/q+5yV9IPxDSWBlkzIew+p0Yr1RVk+aLG5
         yRB7L31xdB/1F7YukrNAb7yh075ztNiys2goa22ZcG0bcYeZ07wH8fK+42vs4d7DszTc
         eZFdmuoo6s9noDnCjk48uH3EqKRBlFOQpeDNfPxFF3QZFhzTeC937vGP0ZNYwDN5zk7A
         2L9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765559179; x=1766163979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3B6h+4SNc9pAAXdmJms6Dj2LNBPMl1Mg0NsoDQr2gRo=;
        b=UMN82Y+BOKoc2zjOp5YvdxLQsWpMacgUBtomz499Nwhz7PUkb7YrtdYj9HRE1R2/nQ
         Qp0zcgRS0Mi3OOnT7jC6JEzQTWprGOGoXp0QdS5/8/Y9+TpDkYAG/X06To3JByP6Pcu6
         jHevXmSRV3IwWmhT/fj3CR1YA/R8iTsuoUTOHZRBdNgCqM3TLN5lHMk4dTAVlfSri7FK
         n7/4RqNAakd7VVc8eELwbV2wddinxUD/LLGloi5mAgVADDA+dDINmhOGJlurRipTkv0Z
         MMpX64PwsFtOjNnhtHdPicgEnvXGsqHI3ndgDoVcxar2+8RXDlZg7zsZCvVljut7oaOT
         4FXw==
X-Forwarded-Encrypted: i=1; AJvYcCWDb7NBCCFd80gzov3cmBfVhs3oWShiQVsuCAB9thU2qfpM7nYqTuMQJWAChwryWQrswT+7QAbChh1wFY399fh7ayg/ReE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXZIxE0xAIxtQLXNTreGC/Ezae2whbY6kynLq4EqyFXJpYf7Fu
	P8g//EFGvlAGJgNXhYpzHHdvRbIpEJGWPT6ivMwA4zi0TeFmoBN6EApPHfu2aOLm8fQKVHVgr64
	3vONj1M7UgzQ42duR2QCtcVS9e9FMeAOIm5DPsbQa
X-Gm-Gg: AY/fxX4jkF3644ZbKLtsiaqBacNt2CkRcuI9wk7jTgSentowbXhp+aMjKxfjNI+p+zv
	z110B859XtJoE7nD2khGN1AzzurSWb/Zeo0Dc1lLQ3/8fsdFlaeI24rAPzQx7yWVA0frCnX3Xam
	w+5MtxQMHzycgVQL1EK/13W0bcVRYUy3C4QS3dm1TBXNYY1DpTslJpXhCAHaUFKT+inysbdxid5
	e7LzAPsTQuRVMmqKswHAzqhq85RDmeDeOz/jhZgIptqbZyyNjiVqWwhKeCd7ys2JK8aMn4=
X-Google-Smtp-Source: AGHT+IFaqW7IgG/dlEqq9P9ebifVI4XQtdspIshrn1/CawJYsrSKREazEXheIJZsJCqGQppG7z9sGAHs+p1sxTGljR8=
X-Received: by 2002:a17:90a:c284:b0:343:e692:f8d7 with SMTP id
 98e67ed59e1d1-34abdf0b232mr1828407a91.11.1765559178387; Fri, 12 Dec 2025
 09:06:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABZOZnS4im-wNK4jtGKvp3YT9hPobA503rgiptutOF8rZEwt_w@mail.gmail.com>
 <a3d28a4b-ee63-463e-8c5c-2597e2dcba98@schaufler-ca.com> <CABZOZnRQ=b4K5jpNM8Z=Zr=+66COwLpC8gynzw88==mL0FCrOw@mail.gmail.com>
 <CAEjxPJ6CbZC-=onSGgELygnt_hsqaN0JS_jJFxWn+hYt90s2Ng@mail.gmail.com>
In-Reply-To: <CAEjxPJ6CbZC-=onSGgELygnt_hsqaN0JS_jJFxWn+hYt90s2Ng@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 12 Dec 2025 12:06:07 -0500
X-Gm-Features: AQt7F2o_RjsFpyeraFLOWGtil5gBzWRObQU9ewwzKEA9-6ycI7LVOIGz40FVhQ4
Message-ID: <CAHC9VhSU5yLQkCchCMUx+OLk+_2YY=1fjzth4s+_ELwgXg5t-A@mail.gmail.com>
Subject: Re: An opinion about Linux security
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Timur Chernykh <tim.cherry.co@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	torvalds@linux-foundation.org, linux-security-module@vger.kernel.org, 
	greg@enjellic.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 11:12=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Dec 12, 2025 at 9:47=E2=80=AFAM Timur Chernykh <tim.cherry.co@gma=
il.com> wrote:
> >
> > I=E2=80=99m lucky enough to have already built a working prototype, whi=
ch I
> > once offered for review:
> >
> > https://github.com/Linux-Endpoint-Security-Framework/linux/tree/esf/mai=
n/security/esf
> > https://github.com/Linux-Endpoint-Security-Framework/linux/tree/esf/mai=
n/include/uapi/linux/esf
> >
> > Less lucky was the reaction I received. Paul Moore was strongly
> > opposed, as far as I remember. Dr. Greg once said that heat death of
> > the universe is more likely than this approach being accepted into the
> > kernel.
>
> Not seeing an actual response from Paul in the archives, but did you
> ever actually post patches to the list?

I was wondering about this too.  I searched through my sent mail and
while it's possible I'm missing some mail, the only conversation I see
with Timur is an off-list discussion from 2024 regarding changes in
the upstream kernel to support out-of-tree LSMs.  While Timur was
added to the conversation by someone, I don't see any mail from him in
that thread.  My comments in that thread are consistent with my
comments in on-list threads from around that same time when
out-of-tree code was discussed.  Here is a snippet from one of my
responses, which still holds true as far as I'm concerned:

 "As stated many times in the past, the LSM framework as
  well as the Linux kernel in general, does not provide the
  same level of consideration to out-of-tree code that it does
  to upstream, mainline code.  My policy on this remains the
  same as last time we talked: while I have no goal to make
  things difficult for out-of-tree code, I will not sacrifice
  the continued development and maintenance of existing
  upstream code in favor of out-of-tree code."

Searching for "Timur Chernykh" in all of the lore archives shows some
BPF related threads and the following LSM thread from June 2024:

https://lore.kernel.org/all/CABZOZnS13-KscVQY0YqqWZsBwmQaKyRO_G=3DkzCL8zc9j=
HxAC=3DA@mail.gmail.com

In this post Timur provides links to his ESF project on GitHub, but no
patches.  I see comments from Stephen, Tetsuo, Casey, and Dr. Greg; I
did not comment on that thread.

Beyond that, I'm a bit lost.  As far as I can remember, and both lore
and my own sent mail folder appear to support this, I've never
commented on ESF.  At this point I think Timur may be mistaken
regarding my commenting on ESF, but if I am wrong please provide a
lore link so I can refresh my memory.

--=20
paul-moore.com
