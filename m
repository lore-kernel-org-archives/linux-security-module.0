Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F32227EA7
	for <linux-security-module@vger.kernel.org>; Mon, 15 Dec 2025 07:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784360; cv=none; b=PUy7fKkpDC2jkYGS2p78TZGWVSlAi5SuW+iWeFcBtq16GY5eZ2nC35tFzNx4QYnxK3innw1tN9nFduVQrAXtvGpmImbj6ZRkiapzAXWoty2sahf0oCpgynfwo4HqPP/sjynubTmZzexxsseeL4Aegv1rDrC0kGH/El5w67F2r50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784360; c=relaxed/simple;
	bh=5MbOIYibDhPlrDcZFo2C8sMQhU7XkvcE8cpwK8O6wYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnEOEws5oj378QUWN1EjV33VYo0hg55VD5/CpaP/8l2oXU60LMmvkW2dRINItaluronIiDxOzHHkWMLrV6vHrQTd0uoO559gMyfFDWHqGE3Ani7SC59bjsemX3mo1PNgdiUEWakb36XcyLsiP0IPR2kBasjy4sRPdxFWyEjstDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SWl7Hiir; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SWl7Hiir"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so6357231a12.1
        for <linux-security-module@vger.kernel.org>; Sun, 14 Dec 2025 23:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765784356; x=1766389156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qSHSM4pgYx0xKFYv00pxu98I3FB9CQ6N6ZXZkiv41/M=;
        b=SWl7Hiir1AvDlJCYUbniAXxvo9go4HGIK/Wdnrrkd/VZLBdwgl4SqfUxp8Xjla3U5T
         bT5/r0qOCARKkB7K+IdXhT5JIt4ykYMyBSC1eCKofRJN4gj8CsabVHoNyGwXHF2wqvhj
         +bC+U4kookHX9Xc2PIWX3reweOBETiAWSwXwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765784356; x=1766389156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSHSM4pgYx0xKFYv00pxu98I3FB9CQ6N6ZXZkiv41/M=;
        b=IUjz+mdZchZWHYbTeDsia8dn3fpPP4+lKQFVzTJ3JyP9z2KWT/lprPaspUE49M4io2
         7d3t7Y58/oe/OnmCQMZY8WbbPCkz7lasxl2u59sK3EUok79s+rkiuXp3LaVNJuhoMGxp
         3fb/rOcSJ8vrrmMKRVK/+f889pR5rjeqgQlZ4Y83wNt6vJWlAbAR15EOb52mXtHigcQK
         NOQG6ksf/EA4xx20KnsLragadqACVBLHitCkDqS6gqSmOr1G7jfMW+cHwDpJgiyxbJ/n
         se59ozckzAB5oFi/s69oePP4E5oWAyMjf08l90Op7Uam31HHXMX6qVab1RuMaa5eQ+cH
         yS5Q==
X-Gm-Message-State: AOJu0Yw3Ho07EAwkvSuc/J+IgBAbY2ZoAog3yYobJbRfY/K5ZkTOn9nO
	UIYu79ozm3H40RpTb77FrjYZ0Ke1fEIlTv6c1dxCH9emN1TN2vY03NDGsAav3kUTyHKT2LQkx6X
	AXZ/iIIu9Lw==
X-Gm-Gg: AY/fxX6glCzngp2qqSkD0I1xClMT7cZbmpb+R8oBA2hv4lB2B3wlAyUepP62aStQ/H0
	gDqrW4YII4mcd3raTV0TzBYlLd1zf1rBMtWklpVYO7KNgtN223j/sMUWvBKaRp3vEnY5m0ejx0Q
	nsvIHUrxImllNIG1fe5Q+usrEZ7AyLQtnPXtHnEGNuWT9Z1Zw7upsqEWYuouJZx4BanbI1bySfa
	hD2O4UguCIsiMORGAUaUrEcHAufuw2g3GKPIsfMPfjSMgM44bU5oO7NQHWS2vOltW+KgtfFaPHM
	6v61/9M1PP/YoOphU3yIGrOkZXupA0w3IWGSQ2ROylMTgxWQb5tAYKhDrHX1wgcZoju0LEXOeHr
	lPyQNRXEfJqbQ8/S/myMwHi5IMnj/RmeUXoNDttzehwf7yD6uTD2b3orIa63zjY/EQZfB5oYm/D
	mR0bFvE8F8cjit5ZmpNHc9Q+6KZS1FE3I81o8Cy5pFg5q5U20PaGDBHQuF9Uhh
X-Google-Smtp-Source: AGHT+IGxUhlH187tPImx53RVN11j2T8Hk5V3iPWgCOYaGIwHDJ+9gCepwTika761gb9mmvcK6EyUCQ==
X-Received: by 2002:a17:907:c1f:b0:b77:2269:8df0 with SMTP id a640c23a62f3a-b7d23ab386bmr939395766b.28.1765784356261;
        Sun, 14 Dec 2025 23:39:16 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2ebafcsm1330344466b.28.2025.12.14.23.39.15
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Dec 2025 23:39:15 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64162c04f90so5957104a12.0
        for <linux-security-module@vger.kernel.org>; Sun, 14 Dec 2025 23:39:15 -0800 (PST)
X-Received: by 2002:a17:906:ee81:b0:b79:ff62:e994 with SMTP id
 a640c23a62f3a-b7d23a7cebbmr1033881266b.22.1765784355049; Sun, 14 Dec 2025
 23:39:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215070838.GA7209@wind.enjellic.com>
In-Reply-To: <20251215070838.GA7209@wind.enjellic.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 Dec 2025 19:38:58 +1200
X-Gmail-Original-Message-ID: <CAHk-=whqzs-3u6Y7UC03A_XJEy6H1kNWvFO_A8jqsuob7SZCLA@mail.gmail.com>
X-Gm-Features: AQt7F2q0X6PlDJGnkyMDYUuj826gW7cUMFlULbNcxB9xasY5GnRZ0AdJ2J7Pw_k
Message-ID: <CAHk-=whqzs-3u6Y7UC03A_XJEy6H1kNWvFO_A8jqsuob7SZCLA@mail.gmail.com>
Subject: Re: A formal request for process clarifications.
To: "Dr. Greg" <greg@enjellic.com>
Cc: linux-security-module@vger.kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Dec 2025 at 19:13, Dr. Greg <greg@enjellic.com> wrote:
>
> Three years ago our team had submitted for review our TSEM LSM that
> provides a framework for generic security modeling,

If you can't convince the LSM people to take your code, you sure can't
convince me.

I already think we have too many of those pointless things. There's a
fine line between diversity and "too much confusion because everybody
thinks they know best". And the linux security modules passed that
line years ago.

So my suggestion is to standardize on normal existing security models
instead of thinking that you can do better by making yet another one.
Or at least work with the existing people instead of trying to bypass
them and ignoring what they tell you.

Yes, I know that security people always think they know best, and they
all disagree with each other, which is why we already have tons of
security modules.  Ask ten people what model is the right one, and you
get fifteen different answers.

I'm not in the least interested in becoming some kind of arbiter or
voice of sanity in this.

              Linus
