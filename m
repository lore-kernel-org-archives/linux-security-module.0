Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2493D9529
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792262633; cv=none; b=uacVCGDZRG43hi13OosvWH6/WbWIz5orczmG75TQ5EYRgHKClbGUCgOHC3aY/Xd1oQakpUHOY7Gq6q2cqOfgipPA258hts0rdYCO+3As3ToKYyacUbPVLCMr/7emv53gewOrvcHq8hOnDsPtGO0YIsUIggoTgsJUmwX8qgxm3LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792262633; c=relaxed/simple;
	bh=S2ea+W73XjvMNfSxSFdKWedK7Nkip9PgDaQM+LFQDts=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=mU94uxO4aOS48QLXz4YYw9uZ+eIzCViITEYVGuGFmInUBZ6/5q4cRRPNEpBwd67t/gQYZEnnWvL6qGJlmaJfhKTBy9b8jXzLconi+Rds6kjwUFiHKZQsH4gtH+eeOJzbzhFhSPr11jxvWRvPv1y3IkMTmYukBPNpzfVQfj199Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cB9SZB6D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cB9SZB6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27101F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 18:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792262632;
	bh=S2ea+W73XjvMNfSxSFdKWedK7Nkip9PgDaQM+LFQDts=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=cB9SZB6DWJaTate1edIjtHPRGWEZv/k8+HcNuzN0Q823IfjTUkgkdCi3OkKc+VH5V
	 rrBEftUGpjeC3fuE2g870isa7kbCVtfq0vhlc3khm3kelPDApjHNjdpbXgsEclZUNM
	 EZ6/gsenNoufI0VaGYACMh1p/w8WVCktrSU2/cV+cVgLfMA9mzEwG29FHIkHk2LpBq
	 /1bk/1tq8JODx/u8qEDsfOEBPM4gi5dMEiOiM6KWp6Og0+AfyduNBqAEome+j5bfoH
	 O1rrupsXVAC2uMfXc0SeYfkty4lFXGjidmOyxgvtEXkYCP+qtqvFi2e8gz6DiXlvUQ
	 HkLYmU8E11LQA==
Message-ID: <sashiko-outbox-175748@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/9] pseries/plpks: fix double conversion of write
 and remove flush errors
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261017183853.596052-2-ssrish@linux.ibm.com>
References: <20261017183853.596052-1-ssrish@linux.ibm.com>
 <20261017183853.596052-2-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 18:43:51 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> plpks_confirm_object_flushed() returns zero or a negative Linux errno.
> However, plpks_write_var() and plpks_remove_var() pass this return value
> through pseries_status_to_err(), which treats it as a raw hypervisor stat=
us
> and converts it again.
>=20
> Convert only errors returned by the write and remove HCALLs, and propagate
> errors from plpks_confirm_object_flushed() unchanged.
>=20
> Fixes: 2454a7af0f2a ("powerpc/pseries: define driver for Platform KeyStor=
e")
> Cc: stable@vger.kernel.org # 6.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017183853.5960=
52-1-ssrish@linux.ibm.com?part=3D1

