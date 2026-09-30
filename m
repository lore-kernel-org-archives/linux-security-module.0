Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379544FC33E
	for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776809; cv=none; b=KU9qpAC46i3iDLIg/iinHJi8t5B3ucQGveFwF2d1cBE1X5rG/rYLhiVWFnCUzu6GmHn7F5juuMssfLZpPx1yfa0wX2ARJPKT8egJBAqVuwP42nAGki2p+DUs12AL/bxAFbVqc6/DYySUoYc3sKQpPSyJc93mcKsl1D9fQc9/tM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776809; c=relaxed/simple;
	bh=b2h2bwC6rKrbMBliNtP0FYJN076UpYIOXhismyN+H+4=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T8OcVhjdf/eqB/Y0K4gM2cn1h/fl35spGJsV6IdSIVqbP4ypYAY4v/JtW5/4e2g4jMLU8dhACbIUQEg1riLyMW6z5shKNhHVmoBuVOnP3BziiOHjNcWSLLNdn3a2/JQG0fyhEB5l13axEarPhw4jUwY9utxF8ZQllzemp/8122s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fx1jTUQt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fx1jTUQt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1C31F00893
	for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 13:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790776795;
	bh=f6zmC3RJZ6RnSYm+ihWa+FCFPsGIlUcn+0uBFvcPrOE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Fx1jTUQt28xF3rapDC/v22nCNGmXSxp2wzmoFmxfzKYkGz+OpTK+oEjEUFdjZzNEM
	 11dH/AttYY8dJfYnEBrJzQB1xThzM+JJq6ax/cGf6cXi/FnHhv4NN7JeEsonU5zYZk
	 6jsnbtfi0+NZ0fADP0eXY/w/3BsNsNMNpyOkP1f/zY7DUQFPeIcgTiWsTW/qoN3cNU
	 Xzpnkk7BUGgax/SoYxdkjHtSXI5cDBl1ZbWnO0eyUfLw28Y+Gd7TsXpO2w8Kb39X0n
	 FXSR2j12fwoF/9mPfk/hECgY9P4fsArwEMdxpqO6uRn50AuzOAsEnTw71Zb8jgixbc
	 tW1p8TwpXJq3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 3/3] security: IMA: use TSM measurement registers
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260930-ima_tgx_integration_v2-v1-3-722c35370548@arm.com>
References: <20260930-ima_tgx_integration_v2-v1-0-722c35370548@arm.com>
 <20260930-ima_tgx_integration_v2-v1-3-722c35370548@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 13:59:54 +0000
Message-Id: <20260930135955.8A1C31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] ima: buffer capacity check bypass in TSM MR read/write operations
- [Medium] ima: implicit assumption of uniform MR sizes across a TSM bank
- [Low] ima: typographical error tgx instead of tdx in function name
--

commit 2a879775437b1a2234f6a7ecbc56b85ccdc11baf
Author: Yeoreum Yun <yeoreum.yun@arm.com>

security: IMA: use TSM measurement registers

This commit adds support for extending IMA measurement digests into Trusted
Security Module (TSM) measurement registers. This serves as an alternative
for guests when no TPM device is available. Mappings are provided for Intel
TDX and Arm CCA.

Link: [0] https://uefi.org/specs/UEFI/2.11/38_Confidential_Computing.html#i=
ntel-trust-domain-extension
Link: [1] https://github.com/tianocore/edk2/issues/11383

> diff --git a/security/integrity/ima/ima_mr_tsm.c b/security/integrity/ima=
/ima_mr_tsm.c
> new file mode 100644
> index 0000000000000..3f88edfb8511c
> --- /dev/null
> +++ b/security/integrity/ima/ima_mr_tsm.c
[ ... ]
> +static int create_tsm_tgx_pcr_map(struct tsm_context *ctx)

[Severity: Low]
This isn't a bug, but is tgx here a typographical error for tdx (Intel
Trust Domain Extensions)?

