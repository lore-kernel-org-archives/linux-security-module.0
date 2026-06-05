Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED6E31352B
	for <linux-security-module@vger.kernel.org>; Fri,  5 Jun 2026 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680189; cv=pass; b=K2FOHC+sCvV0TDaIsrvlD2/m+103yZgJC3+1MEucqEMc8FRaM43zO+PONzMIB2//yfWcAlZMyEtrtZdqGcDRiVTYtf6+7+62tdE+c0w1ELXCWyw7DsVNfa6zWZ6QS7IT4VBEZt6agJPjnCDb2hGTt7+WPdxCQMR7foSf4eA7aLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680189; c=relaxed/simple;
	bh=i7KgJLF9GZ/FwqQM8eGgUNDLnwbwVyWRy6mn5814iEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXFQMAX9vd0rHSSB7nIyi7Do5lDtp90Y/QJ1ofEMXVZEY6o5wbnEEHutqwdOH8uvoqM2Ji7VHjiU7tn7powcPlC+YICS1kOGyUKiihaNtt7N1Kh5J31lp8POv64wvbmSZVL53N/IAJQ7Nds7vaa8QJHkYITHaWYpEwEEu8g4IE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oDrf5ME+; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDrf5ME+"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30741f821cfso259588eec.1
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jun 2026 10:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780680187; cv=none;
        d=google.com; s=arc-20240605;
        b=ZGrj9YOhjYNFJGddQ0EWztO3vcUo/IFL3cUuhzny1ukTCyKpgvilNtszP/PXnUZTuL
         fkSCvKWfF+0el1BpyCQuJ8hBmapxV5AN90bAF1ipmkgYXlniiS+dl3Uca8pHvwrhJj9H
         NKjGALaj+ZXKAngDdWJTUoue2O/i0f6Hy0ZA4oIbVrgS05hNzFYVe1/wbHDO1b4M5Qjd
         KCYJDAMxegG/IWL95JqOTMZj6gRp56vrtDt4LyX5FudHZtsRK/nJlNKEbo4dXwYRdjZv
         iBXo1zfuVzGAKqQ9qkL3MZ3cKelcufeU0Y0QUSX1w+9SY/AZoBMD3ci8mxub6QsovqQn
         9P9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uSx8CCu2zO3nvn/ay1oOlG5l2f1ymr7/7z56E0ctASc=;
        fh=vUyDJYajhqFr6BrY8jFyo9xmUQQEWnxaQOuJpPUM7n0=;
        b=amqT35Vqa6zgsWv/zcoT/wO1P9NwULbhwAVw2p1j+mWg1s4j+YvP1JNSeZTk1LOSyI
         6HJ1Ozl3Xt/R7bqsTc2tu5DFHUK1Qo0HvcJkIddCdYHIS/ZHO0lG261F8BL9AeHxYN8h
         kWFGi8yoRc8u8WP2xS+wgf01Ihu3aFR+lSSB8My5VVYiFbCsQAOxlpBblnEkUswSMa37
         1Me8vLcqXGbQC6BomDyTeUaa7DnRS95qKkRBpGMD9ZWlChAGwzq5/8OVVrWXdGrSafAS
         P0O2TsWY7+tzQbwzekSF2Lp/j3SSlejL/oRmt51N96F5nWdJObB0xL9aPXAT7ivMlncA
         YDmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780680187; x=1781284987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSx8CCu2zO3nvn/ay1oOlG5l2f1ymr7/7z56E0ctASc=;
        b=oDrf5ME+Uw9oOKiSlgKV+3uY7yFSRFQO4epLArS8lYZ701xu2n3dBKlXBhDKc2s9/I
         FPqXbEOzhAUx+VZYCDVwpucOUkSgj3tU9LUR57fpi8jPkIHPsqKrAWQO9RjwIEBZ7g74
         IHIqiAXm2iFnyV/B0gWHVdXw03KpAnnf+gchylsUPeCA8Yriqns4i0QxzONwHtfyjV4U
         Ck5w3+SXVHKlYbTepz4ZDA7FZni+HRC6Hr3jLn7xhjH0YKmF/jHx4md2ahGc2VmepvLK
         5shQyOngqVA4MFGB60bZNZqU4X/+J9iUfxWtcxEPP+raEUTsIzZ74Ne7iZ8tebQyiU2s
         TBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780680187; x=1781284987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uSx8CCu2zO3nvn/ay1oOlG5l2f1ymr7/7z56E0ctASc=;
        b=dqtUbV5/LvmkzaFXUylAUHRXqvIg1NwyGrRGF9abDTUNSgSGukzgzC59DH3yC2VpM3
         gEbUUfpQHiPD+hVUtDyJY3uvqKB+xMV6YZSzJjpdrB1acnxVsWAR0310+W2gwXqzAqvL
         WB0eH3t5pNeMCdXKMmQvRqAAWjghEQfmECbwumVwkXEPRGwZXmuJO0KmZSth0J71PKle
         Uq/aPAC7dTYslaaJVryTxtu1/8Dhe4UDQlpbC7YZWnsvGW58sqj9ZSN4USu/q7gKN9Zl
         0X7zcwYQ0pRnZzw3DMJwTDZyv4hStsPADfZQE0HJTySQZUSiG69xzIZA6aHa3steDg6a
         HBrw==
