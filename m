Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401733DB655
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792263113; cv=none; b=a5Kwg2SeWN3CcoXEJVFkHKt/Po3ZQiUJRf4698pzi2G0x1J5m30UhvAMh/9VyTs3+0eNYeLJUH79q2pQPxOf0p3fK69T9JaThR9rHXfQGxasVCwF8x7ZcF8dbqQq/Qtshhdo++1j6toG1UcdKMlnhEG4FUdIQR3m1K4jl+xAqZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792263113; c=relaxed/simple;
	bh=tOAqUGnKXFdN/3TpxbBJPW9PvrQ3hQ35aRYQWdrQ5Z0=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=h0wNCYc0d6YeRzoH+2qYQ6V0DIAZUuyW+3OwnneC7/HxG2WL2RdUTI6fRQO2scmJOeier2n1PbvjVhwZe+wQLnNiN9ejBmtCcm8XCBPD88hE628wPcPgwcY2lAHgIysvYG5CW8lpk36Ue2yqBX2dmJoEQaIEVggQVkGId2z/H6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Su6XycOA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Su6XycOA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF421F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 18:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792263111;
	bh=G01rdAhjKw5uiBqnhhMxCyLo1wqFyDMF/KdC95ByzEM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Su6XycOAAmoLCAMnl4iaG9R++kiX+aA7ecdqWPgjJRNwFK657oHMH/4npQ1Szwpmy
	 OdPUaJOVRs65VSoJFQFa4yMHnoqbBQ/1i/TxaaU+wLUKLJCW9sOgsqL3genadGaTyN
	 ZCDt+5Rk3QI8JiCgTWCbCsHWnKnoFIIlSQB0U5qsF3A3nNPjv4SlXHvqthkBXzE3/j
	 t3Sl8NEepBtPlyBq+kagt2r2SB9Z96CueSQN4ZgGT43P75AAd2rXVL+y4aWLS+wR7n
	 9Lhj44DZE6X5Y+JAEpk8qeBjhRwEXrlSwt98qQs+dF7YuVw1a1VUoV1dQt0xAChOFL
	 NA9wp8mRc4pXg==
Message-ID: <sashiko-outbox-175762@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 9/9] pseries/plpks/wrapkey: expose PKWM wrapping key
 management to userspace via sysfs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261017183853.596052-10-ssrish@linux.ibm.com>
References: <20261017183853.596052-1-ssrish@linux.ibm.com>
 <20261017183853.596052-10-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 18:51:50 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] powerpc/pseries/plpks: use-after-free of plpks_kobj in plpks_ini=
t_child_kobj()
- [Medium] powerpc/pseries: wrapkey_sysfs_init() does not ensure default ke=
y exists
--

commit 81ec5557b710c94f51afed01c64f4716ffcf0140
Author: Srish Srinivasan <ssrish@linux.ibm.com>

pseries/plpks/wrapkey: expose PKWM wrapping key management to userspace via=
 sysfs

This commit adds a sysfs interface under /sys/firmware/plpks/wrapkey to all=
ow
userspace to create, revoke, unrevoke, delete, and list PKWM wrapping keys =
by
label.

> diff --git a/Documentation/ABI/testing/sysfs-firmware-plpks b/Documentati=
on/ABI/testing/sysfs-firmware-plpks
> index cba061e4eee2a..4144e868da1b1 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-plpks
> +++ b/Documentation/ABI/testing/sysfs-firmware-plpks

[ ... ]

> +What:		/sys/firmware/plpks/wrapkey/list_active
> +Date:		August 2026
> +Contact:	Srish Srinivasan <ssrish@linux.ibm.com>
> +Description:	(RO) List the labels of active, non-revoked wrapping keys. =
The
> +		default wrapping key, named "default-wrapping-key", is always
> +		included in this list.
> +
> +		For example:
> +
> +			cat /sys/firmware/plpks/wrapkey/list_active

[ ... ]

> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platfo=
rms/pseries/Kconfig
> index 7d125e288f6ef..14d2eed4d881a 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -215,3 +215,18 @@ config PPC_SVM
>  	 those guests.
> =20
>  	 If unsure, say "N".
> +
> +config PLPKS_WRAPKEY_SYSFS
> +	bool "Enable sysfs interface for managing PKWM wrapping keys"
> +	default n
> +	depends on PSERIES_PLPKS
> +	depends on SYSFS
> +	depends on TRUSTED_KEYS_PKWM
> +	help
> +	  The PKWM trusted source supports user-created wrapping keys that are
> +	  managed by the OS. These wrapping keys can be created, revoked,
> +	  unrevoked, and deleted through sysfs. Their labels can also be viewed
> +	  through sysfs.
> +
> +	  Say Y if PLPKS and PKWM are enabled and you want to isolate trusted
> +	  keys using user-created wrapping keys.

