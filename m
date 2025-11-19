Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0114C2E92B4
	for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763566577; cv=none; b=bjUayDsbXPIZffGRfAxnVMzTjqd2mi2z+r8R2RcVTvmn9S4z+n+rhi9D2Icr1jWCBBpnRd8Wwz2sPqwYoe4MSTxV+e/GKJ4GyWNslAU2wlKbbjxC25v9uONW+SX5RDSWWDATfm/tdckJKjEQRdw9rXNnK5AgbLMieVxN1oGyYMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763566577; c=relaxed/simple;
	bh=YJBOl5xRvHqehH+NZ2dFOyjFzGyhE3+Cz/8LYxg8Ldw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfnNasoSF/SA3Ppxfje3eXk68A0aIRqQsUJlywm8aCxWzHthaHBLuiEboKNZ2BrbqcCfJeMsLGaIqf3U6oFW03ZFqDo8SBbLDfAA+fu2g0gaoBRP/jJoujqNA3gUCmds9AQqT15r4sBH00ZoOJ06bVymcYok8mHdEO0FMXtJuqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=V3rtJTCr; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="V3rtJTCr"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3418ac74bffso4949187a91.1
        for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 07:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763566575; x=1764171375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2/OWrT07JXUDJL9bCVK36i5AOlvLM/LAZfeF097gg4=;
        b=V3rtJTCrYCom7BvzeT49RRu00m2+A8n4l36jZl6elM1YgbiEIn/94h3MSc10vHrXgP
         8XzPZZeoj+3VjNBmKMiNv/kh1AfBPaKqvBVdnu6FvKp2w/C6HxbzR5mGP6iTN0DLFUjP
         76ej+kJp4/n7Rgz2ZmdxW9655MydoVsWba5gzPiDoGO5eKYcGz51eRbn2axFOmYEOZOo
         RKwwpal/HX3aD7O+kYihcU2VXmNpOOro2ujV5XIEyjEj4vkzL4FdkzrpOA07oNtuQpAg
         JXaeLppOBeomFqXZqbI65/FEISxZ4QdNFcLFOwhmwMoMbMPqe0OGaOW9TNSHUsvASKxH
         HiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763566575; x=1764171375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o2/OWrT07JXUDJL9bCVK36i5AOlvLM/LAZfeF097gg4=;
        b=fmSoJPacjjlo8UZqBqoSZqce/iXddeF8YFdmw7zaIkNatMLD10nM+80wf2R1/8IStL
         jX/NUVN4aVhDenjAzz7Jz0l9Xp1xzEnqxcv6r+kAX2O1BXX+Y27Od7s2yNnHmVGeMZ55
         arLu++rahTvsjbVvxkY5GBkKnSJjOvHRGj+0GHxapc4VnC/wNSUDG7SGAuFf65QTk26j
         RUhJnR6oN1Xysut+qvJdcxhk+6DD5FO1k8q78/Ta8dgeqdM9g4b8k6bsXL0InRfvXK/y
         wZ3xmgjB5hl7NXPYUHKOWX/Cqo0b6FsSkkXzEeMmhfWrcHlNMpxHfhGQEjFCNxL+MYW9
         9smg==
X-Gm-Message-State: AOJu0YzcqxzGnycuku3GKtSmjJIosY6LaziKE3OawDzI1W6Deqp4M82h
	ovIFsUYNOyFcVOFYnHNdjmQ/VOg3tsea3mTIceaTofRalPciOiXGDxzPlNnhQk4QQ13hSabuGqc
	FYnBd0in50tvJuxOC5yh8THo48h7y/rAM57kcKhXsZ6MBltSi7WY=
X-Gm-Gg: ASbGnctnk+CshUX9y7eyCGch136HruKI8L/wG84NxTIr/a2RgNXIFAvnI7/yfaEtYpW
	9I4QzKGBaEAPkvhM0BgMuzckmHm2NmmgM/QjyteLYXhQ+xHTvRo3zx1882gVDsxaiGVCTTseNIa
	hYJR1LsbCYB2lra50iUOLTsUCvtfvGbWZfqKOBN4Jo4y6JfWoGyKcCiFdcyDp1Yi8OZrPzw+j6B
	snr8dPoDOjElSfO1So2k92Zx2mC1mnaf7hODvlP4AaPs1AoNwagslDP2m7egP6jTqeTFEe5vm/7
	iLR0ZA==
X-Google-Smtp-Source: AGHT+IE+Lw7NVKt974dQGQXPOsuYgAgSmDKH0otXSQYdmLQW2lBCvzoNCYm5ypzQlzwbDOpOjGYDfR1o79+lpf7T5UE=
X-Received: by 2002:a17:90b:1dc9:b0:343:7714:4caa with SMTP id
 98e67ed59e1d1-343f9e92175mr20767519a91.3.1763566575109; Wed, 19 Nov 2025
 07:36:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119002808.444259-2-paul@paul-moore.com> <5508241d-7c8f-4caa-a62e-3d8eb2426b55@huaweicloud.com>
In-Reply-To: <5508241d-7c8f-4caa-a62e-3d8eb2426b55@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 19 Nov 2025 10:36:03 -0500
X-Gm-Features: AWmQ_bmnE60jrar6oz0-B29x_za0YuX--TyQ4iQueNk1kRPhIJS-E58w5vPnt1s
Message-ID: <CAHC9VhTe9BgD0LouhDsd-eviehKHmaF=q+mvxabNGmHUOMJMVg@mail.gmail.com>
Subject: Re: [PATCH] lsm: use unrcu_pointer() for current->cred in security_init()
To: Xiujianfeng <xiujianfeng@huaweicloud.com>
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 10:49=E2=80=AFPM Xiujianfeng
<xiujianfeng@huaweicloud.com> wrote:
> On 11/19/2025 8:28 AM, Paul Moore wrote:
> > We need to directly allocate the cred's LSM state for the initial task
> > when we initialize the LSM framework.  Unfortunately, this results in a
> > RCU related type mismatch, use the unrcu_pointer() macro to handle this
> > a bit more elegantly.
> >
> > The explicit type casting still remains as we need to work around the
> > constification of current->cred in this particular case.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >   security/lsm_init.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index 6bb67d41ce52..4dec9199e4c2 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -467,7 +467,8 @@ int __init security_init(void)
> >                                                   blob_sizes.lbs_inode,=
 0,
> >                                                   SLAB_PANIC, NULL);
> >
> > -     if (lsm_cred_alloc((struct cred __rcu *)current->cred, GFP_KERNEL=
))
> > +     if (lsm_cred_alloc(unrcu_pointer((struct cred __rcu *)current->cr=
ed),
> > +                        GFP_KERNEL))
>
> Since the casting from const to non-const is inevitable, why not
> directly cast it to (struct cred *)?

I like having the call to the unrcu_pointer() macro as it helps bring
attention to this corner case should things change in the task_struct,
however, I do think you have a point about moving the cast to *after*
the unrcu_pointer() call as we could so a simpler "(struct cred *)"
cast.

v2 coming shortly.

> >               panic("early LSM cred alloc failed\n");
> >       if (lsm_task_alloc(current))
> >               panic("early LSM task alloc failed\n");

--=20
paul-moore.com
