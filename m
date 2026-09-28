Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF314D4862
	for <linux-security-module@vger.kernel.org>; Mon, 28 Sep 2026 19:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790622964; cv=none; b=s5o6ZZOdlSSCnlfreH7jGS3sQvc5q0y4m0guxaaB4M62eykJow8z+KDnhhVOZtNgkAv1SHYmYNQzGvM6rC03iclBmeUs+RE3hf8rybs6rWaYxMy17WEqd1xxsVc5NHI3ez5jn91jCfm/TCOLNFqTVPx8hEaG39uQfMRz5M1wdrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790622964; c=relaxed/simple;
	bh=itfc4de2Hisa+4dDly1EITdkPLWZiBHJZleZ/WB1Y4Q=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rnp31CuPn5jmnOliBReWA+3UeIMTUJMacHU/xk8RzI+wE4YmM8kzBZb23dJBD5WRgQ8ra9r1jo3illikZVTxNUI2vGvj2VDkDRU/e9ci7dyNAc2z6YBgW5c0Fxn2GENglnJKhVOicIqOgRKzz3MxTPjAy8dWKQiKah3qhRxt4go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUwmzrzX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUwmzrzX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848D71F000FF
	for <linux-security-module@vger.kernel.org>; Mon, 28 Sep 2026 19:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790622962;
	bh=kSY/6ZBOH69KYekKkJRKDnZZpUzBjvBuurBTZzKjDms=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=nUwmzrzXMdIP+H524gW/Auh1YuEExyWRLP/a0VLDTSqyMpQ2ZV0ex5et3Inl5yUCU
	 fQKJWbGF++STbgAGZipXpwS7R6fPIWjX6+YT1YX1ymuApersMYi9Tp9mDBk+7GiAzU
	 gAqHI2Aamanci+jMjuwJ8rsDVr9xhPTyc9AhfI06OkoT1C75uD74cdKlPQvF9CBlxS
	 NAIm6WxSZAopuLCBpyNekMeUb1qM5VzxSKDyipAka6R2i8cOOFFE28d/mZsu4jMWHs
	 8yWdNUsbAUAb3SLFKXj3pV5GXtKOYEHUrvDtt4BY57F95Ih+yjpzsPtVL3IIpbGqaI
	 nF3l0peAZTZyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] apparmor: resolve pivotroot paths before the failure
 audit
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260928190620.1154576-1-adrianox@gmail.com>
References: <20260928190620.1154576-1-adrianox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 19:16:01 +0000
Message-Id: <20260928191602.848D71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] apparmor: uninitialized memory leak and OOB read in aa_pivotroot f=
ail path
--

commit bfa86a29c5894cbd4b54b58280d9a34e8e058003
Author: Adriano Cordova <adrianox@gmail.com>

apparmor: resolve pivotroot paths before the failure audit

build_pivotroot() stores the new and old path names in the audit data
while it mediates a transition, but it returns early for unconfined
profiles and profiles that do not mediate mounts. Resolve the names in
the failure path in that case before the audit record is emitted.

> diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
> index 4ed7b9136bebf..cd869a07335bf 100644
> --- a/security/apparmor/mount.c
> +++ b/security/apparmor/mount.c
> @@ -698,9 +698,18 @@ int aa_pivotroot(const struct cred *subj_cred, struc=
t aa_label *label,
>  	return error;
> =20
>  fail:
> -	/* TODO: add back in auditing of new_name and old_name,
> -	 * needs lifting of name lookup out of profile cb
> -	 */
> +	if (!ad.name) {
> +		struct aa_profile *p =3D labels_profile(label);
> +
> +		aa_path_name(new_path, path_flags(p, new_path), new_buffer,
> +			     &ad.name, &ad.info, p->disconnected);

[Severity: High]
Does this ignore the return value and potentially leak uninitialized memory?

If aa_path_name() fails (e.g., due to an excessively long path), it sets
the output pointer to point to the unmodified buffer:

security/apparmor/path.c:d_namespace_path() {
    ...
		if (PTR_ERR(res) =3D=3D -ENAMETOOLONG) {
			error =3D -ENAMETOOLONG;
			*name =3D buf;
			goto out;
		}
    ...
}

Since new_buffer was allocated using kmalloc() without zeroing:

security/apparmor/lsm.c:aa_get_buffer() {
    ...
	aa_buf =3D kmalloc(aa_g_path_max, flags);
    ...
}

When the error from aa_path_name() is ignored here, ad.name is left
pointing to uninitialized kernel heap memory. The subsequent call to
aa_audit_perm_error() will then read this uninitialized memory,
potentially reading out of bounds or leaking kernel heap data into the
audit logs.

> +	}
> +	if (!ad.mnt.src_name) {
> +		struct aa_profile *p =3D labels_profile(label);
> +
> +		aa_path_name(old_path, path_flags(p, old_path), old_buffer,
> +			     &ad.mnt.src_name, &ad.info, p->disconnected);
> +	}
>  	ad.mnt.trans =3D target->hname;
>  	error =3D aa_audit_perm_error(label, AA_MAY_PIVOTROOT, error, &ad,
>  				    audit_cb);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928190620.1154=
576-1-adrianox@gmail.com?part=3D1