[ ... ]

> diff --git a/arch/powerpc/platforms/pseries/plpks-sysfs.c b/arch/powerpc/=
platforms/pseries/plpks-sysfs.c
> index f2436229f3233..0ca13bb6405f8 100644
> --- a/arch/powerpc/platforms/pseries/plpks-sysfs.c
> +++ b/arch/powerpc/platforms/pseries/plpks-sysfs.c
> @@ -55,6 +55,17 @@ static umode_t plpks_config_attr_is_visible(struct kob=
ject *kobj,
>  	return attr->mode;
>  }
> =20
> +int plpks_init_child_kobj(struct kobject *kobj, const struct kobj_type *=
ktype,
> +			  const char *name)
> +{
> +	kobject_init(kobj, ktype);
> +
> +	if (!plpks_kobj)
> +		return -ENODEV;
> +
> +	return kobject_add(kobj, plpks_kobj, "%s", name);
> +}
> +
>  int plpks_config_create_softlink(struct kobject *from)
>  {
>  	if (!plpks_config_kobj)

[Severity: Medium]
Can plpks_init_child_kobj() dereference a freed plpks_kobj if
plpks_sysfs_init() fails after creating plpks_kobj?

In arch/powerpc/platforms/pseries/plpks-sysfs.c:plpks_sysfs_init():

	plpks_config_kobj =3D kobject_create_and_add("config", plpks_kobj);
	if (!plpks_config_kobj) {
		pr_err("Failed to create plpks config kobj\n");
		kobject_put(plpks_kobj);
		return -ENOMEM;
	}

	rc =3D plpks_sysfs_config(plpks_config_kobj);
	if (rc) {
		pr_err("Failed to create attribute group for plpks config\n");
		kobject_put(plpks_config_kobj);
		kobject_put(plpks_kobj);
		return rc;
	}

If either of those steps fails during machine_subsys_initcall, kobject_put()
frees plpks_kobj without resetting the static pointer to NULL. When
wrapkey_sysfs_init() later runs at machine_late_initcall and calls
plpks_init_child_kobj(), the !plpks_kobj check passes and kobject_add()
operates on the dangling plpks_kobj pointer.

> diff --git a/arch/powerpc/platforms/pseries/plpks-wrapkey-sysfs.c b/arch/=
powerpc/platforms/pseries/plpks-wrapkey-sysfs.c
> new file mode 100644
> index 0000000000000..d810d6d64fb92
> --- /dev/null
> +++ b/arch/powerpc/platforms/pseries/plpks-wrapkey-sysfs.c

[ ... ]

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
> +	if (rc) {
> +		kobject_put(wrapkey_kobj);
> +		wrapkey_kobj =3D NULL;
> +	}
> +
> +	return rc;
> +}
> +
> +machine_late_initcall(pseries, wrapkey_sysfs_init);

[Severity: Medium]
Is "default-wrapping-key" guaranteed to exist in PLPKS when
wrapkey_sysfs_init() exposes /sys/firmware/plpks/wrapkey?

Both the commit message and Documentation/ABI/testing/sysfs-firmware-plpks
state that "default-wrapping-key" is always included in list_active, and
create_store() rejects "default-wrapping-key" with -EEXIST.

However, "default-wrapping-key" is only generated in
security/keys/trusted-keys/trusted_pkwm.c:trusted_pkwm_init():

	var =3D (struct plpks_var) {
		.name =3D (u8 *)PLPKS_DEFAULT_WRAPKEY_LABEL,
		.namelen =3D sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1,
		.policy =3D PLPKS_WRAPPINGKEY,
		.os =3D PLPKS_VAR_LINUX,
		.component =3D PLPKS_WRAPKEY_COMPONENT
	};

	ret =3D plpks_gen_wrapping_key(&var);

Because CONFIG_PLPKS_WRAPKEY_SYSFS is a bool while CONFIG_TRUSTED_KEYS is
tristate, wrapkey_sysfs_init() runs at machine_late_initcall even when
trusted.ko has not been loaded, or when init_trusted() selects another
trusted key source (such as TPM) earlier in trusted_key_sources[]. On a fre=
sh
LPAR where trusted_pkwm_init() has not run, won't reading list_active omit
"default-wrapping-key" while writing "default-wrapping-key" to create fails
with -EEXIST?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017183853.5960=
52-1-ssrish@linux.ibm.com?part=3D9
