Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95EE375AC4
	for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787082535; cv=pass; b=BnWEFU0fBvWWnTznsufRhXM0ltue8y2kq+Ht8EImx1J3NEyP5vbkD6f9pGyq2RXPfQuiV1mj7RMg8Tdk/52W/Wac3pA1IC+4MXtupLksM4QeJUGUat7ye+MM64dcGgQP2UkntajoVb3dQy1IuQKLW6EoAfP+rksA0Sb7rVo8CR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787082535; c=relaxed/simple;
	bh=NbL96y2dar0Pc04P73sZM2+RnuWRwl1qoFF81IVnwW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/NhFMZdJr5uLUltsqpORee1ZNSlDFAreqzy8LuQwJ82sU9aIpvHW7E8l2zCkBF0ZuVUOKcnqTrBQKyO3XKFivg55jAoxjLRIBrtZWkw+OyKK0Y+E8eceFvgI9jwibSKFvvikg6qALJoUSFBcSSH0wd4QCbkr2vhnZPXjTaRD7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a9rVZkJT; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a9rVZkJT"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ced3386430so1784645ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 12:48:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787082533; cv=none;
        d=google.com; s=arc-20260327;
        b=rhWjIR662Ewv5S9gFeib8A4hOmuYIKzSWuN8nRyTlbTrlkykkSHMClkzo68ANpBtAn
         7sPqtxOGdDdBbY7ndj7DjUEHMDsXq/GhkTS05EBK+1H3/uxuknkK6wOJ34wCnlrRNppI
         pn+FYYVkk3SnWMTCd1Zi5nVyHt8sNuxJERew7B3gfpi2r+OEk0acqGPZ8T2Z6JNnsA9o
         1ZVy5lUz/WAyGsmqfKrmIJ8ydiE2nIeenD3K03NgFct3Rxp0/Z3clg8BuQPSaQ6bjkdT
         XMc9rrZ4drQWsyAdgObaUBZHsfUBq7tRbo6J9LIM6Ar5gkiHhyZjIAsy3jN7xvMSDUr9
         b+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NbL96y2dar0Pc04P73sZM2+RnuWRwl1qoFF81IVnwW8=;
        fh=D37VB6kWRAqY9Dfeir47d1m4tYRqcCL2RBuqDoI+2ag=;
        b=pgNaMVycTUjjI7ZE469ons71YYFvzA2jXVHs6bK8iS+gTE4YwZR0PlCXxFrsYHR4jf
         Lan/taZSE6uPZB5DRrjhlKx2UQj9luV5NNxTu5BmYSm9elDjDkBuisHA3OMcT74cR3im
         7CwwjcKvpA1NtWUQpNAuNifEaeM8xYIf6WZxVeIdwLxEV7G8n42+fpwJhknenG+RdG73
         eR7ytRr+2Hi68tRd1jCy/p8z7eB9hT2z1wTzXOzahnmSpSuZvbwzaXPs2OxSdiTDp0GC
         2OekG2VuyQmi/pbE5icjpLNkHPPO3RsPMOMyKCUqYPjqHvrpQg9VpDM1eMPLRncJUA9E
         9pSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787082533; x=1787687333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NbL96y2dar0Pc04P73sZM2+RnuWRwl1qoFF81IVnwW8=;
        b=a9rVZkJTJ06y1ZMTrkPrCkpzUZQXF8YY34fl1+XTOtVNPL793lwmCHIz0GvFfj2e/H
         pJHV5UOG9wnuDNzjfSHS7nxqwf4Aw14YZdh6FuqxTGCAHtONsu/QUlD5jkAxRIUri/UJ
         Xyn4rZZ+OrJFH4pGExflMQIKnH7bcYLIT9uQ9fksREuj7UqnSlSI1pk7YTljaCgx/lou
         F5bNdac5JfyMpqMKNDh6BqmLBOEaoeIqtH9qNgwyFJ9lR7ydpgpLbDrVqelFK9WQSoN7
         gjBY8x/fbVVeb/Jiid2NQUgTsA0b7NJqSIaIHQiBTocE055To4GTItAhRADIWFUiCxBn
         uJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787082533; x=1787687333;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NbL96y2dar0Pc04P73sZM2+RnuWRwl1qoFF81IVnwW8=;
        b=bYtXL6ybu6XtBDidi5AnzL8L/ukacfKqTEEy9m5jnd11HLCskEnaKKoAFjh4QMeabA
         2h2ff8W6bZ7eiopfFEmBAE01eEvWgw0Z0ccijvgzRZx1QheC5DeqyqdunlOKedf26VJp
         c/e1uetBNkZA9FD25eomPEEzA9/TvmzSYPI25xS0T98iW/KylXBY/QpPfAPYBF+/Iqfx
         zWGCBpd1VxwvwhvoNdTTEQYDA6xjIztblokM/xCWMxpD2EzKPCRksEk362kndAMJIE+i
         02rdnOM7/oaP1ReJOB986UdNcGDZ2xLP+0ieLGyYcsa93mbDZu7Zbf64A0SeXmWS4csk
         UAAg==
