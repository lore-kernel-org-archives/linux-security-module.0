Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09D03D3CFF
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792224463; cv=none; b=jSyKA8dsSl4DwccgVKeJy1/0Z47RZTUSmj9ppSzXLO/iD18JaLInhjI1ADLuXGs9gaLKzcikgjZf5bHszL4B46O7pWcR3DtBvdahLQ7ESbZAZSY1IwpL85A0dsVDpqEoB8Te66wRlsJmUv0FRxGN841qH5MijzneKakzHasnCPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792224463; c=relaxed/simple;
	bh=vJ2+Hti8i5lr/Wt8q4miCxN4F5YpoT7GQb9ckg35oV8=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rpg5KIScqwA8NeGwoELR1XLqiGrwOUcrARNG3fMuDyJbhbJFcQjG4NM6fb8kt9+EhkdOqrdM23ioIGP0sRDih02bzzKN8/MQIkyQyeNI2WaEiAs3u+/nR8Ypi2PQANw1dwFKY0/Czp6wxLasl4i3+lsbzlRSJ9cDi8/Sq4hHd4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nObmX5JO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nObmX5JO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FF31F000C5
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 08:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792224461;
	bh=P453dNvDj9BF0/hAmRIX3wPzVsY00pFgrZ4lE7ugRbI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=nObmX5JOU8e1FlRn0CACs1xbBgQPAZ+d0O79J+2r3JoHY+vwitGbmxsJMX0tJmWfs
	 ZhA85Y5XaOY+ZmjRj8i8N8RxLqBDi+VzHhoCGSQ33i/QxozW2ny2FssA3iY9uxpvFS
	 nPSqBS0TPrySfVk2jE0L04gGWFnyI3ZTfdyjoa2JvzGkc/z6E0QZOSkcGjcv7kYWR1
	 aXfl05h1iq3qvpWfH0XwaUK4eO0/W69HsTYfS63shSV3N/anoyVKp7JwKWk0SkFDsG
	 4FI+p279R3xz2JeInrxDECuRkXn468woFn0qqx09Bk4+qvMbSx7HFL8Ipakeuu4SD2
	 M4IAf4b+6Gccw==
Message-ID: <sashiko-outbox-175387@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] pseries/plpks/wrapkey: expose PKWM wrapping key
 management to userspace via sysfs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261017074850.164031-7-ssrish@linux.ibm.com>
References: <20261017074850.164031-1-ssrish@linux.ibm.com>
 <20261017074850.164031-7-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 08:07:41 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] pseries/plpks: missing release() in wrapkey_ktype leaks wrapkey_=
kobj
- [Medium] pseries/plpks: stale var.policy across iterations in list_key_la=
bels()
- [Low] powerpc/pseries: wrapkey_sysfs_init() runs on non-pseries platforms
--

commit 7bc0ceea6c99f35ed770f462297146f04fc44fd3
Author: Srish Srinivasan <ssrish@linux.ibm.com>

pseries/plpks/wrapkey: expose PKWM wrapping key management to userspace via=
 sysfs

This commit adds a sysfs interface under /sys/firmware/plpks/wrapkey to
allow userspace to create, revoke, unrevoke, delete, and list PKWM
wrapping keys.

> diff --git a/arch/powerpc/platforms/pseries/plpks-wrapkey-sysfs.c b/arch/=
powerpc/platforms/pseries/plpks-wrapkey-sysfs.c
> new file mode 100644
> index 0000000000000..efae08e899b66
> --- /dev/null
> +++ b/arch/powerpc/platforms/pseries/plpks-wrapkey-sysfs.c
> @@ -0,0 +1,399 @@

[ ... ]

> +static ssize_t list_key_labels(char *buf, u8 *obj_labels_buf,
> +			       u64 obj_labels_count, int revoked)
> +{
> +	struct plpks_var var =3D {0};
> +	u8 *obj_labels_buf_ptr, *comp_prefix;
> +	u8 *key_label_ptr;
> +	u16 obj_label_len;
> +	int len =3D 0;
> +	int is_revoked;
> +	u64 i;
> +
> +	var.os =3D PLPKS_VAR_LINUX;
> +	var.component =3D PLPKS_WRAPKEY_COMPONENT;
> +	obj_labels_buf_ptr =3D obj_labels_buf;
> +
> +	for (i =3D 0; i < obj_labels_count; ++i) {
> +		obj_label_len =3D get_unaligned_be16(obj_labels_buf_ptr);
> +		comp_prefix =3D obj_labels_buf_ptr +
> +			      PLPKS_OBJLABEL_LEN_FIELD_SIZE;
> +
> +		var.namelen =3D obj_label_len - PLPKS_MAX_LABEL_ATTR_SIZE;
> +		var.name =3D kzalloc(var.namelen + 1, GFP_KERNEL);
> +
> +		if (!var.name)
> +			return -ENOMEM;
> +
> +		key_label_ptr =3D comp_prefix + PLPKS_MAX_LABEL_ATTR_SIZE;
> +		memcpy(var.name, key_label_ptr, var.namelen);
> +
> +		is_revoked =3D plpks_is_wrapping_key_revoked(&var);
> +		if (is_revoked =3D=3D revoked)
> +			len +=3D sysfs_emit_at(buf, len, "<%s>\n",
> +					     (char *)var.name);
> +		else if (is_revoked < 0)
> +			pr_warn("Failed to get revocation status for <%s>\n",
> +				(char *)var.name);
> +
> +		kfree(var.name);
> +		obj_labels_buf_ptr =3D key_label_ptr + var.namelen;
> +	}
> +
> +	return len;
> +}

