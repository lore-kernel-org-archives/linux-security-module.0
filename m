Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D95112D21B
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792224508; cv=none; b=GmRykJ6GPySPSgtv6JAHptFoAPHvzXyHMUejyEDQ/zA+FmEq4m+0MxOmhF0wPwExFeF7ox1/N5Kem+X8tNwEJGw1BGSE0S+LqMPo7S38RWjSycrgyHMXDqhdNAcnBAdtAKfO6GQEVAcVI4dSaqPaOJzj4qRZkP5Fbmq6W9OAb/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792224508; c=relaxed/simple;
	bh=krGNo6367QFkUWS2qzYvsNCt3zIlXAPy9WqpBJrc2js=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Z4I8w2ZGS7xMRThjwANmWuONBCudaUBkNofZd1badd5I58R0pPCI28SPpjB2VBycVYHdV+Sci86yh9WOgs5aUsv+84ACXPG72AguMKLNfLw5hE3f0vF3MauGlpl7YjkGhlL9zNma2d5DCt/97lAqYCoJWz1qBgvDg47KEVpO4AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hH276jqA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hH276jqA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A79E1F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 08:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792224507;
	bh=n+TIee09cFsgnjbeuhxm9J2nxAmcl9zBZyGHXENZMAs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hH276jqAzUxYP3++OnTj66t6EonRt/6XTQSxAzFyiI8nRtAFRzNlO/uXdKaYI0Yh1
	 xiMotNOJ/3PVqqcIU9OvnExpxCkBqT1B2dCxkqCAoDcHvXSq2Z8NCkE3JXEWzgy+Uc
	 OEEMoSn8KuRvdQnMVwSgVhmTz6/fQ7i0fIIql4+dXKnopPW3A+qNwP8UM7fs94GcCK
	 p3rF5wwDz2TQQkncPLdXwtAOLUCfuAUgP//S6IT4gWOSXFc+zOWSh03m6BihyJxQ9W
	 +7Z6eZsxxNvKWVuOX9Lf0Wr2LYXxCla+UjuSOVlsSaMVDzPn2dXiZWNpv4Vjy6NSBH
	 sP5Liz6BO6pfw==
Message-ID: <sashiko-outbox-175388@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] keys/trusted_keys: enable PKWM wrapping key
 selection by label
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261017074850.164031-6-ssrish@linux.ibm.com>
References: <20261017074850.164031-1-ssrish@linux.ibm.com>
 <20261017074850.164031-6-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 08:08:26 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] keys/trusted_keys: uninitialized output_buf freed in trusted_pkwm_=
seal()
- [Medium] powerpc/pseries/plpks: double status conversion in plpks_gen_wra=
pping_key()
--

commit 333e996cc70a34c8f3a006ec261f3d6b0dcd0e1f
Author: Srish Srinivasan <ssrish@linux.ibm.com>

keys/trusted_keys: enable PKWM wrapping key selection by label

This commit updates the PKWM trusted keys backend and pseries PLPKS wrapping
interface to allow callers to specify a wrapping key label via the
wrapping_key=3D<label> option when sealing trusted keys, falling back to the
default wrapping key if none is specified.

> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platfo=
rms/pseries/plpks.c
> index edd189cfcc85c..a4fb5dbac4061 100644
> --- a/arch/powerpc/platforms/pseries/plpks.c
> +++ b/arch/powerpc/platforms/pseries/plpks.c

[ ... ]

