Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426217;
	b=F26zA1HDASOTCZl63WXsAH5yR10ZO9OxUSM4UQ530XDLqXZgkOINxgvhdjsmigJaYkUa
	 mwuJ9HSpiDD2qOPlGohgEYAmVvME12SSIn1NDOMxFBc1iOlxd0qid7leeWJ5hX+98sL3H
	 7sv6xzdBNaH0JBsidrJSN7yW0Q7KT/0LGlXoWoGYACFJkEl1t9Kdg/Vy5kbhtNXbsa2Ad
	 xE/buRomXU7QyA8yeZxgKvmrt93q/UFZJlc0T7Sbx6I6sHhTlZposGo4RpOWVl+7O5Lna
	 hWNJlZjs5yAkg5cHwCobRgrgqB52fLafW5DSX/ZNMISfkX1PVIJPlNnAJrnL5K55q7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426217;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Pe5TJeUPeqhFMLkTr9ljqynL1ArqqRQeyzIuwrC3oFU=;
	b=38cPK3iO9qi5wIAhF4eAuK2msC36CvxKhS5+afDTrFyu1oPIiiKjZfNZh6NmlV8YldCk
	 zKJ9D7a/dCQX3qT0ttdLEBggrufNVA3/6VYj8iBENgyEfiRNemDyS2GAVDbH4u/ezHWxK
	 LT2b5OaA8YfGugSS8VACGO1elunxlzBJmlZGD46ywJ7vbbCA2qIDP030k2Z4ZJpbdF0iW
	 1bQBfakEPVCxcpm+MHTbpZ4Eh5qmaE6D49zDhaJriu2+uZIyQrku4e+dLRChVKCJ2gzxP
	 DoCi75dc6DLYHvDCrtm7koMzB8D5XXCDrOWtQXQdnPxcmMEHf6T0Ur4dtcq1qgQXbIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYuy85m3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6798606A31E
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYuy85m3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269E81F000C6
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 16:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792426216;
	bh=Pe5TJeUPeqhFMLkTr9ljqynL1ArqqRQeyzIuwrC3oFU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=eYuy85m3/uJyvfPhtGi26zJ0S6loUFlOGoK9ORYfRyWOvp23pIkN7I7JCNBqyRm0G
	 riXq81BZWwoqLESCOOw6PrjQMnmWa22Mn/wMOnP1U2A3fX8H/2z0rVOTtZ9zFWwtQb
	 dqH6yVMSbyYbGPkHt2itAw8Of7OA3fQrQDiDlvn6eNmZyzfcIo4tAd8hPFV5Rm+Bjq
	 UFAvyUavNWC/esRuDKf5CR6f7k8u5SWDUV5y7GVsm617ICwNPdI6rluNqZWLHAF+jW
	 AyS1aua6yF8cgBruwu9DEaK3pZjjqJwU0mY1n6gJeIuMu2mg6M3w5wWthzKg7HFlVg
	 mGotlRBpcH/9g==
Message-ID: <sashiko-outbox-177820@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] keys: Protect the read method check against type
 removal
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <pm-key-management-objects-candidate-0010-v7-fc85721ff5cfb9e33ac6@gmail.com>
References: <pm-key-management-objects-candidate-0010-v7-fc85721ff5cfb9e33ac6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:10:15 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> keyctl_read_key() checks key->type->read without holding key->sem.
> A reference keeps the key alive, but does not pin the module containing
> its type. A surviving RxRPC key can therefore be read while AF_RXRPC
> is being unloaded:
>=20
>   KEYCTL_READ task                    Module unload and key GC
>   ----------------                   ------------------------
>   lookup_user_key()
>   permission / possession checks
>   load key->type
>                                      af_rxrpc_exit()
>                                        unregister_key_type()
>                                          GC: down_write(key->sem)
>                                          GC: retype to key_type_dead
>                                          GC: up_write(key->sem)
> [ ... ]
> allocation and copying to userspace remain outside the semaphore.
>=20
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/pm-key-management-o=
bjects-candidate-0010-v7-fc85721ff5cfb9e33ac6@gmail.com?part=3D1

