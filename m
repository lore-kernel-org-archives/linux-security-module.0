Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE5F392C2A
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343603; cv=none; b=Gq3PXfVwqTuPl5GPqWXbzAfqmxaYnpCtusrFalRQ6++jtvTHbtQEr3TbikKct2tTnCwV19l96dC1kcIbWKWk6KMAwxWjP/PeJWrrEX3W7mvmxySeUXiAY13g3U5J4bXR8vQ6lcikzi8uyB/lp35XWFTSRHhvCCHQXepCX1Q1yIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343603; c=relaxed/simple;
	bh=J/vhOVN9CWKUosL5VbRBlGs68/I5xZ52Gi/ORrZJfm4=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=tpJ81L/fHpaHS74b7b6Doojj2jxRks9D0lIVcoLqT4VsuV/vsIaptW5UT0mgrKemXj296vs+6x0XTPKI3lUxAYhqkLO6DCHaLAlva7/e2nCsoXZBT/bArOAy33vS2vFGTMIpN11nz0mJ9BIjuxbM25Yb44amfiC7MTBEbdi/WOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAQdwwB/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAQdwwB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A969B1F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792343601;
	bh=J/vhOVN9CWKUosL5VbRBlGs68/I5xZ52Gi/ORrZJfm4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=FAQdwwB/BSdjQwtWVF4XR9EfAnTjB09t1iNRj+g5IN6kLj4ELXMf9F8z5qh6pq8dd
	 xpu3b5pI20BhuUpoxiPiqLz6b2T7ojjFe5sYiiDkiA6Phg2BOBhKhA1umwTg3/dF64
	 bMcsELuyIt/qVIzAjX1Du40/BL2FcjWP3bzMnPBCJ60nAbBo/9BgWsX86zFiHWT3A0
	 bk+2No+3xMVA6xFgXMERDUTc6JblcqPNJt4e46/QhpnzFd06NdT8nmj0pCj8njxBvg
	 8GU6M+V1JZUk3yCpgKJb0UADwdAuSdgUQYAcueSTIpEPhPfHHljhWvnGTKIGP4wC7F
	 XAc6WMVp5ljQw==
Message-ID: <sashiko-outbox-176306@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/9] keys/trusted_keys: fix PKWM output buffer
 cleanup
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261018170844.491252-6-ssrish@linux.ibm.com>
References: <20261018170844.491252-1-ssrish@linux.ibm.com>
 <20261018170844.491252-6-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 17:13:21 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The PKWM seal and unseal paths unconditionally free their output buffers,
> but the PLPKS helpers can return without initializing those pointers.
>=20
> Initialize the output buffer pointers to NULL to make cleanup safe on ear=
ly
> failure paths.
>=20
> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted sour=
ce")
> Cc: stable@vger.kernel.org # 7.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018170844.4912=
52-1-ssrish@linux.ibm.com?part=3D5

