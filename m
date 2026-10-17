Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724AC3CF1E4
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792224462; cv=none; b=Lc62QzO/+7CbhCRPi/qN8RIwPtdqfref2s9lFOBgEX8usRBxxYpNik/PbZtH0FLbGLhBx3QCQF5l1q7XBu8tk8XHL+i1goCoTmyYltwWJRGDGUlpcFk6itwFEf6o5Yh2MxVsHT5BLIXM/oC1ppt0OI05JIcQj3xhuu8FtG1DbtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792224462; c=relaxed/simple;
	bh=WhP2pfaWrcm1UwDVOjJG0x7rwQ3TYCQvd7CqCXmweQE=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GjxK+ynl7eG30xCM3iIGi5OUUFuTIJ8eFDV/Am8BsnmYmkHP1Yao2E5+Z42sy7iX4xHY6DE2TcQH4cCjo5kZTkuvlKk7pfl8iGWfIuj2DHTlfhc4n3unboGqrWE1JHGGg2FOkdUfwCnwNDCdzCrVsq+O4d62dpvKVCbSSeap++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2ORyXX4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2ORyXX4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31D31F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 08:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792224461;
	bh=QZZF1a5zpQndz98900MTHXm1FLnCTzIrRzDD4kMLxKk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=m2ORyXX4jaN3lMniQ8lRBddFO06HRGYy+ryakam28WAYwPhl6+buhRYz8diLl5fAF
	 CnPVqxeqywDs9ZDOMJL7GM9eIDdGsDKBwyUhXRdGpnOkykwmuNN13s0CXNaRv0A79O
	 lt2FQLdasvcRvzdYX22iFp7k3rjZzCtsC8GDuIuSsS8FHhBjDqc+dmraHmeddUnIwC
	 qxb8nh35/+8uPZoZqwL6/dII+UePxXqpzTEhfMAN3d2HTAVxqR2vIp3sa/A3oOwVAF
	 xvnyn206sY67APh+/AMe/BpMtXcw2CZ9vIKwStd0XAj4LWcQoz7uz3Il1j35d6Mzx6
	 ry0eKpeyZsNHg==
Message-ID: <sashiko-outbox-175386@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] pseries/plpks: add HCALLs for PKWM wrapping key
 life cycle management
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261017074850.164031-5-ssrish@linux.ibm.com>
References: <20261017074850.164031-1-ssrish@linux.ibm.com>
 <20261017074850.164031-5-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 08:07:40 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] pseries/plpks: stale var->policy evaluated in plpks_is_wrapping_=
key_revoked()
- [Low] powerpc/pseries: papr_hcalls.rst swaps H_PKS_GET_OBJECTLABELS outpu=
t order
--

commit 73a27f4e02c0030b70181101065300c5db3bc91b
Author: Srish Srinivasan <ssrish@linux.ibm.com>

pseries/plpks: add HCALLs for PKWM wrapping key life cycle management

This commit implements the H_PKS_REVOKE_OBJECT, H_PKS_UNREVOKE_OBJECT, and
H_PKS_GET_OBJECTLABELS hypervisor calls in the pseries PLPKS driver to
support revoking, unrevoking, deleting, and listing PKWM wrapping keys.

> diff --git a/Documentation/arch/powerpc/papr_hcalls.rst b/Documentation/a=
rch/powerpc/papr_hcalls.rst
> index 44c9c8b32ae3c..3455b403a0486 100644
> --- a/Documentation/arch/powerpc/papr_hcalls.rst
> +++ b/Documentation/arch/powerpc/papr_hcalls.rst
> @@ -343,6 +343,39 @@ is returned to the caller.
[ ... ]
> +**H_PKS_GET_OBJECTLABELS**
> +
> +| Input: authorization, continueToken, out, outlen
> +| Out: *continue-token, number of object labels in the returned list, ob=
ject
> +        label list*
> +| Return Value: *H_Success, H_Function, H_State, H_Parameter, H_P2, H_P3=
, H_P4,
> +                H_Authority, H_Busy, H_Aborted, H_Continue*
> +
> +H_PKS_GET_OBJECTLABELS is used to retrieve a list of object labels owned=
 by the
> +specified consumer.

[Severity: Low]
Are the first two output fields for H_PKS_GET_OBJECTLABELS in
Documentation/arch/powerpc/papr_hcalls.rst swapped relative to the output
registers read in plpks_get_object_labels()?

