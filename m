Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7423CB2FE
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 18:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792262991; cv=none; b=f9cqhvaxtwrrA3ClPlU5rJBj3Xnxq6QWbQoQKCTel74Nith7FQzWnOSe2q6/P9EP99yTR3zWzb9TxisfSjrzFGvuL5/A2kdnI7eomCGJHdQXHwxTVGHe6i8ZqQJWovPTLEHtMkR82zIlutnDV0WMnPA29NiW4NTUX+knxOMbI+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792262991; c=relaxed/simple;
	bh=gJxml6qtlOD1qUeo5NQyFIPhsN/cdLDmjT59NaWKSiQ=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pqBRT1tdETDK4YTLu9wR0//BP4Bm8HY1yPs9QKgxlBb0hM/y3Z63ylYm88Frgu3f9LOVvZJe9ZL8V++R1lFq4O330mMzceJBvReoV/w4Rd4zmJH/WiwwGiA7+uWb3CUK3ZvbwVnrsQv8OrjH6SPjP8hk+XKuVje0TotqzIcVcEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcsw6XNr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcsw6XNr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FFE1F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 18:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792262990;
	bh=g8QyQpu2PT2iNE2DD/fKYZl9ysw5ESik1+mZS/sMnHE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=gcsw6XNrmTbJj6skLmQyUPq8xINMo5gB4NEXYx3bSxUPHzcsAeoSST8N6fAxsuYj5
	 3EZ7i0vcaymvFjQjlb0PQaRCPA/zWuqYn0OSueaUlS84HWW6hFT/BHUzHhriuYvOc9
	 UMeaOag+quVT53voBf6+gic+eUK0tg3jcjJ9L87xPzdQztr1O+3991R3RJ4RL4Zbcb
	 jbdoORAaWjVv83KGMpxghFomzEN/uR1NxdmtzpNd1NaQ+GWJAsTlBhKViVTfZL0CQZ
	 mxKo6suiZpX70WcDpy+QKAwmGteMOYEYaxISp8jZQVW16OXZ5jfkOd3Q+uxpjIGDgH
	 4vPjoBC7OTDpw==
Message-ID: <sashiko-outbox-175758@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/9] pseries/plpks: fix length types for wrapping
 operations
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261017183853.596052-4-ssrish@linux.ibm.com>
References: <20261017183853.596052-1-ssrish@linux.ibm.com>
 <20261017183853.596052-4-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 18:49:49 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pseries/plpks: u64 output_len underflow in plpks_unwrap_object()
--

commit 59911ed0b25c4af265ad691443d2271f507882e0
Author: Srish Srinivasan <ssrish@linux.ibm.com>

pseries/plpks: fix length types for wrapping operations

This commit updates the input_len and output_len parameters of
plpks_wrap_object() and plpks_unwrap_object(), along with their caller in
trusted_pkwm.c, from u32 to u64 to match the underlying 64-bit hypercall
interfaces.

> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platfo=
rms/pseries/plpks.c
> index 584091f9aa08c..cedde24b0d3e0 100644
> --- a/arch/powerpc/platforms/pseries/plpks.c
> +++ b/arch/powerpc/platforms/pseries/plpks.c
> @@ -1023,8 +1023,8 @@ EXPORT_SYMBOL_GPL(plpks_gen_wrapping_key);
>   *
>   * Returns: On success 0 is returned, a negative errno if not.
>   */
> -int plpks_wrap_object(u8 **input_buf, u32 input_len, u16 wrap_flags,
> -		      u8 **output_buf, u32 *output_len)
> +int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
> +		      u8 **output_buf, u64 *output_len)
>  {
>  	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] =3D { 0 };
>  	struct plpks_auth *auth;
> @@ -1142,8 +1142,8 @@ EXPORT_SYMBOL_GPL(plpks_wrap_object);
>   *
>   * Returns: On success 0 is returned, a negative errno if not.
>   */
> -int plpks_unwrap_object(u8 **input_buf, u32 input_len, u8 **output_buf,
> -			u32 *output_len)
> +int plpks_unwrap_object(u8 **input_buf, u64 input_len, u8 **output_buf,
> +			u64 *output_len)
>  {
>  	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] =3D { 0 };
>  	struct plpks_auth *auth;

