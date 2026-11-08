Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169748;
	b=akXD7hAHvpJl6VBufzIbbV4jV1DIfea47zgJX3ZXF4NnMetZwQg+4SpmhNbzjljs8oNr
	 OiLKTnWSZ80lBHrfXETQOfCKCFsShT8O14WDDiEYmqc5FBvkY+cFX1hLOaEb+RuyR7R/G
	 Er/0RcDrEGHnlemmt4tvKLkOoAJLsMtzy8MakHAvcou8j/n/38r/9H2Gp+0zzC9NHhXVb
	 5PmvMV0x1SqeM45Eo+B6ySaAEqmrAN02OS/YSGGuvuWzbCpmXko+jyaoo81jSLloVfAe6
	 f+7E9Dh9uzIgFF15pq5Lrtl9wXx8XsflCBSDJvL++bFrRpjGeIlV5YH/poNSJIu8H5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169748;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m+1aOLs8wattuNV7pmH7DoXse4oolaaExRPxyFX2Bls=;
	b=ihmiv49JP/86XBmAjqjroiqmqohLA/tizcB0DCJ4/aCceuz+ZiJiFCqg+isTejm6BQQ3
	 +rIm7XgXMeTcNzJJz8lhSJvUQHmlgJxpfy/WZkc2yX+0uuSATZ1ff3JbV9BCvw4DPYdGA
	 Oy9k36BGWV2xkHQGwqPpWcoRVhrBlmIlWbyQMlzDnj+GUICv5U2CtQTkj2R+yKDyfFX8v
	 r3DkbjnIJKdBkden3skBGj2VEMWxeaYy5h/4MtZgMP/aMYiMqJtpBGJ77KEnKhZ6Pz3Cf
	 hxPPcnrhSmhCJMFqGGzfA6l+jMZkUvKXulY7I8eIp6kyls63qDUsdVZ6omL031CHzXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BTRUuZNB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5683606A334
	for <linux-security-module@vger.kernel.org>; Sun,  8 Nov 2026 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BTRUuZNB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966441F0089F
	for <linux-security-module@vger.kernel.org>; Sun,  8 Nov 2026 20:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169747;
	bh=m+1aOLs8wattuNV7pmH7DoXse4oolaaExRPxyFX2Bls=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=BTRUuZNByTdx5uM1evg425lqvT+LDMiitr1I43yZuoS38vpEN+1jZfDEcZr4QLMAv
	 kd7UmwWMWtU/9sQnNjopmq81zlRay/OsRKEj9gMNTKLo46YgY7JEAs1n39kAfVZLjm
	 967055dz4ZcTXU8S6RZXZ18CPnkyGDhimbqSz/SP6UVe+rBTG9CVkw5CeSW1+Y2dQk
	 cgsyNsIsVGWTcsQHuaqgEJhDW04jDvB1n3pqC0oUYQJENE/nM2OpQz+/CqUBRkWxZJ
	 t03sdQj4x2k2U/HeJXSsbNp6gy2Gc/3ERZL1ruIVsy9nCAj/xOhF5lKrFfqqW5HaE1
	 Za4293lPa3AHg==
Message-ID: <sashiko-outbox-204016@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] landlock: Simplify landlock_get_fs_access_mask()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261108-b4-landlock-refer-nonfs-layer-v2-3-2b405fc1b3aa@gmail.com>
References: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
 <20261108-b4-landlock-refer-nonfs-layer-v2-3-2b405fc1b3aa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 20:29:07 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Return the handled FS access mask as it is, instead of artificially
> adding LANDLOCK_ACCESS_FS_REFER to it.
>=20
> Since commit d6c7cf84a24f ("landlock: Simplify initially denied access
> rights"), the merge operation already bakes the initially denied
> access rights (LANDLOCK_ACCESS_FS_REFER) into the a layer's handled FS
> access rights. -- They don't need to be added explicitly any more.
>=20
> No functional change.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-b4-landloc=
k-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com?part=3D3

