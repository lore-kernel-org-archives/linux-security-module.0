Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24053188A0F
	for <linux-security-module@vger.kernel.org>; Fri, 23 Aug 2024 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724426777; cv=none; b=q4XAu29TkwYKTB4l1XEmnAuvaUvb0GJQChNgX2CRcDkC+l3DjXUEEnMv9vBMNfRI1X4n+6XEW8/JdR/sJqhAoC0FfbzBDw//Syrv6KD2+3sFKWrTGs/Ef0KEa6AQAxyaMWZsFhB9ajvhdQ49pat3p/SC5YfdHQV+vEZzs8kc52U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724426777; c=relaxed/simple;
	bh=2GYOLw30+luEJg/tFmrxHlNaXFRBGL5NLd68jN4yGL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiZFgNAPxHwpfvEQ9lYJrcTIA0+CuzOGlGIoWVZmaVJZeSgOpsI5a0lMMbu4+UixatMqTFM6PIASKhqrJJlEXkVSXqS4J47ppBFCORjcT+zULZNBhHOdBtqcN04q1rMlYKN+ipq6BAySGOglRte5DufPsEUwVj7HbhEK7NMCBl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JcuhpfdY; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JcuhpfdY"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53349d3071eso2615519e87.2
        for <linux-security-module@vger.kernel.org>; Fri, 23 Aug 2024 08:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724426773; x=1725031573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Szc69PtQ71Cbgpu7+pqMqmqQ4A3cQ2x6GOUbmqVp4eo=;
        b=JcuhpfdY4syLc1pht8M8nFc19b4AXN2lHLVuM+CX8JRmAG1CPBCPa1ChRDCa1DNYVG
         QK5ydrx4jUEKrqyh6PFsVM4g7b5WnWqsgLoeNmIW5i7zM5c4Zj4eDwydfeT8d4blPj57
         Mya3lZOD5m6SnrxH6IGK87OJWaQIqM1alR+20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724426773; x=1725031573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Szc69PtQ71Cbgpu7+pqMqmqQ4A3cQ2x6GOUbmqVp4eo=;
        b=YeX1xcY5RA3U/ZBsdWMRKuv9xSk+7mYtiVY4LPLZ2l4MQ+aOnITeCaBaHr8BsRQahs
         TI4gXT+9PlV6M862YKDSLzPngqt0qZGUqpjct12W6gWMCUNKxhi3roHjDxB7q8+bdhUv
         gijG0haKd2ojmcyZ1T/gdy5kB/v83BbYgArmMBL8FrAIX/hLDOBwyTz9uPc19Svvf/Hi
         ZHWMVbGbpTXPCye74glCxjTQsegzetNTkX1MyrHBG4Z96DSLGw3LTyN1YPlGz+d7o+Wr
         xOHb3PmQCz8AomXYe6CS+NRr+1dD6tOnjHm3mS1g1w3Cg92DJFVfiWjZJwTJaRqReji3
         csUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeFEv2J3q141JwmLKjs4kUFjKxLm6JIobXcNhFJAuQ58nUQSe8OA1vqs3uK4GBh4iQ9MfbrhU2fpf5RUCRnqj6rfjFmug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOIidNJIYoPdvH7pLRWRQHfnkp1qaNfbKkVy12eZ0mmIYnWDbC
	SEPCr+lCQJVmfTxh56UArHYygqg1pm4d54zuhgLOILEN3OlwTyLwACW0433KRxz6aT9B5ELaBXR
	8tTXZqw==
