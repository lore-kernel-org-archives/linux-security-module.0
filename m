Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6047DFB0
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 20:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781124127; cv=pass; b=hk+9UYvxT77uTEZEVIBF1o2YZ9XlRh9IaIAMvFsTdMZYQmIhrUuBPgrD7UmhonHZaZJl7r+T3vgq0fpECUH38XJ4w+1G/EqSkJlyQmr1Y0aHjHUcgOVX+RyTsrnw4WAr8y6k/DyTq3n/3DF/5pYd2cqFgxSXNPvHB3opuFg56TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781124127; c=relaxed/simple;
	bh=gXP3ndAsKNjuDSlFH6w+TobFDE6Il8749kvMxRWmd2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSIV+K0Iifueb6ZKJ9zgz57h8vTsn0ldD5xaOEF0ZW96daMJKLMtFDfLFLSGxhNwrb+PlJsPqm1RXRzD+6+ov3//xMGOj/lazPtdnn/jtWM7r5PuhmoZnum4oSt582WLDesSzX3qWqRZNWOd4Taqjhg+I17+AWO2kvtOo7wKiyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdwAJ9yw; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdwAJ9yw"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa65757ef4so750044e87.2
        for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 13:42:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781124124; cv=none;
        d=google.com; s=arc-20240605;
        b=jaWzH1kiUAq2LEVU8T5l0xP3PmB2TFUFyVxnH3p9I2JUpEU/yObtjE1crOb1+xPuPK
         eNpPPbt+QakFFi8K5IORZRnP3z2eCZi5aBqgJQiMg9AkLRhBg7Qt9nNFoFOG6A18EWy4
         oS9TkpZz47xwW3XfeMdUq9H0XDQlccobJrftggFgPkCfhD00xr9Ur27fydJhz/8lHiOQ
         zszETUKIebi0SIYU0Xy9WdYRDjzGxUiwzK0awKAZv490IwND98kvSE9phG52SBIUBdOD
         fIN2SwcdoDM+oQjUUpIb2WQcGmSZxgIWmm9XUELB8sE4+1agnXnV0c/T4Czb4KG2u7vf
         NX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ojjdRU7C8G8Jli98gKi2UMEANrqIYaK3aEdrLJL6lYU=;
        fh=KFLa4H6nRiPzEXQnCTOLyjXytorpr/UHJRCYO659sCY=;
        b=RV0JO9dvgJ9Ew6K8V4EsaGE1F07PfQcMJlh+R7yL/jFukP54kU6/2U2X40aUGrhaNu
         ALM7z8unPclWrB7th9wk2WqiHLo6OVTn0Yk6DXh42fKDK/fCdP8bjAi4aadYkin6SYSn
         PoJxn7uzz5GsA8PaU4Wd2E/oflh+tyEdwr0CmrK+Lh6o+Ki6piGEM0pdbdd4qLoo5vpK
         I8YQGevWeqWk3+uyp0L0jskM1o74l9a5brzS/1AkvXd4ajFy6zbw3cBm7+FW5EF8Jvxp
         VaW8gulQCoryB2iTUcvpsXfegT3CobzPIWWIFsOOMNV04dp6tVUSYXOjX6fDGbLvcygr
         +VXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781124124; x=1781728924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojjdRU7C8G8Jli98gKi2UMEANrqIYaK3aEdrLJL6lYU=;
        b=AdwAJ9ywfCRvkYxn7doKCw0g3pjI8SF+Hc4hi+SfYiTuGGQqFW6f1ex/kPEyFQw30A
         cYDzSmMmI36qC4HSGY/9gzekbSp0Id/JTvyK3rcAw5XuxE0PZZb/9/BcP9z9FqHuoCt0
         1ZpoWgmLapgCz7nQSLqVRSiNA/kMCCz8oAx1NNQaTjQrEZk0XnmwKZ/rmw3znaQq4e0A
         vA6XQfFj80bGI8eAlUt3HVDJ3pqXcLQPd6y3WgCRIgUPG4daWymxkvk5VduzeCOSLKi0
         jhLSfO+BJ/F8Ch/+TlPfq172IAYDzPlVWUmxzn/FxR+BCkHjI2+6g3Vzgxj/qdcGYsmY
         RLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781124124; x=1781728924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ojjdRU7C8G8Jli98gKi2UMEANrqIYaK3aEdrLJL6lYU=;
        b=UIbYQ+3rM0wEp6FCrCvRRUJMbFDPT907z4/09lmHS4EKvba8AR1SBrkX9zgcDwGOnf
         XbcXmDXh1zqjk3S/lCppUuptMtVVrFe8yuYoaLznEoWQQyK4Ay2IYGvDSGJuYYNo1w9f
         uf1u3hFoZ1Oexs9unvOnyUaKmFNS/DdR1uf8+vcGgrxWS70LBeJDkeAAisgUXZ/Alp8W
         Pmm3rOUZCxE3MxfxAclxo1P0/PbLgFzVqjrwLBuQbMHBAMohISI4jGnngSRTgHOUvWwE
         Z9rrP2pfGURwrmrqOymzU1wtdDXbfRbqL/jUWEANVZ6kqF9f/2u2ayt3gotrLp637atb
         TwnQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rlhWxrX7koARQZBGF0XmXVNk1VfEw28zK0D7JGyu4e19OKjRPGT7g0wramEUi8N0atam4EwNqz/XqvMuz3FGBh9RO/t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE6ER/nchOlhYWfrioIIAS26aBycbnqfLm9wyvWRp/VwH9Hz5F
	8asroYKznn955p+sVHXwwAaUE73C4URGmddi1D2HzUYAhRl98IlWYRQZW09Waiakk6xZP2Xftnq
	L6+O96ibrxI2fL8nqVT8M08HHfI/m5Q9swTq9