> @@ -960,25 +958,22 @@ EXPORT_SYMBOL_GPL(plpks_revoke_is_supported);
>   *
>   * Returns: On success 0 is returned, a negative errno if not.
>   */
> -int plpks_gen_wrapping_key(void)
> +int plpks_gen_wrapping_key(struct plpks_var *var)
>  {
>  	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] =3D { 0 };
>  	struct plpks_auth *auth;
>  	struct label *label;
>  	int rc =3D 0, pseries_status =3D 0;
> -	struct plpks_var var =3D {
> -		.name =3D PLPKS_DEFAULT_WRAPKEY_LABEL,
> -		.namelen =3D sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1,
> -		.policy =3D PLPKS_WRAPPINGKEY,
> -		.os =3D PLPKS_VAR_LINUX,
> -		.component =3D PLPKS_WRAPKEY_COMPONENT
> -	};
> +
> +	if (!var || !var->name || !*var->name)
> +		return -EINVAL;
> =20
>  	auth =3D construct_auth(PLPKS_OS_OWNER);
>  	if (IS_ERR(auth))
>  		return PTR_ERR(auth);
> =20
> -	label =3D construct_label(var.component, var.os, var.name, var.namelen);
> +	label =3D construct_label(var->component, var->os, var->name,
> +				var->namelen);
>  	if (IS_ERR(label)) {
>  		rc =3D PTR_ERR(label);
>  		goto out;
> @@ -986,7 +981,7 @@ int plpks_gen_wrapping_key(void)
> =20
>  	rc =3D plpar_hcall(H_PKS_GEN_KEY, retbuf,
>  			 virt_to_phys(auth), virt_to_phys(label),
> -			 label->size, var.policy,
> +			 label->size, var->policy,
>  			 NULL, PLPKS_WRAPPING_KEY_LENGTH);
> =20
>  	if (!rc)
> @@ -995,12 +990,9 @@ int plpks_gen_wrapping_key(void)
>  	pseries_status =3D rc;
>  	rc =3D pseries_status_to_err(rc);
> =20
> -	if (rc && rc !=3D -EEXIST) {
> -		pr_err("H_PKS_GEN_KEY failed. pseries_status=3D%d, rc=3D%d",
> +	if (rc && rc !=3D -EEXIST)
> +		pr_err("H_PKS_GEN_KEY failed. pseries_status=3D%d, rc=3D%d\n",
>  		       pseries_status, rc);
> -	} else {
> -		rc =3D 0;
> -	}

[Severity: Medium]
When plpar_hcall(H_PKS_GEN_KEY, ...) returns 0, plpks_gen_wrapping_key()
calls plpks_confirm_object_flushed(label, auth):

arch/powerpc/platforms/pseries/plpks.c:plpks_confirm_object_flushed() {
	...
	if (timed_out)
		return -ETIMEDOUT;

	return pseries_status_to_err(rc);
}

Since plpks_confirm_object_flushed() already converts the hypervisor status
code into a negative Linux errno (or returns -ETIMEDOUT), passing its return
value through pseries_status_to_err(rc) a second time in
plpks_gen_wrapping_key() re-maps the Linux errno as if it were a hypervisor
return code.

Because H_RESOURCE is -16 and -EBUSY is also -16, a -EBUSY return from
plpks_confirm_object_flushed() gets converted into -EEXIST. With this patch
Propagating -EEXIST to callers and trusted_pkwm_init() treating -EEXIST as
success, won't a -EBUSY flush failure be silently ignored in both
plpks_gen_wrapping_key() and trusted_pkwm_init(), while other flush errors
like -ETIMEDOUT or -EIO are corrupted into -EINVAL or -ENXIO?

> =20
>  	kfree(label);
>  out:

[ ... ]

> diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/tr=
usted-keys/trusted_pkwm.c
> index 6774557f818a1..ba7717b474b27 100644
> --- a/security/keys/trusted-keys/trusted_pkwm.c
> +++ b/security/keys/trusted-keys/trusted_pkwm.c

[ ... ]

> @@ -82,6 +90,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload=
 *p, char *datablob)
>  {
>  	struct trusted_key_options *options =3D NULL;
>  	struct trusted_pkwm_options *pkwm =3D NULL;
> +	struct plpks_var var =3D {0};
>  	u8 *input_buf, *output_buf;
>  	u64 output_len, input_len;
>  	int rc;
> @@ -108,8 +117,18 @@ static int trusted_pkwm_seal(struct trusted_key_payl=
oad *p, char *datablob)
> =20
>  	pkwm =3D options->private;
> =20
> +	if (pkwm->wrapping_key_label[0]) {
> +		var.name =3D (u8 *)pkwm->wrapping_key_label;
> +		var.namelen =3D strlen(pkwm->wrapping_key_label);
> +	} else {
> +		var.name =3D (u8 *)PLPKS_DEFAULT_WRAPKEY_LABEL;
> +		var.namelen =3D strlen(PLPKS_DEFAULT_WRAPKEY_LABEL);
> +	}
> +	var.os =3D PLPKS_VAR_LINUX;
> +	var.component =3D PLPKS_WRAPKEY_COMPONENT;
> +
>  	rc =3D plpks_wrap_object(&input_buf, input_len, pkwm->wrap_flags,
> -			       &output_buf, &output_len);
> +			       &output_buf, &output_len, &var);
>  	if (!rc) {
>  		memcpy(p->blob, output_buf, output_len);
>  		p->blob_len =3D output_len;

[Severity: High]
Can kfree(output_buf) be called on an uninitialized pointer in
trusted_pkwm_seal()?

In trusted_pkwm_seal(), output_buf is declared on the stack without being
initialized to NULL:

security/keys/trusted-keys/trusted_pkwm.c:trusted_pkwm_seal() {
	...
	u8 *input_buf, *output_buf;
	...
	rc =3D plpks_wrap_object(&input_buf, input_len, pkwm->wrap_flags,
			       &output_buf, &output_len, &var);
	if (!rc) {
		...
	} else {
		pr_err("Wrapping of payload key failed: %d\n", rc);
	}

	kfree_sensitive(input_buf);
	kfree(output_buf);
}

In plpks_wrap_object(), *output_buf is only assigned when kzalloc() is
called:

arch/powerpc/platforms/pseries/plpks.c:plpks_wrap_object() {
	...
	if (!var || !var->name || !*var->name)
		return -EINVAL;

	auth =3D construct_auth(PLPKS_OS_OWNER);
	if (IS_ERR(auth))
		return PTR_ERR(auth);

	label =3D construct_label(var->component, var->os, var->name,
				var->namelen);
	if (IS_ERR(label)) {
		rc =3D PTR_ERR(label);
		goto out;
	}
	...
	if (sb_audit_or_enforce_bit & sb_enforce_bit) {
		pr_err("Cannot set both audit/enforce and enforce bits.");
		rc =3D -EINVAL;
		goto out_free_label;
	}
	...
	*output_buf =3D kzalloc(ALIGN(*output_len, PLPKS_WRAPPING_BUF_ALIGN),
			      GFP_KERNEL);
}

If plpks_wrap_object() returns early via any of those error paths before
reaching kzalloc() (for example if construct_label() fails on the user-
supplied var->name or var->namelen, or if construct_auth() fails with
-ENOMEM), *output_buf is never written and trusted_pkwm_seal() passes the
uninitialized stack value to kfree(output_buf).

The same pattern also exists in trusted_pkwm_unseal(), where output_buf is
uninitialized on the stack and passed to kfree_sensitive(output_buf) if
construct_auth() fails in plpks_unwrap_object() before *output_buf is
allocated. Should output_buf be initialized to NULL in both
trusted_pkwm_seal() and trusted_pkwm_unseal()?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017074850.1640=
31-1-ssrish@linux.ibm.com?part=3D5
