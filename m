Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795489432;
	b=0Qef19i19FzkxTDoEAHij1ndEMLdjsR2LGUCWgae9E2O35wriw0Rut1tcO1ZH+KUNxwy
	 KgqLIaxMdqu/AyFVLOpRgSCtq+4RgJw6T5sNG+EsInA2bukQTgi5y4n8Hjb7T5644kmQN
	 f2SdNVabe5HFMT0jpHq02cIjpi97AMeNdGAKXaB7xA1bv8WBgZPrRQcF6QSZ3UxPoRK/j
	 djTRG7T1Omw6Q0xalOUfEj8aKytbq4di0o8yFyx3/pug+Q6Jpk6U8rg0e+v9Bqm8m9Dje
	 xlrFV6/szHIEANxMxgipSBKbtUtGk2Rdohf9j5a8zk0QLYIEONmKysh+PEjow/+9h/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795489432;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jlx1t6RaSiTEdUd/+cKDPrKgMoakRiadEyQMK7AF7cM=;
	b=M6IZMzdz+qBXfcmQ0C/YmBG2Z68qhaPDIyVwUmvfe4mEZ9xcYwhD2MW6jC5IQtlXARdE
	 ZeATYajNYy75NZyrClr8i/uuH1K8O9OCdrzgtBUYpK3vX+Fa7vzTweC1c+gu34m95uOAL
	 eSJE+4QjEVnfwRhGpm0U3Vq1mm8Oo4JHl5iTM+jrZQbHb8g4V/AY/DADIEEUWw/xDCoUd
	 SnZNA3OIS0g9uN2TlHzmQ4QkugrTlPDvm3yd4z7xbtPe9/94HHnQ+cX7C+KSnWtTXkl+K
	 /yU31kLXtdjMA+p6chSUNx4yFx0ZuQFLS0p2MYcFC825LTD94+c5BuchuHNeFrzdG6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FbW0ssJq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CC2606A31E
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FbW0ssJq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE99A1F000CA
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 03:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795489431;
	bh=jlx1t6RaSiTEdUd/+cKDPrKgMoakRiadEyQMK7AF7cM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=FbW0ssJq2xzTbIrWF0a/kM/iooAwSRPQ2aQEuXReEf6/6PoLPdjZOwHz4AALDt43y
	 QxKZ4siqM1NGEEQRWt9KYvzCPy7YAGGd/KJnzk54Z14j02ydyZs4PqLghjqHP+YzzK
	 iOrhkPvFap3WkqTrZOJHRTRclp6lMYyHg+kDtT6cw2DcKKtRUtX4g8VTPAdWOUaWGB
	 bgqommWTnIt/OYfhbuQzgYO4hE4eQDBBUO6QEOOwWjanDZbRmUz3WY6GuwdpBEHjIv
	 iyDBojsFQsSY8rdp/c3XSky0WpLg2rrT638/1rmNsA+4vy/7E1+QImrJM7G2tkN54Q
	 aSctR0h3oFtNw==
Message-ID: <sashiko-outbox-230434@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] keys: fix crash on big_key read or revoke after a
 failed update
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261124025759.39344-1-bsdhenrymartin@gmail.com>
References: <20261124025759.39344-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 03:03:51 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> big_key_update() reserves quota with the raw payload length and then
> destroys the old payload before instantiating the new one.  For a payload
> of N < 16 bytes that reserve releases 16-N bytes, so the reserve of 16
> done by generic_key_instantiate() charges them again and can fail with
> -EDQUOT once the payload is already destroyed.  big_key_destroy() keeps
> payload->length but clears path and data, so the key stays positive with
> a stale length that KEYCTL_READ and KEYCTL_REVOKE then follow:
>=20
> kernel BUG at fs/open.c:1145!
> Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> RIP: 0010:dentry_open+0x7b/0x90
>  big_key_read+0x141/0x280
>=20
> Instantiate the new payload first and destroy the old one only on success;
> a positive key's reservation is already 16 bytes, so it cannot fail.
>=20
> This issue was discovered by Tencent CodeBuddy Security.
> Cc: stable@vger.kernel.org
> Fixes: b6f61c314649 ("keys: Implement update for the big_key type")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124025759.3934=
4-1-bsdhenrymartin@gmail.com?part=3D1