X-Gm-Gg: Acq92OFq7LB24U+odYc1cr1Dq09yBeI3MUjixfL+/IE6GDjlGMtATxzBzqBCqFR2pfa
	9xwfARrmDPtTZnjANybrpF7F6Q3dFV9FCho7aPGZq3Mv0J5pKQYcxmpQT+2kNqx84ejE1vP6Gp1
	+u4NxufvFqQsizsVgPfly1QNt1M5GCDcsd5NeC4Ot1kOWqzPG5vPbzPARQlc2M6DmmXsJHK2SYi
	ufVd1EtPU1NsrfPFhA5eaj1rD8bOJS7D0xas7+aM4gT3iWPBDu1WQT51ZtAmc9LAUCZ4xfnUoW3
	NTL6oQCFCiYa6On9+Vr1oa+HHMiUhps69dxJcZMy5bwRlbdwFB48DVZOPvxs+MySnAaSYAvY15f
	8Ul4vYXwiO4dR7dct0LQQ59rBNeqT3wdtoA==
X-Received: by 2002:a05:6512:a8d:b0:5aa:635f:7c08 with SMTP id
 2adb3069b0e04-5acfb00c7b7mr1360974e87.7.1781124124359; Wed, 10 Jun 2026
 13:42:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605-rust-reverse-randstruct-dep-v1-1-45ce9ee8d0d1@kernel.org>
 <202606101335.648C6993@keescook>
In-Reply-To: <202606101335.648C6993@keescook>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 10 Jun 2026 22:41:45 +0200
X-Gm-Features: AVVi8CeKmaEylMIDtCA3uvyQRS2s97f1cBEsBG3LVoZ_J7jIYMPtfwWRp6_WCeU
Message-ID: <CANiq72=bH=H-pMHzB7Bk-A-L2421qZD=bz3Rm4kH9QSjFxNRbg@mail.gmail.com>
Subject: Re: [PATCH] hardening: Default randstruct off with rust for better
 allmodconfig support
To: Kees Cook <kees@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 10:37=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Can we instead just allow it? This has been ready to go for a while,
> IIUC:
> https://lore.kernel.org/all/CANiq72n=3DhgH4bqJjp8MsMHAaxaAo75GSBcHGTvFT3N=
TSaVPGWg@mail.gmail.com/

Mark sent a v2 where I mentioned that! :) Please see:

  https://lore.kernel.org/rust-for-linux/CANiq72mmzfBg0_y+TMTsUUuO0cJFE0=3D=
n60-ttwOynai06_y=3Dzg@mail.gmail.com/

Cheers,
Miguel
