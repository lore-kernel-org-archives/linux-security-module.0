Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513392;
	b=wrmluaElufe2+ZvMVA7qhbEl+9/H0lupOCu+SltzY8+Hd7GgZgA88uyQeGFW3oilq82c
	 kwul/sTR3w9fe+J+pIwmdGywNUyZRuBzrF94BL7AXG6sPShvrNNZ0302fMY87YaoWtEWg
	 E8a/Lllsj8vXmYY2FXQTnXdo7k4ZpBOdTFFR19jDu2fm4FTp0scZjE1v680FDV58jsNmY
	 DIkMnC3vvhnP/IzU3Y7u1WKY43/04SqJZ6V0pHqesuM9ztsuVH1SqLIwFcLVH21R7n/XP
	 BgmBOUb/G7ga4Z2Crrajve0sl5KK/hofsUEJ4xMII1vJp3eJ/YGjgxUuwha5RcpPj3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513392;
	h=Received:Message-ID:From:Subject:Reply-To:Cc:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:Date;
	bh=pv5dqbSaC9+zgSUzghNp7LrFGKpFw3bkM7kTkjH+UC0=;
	b=p2+gcVjUdIbITuQtc9FaZZvuankb6hWG+ZwCnC25xir4fF+a5xYF9IQFupjCgxBIpQqT
	 skkYknlwiKvSQQ2aWq0ZuMYbpDz8oZtrVLIzXFIwb1o9iJEgyvVnfpEFduUDOOOtDxYdY
	 ieRv4r/VS3wx5Eigv2fI1jhgnBGEdaQpJ2cvZ8Zw5TOjT0oNr9cWSqg3v3YXmXyGeMm6b
	 jdQimGRvGyaPg7zvK9YY2tejOT/SWJE5NtDpnQYFs7cGsCKpGlcnIbSnfAOJu50dbDoKC
	 HUV3ERkFZBmFK+3qJZahQjV8of07poFC5Xl9u3H0Wa9Heiq2U/jkF3CW9/lgJQXPBAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70190606A31F
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 16:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1AA1F000C4
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 16:23:12 +0000 (UTC)
Message-ID: <sashiko-outbox-179345@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KEYS: trusted: Reject short TPM2 public areas
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261020161954.3956212-1-4ncienth@gmail.com>
References: <ateELTsfmHsdCEGL@kernel.org>
 <20261020161954.3956212-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 16:22:41 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> tpm2_load_cmd() reads TPMA_OBJECT with get_unaligned_be32(pub + 4), but
> does not require public_len to cover that field.
>=20
> A TPM 2.0 ASN.1 key blob with public_len zero makes the read begin at the
> end of the B + 4-byte decoded allocation, causing a four-byte heap
> out-of-bounds read before the TPM command is transmitted. This is reachab=
le
> from an unprivileged add_key() call when TPM trusted keys and a TPM2 devi=
ce
> are available.
>=20
> This affects v5.13-rc1 and later kernels built with CONFIG_TRUSTED_KEYS=
=3Dy
> and CONFIG_TRUSTED_KEYS_TPM=3Dy when a TPM2 device is present. A KASAN run
> as UID 1000 with no effective capabilities reported:
>=20
> BUG: KASAN: slab-out-of-bounds in tpm2_unseal_trusted
> Read of size 4 at addr ffff888106273b48 by task exploit/160
> [ ... ]
> end-to-end QEMU and swtpm reproducer.
>=20
> Fixes: e5fb5d2c5a03 ("security: keys: trusted: Make sealed key properly i=
nteroperable")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020161954.3956=
212-1-4ncienth@gmail.com?part=3D1

