Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890510;
	b=dZ8exRmY97+2NjhCEJD1Ya3XfTZCoD1SAKNt4EHa6wN34szzjG9gDXf8AN3f1DD/ZxWD
	 DKJpVf9rb8xMQAbJz4aYn5JrJ/DB7JeG8Lc3WqAEKAqCK0VQOQzpYN0rqj7BOa2H0X5Q3
	 hXcpL+3XF3JwtPxg8yZJ4FvEoSln1KxZpNgksqIa6eGixCye7pijLu2g5VOxR8UTvOsfp
	 /Ho2rIz2JMaa33O4r01DsRJKb1resdq76z+DPsb/Vf/1AvdVvZ8DHSn8t2F/huSwqTjY0
	 oE9Txy9+pC8ANVQmfywg0bmkLtkqcBOaZuQDixaTCOFJ5atgDmL5Y2Vb98ySIDJZAlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890510;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j18H5p3KNv/NdPOGEmg8rHp5GWxBcK50HbysS/ZOaCo=;
	b=W1wgjh49g8EVwZsBoMaJC4fZ5Y/dsXP/4RdMUjIq68gZsEXXk71gsXHC9AM0C8KvfC9M
	 SecArpmTCY+uQj7h5kJAniMtUYQd0yHmAqJ4MO2vdeZCm5aPSIq92AyTT3CMWNiyZgtYa
	 Ky/rV+cKViANC8FeRhIWfa8GLF87/ctVQ6YSQUtVav/SeRNlarv+wQqK2Rmtg7piwZgji
	 Do2lZwWcf1/BGj0kBETm9hBV/PdnHE8POY1TfV/mYQwwk9DWepN6MqsdGqBtO49qiRSs2
	 cwOlcUBASo7dFVyOGfGs5I1eCuxgsAkqQ6/qUbo4UkirInLQJYFq+iTSkkAUAjBguHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BsFoWBrN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84861606A329
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BsFoWBrN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3B01F00919
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 14:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890510;
	bh=j18H5p3KNv/NdPOGEmg8rHp5GWxBcK50HbysS/ZOaCo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=BsFoWBrNjhRGXiKydGaBqygUVzKPJKr6aX5sAlWBtGWd+x8OKPeJ4sNL8IsIGfN+w
	 LUwIH/8Q/I+1AwHEFBf62Mb9P7RNYWFvgJhBjaPjaae0jaR6PuTuwztT9x89ndZbee
	 6/FAKF2/gVo+Z95e6jwcNwguRT9TO3S4xWBOk3bXBhjIk3cvW9FlzfuB1J5L+c+qeV
	 W7VQ71jibk5/Pu80tHhMb85++Vk2eDJNUQ2lVw0MkgaAmDmWa6xht/4Iseh4W5lPbf
	 NT/1h4Hf6/4vW4nFicVG2Xr2X5bOITM5u1ZwisxARWD8h1wN+ymD8C4ACaQmittr0i
	 aW467pZRPttjQ==
Message-ID: <sashiko-outbox-199275@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/9] pseries/plpks: fix length types for wrapping
 operations
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261105144320.357260-7-ssrish@linux.ibm.com>
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
 <20261105144320.357260-7-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 14:55:09 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The object wrapping and unwrapping HCALLs use 64-bit length values, but
> plpks_wrap_object() and plpks_unwrap_object() currently use u32 for the
> input and output length parameters.
>=20
> Use u64 for the length parameters to match the underlying HCALL interface=
s,
> and update the PKWM consumer accordingly. Validate input lengths against
> the HCALL-defined limits before calculating output buffer sizes.
>=20
> Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping =
Module")
> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted sour=
ce")
> Cc: stable@vger.kernel.org # 7.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105144320.3572=
60-1-ssrish@linux.ibm.com?part=3D6