X-Forwarded-Encrypted: i=1; AFNElJ8ORdaj6vfujvMsyib7OPv7rZuZlT5P3HzMhgUui4Qe5+pVtKB2PB9a6l7c+Rt2uvy9uaCMHcW1pqNZQLBgU/4WqBs+wbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx05MpYC4OEhxa+eR7iOBrL8FOcQeUUrkVpHfnypoxRuPGjaKqO
	zOvuAI0LGLR2vw3dN4Sr2YqMgCon+7ROxXf8+tESLkLaeBkplcqvYKBjFjlnCO7JmxHXtNp+cho
	e3MTum7F6+9GDvdZjaqwY7j7k3xoywUo=
X-Gm-Gg: Acq92OFfY2YWOUP0AwfZF6RBf250JcujxrwJJ18Btyfv5RE0tX5aRu9YJHbi7xUirK0
	V3YL4n1Y/weHxh+bY5gYWiUaGNHbNVYWo75CuRTAdrhTgePUKCv/i/hLyg1aoxWod4m4Zl89N7m
	jhxF5HEehUoyy0VXdhXvzWuAbYFRfJgV/suvQE21Fq7xJivWq1XqmUfG1pqREnQtiwZdT+P3FcI
	jxwe18uYfQufpH6JgLh6dqO4VSxDGQwnxfWkRNSUfZG0PSqMu3dAdD2cWxlZrErsf0YI0/ArJzA
	brrpr+9zn+YmHMIoXSbyYJT+bhM45zthFDXTryDi4ljnJwz+fYoA3+/4WgPleELHOU5ygUdjPG0
	v4Wd1E7/0SV7pZqiTKngSCXngIBw0yzoG/g==
X-Received: by 2002:a05:7300:5723:b0:2ea:5057:a320 with SMTP id
 5a478bee46e88-3077af4a612mr1071744eec.2.1780680187196; Fri, 05 Jun 2026
 10:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605-rust-reverse-randstruct-dep-v2-1-93d38023b6f9@kernel.org>
In-Reply-To: <20260605-rust-reverse-randstruct-dep-v2-1-93d38023b6f9@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 5 Jun 2026 19:22:54 +0200
X-Gm-Features: AVVi8CeXM8Ynb9CW_RjnoK-g1D5_BN8EaZTX5irzVwTw1c48nPyBVyCslPxXk1Q
Message-ID: <CANiq72mmzfBg0_y+TMTsUUuO0cJFE0=n60-ttwOynai06_y=zg@mail.gmail.com>
Subject: Re: [PATCH v2] hardening: Default randstruct off with rust for better
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

On Fri, Jun 5, 2026 at 6:51=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
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

Thanks Mark!

Kees, Gustavo: applying this would help Mark's testing of Rust in
linux-next, which is important to keep.

An alternative would be to move forward with `RANDSTRUCT` support:

  https://lore.kernel.org/rust-for-linux/20260323130224.165738-1-ojeda@kern=
el.org/

Either the conditional (on the Rust side) or the unconditional
approaches (modifying the C side) should be fine, i.e. whatever
Kees/Gustavo think is best. The unconditional one would make things
easier on the Rust side, but it is a "bigger" change in terms of
impact. We can always start with the conditional one instead.

Cheers,
Miguel
