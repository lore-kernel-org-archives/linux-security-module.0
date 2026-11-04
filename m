Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793825915;
	b=jRi2W8wb/1G/agRVWw7Q2qlxuCe3xs+EGGqVyg//mr3S9EQhCa7T417mjeUK+fLyt+dG
	 yG6Iz1cA7U825wg/CDjskPCBhdVutlCTIGgq33WgXSDP6NhKBAETRukpdl00FiQFkDoBX
	 D7pyO/qF2Xij/BLus5O8g0S85i5lgZ/+GSIlEhR3R3yIq4NyuUMjR3LoN56xn6vvuLQUu
	 o8R5W30ITGYWsJOrBI+9GlWyGp0PNJd0KXu9QUy0OcDXIO2Xx/4H4GJZOOJmcIEjMT56N
	 mEYbdBXW8CS+k0slbhb6uTdqnhg8+7T0YFpkPFMKIwDZkiL4QcvBEyGdss2XIvwAbTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3u4qsRO8g/eT6nt0UNNI3jzlxW5m75Q0zJ98YGBjAV8=;
	b=US+J2t9oVsbA1mN0Fuy996LtJPfuGLOFskF2jWOetF2lKpjJ+v4Zn9yMAR4FLd0+m88p
	 fwOMR1tWBKNBWYCjEBkyd4ouUgwcNMnq1xkomKciIg9ZDXRGcCh//HappqLlJk6UNiaQg
	 5UHZ9RyTPIxWXlUJ7cMhgBHsJwob1fEk2yXGpYrXKCpeie1a8PpM7iL/reR7trGjm6UZn
	 9RCG7p3vB3V8kFSC+gPjnDeEi4S5Mq50vjlBNhyanmg3RwOMwBtogW+/wELmd+Q8CHTpc
	 rH1LihuU4Z2U/I6QAsZpBp2LQvFejefQ80vjdw6O5FVRJ0TDizwpGKlmKibeo6BaI3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=fR7AJlRX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B932606C908
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 20:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B932606C908
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=fR7AJlRX
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a39e5161c1so981186b3a.3
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 12:58:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793825914; cv=none;
        d=google.com; s=arc-20260327;
        b=UjebagGRb29njAXGf3IqqwJi1/1UPEluRHQsEyBFsiJlKi8kZG+zk7kTsVuHdS3/5M
         POSQWF/IOnDiBS3gSDprE+nUtaav4ZPLgozHoKWY1zShAvpNRFxTt7Y4EVD2dTDdS3zE
         8AIPUsG/d8bpLyQ+/tiif+h1IpVeE9rv2E89Svt/craAofpV2oKUpL69YTNTLNHICItB
         uvTYs2OiphjssaYZBc18tgi9WydewIGTNFtJ32I1KRv98w88439dQaCZBMb0CC5VnUaW
         6Khe42n8LD4iCfSgABvFvVnxSRDj7cyFidsyVTBWplqeFSRMrhHdlc3CeK9ZuMQG/d3Q
         TH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3u4qsRO8g/eT6nt0UNNI3jzlxW5m75Q0zJ98YGBjAV8=;
        fh=VMmhCvt3YYxQPIhwglk5oq35MfofkUTaSYhlwEe2NCM=;
        b=XTZuODN+lrCADgM6q8UsqllE/OO1p48toIWf2jhapKR7zyCo3pqqCv7hk0wRsE09KQ
         hko4565HmkAqZtiidXMN25RV0nL65cymIeoLOSh93v5NFzNyhfgrdsFBhHNZmp/+6AXq
         vuK3RL+uWffMVHCNjMgELgkLX+IEtenu+mFEAQe0n0iLg6sP2vqfUJTseWEXZhlrpkjJ
         8AfKZEZJnuNmvIW5Q9bwgFly+hiT3PGREqVhcvbpGKK5li8i167fhfnmx1tmAKOWoeYH
         84SNWtHd3uKo1Aq1Af2h1X0wf8zBZbZKrE2yOECYm+c1LwQqt6v0paQyUpbDSTgRy1lV
         mvWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793825914; x=1794430714; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3u4qsRO8g/eT6nt0UNNI3jzlxW5m75Q0zJ98YGBjAV8=;
        b=fR7AJlRXxJe+Nou6J/3N5NmbHU+4+tTxjLQ2uPrrKpNl4XdzMgCm6+MYeGk0R7XODW
         3dVHq2XXYIV5hdgXM+ifxXTnNSWsDA5frsVmV3Knzsrt9WsdDd1+eEWUPQfs5MMfi4ov
         wkSsA1ztfUBOGACSuUX5K5n6nQeN0WDXTOSEtRnRAz6uPsT0s2SbFer6Zks9YFwy9rbK
         ZR2qwnep6N0ASSl4ZFxKQKoE0inEizroQP/SYTAPxIDD40CHWgBLUTat3OheGjvbUMWf
         O57ryQk4WV+NAspycjU6aT0DbFd6GbMHUGe6vaf5lO0CxfMpQ7YeSywFxu32CXG7CADs
         1xPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825914; x=1794430714;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3u4qsRO8g/eT6nt0UNNI3jzlxW5m75Q0zJ98YGBjAV8=;
        b=j/R+u3u/w2uSJyEbdjjoCTFlzpdBXNZ6CH6RVfOA2cjSgZcL3O5gc8V/47mH9/HKrs
         BhksnmjoM+A+Sd5vhDS8LWv9cpE+Viq0CI+5SVdq2i68/9v8LDSLdKxs2ETteRMVTt9P
         ZYR30zmGLoBYyVg8EgLRbLUADLJEUFFCKece7loorfxy18F0LcPTEkp51/jCT28nOVyy
         UV7ALVLQcY4BxlWYVZqQKXubEzrhIcWJapKM9fZURHnYtOXo/7VA+GLy43y4P2sMLcp2
         JsFf5bt871XHaLNe2f9aAhhGibjX0JSIIDKJe+AZG48Be73PX7siya87i8Hg2R+5T7D8
         gVvw==
