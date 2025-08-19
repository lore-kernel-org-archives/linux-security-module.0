Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1958F271472;
	Tue, 19 Aug 2025 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755633838; cv=none; b=G/fJ6mc5ve+jCkl5k+mm2H7ufbjgZDYtXdEFEkocmvUdanh1ynW/cCKKZsUeANpHOtjthcgIZtzhv4brKIeMC8z7iAmyRXIOGiIJKfrRE8UUK0ILzPA9at2/RAMFm1OG+rzBEeaVyhfqi4QBLXWw7HGSvEL6SmShKsv2LDxAYfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755633838; c=relaxed/simple;
	bh=rTVP19kuX9z4ilZTIXM/dKx6fGXjWcfgz/aLkcj4l/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dorx3lArgBOBKUqb0V+3C1hlTUUHHHQlj6WgYlJ1/fmgK3M0PtezpmMyfS7QrNgBwvuiSqsRkf0Wa9IjhUvrV0l1dP1sWhwFcwHHFM5ZCDjMfM+dV5ljcr+W4CMM5b4gRsva8ZqiVLr17yy9fZxOQwO9xkJcew81o5aarWxfEP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VH23Q1iM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VH23Q1iM"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2447d607b70so3761015ad.3;
        Tue, 19 Aug 2025 13:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755633835; x=1756238635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTVP19kuX9z4ilZTIXM/dKx6fGXjWcfgz/aLkcj4l/Y=;
        b=VH23Q1iMKyQgW0M/DWlGnVM5IWf1lzhzXg8Iy7LL6hjoVBHXM1IlJoC8Aea9l6Yi3Y
         4AL0HPVSx1p6OTRbDR+wkMCiVsAPf/MGPWWjXPZGlmzB49mEqS5SSt+9RQPOIeSKSKp8
         aDNXmCyzBBY7V1bu4nPoNFl6EqfgiyQ6iNolbm0kIxFmCmnolBkZZG5km12hiXXWwYZP
         SJf8LBqzETfj3Wx78oow/iC+56v+GXVUTXCm2ht4kX4JqD5NUgm41OUpP8roGkj47lzr
         /RtGFQcMS4dFvZrAqeBKR7RQxAb/s+8gfbqe4EtFmMocAkR0dZWHP8LUTCRMyUBU+SBe
         ClmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755633835; x=1756238635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTVP19kuX9z4ilZTIXM/dKx6fGXjWcfgz/aLkcj4l/Y=;
        b=P/bXehuA4+oU3t5F9kQWaxFaUnA1djLuIhJdAjeKO6+K565+w7zUlRT/His7IZm8oH
         c8Xa1WrH/DV/2gdccqSKgztmyeTU7OOs+C+dA0IIxLEYVFT/cbyBr+88fKFRviUFQKMS
         a4RliO6UeIq17heCGM2F9DgNtbDiGOBqOlnMbaHmZ15zqE7tnuS9tzm3EHiQNj7glsWt
         LW0I6mYvr8DsjGKKsXX4NowWwZ8CIgJUA4YXNWZ2ISkpisdVwW4eCKFMjQEgzndAB3oB
         agQ5HJv5bQ9TlA2B9behYAGdz6lyhNCEvvbzEGBMyWVIN9sXs/A6MZfBeErcEsJtCDyC
         wRfg==
X-Forwarded-Encrypted: i=1; AJvYcCV4ISeRfbg0UY4NcUTGfQgWAITykhUZ2t8sYQhUWKR2sNTTTtXs/aNHLBkU+DghrjK2lDnCsp5t2DoQYW9NWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNBfs4MzzN1j22v9CUN84ePdDktMAGiR6KS1/YTqnT44vvzQqZ
	pnLcF1Y7vQwiCFvDtaPscK19hcfWbgsxbowKEhX9959Umk3j9Rs5RTTYWz9tctEKr7L26tQvr3F
	w0s/GXiGyRspD8UD4QPvwevP0zFQaiuocmv0ZgMk=
X-Gm-Gg: ASbGncuxE568IgXdwUXdbpsBqqQkS2+Tm3gnnLM7DqyfrEpcYBWy9Oj4PIflOivndgR
	Qm3Uf5rNCdYlt33BpCA6JDl6m3eBjXS0UtcBw5KRAg9GiOoBDzpR7iJbvr5MwHiwkK5cgSNicTO
	lybY74pUEfIaM/wU3dHuJYVT8dpH6lHNJ+hN/2Iu+o3510k3SkQqm5O07AUiwgFiLescTtw9174
	ORWRBb1
X-Google-Smtp-Source: AGHT+IEPaZYukJ4IdWRl5XUPLlbm320nNCd+bEH2Gb+NxcNewl3Sqpfcd6vgEx5A0I5mMGSHn3aDuxOjwvkQmmXb1ns=
X-Received: by 2002:a17:903:1a68:b0:234:8f5d:e3a0 with SMTP id
 d9443c01a7336-245ef11a18emr1781815ad.2.1755633835210; Tue, 19 Aug 2025
 13:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819195841.238246-2-paul@paul-moore.com>
In-Reply-To: <20250819195841.238246-2-paul@paul-moore.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 Aug 2025 22:03:43 +0200
X-Gm-Features: Ac12FXwm7Ez5ZJmBzBEUk4vgyM3DGBmh9ZfGDM3Syy2dHncKfy0E_Kw18SsqNE4
Message-ID: <CANiq72nkvcGesG+XUzw3b2pyN1-J9Eo4utsEAYnBiifOvGGpQg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add the associated Rust helper to the
 CREDENTIALS section
To: Paul Moore <paul@paul-moore.com>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 9:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Sounds great, thanks for taking ownership of the file!

Cc'ing Christian, since he originally took the first patches to the
file. (I think some people may be filtering based on whether they are
Cc'd or not, so it may be good to Cc others too)

Acked-by: Miguel Ojeda <ojeda@kernel.org>

It may be a good idea to give some context in the commit message too.

Cheers,
Miguel