X-Google-Smtp-Source: AGHT+IHETuYBERCAblBB10XEnACwDlKjxVydl2PxgdBUef17ark0urvTFD1b124qoJz1CxAFCMgfTw==
X-Received: by 2002:a05:6512:3e1b:b0:533:d3e:16e6 with SMTP id 2adb3069b0e04-53438784950mr2017693e87.25.1724426772484;
        Fri, 23 Aug 2024 08:26:12 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea297casm569540e87.39.2024.08.23.08.26.11
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 08:26:11 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f3e2f07f41so21867461fa.3
        for <linux-security-module@vger.kernel.org>; Fri, 23 Aug 2024 08:26:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyHu0xdAG9oic4rwQ7sXgwLuvlCcZN9I2sY4wVmFG1bVO9+az8AuJIMarhmAaV0ZScLLacPRVn00S3fjM8FiZT6DJU5Lk=@vger.kernel.org
X-Received: by 2002:a2e:9c55:0:b0:2ef:2883:2746 with SMTP id
 38308e7fff4ca-2f4f4965089mr17361201fa.48.1724426771254; Fri, 23 Aug 2024
 08:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822131542.785546-1-mjguzik@gmail.com> <CAHk-=wj-UanKTT-NZKLVjK3mgQsC0Ptv8mK8AM7LfZhj2dVCUA@mail.gmail.com>
 <CAGudoHEjjuGOwf=KkZjNUTPXSr6E8w8Dvz6=_CiKVHsUOY8KeA@mail.gmail.com>
In-Reply-To: <CAGudoHEjjuGOwf=KkZjNUTPXSr6E8w8Dvz6=_CiKVHsUOY8KeA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Aug 2024 23:25:54 +0800
X-Gmail-Original-Message-ID: <CAHk-=wh84ATUBUZG4DtoY-=Jo-WKwDcfNUdOGw0_PzEr85rLqw@mail.gmail.com>
Message-ID: <CAHk-=wh84ATUBUZG4DtoY-=Jo-WKwDcfNUdOGw0_PzEr85rLqw@mail.gmail.com>
Subject: Re: [RESEND PATCH] cred: separate the refcount from frequently read fields
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Aug 2024 at 20:33, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> On Fri, Aug 23, 2024 at 2:06=E2=80=AFAM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >
> > Yes, it is rarely actually written to and as such can be "mostly
> > read-only", but since it is both read and written next to refcounts,
> > why do that?
> >
> > Did I miss some common use?
> >
>
> It gets looked at every time you grab a ref.

Mateusz - read my email. That's what I daid.

But the *ref* is already in cacheline 0. With your change it looked like th=
is:

   struct cred {
        atomic_long_t   usage;
        struct rcu_head rcu;            /* RCU deletion hook */

and if you had kept the union with that 'struct rcu_head', then
'non_rcu' would be RIGHT THERE.

> Thus consumers which grab the ref and then look at the most commonly
> used fields get the non_rcu + rest combo "for free".

They'd get it for free JUST BECAUSE IT'S NEXT TO THE REF. In cacheline
0 - that is already dirtied by the reference count. Which makes a
*store* cheaper.

And you also wouldn't waste separate space for it.

> consumers which already had a ref don't suffer any extra misses

Consumers that already had a ref don't touch 'non_rcu' at all as far
as I can see, so they have no reason to have it next to those "most
commonly used fields".

See my argument? You seem to have pointlessly separated out the
'non_rcu' from being together with the rcu_head, and thus wasted
potentially useful space in the structure.

Your own email even had that:

>        bool                       non_rcu;              /*   100     1 */
>
>        /* XXX 3 bytes hole, try to pack */

which would have been a /* 4 byte hole, try to pack */

A 4-byte hole is more useful than a 3-byte one. A 3-byte one is much
harder to use.

In fact, even without the union, I think your current cacheline 0 ends
up having a 3-byte hole due to that

        unsigned char   jit_keyring;    /* default keyring to attach reques=
ted

with CONFIG_KEYS.

Without CONFIG_KEYS, you have something like a 40-byte hole there due to th=
e

    kuid_t uid ____cacheline_aligned_in_smp;

which seems very wasteful, but I guess CONFIG_KEYS is the common case.

So I repeat: what did I miss?

       Linus
