Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44821221F0C
	for <linux-security-module@vger.kernel.org>; Thu, 15 Jan 2026 23:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768518595; cv=none; b=mO2JavyFooUcMksrPe8U0dJzZnhj6Ld+aiQNK3zA1NK7VyUuO6IOwzRV9cwPgKJh0+CkBHlJz5w6+VitdkoX+B5UQcVOH5o8qSb8jK+P1ZvwnPrlphnKxCSTfAUTZvl+lv5ShKvQfRCeorEZ7Jw8WWRrCJ1QgSZWKFd8j8ioHRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768518595; c=relaxed/simple;
	bh=b44Fmhb5MCC/h0Z4khpp8iGPJ8/T5BSX3KCA+nwZusA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgD+NDuflAPIZnmUphA6llAnUQyVQlr4YJ6EhvqugHy//8KKfYLItWpa1eQG1VLR1fClrGlWmqCzruxyaTMO6HduIToPbOCIQBIXf/twqWTJYftyuIDyHsYU9YHoh9ZTS655nyKFSuvofmruaRi1keHB4ocmCvCg1sDlj+T3SeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d4axZ2zN; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d4axZ2zN"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64bea6c5819so2475292a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 15 Jan 2026 15:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1768518592; x=1769123392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cQQ3tZ9MbmRpcFLtL2Gj/mIevTL7qyyp8QvI43AANI=;
        b=d4axZ2zN0hVk8evBT5x1N7G3DD56gSjvGUREhuu9+l8gDxT1Xzqu7y4VvlP0d/TC6V
         04K+JD0MlT8AFgOfCIvzNVSC5TKpzoHKGg/frb8nR1sVTy0VpvLTYZjutkZ03SHUfn9V
         fDt8cwkjybu+wn0w36CFKQpwAZLMIdHeO4vDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768518592; x=1769123392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/cQQ3tZ9MbmRpcFLtL2Gj/mIevTL7qyyp8QvI43AANI=;
        b=EjrW5hqoSuosnj3BplDh5fMzpcOqFNESVwpJ4x2BZBMQ4ovB6YIf3hJWA6D0RthAVT
         90rMyPqHTdegmpGbuJdlC0pFBlzxX6QODwTgr+H88ltGG2jjxQ7X3B1JyDjGUTSYXVZy
         r5jZHljl45xUFHSfe0yj7MpnEkjsEnTDydguD2liH2vPXrXf0Gln0ZK/V9I8z0uQT4ng
         kqMq/139xix54r6JEvC5w34089NntsglhmuHxq2zJ0sIsO9wW78n++cxRpOgecimtrK8
         Q2rfl5idWPvALRC9fLUQ4d7riQZ3krIVbFGbz6NFb07sbj0ETbUyYxBxFunysRj0El6E
         cgjw==
X-Forwarded-Encrypted: i=1; AJvYcCWQd8Z6cJ8vuX3LhwndPNfWP2a9ybvd+xhKeMyR/VzVLicWVqhwmRdEkW3wG804M3y+lKOFieqJANIIEUv46Kfr59kCm5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdZ2FCKcgoDm2nVGhayN7JoL/0YZiJ9jLRO2aJYc+AQ8NKiFIr
	SEp+X/yXCSPzNIMkAByQ4MsdizQJ+pEi3FDxIRILSIWLtIrQFCDUN+VN6r5oKR5hTpreXet8joF
	72sIYypo=
X-Gm-Gg: AY/fxX7bM6FaUQHvJPmpXBlisQ8ImU2j7/vRl0PjcOJhZAwGwbbCXZai1+8axTBa/y1
	HsNEgLOkz7AOi9pNhpDJdB0S6c7AHlSwe/zrKFtbqcXnxjWt34zv7YSRZuWvo/rtOFyK+MVRVPn
	SzhlRGqlBvqhsIdjcegPPn4lc/xOUlsHvRzgNOhz7n5aRJGZtRAaZiQ63LSFUgi2/BfVhmQDXPb
	2aRJbsFHKhzliDb1ee0Vd9WDppgK0p7Q8iupjmxUVPRcZDDuWR5rRhx1RF0zlAI7CqgvJfrg335
	PoKNFcF95rz4v17phoiNaYXu+jPAaZtYe8tg/k5EjJAIjxmSjOdZUdogsGRysJS2NkcDl3kbr6F
	OXd0ZmMIuXHXT37eoFwQ5746BhKdS7DNNzfF/5xqaYPqeSqEwgN2KMygY67hzWDxc1gJj4Z4G4y
	AguONpdthlNirSjFf5Az746kfjlMfATe23T7rF8YwwNbGs8Pvgx6j44oXeQHBSW8jWXaMWjTI=
X-Received: by 2002:a17:907:9492:b0:b87:1822:4021 with SMTP id a640c23a62f3a-b8792f5a9f0mr110270666b.20.1768518592541;
        Thu, 15 Jan 2026 15:09:52 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a31322sm58839666b.63.2026.01.15.15.09.52
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 15:09:52 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b58553449so2499845a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 15 Jan 2026 15:09:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5tWmvOPJoxACMW3Ke4h20sBHaXnBj2hlSgPRrOk+CDx/fpt/VMsVLLzVSxsOApt0ArtcG1gMS7M70QN+Gu41qzYQR44c=@vger.kernel.org
X-Received: by 2002:a50:cc05:0:b0:653:b83b:a66d with SMTP id
 4fb4d7f45d1cf-65452bcc0a1mr670701a12.28.1768518592019; Thu, 15 Jan 2026
 15:09:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115214740.803611-1-mic@digikod.net>
In-Reply-To: <20260115214740.803611-1-mic@digikod.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Jan 2026 15:09:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgPRijTr7fZQNs9pxbhRLBVQGdE7ceZDwQFP53MXjRBxg@mail.gmail.com>
X-Gm-Features: AZwV_QiiPsCZrr2CTXJLdelIItyvHp5tiByv6aRPU_bH5dEAxzNiv3JA5E_dLHo
Message-ID: <CAHk-=wgPRijTr7fZQNs9pxbhRLBVQGdE7ceZDwQFP53MXjRBxg@mail.gmail.com>
Subject: Re: [GIT PULL] Landlock fix for v6.19-rc6
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Tingmao Wang <m@maowtm.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Jan 2026 at 13:47, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wr=
ote:
>
> This PR fixes TCP handling, tests, documentation, non-audit elided code,
> and minor cosmetic changes.

This seems significantly bigger than what you sent for the whole merge
window for the Landlock code.

The merge window pull was - ignoring tests - 4 files changed, 59
insertions(+), 17 deletions(-).

I want more explanations for why I'm suddenly getting more alleged
fixes than I got any development and why this shouldn't wait until the
next merge window.

Because honestly, this just all seems out of place.

            Linus
