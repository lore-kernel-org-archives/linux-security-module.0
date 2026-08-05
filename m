Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2733E3CF20E
	for <linux-security-module@vger.kernel.org>; Wed,  5 Aug 2026 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950687; cv=pass; b=XkZPD/WudsKbw6e5quN27pEVp6380UTr3XzUceMTfOCO4K39vZOlXVEYbBHRQa83MqyVddutfJf/8tqXJV905qBTgWLSm9PaLbbnD2xZguTfC9f2IwZp4/mMYw6ArGz+MdcfK5QR0ZxNCv33C2ImLhcj77FMS5K19Ssq78FpnHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950687; c=relaxed/simple;
	bh=lqsoXm6msVcY9U+iIeiwYgdVs6Tx/P7U6/+PspA3yMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPXbPVEhSNOcsPeipi/o2vHxxXpf470Jr4pDOxYnBkafUXidNf4l8diQ85FPdbDIzzK0y80EAUi/hr6K97c383Ldo3Zq0969H/64lqNjqbRkRNiInPCBHnA5ddsk1b0I1bNvZPHzd+QVkiRb1lJasfK7Yeagj0VRkcqNq7kwm5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JkY8VfBU; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JkY8VfBU"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ced3386430so14677625ad.1
        for <linux-security-module@vger.kernel.org>; Wed, 05 Aug 2026 10:24:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785950685; cv=none;
        d=google.com; s=arc-20260327;
        b=pVxIGsMGBo7jllhsgc8ltKmVc1vQz6itUWw2q0k+/LGhK/mwIxvJ8909FKWALt5jCz
         /pjyIJWL5hTHQat3j3MBh41aEXxSFtG13nQ82VhvH5BSUqZ6HI3WZjtdrKfqZm767CKz
         J5UsPGyyhiXSKFpipn8mSHU54aGaXpu5VqGuscms64gBT3I70LShlRYQ92g27pZq0zeq
         8KnCFSY6xAIW8l4kZoK0P7gMgVmB3GPcKmmXR8fZNrqijjKHitgYkQo1LFurmm6XcAwL
         dFSch7axQFONr7WpwICog5DNW4s3W9YZgatC8CJ+AB3RTrQ6sRVLH5F0V33mwDAOwpet
         Ekjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hhSYt4d9matGJuiLLAOV82UjY/nIME2EtOpvh8wRLTg=;
        fh=gdavEh5BoVDQXctEpMXsMw/uE3tRXLKWGTSlZqhcr7E=;
        b=iwwJJ4TkAq9FUyV/omZBukoKgWMauXtzAVSETN582dRdIhrotgByo+pD0nNNBiqOL6
         nk7ahmYhr9cldg7VcH3Jkc9fmzyzAUZked0OxFfVKJ9jX3Coy6Kr51HBbFghLJWr2nwl
         9Uvgf7x/lMD8lD2UeOZdRnuXbR2LAVpWa/temb172zqmHoo4u5x0bUg7Wf/WXQEeitr1
         L5w68v5TgI3mtxoKi61R9Yjzk8uBPlkdT3yTwEUbwk8spwfCnejb4dp3a8gpgKUzikL9
         c4uFZAxZsrcNnrIaUJQ60CwI/jROQO+/HRcUsLfJUjr3d4LybSLf4ahqFn6cLX67Lj+B
         AFkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785950685; x=1786555485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hhSYt4d9matGJuiLLAOV82UjY/nIME2EtOpvh8wRLTg=;
        b=JkY8VfBUk1kB+aHrcnZ/zyJYMbOgb+woFfma9U/a80ijWK/f0dtwcNN+6Fj/6Pt3sh
         1pohZzw9l1NZFLLSUX6RLacfVN3n0TpNbuZ29TxWwZn54u2ewdOQNCOXTlmTwQj9X2au
         Km7cVlAv/5TBJ107Hsh0RZSOoI7zcg38H62LkgMcUKRkd0tWwVtPZEk3q1B1ZdWjL5jk
         1+uZzX8Cdiy1RYVncaR9ypFUtcfaBO5xXbopVRbpVVDuB9AegGwUAp19QojpwY6ksAhC
         C4o/q7kB0H8pS4mk2X4MRJbhXkneiLMwXli79Ch+fq+hh+QXOpj1OCHdnIfZghtX1yB8
         vhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785950685; x=1786555485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hhSYt4d9matGJuiLLAOV82UjY/nIME2EtOpvh8wRLTg=;
        b=Iyqg+ZQJj1+jXiBLxmbUcYFW5I37kuH6m0shH17Pi/8914cLuY3U6fvjmDHiYW3jFw
         wCuys2eALEUckFAA+kGtTxgMjTWmDXPmd6CV8Y9oHprp12LA1T7jKWsoJkU5lXDXAA5h
         ssPzUxFQ60DO8MR2D6GIV5qhKvmuLcy10T+/CDavBQoAiy7aagHfM9+kx9+z3J1NGGq+
         A6fj6X8ozx//2I7uqzKTAE70iuq1nOIEwCicba+ikhoU7Zpyx3FODsngQT22Q28hQwJD
         ApoNqEqnXvUCLYID8fxICGA8waNb7lyHe3UN+BElXKz8txYswnPYBfsHfDiDd1hXaw5y
         I0AA==
