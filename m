Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793287285;
	b=XLd7lyvQY74FQVDWDRb4jjVjVRgcCpBN+aK1B9iWB74uhgoEw4bHC3MAyk6s0lulWj5B
	 19+MNDRlgGzwFN+9GKxdmbP45VgDyw5VR5yYSNV4gNaMh1NVjWSe3QeMCOy7mH+334Vwq
	 w73Q8pw4RX6pw+FTzU3lNUwnvThIyB8F5Sy00UVgUoVCA0g/CEHlE6sMwzF2LHty9ADSR
	 iNB6o4k2yuSzaxC/Gpx3mZlMtqeLRJkzaTYgN/S1a/GmnY8m9A7mtBEdM/liuTmQ0UFRS
	 s0Z7NZjqobiwxBW2GqKjtEC6BpwiPBn4bqR01zaQkOpG9ndLH9UdJ2/DiwDOsxe2Ywg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287285;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Wo5jTY5q3sZ3DP6B65qdbKwNGei1NO13ySSmkwLoN3Y=;
	b=ptgEKsACOdk90Kc0COVwFAxQeagvC2/fCR5DTkBplt6Zy2EP4gjQPp5vWj57OulP6Sde
	 B0S5iQF6DCOcY83hSlPvGBkhqB1wbwAGVx6PBc7276nwXAUvYYoYn7WVXXFn8AsyMCsu/
	 Cxl7ovZXu4oOOlmXf+tQI68+/fDUQ9lOAMM9E8Ogr86EUbv4/4LrbLMMLIgazJUgFsuT7
	 Y3lmQmBJ5lNTEnYmXXm20upek+VcVdv6vABEQMVDxdsAhC1mduxCzxsfqo7aPOvCkz08b
	 rIn2QGJE4dL5czryMCl+CmZ01Gh6hs2s3zQsnyNEAwGS5qh6LStmG/UM1BwrYu78DSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhdHJYR3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45BF606A31D
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhdHJYR3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F021F01824
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 15:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793287285;
	bh=Wo5jTY5q3sZ3DP6B65qdbKwNGei1NO13ySSmkwLoN3Y=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FhdHJYR3726+t0vQ3q1JOTqpbPWJFRx6/wQYasdTOdw9ChLS/x+82i3N1X+e89TSj
	 oYWNbiaA/ssokC7VDZ7LH8CnJK5OxqRqbRiauQqYyWM2GCvIr6PVGTFFFa0ITDNpG6
	 EU7eW5XzzgvNex7ZWgEKxrkU7tJN0/7mnZY1AlWFzwnGmxriy07REoA35PIzeABBcq
	 yDyxb+eyVRsKJGfr8jnpd6ltWXw2bUY5w3WvQd5qLKxhPV0N2Yv8BanlulrvHrVvcW
	 2XnXlYtwmAHsxxkB68OTUvcdtHxmvfyhs1MHgv5DI4Jm/toC4PLOkukz+YCc5JT8UN
	 eja2tEde6mcHw==
Message-ID: <sashiko-outbox-189594@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2] loadpin: allow untoggleable enforcement on
 filesystems which don't appear to be read-only
Reply-To: sashiko-reviews@lists.linux.dev
To: linux-security-module@vger.kernel.org
In-Reply-To: <20261029151432.27642-1-acrate@waldn.net>
References: <20261023171508.3460300-1-acrate@waldn.net>
 <20261029151432.27642-1-acrate@waldn.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:21:24 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] loadpin: missing kernel-parameters.txt entry for loadpin.force_enfo=
rce
--

commit 3c1a61d7c88964a1454aaa2bc83f65dd49fd3e65
Author: Amelia Crate <acrate@waldn.net>

loadpin: allow untoggleable enforcement on filesystems which don't appear t=
o be read-only

This patch adds a loadpin.force_enforce kernel parameter and corresponding
read-only sysctl to enforce LoadPin and prevent toggling enforcement even
when the backing filesystem does not appear to be read-only.

> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index f71861f98e1ab..0014f78799b21 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c

[ ... ]

> @@ -436,6 +454,8 @@ DEFINE_LSM(loadpin) =3D {
>  };
> =20
>  /* Should not be mutable after boot, so not listed in sysfs (perm =3D=3D=
 0). */
> +module_param(force_enforce, bool, 0);
> +MODULE_PARM_DESC(force_enforce, "Always enforce module/firmware pinning"=
);

[Severity: Low]
This adds the loadpin.force_enforce boot parameter via module_param() in
security/loadpin/loadpin.c and documents it in
Documentation/admin-guide/LSM/LoadPin.rst, but omits an entry in
Documentation/admin-guide/kernel-parameters.txt.

Should loadpin.force_enforce also be documented in
Documentation/admin-guide/kernel-parameters.txt?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029151432.2764=
2-1-acrate@waldn.net?part=3D1
