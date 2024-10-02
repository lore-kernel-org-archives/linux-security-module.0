Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E071D1518
	for <linux-security-module@vger.kernel.org>; Wed,  2 Oct 2024 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877728; cv=none; b=PrB5CSd6pXSpa6WU4msj3VbIKIQrlwE0RhOC6jd3qjl2zTZPIKWOecZgzyEH3FKguxaSWIKKKqcy1JRLG8ropmd9DyueAtjwWL2SX5BUrZQHWPBQNnYzCoyp8fwW4+Fo50d6hhA2ntPmeBqkNds2y/M1McF2jf2/MAnVOuaL7yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877728; c=relaxed/simple;
	bh=7BrTsAKh4MFpdR9YBwkIuwHmvrRp75lxEmda2w5qUJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=se9WTTkytTX+n5CGDgsr3WnYxsqbk0t0ajEccqe08xFlKzMfTlM1re8/LOffXtI+eTI1pcjnWgWRhDFXkWPnhm+4PBM0GuC70EcU6DIMUjazrWFkyMgJaGiL4teaDOCp5UThLPt+MZ7KnGLuB+ubJQYta2rK6EULyNEjMR4oimE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aYu9Idr5; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aYu9Idr5"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e25e4023cafso4510746276.2
        for <linux-security-module@vger.kernel.org>; Wed, 02 Oct 2024 07:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727877726; x=1728482526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hU3AfRDfh1aF4aXzKGaV2H7rkfLnCR1DkDAZ1hTclEs=;
        b=aYu9Idr5zbC5b3bJ1ZQi2tvc4FesDTQ+TiVfegtIK5lwv9ats943pDuE8KXP71d2Qr
         gyCSwa0qoqxIsApW2HOR+Dm7WwnEd5ZBkGPcSlDJJfJeH1vKHWZQgDM5IpxOh4HwV3dQ
         hP3tXsBZTyO/0kXnMZXAaggCXP+xlZjpG5tuvQ/Wj9LN1bQbHaZIxzlI/e6bGtNeBpqa
         ooeuqo132uEUWsjg+nqCh4UVfRH6zq0EJCR8gfMpHVzo00R6bwd1CXMjOAsx/IwbUmVJ
         ZQ9t4obSuU5zmA54a3OF/jh6gf+iT29jiKJun2pX0rEM+U8Kjf3wk9h4x5x7pYGC5r8t
         CDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877726; x=1728482526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hU3AfRDfh1aF4aXzKGaV2H7rkfLnCR1DkDAZ1hTclEs=;
        b=W9hbc8MmCxDY3zhuYJHPg78aKmmKXN0PumZpLFrHFAy09OVEf3b/1BPyAcgGRL9bGR
         aISnWG8GfJqkF5r+Ar+9eZHYj5bAsnwQpT/ujk+NC+lp8UbAO3gJXt2dvNHR4CZxpE4Q
         R7JzdH+JIDmHap1mBxO4M00JbvHWv3DPiVg5K+PYjymj2Y/Qld2bVT2pnKDVSuc3AI/l
         eXjHU92JBGxeeyJcRL9HmMGJ3R/amqqF8LEHMWcGzmnB+Zf6maLEJLudEPjMoIC9W0TO
         R3BjMAYLHp7W6b7eaHJo+oxREz5hh1EYiNO7k2ZFBiTe7Re2peUjS0q970YPANpITfzC
         MO5g==
X-Forwarded-Encrypted: i=1; AJvYcCXUhYkKxnWyouWSMPg0qbnlJE/GGa06EK4a4Ajf5BiBRpzzdtuwN/d20CVrGaB+nFZG0Z4B26hj3oPvXXz3JEVwmkqoCA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7lENS5i64h5o2TCjxgqdVJztouRBmixoDP12L6ZHkHAx3pCkq
	/dtdGbZraVVRNcX5WPym7ESLk+TG+dOtDprBM+1UewoB+Z9otQ2DaKC+vuui9eaWUWsgLBH/Zyf
	tZU8tAsFwna9SE69F3StEo52yH9H91U3Bzunga+T1XWjPBIU=
X-Google-Smtp-Source: AGHT+IHxMeZ2QMGkwVqefxWia7dXDdxuFAW9bJYl6/vLiZMsrnWrsRP8Q/j2Vva+3XWYlULqu0GU9E+R8/EoarfWMWE=
X-Received: by 2002:a05:690c:4d01:b0:6db:d7c9:c97b with SMTP id
 00721157ae682-6e2a2e3672fmr30677237b3.40.1727877725970; Wed, 02 Oct 2024
 07:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net> <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
 <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
 <CAHC9VhS_8JtU0KQyy3rEGt0CQ_XMQFt2Kic-bz-Qd=SMjeWe4Q@mail.gmail.com> <19e29693-718c-4667-ab40-948718bcc6f5@I-love.SAKURA.ne.jp>
In-Reply-To: <19e29693-718c-4667-ab40-948718bcc6f5@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 2 Oct 2024 10:01:55 -0400
Message-ID: <CAHC9VhT3yfahvwSVqGHyQq5SDpf8QRjDoEttoyD0zSau41Sb4Q@mail.gmail.com>
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	LKML <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 11:32=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2024/10/02 3:22, Paul Moore wrote:
> > Starting tomorrow when I'm reliably back in front of computer I'll
> > sort this out with the rest of the LSM folks.  Unless something
> > unexpected comes up in the discussion I'll send you a revert later
> > this week.
>
> What I am asking LSM framework is as simple as
> https://lkml.kernel.org/r/caafb609-8bef-4840-a080-81537356fc60@I-love.SAK=
URA.ne.jp .

You mention that Linux hasn't supported loadable LSMs since v2.6.23
when SELinux was the only LSM implementation in the upstream Linux
kernel.  In the (almost) 17 years since then we've seen a number of
new LSMs introduced and merged into the upstream kernel, each having a
voice as to how the LSM framework is managed.

> Now that built-in LSM modules started using __ro_after_init static calls,=
 !built-in
> LSM modules can start using !__ro_after_init linked list without affectin=
g built-in
> LSM modules. I can't understand why Paul does not like it.

A *lot* of effort has gone into both hardening and improving the
performance of the LSM framework.  I'm loath to introduce anything
which would take away from those gains, especially if it is only done
to satisfy out-of-tree LSMs, or users who don't agree with their
distro kernel's build-time configuration.

--
paul-moore.com
