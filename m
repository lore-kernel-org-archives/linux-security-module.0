Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285936;
	b=zVd8uF9hmbhni4CSshubTGw2zjCmqXOu6OgNvIkxtqWy2CEHEfkxZ/VOfqFdzC8HwT+a
	 ZmKeeCMr8NiHJv2Q32Ox9hzwh8D9ByvUpDBkHtf1l1hoQi+O6tHSJaKc+Er+Ki/FUxARb
	 A2qO+QI16ts8C8lFNGHVqnA6edLht6uDcCrIVgtdwv3a3YphGv/lpJQZRySPiUxxImrQg
	 arykZS6cZR/VScRuO217jKbHYiYRQrg2jbvapDHDgh0rvFNZdIij/Vyl87+uY6BJ4B0Oo
	 931oDl54QwIXH6gajqu7qkyZcklOIzQYx4BN3LzzHRNPbkMpXaYB+Z3+kMFc1Crs2lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285936;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hnZZ0OOaLgEDt9qMVsuaDv4k2lPhSGk0Xi0nxgnm7Hk=;
	b=nWxj5HJy2zM3bpjoIzjxqFUMv+RxhwvdcC1BiXYwU1oMt8Z0OwIJtgvbkCx0ei7TdEGD
	 Nxg8KRSdTRoRqiAfqzgPOyLTCRO27wKLw4k3HwHWIhHY+oEmcENaJ5ZjQq6lBDdfihD89
	 BjVn01ASd7MQsfinAyGerQ4hoYe+3yYluQ6E+x/lJxUc843NvFlLSLhYwjbYC8+zLNnnL
	 xKyum6dgDfgd089tGdro8amIb2/iBAF3wnmfwUv1t81Enowu0UeXYDovhPDbR26i0kjkl
	 8WMxPGHoJBkcReuvwWzVTT2Daq+Ns05lIGiZEqgWfFw5NftHNwsTdUbjjpO/ZXr2rdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccf63WYo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A94606A33A
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 04:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccf63WYo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA051F0089F
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 04:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285935;
	bh=hnZZ0OOaLgEDt9qMVsuaDv4k2lPhSGk0Xi0nxgnm7Hk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ccf63WYoSBBXpfGpkD9pjR146JCAAUBzzQzDgO6DXQjsVJxxAMprXLLGZ8tIOurGk
	 p2BGK0gOSK+SN4D+RVZC4WYhW+pKzeoFN/J4O4iYvAQZtP3W/5xoOzVIiS2VpjdLl4
	 eLwvvicKWTJcQo4gkvfsLW/bwaYOlxRdaCoTTeA8d1eaPPl2Ya2GXdwSRXQHk7NLK3
	 fqG/kUo4AWYThXORJNLfk3pBFn6bmSugtSMjgXG4dLmSYh68nZvf0dF7huWvs7Zr3q
	 kxOn8K6NUeq6jhi20YfWv+4zXoop1bZape/uEsvQqRCpxR4K4BIXBgZ/VEweDKsp1Y
	 +I2KdaEOLiTfg==
Message-ID: <sashiko-outbox-206236@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/3] lib: Remove assoc_array
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110044043.2608600-4-jarkko@kernel.org>
References: <20261110044043.2608600-1-jarkko@kernel.org>
 <20261110044043.2608600-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:45:35 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> As assoc_array has no longer in-kernel users, remove assoc_array
> implementation, includes and documentation.
>=20
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110044043.2608=
600-1-jarkko@kernel.org?part=3D3

