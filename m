Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E824A0915
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545994; cv=none; b=kboSZCJXOKCEzMBS+1OQXdtDlO3qpvnkx0TNLR5Qai+p0uwmmZDNQIQvLD1Q+JJEo/TwhoJfMnOgkqLEyncoLB/8TRZ7Nz3bNExpEp1pVSTLhFu4F85JG4ttiu1Qe3SCjMxGeX0MIpPloDqsLIwsS+S7FOoAfobR79WoAFGkgC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545994; c=relaxed/simple;
	bh=BNnTHQwaOl7aiIs0Bz9dpJlbBhfq/OKug/wGeJDcw28=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=onTxvq9VmepvnpBO2NWUHgfHfZAfflPkZuPP333haaj/hh/GCVIgKay0b4Eg42LcGobe7kf6rHlPg0WbENizKbLiMlWn8GaeZ/z4ugWk6g4Vs8KXgayjBM08KpMgDazvy2hPX+cCUy6VpvIy3bxjTXsZ5fXbqnePaF03H5tcTXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwfspaZn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwfspaZn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7D21F000FF
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 11:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791545986;
	bh=Wrno+A1NjkfvM7mTg9M7IheX8VrZdHqG6I8REA/Sau8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=LwfspaZn6PRjFSERwS4h/t4abEJrifN5V4c9EVttarZQh98FwdZoBH51kY0spHAxx
	 dEClWnH16TbYCV8sAtMP+8TIresbDaNOqtIr8NCfPSLfs1x4pUUoH986gpQ5JiWEhf
	 p59Ix/ekgQblOLB/XUlv68kG+KWBZpA+DALkonwEhTF5jPmdOa1TZnkOuF6wjqhSzy
	 154byvHVjLfVDu/cSnFmPMBPxR5/6y4JLfzVaFZ4FSp1ukjfxhBNgyx3YuWPC3EG8T
	 bjxiC6CE5bssbbFr3z4SEfMIAMtUu8GVnAusHdr8mzFDMAqyTfXnk3nv+MW8zGn1oK
	 AHOR9HkySR42Q==
Message-ID: <sashiko-outbox-165403@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] evm: check return values of crypto_shash functions
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261009111212.1516243-1-roberto.sassu@huaweicloud.com>
References: <20261009111212.1516243-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:39:46 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Daniel Hodges <git@danielhodges.dev>
>=20
> The crypto_shash_update() and crypto_shash_final() functions can fail
> and return error codes, but their return values were not being checked
> in several places in security/integrity/evm/evm_crypto.c:
>=20
> - hmac_add_misc() ignored returns from crypto_shash_update() and
>   crypto_shash_final()
> - evm_calc_hmac_or_hash() ignored returns from crypto_shash_update()
> - evm_init_hmac() ignored returns from crypto_shash_update()
>=20
> If these hash operations fail silently, the resulting HMAC could be
> invalid or incomplete, which could weaken the integrity verification
> security that EVM provides.
>=20
> [ ... ]
> [roberto.sassu@huawei.com: call hmac_add_misc() in evm_calc_hmac_or_hash()
>  only if no previous error, to avoid overwriting -ENODATA, and jump to out
>  only if hmac_add_misc() fails]
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009111212.1516=
243-1-roberto.sassu@huaweicloud.com?part=3D1

