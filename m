Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBC3268C40
	for <linux-security-module@vger.kernel.org>; Fri, 10 Oct 2025 03:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067011; cv=none; b=mjbTRw32qLCZHuh4XaIsFx4d00q1c2ng3/3+eClpMgTK8rmWqt779WUK8nwz68jtvMxN0ALopyQWjyydZtHPNJMPptdlGVtjrGj4tTkDyGj7FDI2uuwgn+oq6hMJddEeK4L5fs27Np01lH37HzurkD/YkVpzLmv1tng/PzkowG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067011; c=relaxed/simple;
	bh=UwYI1Y9zzpkLWZonQKLPHrolSHjRGw+LY5fd58IPCws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2QSsZ8H04XKkKt/fIKQZerUUlQnTD5Jr6I7xdY4znFpGXlCwDOgARPNmW29Gr6EkfyrgBAf1zP7X+dTTDgSHhAf8F3vKmcGfEcqCDeIJ9jDexsETNXn8gMer0uVf/ovK47/uTCpi3aeEHecUcyKc2/yB5WEnbrUgKywUGdZD50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1DA0GK1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1DA0GK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8528C116B1
	for <linux-security-module@vger.kernel.org>; Fri, 10 Oct 2025 03:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760067010;
	bh=UwYI1Y9zzpkLWZonQKLPHrolSHjRGw+LY5fd58IPCws=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s1DA0GK1N26hb8WWnmFel9nQ94mCRxpbVVZwaFKl5XjMUFFzByJ9g3Zo4JCqloZEW
	 nCA4RH+l5DfKPp4JIen49URYgB5IfMNC9l/TPyyE2Fblbe9Ajq1eT6GcW76aHmG54O
	 baNhvQmTwMu4kxAXBm42ITWUEQHPHJ26aZvnDd62Yh7y8gkLZ2JE8b3Ofm0J9qa7mx
	 Sgpw9n74QFA3bp6SXmFdiaIZux3gtMtAcqEkMPUX9kKf4+ZNBujXffq6w5S8TS2Ixx
	 TmOPPO1varkTxBTEoq09b44izWYST7a8kB/IUfkmxz2rCCZ8H944W/BkNirMj/DSZV
	 FYH1bLm+YRzKg==
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3306b83ebdaso1429475a91.3
        for <linux-security-module@vger.kernel.org>; Thu, 09 Oct 2025 20:30:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJUI8q9xzzfT+oL9HYluQ0dGNOdAM+RDvfL0StfXj1IOp4QSfUKSUSY5ex1bIpk29vX/yNPKr9wm20TJeOCiyauXXFAV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEaNsS8uLkPc15Uh2WhQoFCT7wWgOVJf/e9OuV3M0KPIShvsgf
	Tv6zo4Tsz1/19XlATzIz5cRSzHiiumnJFN5OUEYSz84THxxEUq1uWuL2l5TCbwWSFxkTHVgbF5B
	FAoyns/kDnw91asp2N1zPv3z6NRaWIVY=
X-Google-Smtp-Source: AGHT+IFC8y1COauSn562LCbBBd6ugpsfjo0VIlf7hz5sw+24Aezq7s8KdouhQV3Zdib7V9MkZYqnVr9+gUZV0IfsSLY=
X-Received: by 2002:a17:902:ef07:b0:288:5d07:8a8f with SMTP id
 d9443c01a7336-2902724dc52mr130716075ad.24.1760067010423; Thu, 09 Oct 2025
 20:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009154525.31932-1-bp@kernel.org>
In-Reply-To: <20251009154525.31932-1-bp@kernel.org>
From: Fan Wu <wufan@kernel.org>
Date: Thu, 9 Oct 2025 20:29:58 -0700
X-Gmail-Original-Message-ID: <CAKtyLkGhdPgtXeCYpxO8p7YjQ8a7CUygUn63P-Aj71zsfP50wQ@mail.gmail.com>
X-Gm-Features: AS18NWAKOC3o3IQbceKdyO39h8_ejvzlFqnWt_-WVj5xoNLtcyI_W2RGz9u1SM8
Message-ID: <CAKtyLkGhdPgtXeCYpxO8p7YjQ8a7CUygUn63P-Aj71zsfP50wQ@mail.gmail.com>
Subject: Re: [PATCH] ipe: Drop a duplicated CONFIG_ prefix in the ifdeffery
To: Borislav Petkov <bp@kernel.org>
Cc: Fan Wu <wufan@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 8:45=E2=80=AFAM Borislav Petkov <bp@kernel.org> wrot=
e:
>
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
>
> Looks like it got added by mistake, perhaps editor auto-completion
> artifact. Drop it.
>
> No functional changes.
>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

Thanks, applied to ipe-next.

-Fan
