Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795766874;
	b=becZSZDBj75eAKLu1MwInquKFMmjpBkQe+2wFpsjpT9WWv6RJVXytEUw9xyMQj42ToxI
	 juLxBhZY5wtm3vco9JyiRr8H2D1KR9wvSokc3sZksOmJocSGjULA5Sbavf1iWXxqdhEZ8
	 Lvet7zzZgxfDk3SghW2T4C/ZFHsWhpGwKGPFZJb0q4KnIEyO1GuaFQBeRjueYYUEePulF
	 2xwOD/N0sAXHRRRJO5kXVly53ZaU7VUXXoLDgPXvRWrReL+BqMnqAtaFXVbmEBjx9Lha5
	 Pj4Jvc43Ev7kR4Mw9rXQVCRDWBtMijUxvS7YhE+uNoDHw4z5uJmgfl/fa7Ty0hxDQwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766874;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Py81VRWuH8DWI735x20Lg3IvPXj0Jm5nzDFjQsTFa3U=;
	b=i8ltHwVbZWAFb1GPm81uG/WC3+P6tCLZ2Djt9+oYGlh+wbYCqlf04vA46GW9BgfuySxQ
	 khH/ltIKLiz5ncsmDdkrj9U1xuxrf2GLrYr8j+bcRVaahTLRs+NKA88rvB/AD29THd9sT
	 EL1VRVYnn97eT/nWgd0rGK74E9UT7/cSfHgUwVWMqACBz2cu/dNFEY6K5/yDLeWrNsryA
	 yLIWSfyg6vNZiestpl5Z8r1o+yiMYHQSuxNnH0I356b5sZbHCWwBh6nDZQ94IdWWSfW4E
	 oZwa0q+Vd8TyL8fB7stSfYIK1ekBUKlfm6Q0VDK208xqu0+DAeVV5096/h26dFEfoFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYtGNLn9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762E2606A31E
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYtGNLn9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9696A1F00893
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 08:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795766873;
	bh=Py81VRWuH8DWI735x20Lg3IvPXj0Jm5nzDFjQsTFa3U=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=UYtGNLn9cap16/z+x1P9xw+Gc1pWRU3vodSxhdKDkCARf8FES0H3WUpCSpmfS4Q5P
	 fZZws3xl9AeqG1ZgzI0kS1by6xLisJz4lutdQG0yMXQVnvErZzpZ2zEl7CuIUDXjxp
	 JgWtLw2LaXCiME0IEFuOPXm4pmsDJHEz8U3JU6nB+NQMRtAZqxs2wLHPaRWlWslHp/
	 0lnHfb+uyxmAPHbw5mdAPj6xozdXtEpG7bR1KXF96yk/n7+VNjV5K4JUzAbRla91Kt
	 KiHGdaPwhyRv70k/S5RTds/LkDU+mpEzsPm/efv9B/jW4MpvG23JhjdWCWG2aqyf7T
	 DvHr6s1cG17VQ==
Message-ID: <sashiko-outbox-236861@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] apparmor: set xattr_count only after the xattrs array
 is allocated
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261127080400.275982-1-congnt264@gmail.com>
References: <20261127080400.275982-1-congnt264@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 08:07:53 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> unpack_xattrs() sets profile->attach.xattr_count before it allocates
> profile->attach.xattrs with kcalloc(). If the allocation fails, the load
> fails and free_attachment() runs on the profile. It loops over
> xattr_count entries and reads attach->xattrs[i], which is NULL, so it
> dereferences a NULL pointer.
>=20
> Set xattr_count after the allocation has succeeded.
>=20
> Fixes: 8e51f9087f40 ("apparmor: Add support for attaching profiles via xa=
ttr, presence and value")
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127080400.2759=
82-1-congnt264@gmail.com?part=3D1
