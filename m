Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674987;
	b=KhLnKVpzwlUM8H0rNDjHbIcI7gFVaWLzxIVxEgTA5u6tmhQbT22+3g1U6wfjT1SUpSbv
	 r3sHvxfnwgs69BM3Opw2/Snito0mGKCMfHm93+lP+VAiq5j1PlrHrfrSSn2lJPC2q0oYW
	 tWDTfxJtp5RDdA/C7QncbSeAkDSxymA8csQouGPQDB5flIghwrdvULGRjCkKt4jQuw8s7
	 WLIitpkzWjswN4LTWqYoUclOqL+VYsmrXjRglTquMwFnySLP8J0U+eBcbtEIBw4JmwBCx
	 TJbmvYlqpNSKbunxDB+c3LLW8FRLq+4bb33wWEKplnC8L5dB8aTQUhCi63T2IUZFY2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674987;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SWQRn9ZfNcs6Sjb7KXWMC6r+uw+z2BPw7zdiejGfxzw=;
	b=1cpXmkA8CkQtfuOD5k7Dvt26xRSQmLnyI9esujhT4DpPBnf9MIFk4ZiaW5FRpSTkHIr/
	 Zj+QYHKDmlOjvU3EL4+3wnatghUyL7B8Cb6/q0RDyHaRLTv7UKUS1L7SQub/9EtqazhYz
	 TVndtcH/jKq5auNMdj8DhKOakHK2bQcszp5Svsrhv7NyGwVKU9Ij+h9OwvZRYPs73jJiM
	 7D4rK3G5w2ujaiM7r9CBhjhTIFRg2PFfXeg+dXQTfHAva5/KG/J4saOnI7yxOdIb2kQuU
	 Npha7t1P5HMyiLLG8fAKuzfLXNi58d4fNo2TCGlp1e4RimUyDG+j29Zxqxt3Y3kMuzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEA5bqeq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BA2606A881
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEA5bqeq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D901F000C6
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 16:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794674987;
	bh=SWQRn9ZfNcs6Sjb7KXWMC6r+uw+z2BPw7zdiejGfxzw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=TEA5bqeqrlsPoneA5DMpbAJFuj1b6N0/1O7DWoytZ8HMYHNYK5u/YGrbmGwg+wnJL
	 aJIjVtseXT6kPvstOeIKkbA6/3w5mdLGJW+ukgN3qC9o848LQJELQYcqrgq3laCzBb
	 myVmNnLORg/rJq9y2tJsvCXGaKbvooCxl7nbmdMN5YcbRL4YOtIUAPrenVkTOALNnd
	 jR+LMZ7U17fl0i6IVvlfzrAQcfR5ijr+F4/r9B6DWkF4OSOpSvLe7vxJdLkbWpIEUa
	 a2/7+kfaZXhTfaEB2bPZME/+Gx9GWc4f34OijID9roHPNZ9UaYEfYkFTcfpQkpIQHN
	 oOrSm7e8Lidig==
Message-ID: <sashiko-outbox-214787@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 6/6] lib: Remove assoc_array
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261114164139.429814-7-jarkko@kernel.org>
References: <20261114164139.429814-1-jarkko@kernel.org>
 <20261114164139.429814-7-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:49:46 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114164139.4298=
14-1-jarkko@kernel.org?part=3D6