[Severity: High]
With input_len and *output_len changed to u64, what happens in
plpks_unwrap_object() if input_len is less than or equal to
PLPKS_WRAPPING_BUF_DIFF (1024)?

In arch/powerpc/platforms/pseries/plpks.c:plpks_unwrap_object():

	*output_len =3D input_len - PLPKS_WRAPPING_BUF_DIFF;
	*output_buf =3D kzalloc(ALIGN(*output_len, PLPKS_WRAPPING_BUF_ALIGN),
			      GFP_KERNEL);

Previously, when *output_len was u32, an underflow produced a 32-bit value
such as 0xfffffc00, which promoted to u64 inside ALIGN(..., 4096) and
allocated 0x100000000 bytes (failing in kzalloc()).

Now that *output_len is u64, if input_len <=3D 1024, *output_len underflows=
 to
[0xfffffffffffffc00ULL, 0xffffffffffffffffULL] (or 0 when input_len =3D=3D =
1024),
and ALIGN(*output_len, 4096) wraps 64-bit arithmetic around to 0.

kzalloc(0, GFP_KERNEL) then returns ZERO_SIZE_PTR ((void *)16), which passes
the !(*output_buf) check. Subsequently, virt_to_phys(*output_buf) triggers
WARN_ON under CONFIG_DEBUG_VIRTUAL and passes physical address 0x10 along
with the underflowed 64-bit *output_len to plpar_hcall9(H_PKS_UNWRAP_OBJECT,
...).

This can be reached from userspace via add_key("trusted", ..., "load <hex>",
...):

  trusted_instantiate()
    datablob_parse()
    trusted_pkwm_unseal()
      plpks_unwrap_object()

because datablob_parse() only enforces p->blob_len <=3D MAX_BLOB_SIZE (1152=
) and
does not enforce a minimum blob length. In addition, in plpks_wrap_object(),
PLPKS_WRAPPING_BUF_DIFF is the extra buffer capacity allocated for
H_PKS_WRAP_OBJECT, while the actual wrapped blob size comes from retbuf[1],
which is not guaranteed to exceed 1024 bytes.

Similarly, in arch/powerpc/platforms/pseries/plpks.c:plpks_wrap_object():

	*output_len =3D input_len + PLPKS_WRAPPING_BUF_DIFF;

	*output_buf =3D kzalloc(ALIGN(*output_len, PLPKS_WRAPPING_BUF_ALIGN),
			      GFP_KERNEL);

could input_len + PLPKS_WRAPPING_BUF_DIFF or ALIGN(*output_len,
PLPKS_WRAPPING_BUF_ALIGN) overflow u64 if a caller passes a large input_len
near U64_MAX?

Should plpks_unwrap_object() and plpks_wrap_object() validate input_len
before computing *output_len and allocating *output_buf?

> diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/tr=
usted-keys/trusted_pkwm.c
> index bf42c6679245a..b6b5697426a8a 100644
> --- a/security/keys/trusted-keys/trusted_pkwm.c
> +++ b/security/keys/trusted-keys/trusted_pkwm.c

[ ... ]

> @@ -130,7 +130,7 @@ static int trusted_pkwm_seal(struct trusted_key_paylo=
ad *p, char *datablob)
>  static int trusted_pkwm_unseal(struct trusted_key_payload *p, char *data=
blob)
>  {
>  	u8 *input_buf, *output_buf;
> -	u32 input_len, output_len;
> +	u64 input_len, output_len;
>  	int rc;
> =20
>  	input_len =3D p->blob_len;

In trusted_pkwm_unseal(), p->blob_len is assigned directly to input_len and
passed to kmalloc(ALIGN(input_len, 4096), GFP_KERNEL) and
plpks_unwrap_object() without checking that p->blob_len >
PLPKS_WRAPPING_BUF_DIFF (or non-zero, since ALIGN(0, 4096) also results in
kmalloc(0) returning ZERO_SIZE_PTR for input_buf).

_________________
AI review your patch. Please Reach out if you have any feedback!
Sidharth Seela <sidharthseela@gmail.com>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017183853.5960=
52-1-ssrish@linux.ibm.com?part=3D3