In Documentation/arch/powerpc/papr_hcalls.rst, the Out field lists output
registers in order starting from r4 (retbuf[0]) and r5 (retbuf[1]), which
here places continue-token before the number of object labels.

However, in arch/powerpc/platforms/pseries/plpks.c:plpks_get_object_labels(=
),
retbuf[0] is read as labels_count and retbuf[1] is read as continuetoken:

    continuetoken =3D retbuf[1];

    labels_count =3D retbuf[0];

[ ... ]
> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platfo=
rms/pseries/plpks.c
> index a7953db3f23a6..edd189cfcc85c 100644
> --- a/arch/powerpc/platforms/pseries/plpks.c
> +++ b/arch/powerpc/platforms/pseries/plpks.c
[ ... ]
> @@ -831,9 +846,6 @@ static int plpks_read_var(u8 consumer, struct plpks_v=
ar *var)
>  	if (var->namelen > PLPKS_MAX_NAME_SIZE)
>  		return -EINVAL;
> =20
> -	if (var->policy & PLPKS_WRAPPINGKEY)
> -		return -EPERM;
> -
>  	auth =3D construct_auth(consumer);
>  	if (IS_ERR(auth))
>  		return PTR_ERR(auth);
[ ... ]
> @@ -1189,6 +1218,419 @@ int plpks_unwrap_object(u8 **input_buf, u64 input=
_len, u8 **output_buf,
[ ... ]
> +int plpks_is_wrapping_key_revoked(struct plpks_var *var)
> +{
> +	int rc;
> +
> +	if (!var || !var->name || !*var->name)
> +		return -EINVAL;
> +
> +	rc =3D plpks_read_var(PLPKS_OS_OWNER, var);
> +	if (!rc) {
> +		/*
> +		 * Reading a wrapping key is expected to fail with
> +		 * -EPERM and return its policy.
> +		 */
> +		rc =3D -EIO;
> +	} else if (rc =3D=3D -EPERM) {
> +		if (var->policy & PLPKS_WRAPPINGKEY) {
> +			if (var->policy & PLPKS_REVOKED)
> +				rc =3D 1;
> +			else
> +				rc =3D 0;
> +		}
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(plpks_is_wrapping_key_revoked);

[Severity: Medium]
Can plpks_is_wrapping_key_revoked() evaluate a stale var->policy when
H_PKS_READ_OBJECT fails with H_AUTHORITY and retbuf[1] is 0, or overwrite
var->datalen and var->data if H_PKS_READ_OBJECT succeeds?

In arch/powerpc/platforms/pseries/plpks.c:plpks_read_var(), when
H_PKS_READ_OBJECT returns H_AUTHORITY (mapped to -EPERM), var->policy is on=
ly
updated if retbuf[1] is non-zero:

    if (rc !=3D H_SUCCESS) {
        rc =3D pseries_status_to_err(rc);
        if (rc !=3D -EPERM || !retbuf[1])
            goto out_free_output;
        goto out_copy_policy;
    }

Because plpks_is_wrapping_key_revoked() does not zero var->policy before
calling plpks_read_var(), an H_AUTHORITY failure with retbuf[1] =3D=3D 0 le=
aves
var->policy untouched and plpks_is_wrapping_key_revoked() then checks the
pre-existing value in var->policy.

In the subsequent commit "pseries/plpks/wrapkey: expose PKWM wrapping key
management to userspace via sysfs", list_key_labels() defines a single
struct plpks_var var =3D {0} outside the loop and calls
plpks_is_wrapping_key_revoked(&var) across all labels without resetting
var.policy between iterations. Once an earlier iteration populates var.poli=
cy
with PLPKS_WRAPPINGKEY, any later iteration where H_PKS_READ_OBJECT returns
H_AUTHORITY with retbuf[1] =3D=3D 0 will inspect the previous key's var.pol=
icy
and return 0 or 1 instead of -EPERM. The same happens if a caller of
plpks_is_wrapping_key_revoked() or plpks_del_wrapping_key() passes a
struct plpks_var with PLPKS_WRAPPINGKEY already set in var->policy.

Additionally, if H_PKS_READ_OBJECT unexpectedly succeeds on a readable
object, plpks_read_var() will overwrite var->datalen and copy into var->data
(if non-NULL) before plpks_is_wrapping_key_revoked() returns -EIO.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017074850.1640=
31-1-ssrish@linux.ibm.com?part=3D4
