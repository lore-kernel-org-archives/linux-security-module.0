Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415223;
	b=mnUcbpMWoHfkpS0D71rmC0ij8WM1tCC5vScu0kIsYa5WVyvzmGmwfzBYLQ9PuzJkkmsF
	 M9KtLcgo+raEflz0xoqbUR9PSkPal2Cf9KQE32pjfr3jyeMrPKfdY3e5JJRiSR2soZst0
	 4daPUZ2/Y4erPckqlcqUoMoOKCC0a82Qz94CO/rK6MIpCXDh+AG5WsrGjvg0IDIGAwfIc
	 PdqMmYeqDXBe7yVfKK2CPkG88AjfShlr/ybJO+7Re6VAwEVIN1ufJDJjhlqJII4c0kj3K
	 mp2QRQqxuKbwBbACrfI08Ma0rKMV2uhShBG0HItWAFD5AXJ/jUlrNILuWH0LzJ0MOKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415223;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/oVgasvR4eFBR1Wk9CfJnvgcqC2sniZmjI61U4flr3o=;
	b=ODYGGpO/rLNvUlvWFO6zvo2UTThC1+E/kkChhs3rShfhBF73WsmBfQnI8G4Q/pJggCoJ
	 7Wn4/DpdFXWMZz5Mcbygd+/vcUZi/V8GsD9QmodjYqjLOVmMvFRnMoVac2xMWK4wDpBQB
	 Fco73PkcoN0l4m8WeE9CV7Rv4w8o/Lx3Hul2Zq6H5EsLv9zNws99ynsjJhfUs2G69uVnu
	 69QNS2Q4RbC7+5zYb4kTbDREsLl0y3B1i8d+41V65wUXoLAJT+sYOWD63SrbeRh4Fjelf
	 LYwGhKtohxSZGGxQgDL2NXjyirHSpaKQcXHks0/XMiDBH3Uz1fg9W/2IY4UOiBnoFew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cPFFHW6n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D61606A31C
	for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2026 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cPFFHW6n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C29E1F00A08
	for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2026 16:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415222;
	bh=/oVgasvR4eFBR1Wk9CfJnvgcqC2sniZmjI61U4flr3o=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=cPFFHW6nBTcHlxbVEECOkaHQPygbFIQja8gRV5oWmfr1fMAAIqCIc7EmqgE7Zl5bp
	 NEgW/wCJwClqQXpl/CMl7W+3kPpSvXFzaFQsfc9SiOhRj3j4zumh/kWtznNIW8t8iu
	 mwYNQtE1/PNi9yq3qzoDqTtWBhdvzQXWRZHTg2SLRETxTTj8L9yhKeQdcqApVeS7o7
	 9WMsarT9ZDMQaCzZdjV5GMkjqv+ID9pIA8jqWU4ucq26UiAGD8DxFJG/wtNFoexxhk
	 0Vbnp0e09aCZmjm4xp6okF5nb+Aj5/lOGydRC8UqRJTGVwdtaiXHC8dhov/JLlJCei
	 PhHt6GJSC95fA==
Message-ID: <sashiko-outbox-209303@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] KEYS: fix signature length passed to
 KEYCTL_PKEY_VERIFY
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261111-keyctl-pkey-fixes-v1-1-934ebaa267a7@cispa.de>
References: <20261111-keyctl-pkey-fixes-v1-0-934ebaa267a7@cispa.de>
 <20261111-keyctl-pkey-fixes-v1-1-934ebaa267a7@cispa.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 16:40:21 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> From: Florian Bauckholt <florian.bauckholt@cispa.de>
>=20
> Commit cb481e59ea6c ("KEYS: fix overflow in keyctl_pkey_params_get_2()")
> made keyctl_pkey_params_get_2() set params->out_len to the maximum
> output size of the operation instead of the size provided by the caller.
> It does so for KEYCTL_PKEY_VERIFY as well, but verify has no output
> buffer: out_len shares a union with in2_len, the length of the
> signature.
>=20
> As a result keyctl_pkey_verify() ignores the signature length passed by
> the caller. It copies max_sig_size bytes from the signature pointer and
> passes max_sig_size as the signature size to the verification.
>=20
> This makes no difference for signatures that are always max_sig_size
> bytes long, such as RSA. A shorter signature, e.g. a DER-encoded ECDSA
> signature, is followed by whatever is behind it in the caller's memory,
> or the call fails with -EFAULT if that memory is not readable. The
> x962 ECDSA template currently ignores data following the signature,
> which hides the problem.
>=20
> Use the length provided by the caller, which has already been checked
> against max_sig_size.
>=20
> Fixes: cb481e59ea6c ("KEYS: fix overflow in keyctl_pkey_params_get_2()")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20260919221742.3709658-1-benquike@gmail=
.com/
> Signed-off-by: Florian Bauckholt <florian.bauckholt@cispa.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-keyctl-pke=
y-fixes-v1-0-934ebaa267a7@cispa.de?part=3D1

