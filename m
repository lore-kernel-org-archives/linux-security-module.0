Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2E4A1387
	for <linux-security-module@vger.kernel.org>; Tue,  1 Sep 2026 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788303615; cv=pass; b=fHOL0Fk8/AyrW5Gev4IY9R1UqPK3DGXo2omZPeE0wbeb4S7C6LRNU7b1tunfIkfpGNpDYopZQ/kcVU+Ape66aCGvyhmuhR0vFnW5G3SsvUCVI/ojo0vvwpqFd5pzDKzvzMK8PZs+7Bv0k8XON6e8xkldc81Ap0hTTXHQ5HO9RVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788303615; c=relaxed/simple;
	bh=1EohgyTendztVlDk+2uhEI24wsVVaL8E9Q/KpC4uNBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ak+QCwQip9CaQN78JuegBBS9VDUJokIbVSI/3mxPSo8we8cOAWH1WcQXCgfphHKbYRv8NylazjDCqPmWdD7OtL1p9cwZ7buHplhg7lIY/2qudzSKYn5a1y3wX4JnNB2NBZdTEA+ihGcEhabSXh+hh+3xSxb1wNm2eu32XqG8CWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BO5eB0g+; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO5eB0g+"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-384c94c9423so42582a91.2
        for <linux-security-module@vger.kernel.org>; Tue, 01 Sep 2026 16:00:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788303613; cv=none;
        d=google.com; s=arc-20260327;
        b=Q672KjZedRXLsusMMjG4e/XA6WAbZVGsk4WylqT44Q/rHg4EZj5Se+GbUVroJF+NWU
         v27/Xw19MXKiRnCuQRDcQc3Gp/QifkCaSrNFwaT/wUFLQqLu+Tep2lAep715ziDtar5Q
         WIaADR0N5x5XQmLJe+VuDqFzTNMECdrpl1s9Ip6W3sohF2Ti1azRLzSnExNEI0fyMfd6
         YwsfV24yv1wIZm13/or5/9HllxSqFjiV73NS8fcEvaPKdfFcmI6j4okO45mXDRyli4Zk
         ANuRQl4USilnVXqrxd41Ha8J147E9MFicuQrlYfaPDuyvgPghfDC1hzz5ADTkzZBTkbZ
         uzxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HkZyz0DUc9IX+6OAto+PXMl+WtSd8or4pjnBzMTymto=;
        fh=9wExSXhdjrH6DOZaBBMbVfYlku6NGf8H54NoELut/VY=;
        b=RZm3Ti8fjZW8gw+dz0+Z99RPzr2LIASI32vvM8zIbsayf/q+AMW8emwYM2ju3zO5Do
         Zro1eJBX9Z9Mvm/phI96ytHikMFqMiiiMuOuwIis5cerV4cjDRKJr1eJaE2aTvyZx7O0
         iqsfo2Bgwtvu4IC7ujfu4B+Hfzg592X85V/siIbRoDa7ZBZtspqks5NW0qhMXU3gjxgV
         4ab8DoX4XUkgYY3G4EFFIwg1zFtkiXQ3AcKW8/muVSgOo7wraNZ7I69EZjlL8HKJRFvY
         qW17KFftLWUaSIlQwTvacjl97eJNMnfmJMMBZxcdDgvF/hQgHJqTY/fXrHl6M90rUpeD
         XAbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788303613; x=1788908413; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HkZyz0DUc9IX+6OAto+PXMl+WtSd8or4pjnBzMTymto=;
        b=BO5eB0g+tnxZVHVPRGmO8qWdaC0Pj61waUxjA74VN7qQTtW4H0ShrSqr8jIn1WdpIv
         jJxLGlSen3JumbU8sTuRChPCUDuUnOyk8vhCE63tuI4bzuddMDndIxk+CN28hpMIoxdy
         yc6R1r6xtClIliRKpjqh0T03lqk3UddKKH0aXA54u5WNHlBO64PVV88fTw52So/w5Fbw
         4OfdJQ54DOfy20X2wx85hpL5cQLQJ281hMGnaUJiczpSHnPSNCFjFxoVbeqJ2PZ+C/78
         O98mbs4OfQOPUv5/DWHAPCTAI+gGUhIFITi4fxzEvuKOt0CfvefWFfvVGMWk7dpbP65L
         aLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788303613; x=1788908413;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HkZyz0DUc9IX+6OAto+PXMl+WtSd8or4pjnBzMTymto=;
        b=beCm3SpvrBPZtOsl/L3H/vFwILsXQ1sB4pxAUC3V5krojwdBOuogfQGo5MrtS3VoMZ
         Kqna1C2eAtv5HjVAgVUktVKuPJ3M9ZmdTpmdhC45+Fdtv/i4nI/txziQ5GnIwaq4eEuQ
         v6q7YFPiqDjks7ryKQqK8aNMR6D9+JU5uDFYvd6cjTsbcMloP/Y1N41rype55Ak70xrx
         2IWuC4vX4QcLmxCoPufH5odW+EQ23+gAHbF6d/XU76z+VOEtpswsXWKyXbucs6DDJMym
         CN6Q1nxzY58MdeZEDzGA5hzznW6A50qit09u/Z6IiIOyzNayY/uwWqQCv0M8uAwRy3FP
         1t5g==
