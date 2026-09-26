Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1878036E484
	for <linux-security-module@vger.kernel.org>; Sat, 26 Sep 2026 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790448692; cv=none; b=RyIvFY9I7pOsNSRYEWf+7rh5FzZP0zL1qHgKJJ/bxEXa2kUci4h/zCAAC3+YK6prDMqF6mmbVrSMae9pEmnyTou0r6K0euOLz8sX/WPZ7qDnOk1dN28LX1OZvR6dbGd/E5bRESsw0v4aU4WjYa6v0TGh+HYrrKUaC7ZZzikjoPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790448692; c=relaxed/simple;
	bh=obRVMXamTuAUeeS6P3MOG0YvnpvyYded6n4ud8Mif+Y=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AZkzZdbxrKwFNMiXmSZhra/NKld6pe9Uv2KbAOafFsDH0guRT5+qkgd0YIFHHrCnq6qFrCEyCvLaCbt4xaHgjAwtNQE5NvwNxlUvXpK375zSMHcnsLCpqdTzWgPGhqBUcsBdHIrQCyPtcHcZMfpqCnmPDpwtdo4buGDNhFapS5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7e2w13X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7e2w13X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887231F000FF
	for <linux-security-module@vger.kernel.org>; Sat, 26 Sep 2026 18:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790448690;
	bh=/6mw2m4CU/nz4KRo8belboXS2r0LhkDLljyztYvSS/c=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=f7e2w13XQVomTxEz9cVe+/j/5j3fNZ98WcD41n6YLJcNMXZhkutNtEx0BhSHEvXeb
	 5aEwBeLUlv0h5bkeB4yUUEB05JKd5drLp1EhZJyyeMtLjQMQPZojQlzyLCS09hJZjJ
	 1ulmyPJnWXXryIhj8qsEiseMvsC6OMtBrvR7/7MtjLJZiKQVH798y7yY+KQN6iJ2C8
	 J65k+TeFAOQOn4dX4ZsDhJymtxKVF525pMvaUEVztNPcj6icR1KByaWca21fxcbtMi
	 YsIWuW4mQUz/0fela3aONZ+O8V30gXZqKAlEBGQJcMHzN4J0J2HnMdgjbknHohZiAt
	 pB+fjzHuT95eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] keys/trusted/tpm2: Validate TPM2_Create object sizes
 separately
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260926184203.479203-1-ssrish@linux.ibm.com>
References: <20260926184203.479203-1-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 18:51:30 +0000
Message-Id: <20260926185130.887231F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] cleanup: mixing goto-based error handling with scope-based cleanup
--

commit 6bc711f0f487069cc2bd8437493ff78b9ed1f263
Author: Srish Srinivasan <ssrish@linux.ibm.com>

keys/trusted/tpm2: Validate TPM2_Create object sizes separately

This commit updates trusted key creation to validate TPM2_Create object
sizes separately from the complete response area. It also adopts scope-based
cleanup to simplify resource management.

> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/tr=
usted-keys/trusted_tpm2.c
> index c2a69bcf381d7..eae9d81fed0ff 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c

[ ... ]

> @@ -340,10 +345,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  		goto out;
> =20
>  	blob_len =3D tpm_buf_read_u32(buf, &offset);
> -	if (blob_len > MAX_BLOB_SIZE || buf->flags & TPM_BUF_INVALID) {
> +	if (buf->flags & TPM_BUF_INVALID) {
>  		rc =3D -E2BIG;
>  		goto out;
>  	}
> +
>  	if (buf->length - offset < blob_len) {
>  		rc =3D -EFAULT;
>  		goto out;

[Severity: Low]
Does this function mix goto-based error handling with scope-based cleanup?

Looking at tpm2_seal_trusted() in security/keys/trusted-keys/trusted_tpm2.c=
,=20
it defines resources using scope-based cleanup:

	struct tpm_buf *buf __free(kfree) =3D NULL;
	struct tpm_buf *sized __free(kfree) =3D NULL;

But the function still uses goto labels for TPM operations cleanup:

out:
	if (!rc)
		payload->blob_len =3D blob_len;

out_put:
	tpm_put_ops(chip);
	return tpm_ret_to_err(rc);

The cleanup subsystem guidelines expect that usage of goto and cleanup
helpers are never mixed in the same function.

Could the remaining goto labels in tpm2_seal_trusted() be converted to
scope-based cleanup to avoid mixing paradigms?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926184203.4792=
03-1-ssrish@linux.ibm.com?part=3D1
