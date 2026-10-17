Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD49F3A16AE
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 07:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792223591; cv=none; b=YojK5gQdmNi/x7uBMrXaGY/ksj8MZ0iGzH8QitGVOdjaihZZJ9Rw6XBvV9KDEkqipV/4L7gtVIzZ+R1rKnq9ljuuBKPxkXxhBPTskkdZ1OB94aT/0ztZRZnDxgJ5561H884YP+IImh43U69U2h1P6mcutCnuHhBF7AuKUlx4aDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792223591; c=relaxed/simple;
	bh=KWTKx2L++1SqdYyu5yo2RaDFg0Wk9fpmecSwQVFfIz8=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HnnRcYQt0LQ40mb7rDSQBPSqoYUaBzhabbM24HwYzpGwir5hW8/+fleoOq3frETc3MSDXrNehtzLARzhclUPYLGG2Mr7szUHId7W8pebWh1LcKVTHp1Dmlu+SUbkVEaVUMxFUusjfHd53xoNN+3dvYja0/phVIb3NLHQTZnVO+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmDt7aCf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmDt7aCf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364791F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 07:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792223590;
	bh=KWTKx2L++1SqdYyu5yo2RaDFg0Wk9fpmecSwQVFfIz8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=nmDt7aCfCm2m0zaVoDFiG8s0vzWj+dMN/vklynPBdJeq+ahwZ4E43iJHCQQ9lPREA
	 GfX99LvrjoqXhLcKc3x1C/u5DeCuai5uxkvAJw+vGryFBsvaaIXIOOIzCCju0NUtbk
	 uH88EoHw47h3OZ6h4qY/KibCuuf/H5DuEjy/QrfeQCVJxiieNa9axt2yS3cxEy9oEk
	 4cb7fZCvNuKDiVdWOIn/h9BJry8wuXq5teBQ0AxYnPAxiJNAlYZ19xR37KjK9Dz5ci
	 WDg5R50MKb2TqD7nzIlXks4Cbkt0oypdj+/nq2FGKguv4RU6vRZgaWq3hSFuedJo7A
	 NEzrUdiPedYOQ==
Message-ID: <sashiko-outbox-175378@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] keys/trusted_keys: propagate wrapping key
 generation errors
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261017074850.164031-3-ssrish@linux.ibm.com>
References: <20261017074850.164031-1-ssrish@linux.ibm.com>
 <20261017074850.164031-3-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 07:53:09 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> plpks_gen_wrapping_key() returns a negative errno when default wrapping k=
ey
> generation fails. However, trusted_pkwm_init() returns -EINVAL for all su=
ch
> failures, discarding the original error.
>=20
> Propagate the error returned by plpks_gen_wrapping_key() unchanged.
>=20
> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted sour=
ce")
> Cc: stable@vger.kernel.org # 7.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017074850.1640=
31-1-ssrish@linux.ibm.com?part=3D2

