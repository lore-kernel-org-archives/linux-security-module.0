Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080406;
	b=VN4Xe7jYqDX7gizsWc4PmXPGh2QyDIm0zxR7RGHvmKeL4/hbMRqOqL0Q6geDjE/QfWAi
	 r5USaAnzkKWPk0dOWzJrNyqEbKnDWFrGF9BdYHuQ0/hKKCyiXdCPtp1Y6ZJy7e5YKlePc
	 D7GRpa4GKj6ebtGt8wV6dGdaRE1fDCca4N5kqJafCEAjN15pdAl26ZLd3yE9Cbp3b1Lg7
	 Qw+XQCk/qRW8SVntsR34t4ffb4WrLrsiOCWtUoWp7Zo7tk4nArkLGAil88Z/jMRxPXiQc
	 Yrh0pdThsoTrZ8JErWLpwiOhs9JnlAnhi7ZpjjwEZHlMnJuHnzdlE/bTtKMOMToNMvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080406;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xxkMYEUl4TLwUUfbwzUjsgbglLKi+uwUGKEqKn4Bc3E=;
	b=sZ1uItbom4gI/NsZJkl1IK0E1GW+TEKlzdgxM3t0w3PkKIve2NbGXmimcN0qfIZSnX1W
	 NBnQMq6cs1m/KGWbDm/FtROoszFLXxlgjVLLG7NLM9ID0gCkdwr+b4DwptU13SLy2AIqh
	 WmdJNITHQrCdCRiH4fsyqrMnMHoC4IEZX9D0fU5RjemkgvwBroVyav8D6nJo9yz4a72aZ
	 U03GFomalOH2qwOLTG8JnbpTIhj14u0NtcG1+qQrqGu7wJ757TaEUt6r+Qr9Jrh6AyS0Z
	 q0W4PiMVq4CC/oKJKDePz+tGH86YEZrgY/V21uKefzt8VKMp7Ff6/Z7zGuG6JQQgYQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbzioATu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1C2606A326
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbzioATu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AB01F0089F
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794080406;
	bh=xxkMYEUl4TLwUUfbwzUjsgbglLKi+uwUGKEqKn4Bc3E=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=AbzioATu/1Rv0pfVNWNMYzqZEJrs+DrM8Y3cQTobbbJzY7xocGxzknZfXPiMDllNb
	 hoz7XzS5Dd2t4Mzz9Afk/0+H5k5LImIs01z77OJVofkJkj4ui7iqK8uc+6ELQsP7hX
	 GPRfHwbHDunZ8bjUpOXqwSmOkuRXjvOumXuWiJn+dhI21M9eBGDc8nvicEHiyurU/5
	 ILtnxrxqJYw6/IY07gTRr0DiTqjydLYtNlsn9Vmf8/lwIke1nCnodBOlubknZbg2n0
	 l0QsS8FMq7oJbtNefmSTv0LLGVtyReEdAq7nizvK6aQDCICYD5LszF8Xyl6H4W8uiJ
	 DDhemhnLxlIDA==
Message-ID: <sashiko-outbox-203217@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12] fsverity: Tell LSMs about signature only after
 verity is enabled
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261107193513.54738-1-ebiggers@kernel.org>
References: <20261107193513.54738-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 19:40:05 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> commit 28d74059fddbd8ae83c7715056b303c402071f6f upstream.
>=20
> FS_IOC_ENABLE_VERITY calls security_inode_setintegrity() before verity
> has finished being enabled.  That's broken because enabling verity can
> still fail at that point, e.g. due to insufficient xattr space.
>=20
> Afterwards, arbitrary contents can be written to the file, which doesn't
> actually have verity enabled.  The in-core inode stays the same, so the
> LSM considers it to have verity enabled with a valid signature.  (Or
> rather, in the case of IPE, which is the only LSM that implements
> security_inode_setintegrity(), it also checks IS_VERITY(), which can be
> bypassed by enabling verity with no signature after the file writes.)
>=20
> Fix this by moving the call to security_inode_setintegrity() out of
> fsverity_verify_signature() and into a new function that is called from
> the appropriate places.
>=20
> Fixes: 7c373e4f1445 ("fsverity: expose verified fsverity built-in signatu=
res to LSMs")
> Cc: stable@vger.kernel.org
> Reviewed-by: Fan Wu <wufan@kernel.org>
> Tested-by: Fan Wu <wufan@kernel.org>
> Link: https://patch.msgid.link/20261025204534.122506-1-ebiggers@kernel.org
> (6.12: resolved conflicts with this version storing the fsverity_info
>  pointer in the inode instead of using a hash table)
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107193513.5473=
8-1-ebiggers@kernel.org?part=3D1

