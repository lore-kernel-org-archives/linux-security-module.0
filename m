Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204175;
	b=NypmM52XrxRiaj+n0OU19o6Xxfc3NbPl54pXQ4vZkxyqAd2TMITRQV9f9oquacduccq6
	 gGVIbwpKVAmKykBrde8TnZJI0cobd7pzNrt6eyXRyQRIQ3A+briA9df9AFXNxYH4BiH5a
	 dIFtTau5oA8BFPIdh4ibK2XoDlFtSHdJI4D4UWg35JJbUHHdrz6j3v0VqUcEh3uJpUQ1b
	 amep6tgc7oRXok9j8edP6kiZWK0JQhU/VBjyXkbgqxddhQLkySHVVC+RJmR3Ka/tvQNq9
	 BVApl2SQWqhM8e2noflT5Y9q3w0lWiyo/tQRwiUsQoUwSWO6wYoDQB5UXpjUfJBTTkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204175;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gxdriF0reIaifBmXiYaMPWezClX59Q95fZVhShs1GB4=;
	b=RF2ozSJtMujYcrplkL9k6s6Y0bs4V/NhLLJtcluLoA5zzgLUVqL6y2+v4TdIHexrkx3M
	 rqcnf7tjhFjuuxtjQa5njC3+FZuKsUyy+WTO6hQVjdshBlwZkg/abytr511XBBqkg0Cv9
	 rxZglwRDDHIak6CxnXucAdEn+SWqfYywoiIAStcsC8WJms82a5YhBY2tg2DrkPk3ZrnAy
	 IEjYOyw1vWVX8vK3Gz9L3f0mt2AiNOdScOLCexc3GAMdf/0xtnhRb4QFSBeV2pZqopVoz
	 UVjj3FKXWGf5xPlIu32SP3vcHD32KB2uDYVIQWIub1pBEo4cP4Dht55he/3dJsEMtHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfV6qYcv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294E5606A31C
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 06:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfV6qYcv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC0C1F0089F
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 06:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794204174;
	bh=gxdriF0reIaifBmXiYaMPWezClX59Q95fZVhShs1GB4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=AfV6qYcvVK4avJHs9riDmEI6SsCCrlazooBGrFCYByGE1ps9OM9b/f8/JYuCIXeXr
	 CbGKX2E6lfIIVilvYX0G/JvnBIPUtgnU2l0LYS0EQ1L0NzWUQ0HfB01wKn7mwzbhRz
	 +RSYgML6RBW6hILnrT9XQWjNWuSPGTOiSi7Z5qX5F9e2YJueoq8UXiR+ScIYlJjVGL
	 10GzAF8cDbtolYIa9xbungzI/XiM8kvTv4HTt4BaFrwNbKmdWugByF55oVF+5ViDYO
	 tmwmn20R3331sSdGzysBCYXj0MOLfIN5lOH7x4/WELQnDdpKqH94Zg4zWSApWaQHPF
	 NJCoEGEd09otw==
Message-ID: <sashiko-outbox-204480@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] KEYS: Protect pkey method checks against type
 removal
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261109055204.31673-1-0xbeac@gmail.com>
References: <avCZIMCsZ4um18e-@kernel.org>
 <20261109055204.31673-1-0xbeac@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 06:02:54 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> keyctl_pkey_query(), keyctl_pkey_e_d_s() and keyctl_pkey_verify() check
> that key->type has the ->asym_*() method they need and call it later,
> without holding key->sem.  A reference keeps the key alive, but does not
> pin the module that provides its type.
>=20
> When that module is unloaded, unregister_key_type() waits for the key GC
> to process every remaining key of the type.  For each such key, the GC
> takes key->sem for writing, switches key->type to key_type_dead, whose
> ->asym_*() methods are NULL, and destroys the payload.  If this happens
> between the check and the call, the keyctl calls a NULL method:
>=20
>   KEYCTL_PKEY_SIGN task              Module unload and key GC
>   ------------------------           ------------------------
>   keyctl_pkey_e_d_s()
>     if (!key->type->asym_eds_op)     unregister_key_type()
> [ ... ]
> against type removal").
>=20
> Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops=
 for asymmetric keys [ver #2]")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuansheng Yang <0xbeac@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109055204.3167=
3-1-0xbeac@gmail.com?part=3D1

