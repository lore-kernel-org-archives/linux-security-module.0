Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795044270;
	b=GPQLozxQMqXOqKvUzaW2Cv3QIMr1yrMiMsLFtXsI6n9YjaQKSwQEhyFEBWTq2v+ZxYvq
	 /pCpiFfPXt8bdwkKBxBwxnjtd9BmzRgX3wXi6xL5Tzb8lyMs7qOuv5Hru35Fceo36eWx8
	 weSVxvUxDS9VZ961yu3Ma35d5T0tnZDmx4a210JAexlmDH1PxJrQ4muOkLQbwFnYAJSj5
	 8+qGUaSk+sEG11Jjv466jGf3asTyQPC7ncB4V7WE8MisqvCeSO+2qiWdThxFfj1DCgcha
	 C2mixOvylu/zmaP+CywA3NJszyuQSTVcpi3vb182oXaK7jFrCWYP1bCj0mxIkSGz/FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795044270;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E4/vsokQ000gTd8bg+fKoj7IKBe0tvzoMJilUkSvN/U=;
	b=DqBGRXlSMYWljeTasSDLDWjItUQJ1yw7WHnyb8GpC1nwRoI3ASWZtTzP48TW8Tq9GGdW
	 afK/Hf9zfxC17Dnnc9+oNKEClii5Q4RkKTIQ7sHEEX03vLJO7FrS5eE//DbJ+S7AKInZv
	 +hXNlP68Wj64k2TsXKHYiYtjRwCk5xfZU4yYgccVRDuhN/fbVTVCY8d3MgeLv+PBoYyN0
	 4GgxrWOT3n4ypq+QGK34ps/3lC2qgMO9dgl2VsBNL9XjXSpJRdCoHiM/HasTcD0JhIed5
	 GOsxoIoFTpXzu5WPpL2k07fS0sFZUjAIG9aoTDukx8Hk8rlqPvto9yGQ4uzzF9FmzNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+eVBGq6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A5260A260B
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+eVBGq6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA3B1F000CB
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 23:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795044270;
	bh=E4/vsokQ000gTd8bg+fKoj7IKBe0tvzoMJilUkSvN/U=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=i+eVBGq6F1pXP6dCCSy/m0YHlX5cLEy7nPT876rZkUg+/8HNsZCgjcbDYmp1u/Dfb
	 xWAakAHaW9FrTIPIouxqSx1V3hgUdv5thbTidybvHu56Mn/W50FAJjbH8yhL4qgBeM
	 RrZm+YH4NDOuX0dHjv/OgzV44VoG02I9kW3ifXSdwQhoIiDQsIdnALK6Ys9+Lv4qTI
	 cCj1IZecj8KKFJe2Gmy5evBJyYyyyEiVDeF65TXvOp/GaspeaiW9Cb/jg9K1WDpZUh
	 wsoLSxlilYnH7xbzAa3LbBnyJbv4Vo+odKecmC5KXjoR68Nkr3/1UTO4FimF+85Ugw
	 ffaR1Av8ZPxrw==
Message-ID: <sashiko-outbox-222177@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] KEYS: fix signature length passed to
 KEYCTL_PKEY_VERIFY
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261119-keyctl-pkey-fixes-v2-1-9e2d1c7db7ec@cispa.de>
References: <20261119-keyctl-pkey-fixes-v2-0-9e2d1c7db7ec@cispa.de>
 <20261119-keyctl-pkey-fixes-v2-1-9e2d1c7db7ec@cispa.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:24:30 +0000
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
> the caller and always reads max_sig_size bytes from the signature
> pointer. A shorter signature is extended with whatever follows it in
> the caller's memory, or the call fails with -EFAULT if that memory is
> not readable.
>=20
> The x962 ECDSA template currently ignores data following a DER-encoded
> signature, which hides the problem there. A truncated RSA signature,
> however, is accepted if the bytes following it happen to match the ones
> that were cut off, as reported by Rodolfo Giometti [1].
>=20
> Use the length provided by the caller, which has already been checked
> against max_sig_size.
>=20
> Fixes: cb481e59ea6c ("KEYS: fix overflow in keyctl_pkey_params_get_2()")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20260919221742.3709658-1-benquike@gmail=
.com/
> Link: https://lore.kernel.org/all/0e20f799-e389-40d2-aaee-2f174748faae@en=
neenne.com/ [1]
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Tested-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Florian Bauckholt <florian.bauckholt@cispa.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-keyctl-pke=
y-fixes-v2-0-9e2d1c7db7ec@cispa.de?part=3D1

