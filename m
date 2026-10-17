Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D98E3A9628
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792223683; cv=none; b=PziqE5XiqV6po9HTgeokhqaqA6pAeXmMJ/K5AOLMmLExX+0fEEHq7VaRLcG5AGJQr5ckFiG+1jCRYJtecDG6iy2OAN/Kn+O0QgtBHcL3MIbzRX+G0zV1QbbNmNRqtFPOhhM3zRQyQDV0cr0pj8a7u9um8AgcKto6Or6o8fv6beE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792223683; c=relaxed/simple;
	bh=7WKC97l/+4LzrNMTvjN2gUWC6Li7BE7+Zsq6XcXQSGM=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=g9avoNiphnMW1iDXsU6y/SkCQBn3mjuToSBIspfBcfsHVNUW5j1T6qBc19CImwzPBUSeHuL3/Zw0oUDOVXwSSyvZ4glNtgH6DPLdnUvWjXhXTYHv9uqpUJ2dkhFC6++54VUAi3qa1nYDnr7HvYYaxHNaGffiyWC9tKCcbWeUDnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMpk18tB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMpk18tB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1681F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 07:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792223681;
	bh=7WKC97l/+4LzrNMTvjN2gUWC6Li7BE7+Zsq6XcXQSGM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=mMpk18tBYERN9IuGeBA+Ez/jEnjRk5ezXzyxJRmEFwvQr3oN+0qk58uK9Z7WUOrOS
	 BipoyATIjezY76Ntq2rd5EhpN/OPGdamnVmLvo+LI1GDj7bLfidFTAZ0250EvfIn/U
	 WOcsQsmY/+xLiLFaelDf3DGusknE3LJ51/ngf93ImlIjJc9M7IHedY68G7wH4FXrSn
	 zfJiR6OZzUpZdMGpVbYX4k6uYOE3HwAKF1rBTiibRL0BIpRLeibL1zbbiNEOs8ma0A
	 E7KrwgG0FNBQ2McBwRlxhbU2tG2nGyLBmm+2gg4mJsC5iOZEQakXx9XMJToYA9Q8Mo
	 yKb6+EhanKAEQ==
Message-ID: <sashiko-outbox-175381@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] keys/trusted_keys: clear sensitive PKWM buffers
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261017074850.164031-4-ssrish@linux.ibm.com>
References: <20261017074850.164031-1-ssrish@linux.ibm.com>
 <20261017074850.164031-4-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 07:54:41 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The input buffer to PKWM seal and the output buffer from PKWM unseal
> contain plaintext trusted-key payload data. Freeing these buffers with
> kfree(), without wiping the contents, can leave sensitive key material
> in memory.
>=20
> Use kfree_sensitive() to wipe the sensitive key material when freeing
> these buffers.
>=20
> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted sour=
ce")
> Cc: stable@vger.kernel.org # 7.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017074850.1640=
31-1-ssrish@linux.ibm.com?part=3D3