X-Forwarded-Encrypted: i=1; AHgh+RpZ237kUqEbuBu5y5O9aoJdGCKv2zMM/U1j/8ChhJrvO5mqY72B8bORpd16UAmjVhidCxVyisWXJIClp519AfWglytUrGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YylJODVQmO46RdTp9+CAKHUYPKoItYcTRWePEPPoakQJn4a5d+4
	ZYJZcLdV2L1MVANDy8SCyj1CFwJtjMtbYCFoaf5yyLmNWmGihSGm4IQoHSRj1bENcdEpqZDXzSH
	CdAhGZUVrPs1SYJNGMhAPoy+XM6MvQRcL6nVGGEo3
X-Gm-Gg: AR+sD10a9t0uNWaCXJ1uNtXVDinERVkA8qpS8bOG7v3D9z3/00ziKvfNRG6UMFKVBYT
	BqR7e9JrcEoiXiTXgXNJ9aoDC+90BR71q9nVTXY6H9p/z1ozH6NMLeDYdWjCrGamYIfolDaE4d8
	ZmvwYDX3rNKHuUfm2SAxWHlQSqzcnMm2vzs62fwTjpaBoLip5kHWJwDeJLmqnwA93iAkZ2O/l7I
	SABEeE1+D7n5x6mYVIG9fQzrXLnz4PRqgp9Lr8CMHKej0zbdUhz2dUHJ9D2wh6NcqtHIykn2occ
	njgHfTjjmPZVR1zLbBceyXIqFnAEw5+0gwXxYS/8vI6d
X-Received: by 2002:a17:903:35c6:b0:2cf:84bb:1ebc with SMTP id
 d9443c01a7336-2d5f6ba5ad1mr3952885ad.15.1787082533074; Tue, 18 Aug 2026
 12:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815112041.1248855-1-utilityemal77@gmail.com>
 <DKRYZPV04750.1V3UXL56PKB6@gmail.com> <CAEXv5_gT+xcZauKug-VsmqSBtuMPEPtw7hubxn6-0nv=D9aq5A@mail.gmail.com>
In-Reply-To: <CAEXv5_gT+xcZauKug-VsmqSBtuMPEPtw7hubxn6-0nv=D9aq5A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 18 Aug 2026 15:48:40 -0400
X-Gm-Features: AcwNN1WUdAwPBQ6w2_WyV_dcHHbst9nZ7dsq9WTR3jGvtOxDRu0F7Wr4dM9TVgs
Message-ID: <CAHC9VhSs5noQexa5c5RiP_DEzUgGaZw1hwsP+T-HWRvvymB+3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] lsm: give BPF programs a way to query
 locked_down state
To: David Windsor <dwindsor@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Justin Suess <utilityemal77@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Xiu Jianfeng <xiujianfeng@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 1:42=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
> On Tue, Aug 18, 2026 at 5:43=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> >
> > Lastly, given the difficulties we've faced from the LSM maintainers, I'=
m not
> > inclined to waste more time in explaining again why this cannot go unde=
r
> > security/.
> >
>
> I'm still going to send v7 of bpf_init_inode_xattr series, even though
> it's a stalemate. Haven't yet decided where it'll live in v7, I'm
> inclined to leave it where it was (in fs/) since one side will NAK it
> wherever it lives. We can record NAKs and take it from there.

As a FYI, I'm not going to ACK any of the LSM changes with the kfunc
in security/bpf_lsm_kfuncs.c.

--=20
paul-moore.com
