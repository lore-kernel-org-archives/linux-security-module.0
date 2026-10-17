Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4321B3E3166
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792262699; cv=none; b=I2f6b4a/9mPThlA/hA219RUKOMwQ/CTrmw0pGRSaZJghGeS3lZxM/6CNOBItnhGZ/qCS15WveOsIDSwKRoxrB2b/XjYxRqCFtW+WIZ6NWXxN+2UgmbDdWK3JBG80DVXSV2rvBvECdK/Nhc0XFAJ9PVLAogM6rX7fTLGv4XF7n8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792262699; c=relaxed/simple;
	bh=5IcLQarjQ+Ob/G94jrZB+1WrMxUVA8WP4PxbLgarnkw=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rX57ii5EhXT74fSnomYOm5jMWQ2mUqlSCwOuuChrHc3MaEQ6aoCA0igUyVvZbTtS6pLU2Lygh8t1LVYC+Ih4YgZxlkF6+hxbHANL+JF9W3yMhVs9OXOwUhmiDqevZ+p00Cmvf6GaL1TSsnu1lOwRsRvnN+pQGt2+rLW4xYty9lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIQPOnSx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIQPOnSx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B978B1F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 18:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792262697;
	bh=5IcLQarjQ+Ob/G94jrZB+1WrMxUVA8WP4PxbLgarnkw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=RIQPOnSxKDaCnlZ8VWR79Iq34kLGe44qq7raj+F1O3FuIJgsBIAM0jet3vbyy0T5u
	 ZJZni17wR2jy/obub/5V5EeUmNOt6pIUhsv79GnoIKyaLfrV15sqgcLXqVvnVMMvJT
	 cpfQvneFlhk5Gk5gD0KuTKqFXk2MaJxBDV+8qhin8r86+Us+Wkxbo+wnLC5TR69GnG
	 qD0sfCFrizWEjUmwrNIuuqg69wLM9QoczSOI8ftt3QU1nt7fQ4fwvHwiWVOPTbK1yp
	 mtg/P0g267GQU9kvNb6F5qrARbfM7bHueAcM6ABHn8bwO+CQms8Q42nVoGLRYOJPzr
	 0o1IDuUQNmV6g==
Message-ID: <sashiko-outbox-175749@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/9] keys/trusted_keys: enable PKWM wrapping key
 selection by label
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261017183853.596052-9-ssrish@linux.ibm.com>
References: <20261017183853.596052-1-ssrish@linux.ibm.com>
 <20261017183853.596052-9-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 18:44:57 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The PKWM trusted source currently uses the default wrapping key for all
> seal and unseal operations. However, PKWM supports multiple wrapping keys,
> enabling better isolation between trusted keys.
>=20
> Allow users to provide an active wrapping key of their choice created
> through sysfs when sealing trusted keys through a new wrapping_key=3D<lab=
el>
> option. If no label is specified, the default wrapping key is used for
> sealing.
>=20
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017183853.5960=
52-1-ssrish@linux.ibm.com?part=3D8