> +{
> +	int mrtd_idx, rtmr0_idx, rtmr1_idx, rtmr2_idx;
[ ... ]
> +static int tsm_mr_calc_boot_aggregate(struct ima_mr *mr, int bank,
> +				      char *digest, struct crypto_shash *tfm)
> +{
[ ... ]
> +	for (pcr_idx =3D TPM_PCR0; pcr_idx <=3D TPM_PCR2; pcr_idx++) {
> +		tsm_mr =3D tsm_mr_get(ctx, pcr_idx);
> +		if (!tsm_mr)
> +			return -ENODEV;
> +
> +		mr_idx =3D tsm_mr_idx(ctx->tm, tsm_mr);
> +		rc =3D tsm_mr_read(ctx->tm, mr_idx, d.digest, tsm_mr->mr_size);

[Severity: Medium]
Does passing tsm_mr->mr_size instead of the actual buffer capacity bypass
internal bounds checking?

If a future TSM architecture implements an mr_size larger than the
statically sized d.digest buffer (which is bounded to TPM2_MAX_DIGEST_SIZE),
passing the hardware-defined size rather than sizeof(d.digest) could
result in a stack buffer overflow.

> +		if (rc) {
> +			pr_err("Error Communicating to TSM(%d)\n", rc);
> +			return rc;
> +		}
> +
> +		/* now accumulate with current aggregate */
> +		rc =3D crypto_shash_update(shash, d.digest,
> +					 crypto_shash_digestsize(tfm));

[Severity: Medium]
Does this code assume that all TSM measurement registers mapped to this bank
share the exact same digest size as TPM_PCR0?

The bank information is initialized using PCR0's hash algorithm and size.
If a future TSM architecture were to use heterogeneous MR sizes, and a
subsequent register had a smaller size than PCR0, could tsm_mr_read() only
partially overwrite d.digest?

This would leave stale bytes from previous loop iterations in the buffer.
These stale bytes would then be hashed by crypto_shash_update(), since it
uses the larger size returned by crypto_shash_digestsize(tfm), which could
silently corrupt the boot aggregate.

> +		if (rc)
> +			return rc;
> +	}
[ ... ]
> +	if (d.alg_id !=3D TPM_ALG_SHA1) {
> +		tsm_mr =3D tsm_mr_get(ctx, TPM_PCR8);
> +		if (!tsm_mr)
> +			return -ENODEV;
> +
> +		mr_idx =3D tsm_mr_idx(ctx->tm, tsm_mr);
> +		rc =3D tsm_mr_read(ctx->tm, mr_idx, d.digest, tsm_mr->mr_size);

[Severity: Medium]
Does this second instance also neutralize the capacity bounds check by
passing the hardware-defined mr_size instead of the destination buffer size?

> +		if (rc) {
> +			pr_err("Error Communicating to TSM(%d)\n", rc);
> +			return rc;
> +		}
> +
> +		rc =3D crypto_shash_update(shash, d.digest,
> +					crypto_shash_digestsize(tfm));
> +	}
[ ... ]
> +static int tsm_mr_extend(struct ima_mr *mr, u32 pcr_idx,
> +			 mr_digest_t *digests)
> +{
[ ... ]
> +	mr_idx =3D tsm_mr_idx(ctx->tm, tsm_mr);
> +
> +	/* TSM has only one bank. */
> +	rc =3D tsm_mr_write(ctx->tm, mr_idx, digests[0].digest, tsm_mr->mr_size=
);

[Severity: Medium]
Could this lead to an out-of-bounds read if tsm_mr->mr_size exceeds
TPM2_MAX_DIGEST_SIZE?

Similar to the read operations above, using the hardware-defined register
size instead of the array bounds of digests[0].digest might cause the code
to read past the end of the allocated structure if a larger MR size is
encountered.

> +	if (rc)
> +		pr_err("Error Communicating to TSM, result: %d\n", rc);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-ima_tgx_in=
tegration_v2-v1-0-722c35370548@arm.com?part=3D3