X-Forwarded-Encrypted: i=1; AKwUvByNZNXV11E6oQDOXSJ8LZ3JAefYDZih3GZYkx8ChUe04T22cir4XJfeQ8JALcukOr/JzukfLTt+TU5UvswyPjNie7aMyBQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l0noTs09Rnr5bRqRQ4ZDcoJQOthUXmKw7QHD1KXGgMdrivIp81
	PqJtX8s6n9ZWpL3lmXgImWTMLejB7XKVSqLWXtvYTs0/5xu76R4ND+cikCrByHzA5mC8G5n5Ahi
	5XCsgnJpnmgjDqGqyJi+5WyliD37pUV0=
X-Gm-Gg: AYBFou2xhjabCiTDf594rc4J/c8sY8NmCu4Wex2lxjOKHXexXz4D/MnZLvfRn2DhdL5
	IXe1wT+dseiR44OiCAOQhj4LFm0lOySHsNDFX3HZWMVcWTJCPyD/vKoZ2o8jAYN2yUy0yD3rEMg
	esmpHlGtyEB9u2U/U8l1UX8hz97nldzVB2GCFhHhIU2VsnWT/pOIx6UbPebqxzI34G1N4jzFwWC
	PuRPomULfx+r87hjFWop4RkQ1Q7MnQ1faVxVmEJx5FJDpMCq5mMWvPWoPJEy3UWZr44Lmx2Wxdf
	/WwrvSWBC7MWVwfxO8VmzzJmf3fBWeJRlDyh6DN1AiqwgM50ET46JaUDFhe9BedeoRZ1mbDRbMY
	1DYt6gr7WWL5TkdRmN1vKu3ev3+9rXUrMckVzwGSeLtJYSWyAxFgtvijIC10m
X-Received: by 2002:a17:90b:590f:b0:398:bac7:72d0 with SMTP id
 98e67ed59e1d1-39aee222c37mr234130a91.5.1788303612233; Tue, 01 Sep 2026
 16:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901-rust-reverse-randstruct-dep-v4-1-3bfa19efe1fa@kernel.org>
In-Reply-To: <20260901-rust-reverse-randstruct-dep-v4-1-3bfa19efe1fa@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 2 Sep 2026 00:59:59 +0200
X-Gm-Features: AcwNN1V6mJqATHgXTZuy_n_fFgcdcAsp6sZqZ6O99j8lAs7oSu_PsUpXZ9i9pWM
Message-ID: <CANiq72nOk-gbd+C9oG5y5RKrYhqNx+BLcwS-8u-uHxUjVTwEtA@mail.gmail.com>
Subject: Re: [PATCH v4] hardening: Default randstruct off with rust for better
 allmodconfig support
To: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
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

On Wed, Sep 2, 2026 at 12:52=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
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

I thought this was already applied:

  https://git.kernel.org/kees/c/3844a38c9c4a

  https://lore.kernel.org/rust-for-linux/178733378275.2181196.3186172911325=
132761.b4-ty@kernel.org/

But it doesn't seem to be in -next -- that branch isn't merged there I thin=
k.

Cheers,
Miguel
