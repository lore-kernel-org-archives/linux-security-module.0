Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794195510;
	b=vrA1e7faQbJCcdqHq51DA+31h/4+fT8qpCyhqqQlEslViCfJsvK1qtKYZGU9Dh9rOgPX
	 tvYzLQJkS2qZAJ0vgZSIVR86xWzoi8+e/o6MnhMpjiD7+LnHmQ+i5ruTtg9Uf7JCScR15
	 kedePOO1NSI24ktE6PP9HoC99F03TavXsVCAU6xUoc3Id0k8EWjLHne/yWPbluYdvpGoQ
	 65IMc2CKGFRko9CxbpLqWSVDvbFChUYY/+cGrSpYZydkKjx8loEzzMH7ealDMCMZgaobp
	 ShfZmbwzJsvanVy75gDpP3ocAThI6Kp8X4epePzC0fHo0+XBvKa4e8iWlziJv0+69UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794195510;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0T56vh8ANg7dvekGU2s7V45mxPymyzMv+otMfFJ0AHQ=;
	b=w1TLFz0w3AHGLagutSrIwf3Kl4r0EcpH3m+ywxLnSORJs90nLh6mnQj7l4j58YodnpIs
	 O3j3LL9ktHewn36EiEL8FLIeEsAowvympr3JQlABen1romEENgLKCzIwtQCDylLHQDyY7
	 dEzTownrqoLcCJOEYRGykEqoO8xMoMVOv3C2XEEpp81QTVzK+NtrjtgeNkhglFX0L2kJZ
	 Kh6VWYxe7LYoEMaPW/PVnv91ZMaie3Wmw655VN+qNzrfvDpT35pistGfrHLjEQyjurrji
	 yTavixyaoU5I+kDhW3VlsvqUo8+WITXvvBk7bLLvz2vzDdhn/urIVwg2k+lR1aLAzGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRXdvFZZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31028606A336
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 03:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRXdvFZZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1B41F0089F
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 03:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794195509;
	bh=0T56vh8ANg7dvekGU2s7V45mxPymyzMv+otMfFJ0AHQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZRXdvFZZE1kcIK041kzft/t1AK4UWg2PUPhffDibsKx2Fojj6ViY2TSirbRm0IVm3
	 01EQ6ESMZvvNVKksF1BWvwmOQ/n07Kjc5Npu3y145WLUJsVJpgqGAbSl2RqbPVLSz7
	 0gXuV6kpFcwFPumDTWfsphwUxt3r6ZDwMBTsflb6Ss2YQKgx3YSITHAUk8ceVbDZbd
	 8Ditx/cxFs1E1H2dB2Rmeegl85TFs7KhVd1RBSsrc7ZdsiSOZL5e8fXfrZC0t9QL2y
	 Fl+layuV5SHwQEgudQ44ohaEecVlQgRhInNKGT/FdQZxcoAkPSb5WubUBfzk09uOnI
	 vwSvoR4Ezi+2Q==
Message-ID: <sashiko-outbox-204377@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KEYS: do not let an unmatched key decide the search
 result
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261109032931.80406-2-weiguixiong@bytedance.com>
References: <20261109032931.80406-2-weiguixiong@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 03:38:29 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> With the dns_resolver key type available, put a key named "foo" in a
> fresh session keyring, revoke it, and search for "bar":
>=20
>   keyctl new_session >/dev/null
>   A=3D$(printf '127.0.0.1\0' | keyctl padd dns_resolver foo @s)
>   keyctl revoke "$A"
>   keyctl search @s dns_resolver bar
>=20
> Results:
>=20
>   keyctl_search: Key has been revoked
>=20
> The search returns -EKEYREVOKED even though there is no key named "bar".
> It should return -ENOKEY.
>=20
> A dns_resolver search walks the keys in the keyring and uses
> dns_resolver_cmp() to compare their descriptions with the requested
> name. When keyring_search_iterator() sees the revoked "foo" key, it
> records -EKEYREVOKED in ctx->result and skips the key before comparing
> its description. The search continues, but without a match it returns
> the error recorded for "foo".
>=20
> Call the match callback before checking for invalidated, revoked or
> expired keys. A nonmatching key then leaves ctx->result alone.
>=20
> Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> Reported-by: Jarkko Sakkinen <jarkko@kernel.org>
> Closes: https://lore.kernel.org/lkml/avDG8G-Jl1YsmfCs@kernel.org/
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109032931.8040=
6-2-weiguixiong@bytedance.com?part=3D1