X-Forwarded-Encrypted: i=1; AKwUvBw9qt03ErKKA5fq4vuZww9Zr3ZSnRuC6s44Ru6tgFMTkBJHQ7aixv2tBFHKfG654VcNN78M4e/XuWqyArcW+lFQbcVeQdw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tBHA8FT1Ehx1ta6oriLRlnTFlsr/U95lqO7M5VG5M+l6gupcs
	yo9gPRgCgPrivAy1BM1/8mJaJs0GhfwlCdruul88QGu3y+uqeDNtEaF/fX7UouW9ul0TEXPwvD/
	JktulLjPi/sVCH2zj+EFFKG9vm68wo4zg+bW29NsY
X-Gm-Gg: AYBFou3BWWAzUUarHt5XjTzAjTFBKmvHxjs1nxmJ9luHUoA0Px45/Z30esE2PPGVJdx
	26bsOt2cZ/X3/f4m2GJRjyblcF6ep1FuimWkSW//Vyce9DsKB/vzj9jw49eyF1tC5t8zImw8k/l
	pYmytsp0He/4JvPrwxcSg5z71Z3CWRn+h1x74dxDnLRWKdTaSknDJIXZ4ncERjGwolRP/KD0vH1
	c3wh9NJNCP38mFysio6K++wPsPOhCfcDVm2T10MgpFUoJ8O475ZOwLzJMcqRyQiNJlT2TFraWZ2
	Wyr6SHC1853ysaNPKQIbd1uQAnwibC/j8koNJb/pdodWNpMcJ5r6JuRPCo9Tg+UBwQLSq1/mzNd
	DPN2PSvrFNY6nB5iUELqGWd8/H2JFgD9Vb4jtDhevzOSX1fCkfgHThbV+RbOi1I7ZnRmcn90Yy4
	qRtiHcX1P92/akmw==
X-Received: by 2002:a05:6a21:a94:b0:3e2:9f69:35bd with SMTP id
 adf61e73a8af0-3e928cd50f3mr14704044637.34.1793825913688; Wed, 04 Nov 2026
 12:58:33 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014165532.329933-2-blum@kernel.org>
In-Reply-To: <20261014165532.329933-2-blum@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 4 Nov 2026 15:58:17 -0500
X-Gm-Features: AclHuK-sTQRosfk6KioQIcgdkHhd6zNTYpIgrN0o0NCORE_8LHez5kzEc-RAYyk
Message-ID: <CAHC9VhR8=-yiV5p93sDvmnQZK3QmnDdmZS+J12muxx7VXPq5+g@mail.gmail.com>
Subject: Re: [PATCH] tomoyo: Use isdigit() in tomoyo_numscan()
To: Thorsten Blum <blum@kernel.org>
Cc: Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 12:55=E2=80=AFPM Thorsten Blum <blum@kernel.org> wr=
ote:
>
> Use isdigit() to replace the open-coded implementation.
>
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
>  security/tomoyo/common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