[Severity: Medium]
Can a stale var.policy value carry over across iterations of the loop in
list_key_labels()?

In list_key_labels(), struct plpks_var var is zero-initialized once before
the loop, and each iteration calls plpks_is_wrapping_key_revoked(&var) ->
plpks_read_var(PLPKS_OS_OWNER, &var) without resetting var.policy.

When plpks_read_var() succeeds in retrieving a wrapping key's policy on
one iteration, it sets var->policy (including PLPKS_WRAPPINGKEY and
possibly PLPKS_REVOKED). If a subsequent iteration fails with -EPERM and
retbuf[1] =3D=3D 0:

arch/powerpc/platforms/pseries/plpks.c:plpks_read_var() {
	if (rc !=3D H_SUCCESS) {
		rc =3D pseries_status_to_err(rc);
		if (rc !=3D -EPERM || !retbuf[1])
			goto out_free_output;
		goto out_copy_policy;
	}
}

var->policy is not overwritten. Then plpks_is_wrapping_key_revoked()
inspects the stale var->policy from the previous key:

arch/powerpc/platforms/pseries/plpks.c:plpks_is_wrapping_key_revoked() {
	} else if (rc =3D=3D -EPERM) {
		if (var->policy & PLPKS_WRAPPINGKEY) {
			if (var->policy & PLPKS_REVOKED)
				rc =3D 1;
			else
				rc =3D 0;
		}
	}
}

Would this cause plpks_is_wrapping_key_revoked() to return the previous
key's revocation status (0 or 1) instead of -EPERM?

[ ... ]

> +static const struct kobj_type wrapkey_ktype =3D {
> +	.sysfs_ops	=3D &kobj_sysfs_ops,
> +	.default_groups =3D wrapkey_attr_groups,
> +};
> +
> +static __init int wrapkey_sysfs_init(void)
> +{
> +	int rc;
> +
> +	if (!plpks_revoke_is_supported()) {
> +		pr_err("H_PKS_{UN}REVOKE_OBJECT interface not supported\n");
> +		return -ENODEV;
> +	}
> +
> +	wrapkey_kobj =3D kzalloc_obj(*wrapkey_kobj);
> +	if (!wrapkey_kobj)
> +		return -ENOMEM;
> +
> +	rc =3D plpks_init_child_kobj(wrapkey_kobj, &wrapkey_ktype, "wrapkey");
> +
> +	if (rc)
> +		kobject_put(wrapkey_kobj);
> +
> +	return rc;
> +}

[Severity: Medium]
Does calling kobject_put(wrapkey_kobj) leak wrapkey_kobj and trigger a
kobject warning because wrapkey_ktype has no .release callback?

In wrapkey_sysfs_init(), wrapkey_kobj is dynamically allocated with
kzalloc_obj(*wrapkey_kobj) and initialized via plpks_init_child_kobj() ->
kobject_init(kobj, &wrapkey_ktype).

If plpks_init_child_kobj() fails (for example, when plpks_kobj is NULL or
kobject_add() returns an error), wrapkey_sysfs_init() calls
kobject_put(wrapkey_kobj). Because wrapkey_ktype omits .release,
kobject_cleanup() will not free wrapkey_kobj, and wrapkey_kobj also
remains non-NULL.

> +
> +late_initcall(wrapkey_sysfs_init);

[Severity: Low]
Should this use machine_late_initcall(pseries, wrapkey_sysfs_init) instead
of late_initcall(wrapkey_sysfs_init)?

Other PLPKS initcalls (such as pseries_plpks_init() in plpks.c and
plpks_sysfs_init() in plpks-sysfs.c) use machine_*_initcall(pseries, ...).
With a bare late_initcall(), booting a multi-platform powerpc kernel on a
non-pseries machine will run wrapkey_sysfs_init() and log:

  wrapkey-sysfs: H_PKS_{UN}REVOKE_OBJECT interface not supported

[]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017074850.1640=
31-1-ssrish@linux.ibm.com?part=3D6
