Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7F64562BA
	for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330611; cv=none; b=SZnKFMAGuwH8lJTFJ2aH/yB6YukCQiBO/20i3yY5EL21dkeWVu2paOCI8luE7tPaxx6YsEtVWS5ba0IFou8rJry/2l6O/GI2pK9Kju4ErztWIUKSMoViUfgCajVYj9V27/EE6HqzRoYXfDvdhwTJgwFl4vrAQqX35RFZOpOpfu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330611; c=relaxed/simple;
	bh=V/yy7izviGSfuTMoggeTKK3osXNg0qlr1muymj0vhfo=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ImSdRwbQB7Y2Yr0nqbCbiUVSL9EVlXO9V2GUsnR/BsnPPTjMus75Hsgm7GraH7WZ33bAhxonkrwro9RvVHkNC+ac5Y30nsQjmnFRMPzaXov09sIm/e7GNhWxII9gUfK0mPygHp0kBoWAcDqt/caPdiOis6uT0J+4nwsAcxNFgYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsXBKKAD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsXBKKAD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0C01F000FF
	for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 10:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790330609;
	bh=V/yy7izviGSfuTMoggeTKK3osXNg0qlr1muymj0vhfo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=QsXBKKAD2cU8b58Z5zB062fGmTSjuCrYSylV+DHLHUcDMwfNUyFUlgN4MWNtUMk6f
	 bFREnZQ1/KHO5rB5mjNobw8ULt2l91miUnsrkICLqg0ednFY/cgEJMrHka1bF1oXCh
	 A5QqXUpc/IoNHbB6cq5WLHhNobx2NjrwZ8C0K/9i3CvTXbyi04IVJ+zGLqQ1NmUbbI
	 BSdmCCZ1bBfGy4sfNX6GzUPxSzstRrckJowxPO0+usW8k/2n51+KSkUWDxD8nXYbeF
	 B/k974RkBrsoDwArTzVF6QvPVHUJOI+FIzPEE0RzNNRcCAeZspZPcybXb5KMJMvZNr
	 DTjLCVfCNBOVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KEYS: trusted: Reject short TPM2 public areas
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260925095308.3248297-1-4ncienth@gmail.com>
References: <20260925095308.3248297-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 10:03:29 +0000
Message-Id: <20260925100329.AF0C01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> tpm2_load_cmd() reads TPMA_OBJECT with get_unaligned_be32(pub + 4), but
> does not require public_len to cover that field.
>=20
> A new-format blob with public_len zero makes the read begin at the end of
> the B + 4-byte decoded allocation, causing a four-byte heap out-of-bounds
> read before the TPM command is transmitted. This is reachable from an
> unprivileged add_key() call when TPM trusted keys and a TPM2 device are
> available.
>=20
> This affects v5.13-rc1 and later kernels built with CONFIG_TRUSTED_KEYS=
=3Dy
> and CONFIG_TRUSTED_KEYS_TPM=3Dy when a TPM2 device is present. A KASAN run
> as UID 1000 with no effective capabilities reported:
>=20
> BUG: KASAN: slab-out-of-bounds in tpm2_unseal_trusted
> Read of size 4 at addr ffff888106273b48 by task exploit/160
> [ ... ]
>=20
> Fixes: e5fb5d2c5a03 ("security: keys: trusted: Make sealed key properly i=
nteroperable")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925095308.3248=
297-1-4ncienth@gmail.com?part=3D1

