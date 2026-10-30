Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356124;
	b=c6IUhioHbmAnyWl0LmA7B+rSgg4t/cTu5nkqmecXCMhPYc6iIQaYTkeJY0KRJNHJMYcl
	 ao/gb5P6OqRISS4NtYAvXHUDK7U5JJUok7X5nYYG+cgdMD0NPsFl68I+vPB8Jr+mcsP2s
	 Y3qRvS3J/qPbN47eljoF9aGkODzyAWbnaWiGSetVB934avkZXW3HzTM914Us0tKfAkO2Z
	 bZHsUCQ0KwJn/Cd3kZMIYOOd61nOJwB4Y1dwNx70Gim6pYQ4uS7sXIPdC7BrgnmUqeRqh
	 GBEr+MKCxPpIPn8FuStOaRv4H2RNrdyf8cYPliXH0YV2EvfAfHZDldtSvco2tQa1UPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356124;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h4bApnSXwI4u3SQLof4EdePpLuwAnTVoK/ULpNeQqGA=;
	b=RNhu/1bMqsRspyNLj879wMzstkQ0G5LWeI5jp+Ijtk3zzrA+xJ+bW+ODcAx0I2GvlQeI
	 8BzctH4R+o/E62/LHjsv6WX/1380sArOuv26rsumpRj5lJ9JYgvTNXW8MtN4tx9XE8z77
	 fKhZMPMkW02LFE5gNNVjNG+aJHaSr7F2ny5Pw8YWdCNOYQPn2PvoatFl27hgtnGTnFuS/
	 KUYgL6eMba4mNeOYNBny3ubZJnCWxxenv6pYAu03yLNOkJFZ2mKVEK9+CZYn9XE2Lub0w
	 VpYR7M0wMxEzQy7V0ghOeYq6jBTpIXWEx+O2hFJ5AnYtt2k8WKwuJHBz7W86qZE6VJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PElsilsI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B1D60A5BDD
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PElsilsI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7141F00A1A
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 10:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793356123;
	bh=h4bApnSXwI4u3SQLof4EdePpLuwAnTVoK/ULpNeQqGA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=PElsilsIZfGd/qvx9hHkSF6OKkaiD6PL3d+gEQ1E3gdbE5nFw7sEFu5Ks6VtmjAbb
	 CBGZ9ZtJ3llaMGDyPLdw7N0a4ZCPSDCWHbrbjbCaWzcjySiHEy76VFgiiHG5Njkq1J
	 ULqCy/7fOgz13Zz9sHqulkVEWvlm6CDPhQNINVPCTEjWn2C/ZzSGd54pXoMc9D2eb/
	 9MfKylx/8OpYZ5YEX0mG/jbM3PNZffjuivz/gTyE/7ihrlO+kw4h2+aehE8bKOOjdF
	 FKKR2V65EDf132g5pArt1mMHVm2D5VUGA+GhhJrDPRlYr32Q1exkaIxh/GCxhJ5rNx
	 iFmvBXBrX5l9g==
Message-ID: <sashiko-outbox-190827@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] landlock: Simplify landlock_get_fs_access_mask()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261030102411.12985-4-gnoack3000@gmail.com>
References: <20261030102411.12985-1-gnoack3000@gmail.com>
 <20261030102411.12985-4-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 10:28:43 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030102411.1298=
5-1-gnoack3000@gmail.com?part=3D3

