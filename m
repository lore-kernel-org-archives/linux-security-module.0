Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415710;
	b=BLXhtKz3MFmKlI6C6Lz1aVup4qtOOh37vTpIrPNK/yIKuJXLO1qutUMamBybkBLJRPc6
	 RA4GtQLCjhKNWJWnLG0nZTZ06MZNnITzH522PALSTpFMc90S60osNmvLqG2TxnY3mWS0y
	 B1jCkof8vMefYgunih1/TVGKwBQKONA+0cJiDM7DE4mO92dGS6hi1jt+SVIddpt3WE4pn
	 CxFnCIy8atSPGgkJUWJndcKgiTTO00/phEevHXShiWYTQGk5vfw08zOdz/tBW0K3wcVpt
	 iN+VoUaxE6g1bN9uHRyfzIQBKnRr5gUpeZCDcor8SAiG+d7s7dEUjXuhf4ky0bfM9WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415710;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vfosLBvh3I/3CmAqO8BeBnJa4BveShcERCHhki8Iw0g=;
	b=CwebT0AOMlE68zO4NNC/2EzQOZCjwKn/cFyje7CzqFr8pR80faRdxgaGnRJGqcenKjSE
	 UrpR6KSLnt1aSuDddixJkgHh/OeP86us7yXa0xXVDKqpRFawtWTCsD6mlCPun73WuJt+X
	 3FWIlvtqsyIaclj8iJdetQrRBvGGl7WMfdgCXKivCXNAovqVO0ywyt/9N8TFL89drunnk
	 uq4zmhXQ05kU8SWch4YPXO/wJKVasFRHd2LVutqYK2DumJMxqw6bIrFF8TOdz5uWybwgC
	 ROp/DD4mb9FuSP71jd7frS9WlBoZgb3UKaKZNMHXTxsaD0ANTDP7BlS8pTV1EaSPGDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hXL8AT7A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74564606A885
	for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2026 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hXL8AT7A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA34F1F00A06
	for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2026 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415710;
	bh=vfosLBvh3I/3CmAqO8BeBnJa4BveShcERCHhki8Iw0g=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hXL8AT7APEGSxLSYHuCKNy2pjGrPPSnwuXsXmxmNjr2sx1vAzN4o2xz4UWHKeD4Tu
	 vztj3YMbZH6r34XN4himWq/NxSgvcMnMgYBoCDZU8Q/oT4ddDhXntSP7BYIXk/AoDT
	 JOTUfYfMDQqXddxvXloqWGPrMRk15sKI7cbqejv69bgk5cMXdWCDoRhkwYVieFD4bG
	 Xmo9ZhgcW61i2QBzhqdLoQGFY/m5F9wWv0Th1T87uUTsk6acgqkWypfujHAnLkvGUG
	 8G79usNX58tur7PaA12esOde/8ccbFVWfyNy/UyuC/Yb5CJnVFfbFioKoqY+SLTf9u
	 ZGE1bThNifuAA==
Message-ID: <sashiko-outbox-209325@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KEYS: asymmetric: Fix PKCS#1 decryption of an empty
 message
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261111-keyctl-pkey-fixes-v1-2-934ebaa267a7@cispa.de>
References: <20261111-keyctl-pkey-fixes-v1-0-934ebaa267a7@cispa.de>
 <20261111-keyctl-pkey-fixes-v1-2-934ebaa267a7@cispa.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 16:48:29 +0000
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
> KEYCTL_PKEY_DECRYPT with enc=3Dpkcs1 on a valid ciphertext of an empty
> message returns the key size instead of 0, and the output buffer is
> filled with the ciphertext.
>=20
> crypto_akcipher_sync_encrypt() returns 0 on success, so
> software_key_eds_op() maps a result of 0 to crypto_akcipher_maxsize().
> The mapping is applied to decryption as well, but
> crypto_akcipher_sync_decrypt() returns the length of the plaintext,
> which is 0 for an empty message. By then crypto_akcipher_sync_post()
> has copied its scratch buffer to the output. pkcs1pad copied nothing
> into that buffer, so it still holds the ciphertext.
>=20
> Only the caller's own input is returned, so nothing is disclosed, and
> messages that are not empty are decrypted correctly. An empty message
> is valid, though: RFC 8017 section 7.2 only limits the message length
> to k - 11 octets.
>=20
> Apply the mapping to encryption only.
>=20
> Fixes: 63ba4d67594a ("KEYS: asymmetric: Use new crypto interface without =
scatterlists")
> Cc: stable@vger.kernel.org # v6.5+
> Link: https://lore.kernel.org/all/20260919221742.3709658-1-benquike@gmail=
.com/
> Signed-off-by: Florian Bauckholt <florian.bauckholt@cispa.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-keyctl-pke=
y-fixes-v1-0-934ebaa267a7@cispa.de?part=3D2