X-Forwarded-Encrypted: i=1; AHgh+Ro/gVU3ZXlseRTnKuSo3ixEei9nXDb6Z5GBooIN1KcyxP9rafs4AgvZvT8d/4YuJ+UHE2p00pY8NzKSIWnXS6LJDMDt2OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxstJqa3nmtpnzgAO4C5GtvpR2LbMnbG48ArgqDP86L7DQI7kLf
	2bbhN0aRtzqsDgxIYBEfuLXVGq1ydgzrRVW3EA+l9FW6QSs99tQuFdTbP6SsY+AN6i3NMVTIGZw
	U5DF3YQMfATAq7vdWv8/lqtDFKH8+bjkLInR6+1/5
X-Gm-Gg: AR+sD113klh1Gyz2oi90SHdY07OrF85C0rlE4YX9MMLCymvh6TwTpVw0VXtqbtSAHhl
	abkGs8ceX2F6v6ln5FAiRCAlxsEeTrhfGOdm/AOZV/zjJ8BrY10tAuyP95y1omdLyj5O0JEJhrZ
	Chzv8K7gVod093P61bLUa2BIN0daZ4A6gy/LY4POsVJxgB73TSjZu1Or7gJmhRonhZBRLxaGedD
	gNbw/UGuKCwbkkTRTGwubPvuGIJn3tqBirVvsYFNtC5mOl8nMp5xKLz/Z/k68nuKgEw0bexDZHB
	+v3onzjdadDqNNk1k7q1jsPrcBKr5Hn2oheCKK1reExH
X-Received: by 2002:a17:902:d58e:b0:2c7:1200:bd7e with SMTP id
 d9443c01a7336-2d0ca9838ebmr108122505ad.18.1785950685533; Wed, 05 Aug 2026
 10:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805-rust-reverse-randstruct-dep-v3-1-7b8b2c761d6e@kernel.org>
In-Reply-To: <20260805-rust-reverse-randstruct-dep-v3-1-7b8b2c761d6e@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 5 Aug 2026 13:24:32 -0400
X-Gm-Features: AUfX_mylEjzCXDD3QT1Cy9_QSKHwq2vNWKIY4ZjNvWR0wcVwfxD1mF4zdKJhIk4
Message-ID: <CAHC9VhT6s5G_toXHBsZZ6=pNNfk+v__Wwt1mGE_7C+0WqjP6VQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v3] hardening: Default randstruct off with rust for
 better allmodconfig support
To: Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 1:02=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> Currently randstruct does not support rust so we have Kconfig dependencie=
s
> which prevent rust being enabled when randstruct is. Unfortunately this
> prevents rust being enabled in allmodconfig, our standard coverage build.
> randstruct gets turned on by default, then the dependency on !RANDSTRUCT
> causes rust to get disabled.
>
> Work around this by disabling randstruct by default if we have a usable
> rust toolchain and rust support for the architecture, circular
> dependencies prevent us directly depending on !RUST. This means we might
> end up with a configuration that disables both rust and randstruct but
> hopefully it's more likely go give the expected result.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v3:
> - Rebase onto v7.2-rc1.
> - Link to v2: https://patch.msgid.link/20260605-rust-reverse-randstruct-d=
ep-v2-1-93d38023b6f9@kernel.org
>
> Changes in v2:
> - Add a HAVE_RUST in there too.
> - Link to v1: https://patch.msgid.link/20260605-rust-reverse-randstruct-d=
ep-v1-1-45ce9ee8d0d1@kernel.org
> ---
>  security/Kconfig.hardening | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

FYI, I believe Kees has been away from email for a bit, but my
understanding is that will be changing soon.

> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 6923036e1a2f..81c81ad983ad 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -278,7 +278,7 @@ config CC_HAS_RANDSTRUCT
>
>  choice
>         prompt "Randomize layout of sensitive kernel structures"
> -       default RANDSTRUCT_FULL if COMPILE_TEST && (GCC_PLUGINS || CC_HAS=
_RANDSTRUCT)
> +       default RANDSTRUCT_FULL if !(RUST_IS_AVAILABLE && HAVE_RUST) && C=
OMPILE_TEST && (GCC_PLUGINS || CC_HAS_RANDSTRUCT)
>         default RANDSTRUCT_NONE
>         help
>           If you enable this, the layouts of structures that are entirely
>
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260605-rust-reverse-randstruct-dep-5a504c861128

--=20
paul-moore.com
