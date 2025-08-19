Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4442848AA;
	Tue, 19 Aug 2025 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755634099; cv=none; b=sAqa2KK7qYv9h1A8VgxMkTDbCcXg03I4y2zKBuBH00wWXZrA4LnmuLfjwYNaBF7KNNYhUlBxOXkNY9eJ3lYBm5Y+44yUQDjOd8B8nR99NCyr0WPDyXE5RmhsoEl7+Tikot1Z0izf5yS4aieA9TCqFGo1BS1e01wREjFRW8QiYo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755634099; c=relaxed/simple;
	bh=mTlLybo0QoOcSNs2d/mPyiK88ZnI9/A14rGh2D68KKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRXhUotKGCtDOaK76CDE2Nlh48/qTP8pWUsM7h8cA6PBIiixDrmVmZjTSGDe/2vpM4aEm+uymnv4HJqsir+NCyHS0reJV3IwlrdtfBFxGaMlUyiebxJIw42g1yVo0zG5MgmhLE78pHZAsqVkt8YQuli7jh4huOCUGYvlj5Rl04k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMgMEYF+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMgMEYF+"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2445806dc89so8485245ad.1;
        Tue, 19 Aug 2025 13:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755634097; x=1756238897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayBfaMjVSa2pLtn9khQGd261i74IabYZ8vfPSN4zksw=;
        b=KMgMEYF+tc0xRsIna8BFEKvstHwPzprNM2trL0fvQJMe0ujSyPKME/8qHhWEItbw9T
         dv47Th1q3+akVpINKiIi5KRJFyMwsO78GKGDVKD28qHmzX23+J8vydulp5wO80qiZYqi
         6PwkAn1q7mofF4HQeJBkr9YVXoTD0Osf8q/6W7r0BZ+2W2AvVwehjpNSqvhmKgxPSAxz
         /tg3WRxYDR5E/mvRcajpvhqfsJQDljOxmCYu1PVP0wq++fpTtKQasyyRcj5ci4HMCt3L
         fA6Z//3TdZot1wCPNLF+yITXPk/Y05DhuF8PDuB11Bud2O9ijgK/25KoNT1d90qmvbHb
         wEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755634097; x=1756238897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayBfaMjVSa2pLtn9khQGd261i74IabYZ8vfPSN4zksw=;
        b=jsu0r0r2OW1Cvq07PX1+P/aecnzzSU1o2LJZLMH/6vLRqq0PZl89JWdVMg0A8U7hR5
         /c3tZty8ZzMvl9xkB7BvqWAo4MXQGCrFX5juWNOEEbwxw8ODyOYlislQugFeMezjHlvX
         QrpcxvF4pxd/IeMHUHsuLVqVcfYVnlNY0k7U7XuKiovdwFx/AjL+3O3XMzdhEZm2PIE3
         ICPFyYMD0U2ozRHuGbfezVRW3nyYhHki+GFiu2ljHwrfdrMXXlY+zIox0+ywl2AbiMT5
         6h9cSLmsPTftqQ7GH/IxRem0AU6BqcbMdtV21FlMfYvjWwG2C02HB5ATRKoSVN1FF0sA
         VafA==
X-Forwarded-Encrypted: i=1; AJvYcCVZwj3SqhWdQMzmpQR6oelHqW9oip4pKbw7uFkKVjzNodH7ues3bBhtoV5Mgyyv1ErdXUTej4zoHH9gAOMHIgQ=@vger.kernel.org, AJvYcCXRirnfK8kw/SaztfOo0bf8qTCY7SJIruJoYIzk5wr0aPiwORyurE4vpXsu0ab8JhwkudPZ/i+Tvq7ELIw=@vger.kernel.org, AJvYcCXk6GKuAEBfyV6G8tZUTwZc43/4bMqzEmeStQEUBigADfp07EKdMm0UkrrOzJRcxd+SZzKrTFfMLKQLmS0TJCnA7gE7e+rP@vger.kernel.org
X-Gm-Message-State: AOJu0YznP4HSG42G9Dp0KT1pas1g/fkcLILJpGt9eCxi6KxqE8ZI/eM3
	I8pCZ+NmXzKStLRfDfF4Ifl9aatwg68MoUKw40yZk0xVksz5mObIGcwV1Mk8feY8PASibTVVbIP
	wzrBRw7xzZn4aHYaQR1NdeJ2Tk6UBUrs=
X-Gm-Gg: ASbGncsYor7dgUKOouDjIF0C4lZtVQBTtdNhXo6sfe3vTc0Yn12rNn0wLTDR+Om14+7
	4oFkz7jUD5m91dAUt5UsU9LIrkvvm7LQO3r+rQOfm4Y+hHIZ7/OHHjiNeC0KCk76WREYt9MlCwE
	RwDAewwosMQzrvmVGpemeA2/D/0PjGnqboPKt+askp90xNwNeHYaaiTd0/Cvy2akwnf1TCT84Wh
	M6hHG2Z
X-Google-Smtp-Source: AGHT+IF6YjB9fwvcSPVBZ/HilzzdSmraaHI2nlPQrVCcuaQernRFaokNv97vuNIty/S5gOCL5ULRZrWto7bVkDwmqvI=
X-Received: by 2002:a17:903:22cb:b0:240:8fd6:f798 with SMTP id
 d9443c01a7336-245ef166cf2mr1816265ad.4.1755634096816; Tue, 19 Aug 2025
 13:08:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816114409.10107-1-shankari.ak0208@gmail.com>
 <aKKdULYbLFRMS9qe@mail.hallyn.com> <CAHC9VhRwpYx0jVybcAnGdm4AGDno-GwyCzZCS7U+56Fwu2tuCg@mail.gmail.com>
 <CAH5fLgin9OhTmf52i2hQKztYLcHTxE+n1gMPXDFN83atE+u_oA@mail.gmail.com> <CAHC9VhSoyh3EqFqYD7tXDmPXsao8FLQo2PMAKEmJVJ6khPA51Q@mail.gmail.com>
In-Reply-To: <CAHC9VhSoyh3EqFqYD7tXDmPXsao8FLQo2PMAKEmJVJ6khPA51Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 Aug 2025 22:08:05 +0200
X-Gm-Features: Ac12FXy3NwdtF7idux_OKigG74fa6K021NOstGEPaHZFntnKS7iYP8o5tl2p2RY
Message-ID: <CANiq72n-4_j44DbQkD2oT3enkn5tdswLwETNfSPFaqUgKGRB2g@mail.gmail.com>
Subject: Re: [PATCH] rust: cred: update AlwaysRefCounted import to sync::aref
To: Paul Moore <paul@paul-moore.com>
Cc: Alice Ryhl <aliceryhl@google.com>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Shankari Anand <shankari.ak0208@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 10:06=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Okay, patch sent.
>
> https://lore.kernel.org/linux-security-module/20250819195841.238246-2-pau=
l@paul-moore.com
>
> In that case, I've gone ahead and merged Shankari's patch into lsm/dev
> and will plan to send it up to Linus during the next merge window.  If
> something changes and the Rust folks want to send this up via a Rust
> tree just let me know and I'll drop the patch.

Sounds good, thanks a lot -- I replied on the patch.

Cheers,
Miguel
