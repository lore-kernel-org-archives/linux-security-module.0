Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792776623;
	b=OHXfb45zNJzRMRfOjMmiJ2hgfxzZ41SjCRhV22TgdM2QHhsn3xk4aZtEMdPvcq3qoARL
	 43Lk8v4QBtg+9c2MNwPusRQ5M/1RpL1WncaCf2zNnlna66Iu/ieoXB58tS3tPGDeAyh8w
	 rbdN5I400IBx1JJo9KE+VbS9ID8SbvgItxSEsmFcJj6rfkHPS9awXUqL2Be734QTl6JAr
	 t7DpT06/0wiEP+Oduv6gC7p686EHTmS0vt6NQvQCdPnqV+O5tYlb7BwMHY9zkpS2RfyGv
	 kVeXDKdMmLeecWb3QSxwM7zd6lYlkFstwRzQykmGDNVLsmUBdhVt7bbJlL9Y3OYYxQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792776623;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9TWm1lR2/77ixWUk0wn8e/sarWzldpnztTpDCLDekyo=;
	b=wM/Dfnz93UDGeJLZZWU0pPOj9CZIQmiP4JxBgou5KMkEeWOKd/y2ck9e5PJ7S8ON1uYn
	 0SvpMGPLquYTKOf0inhhOa6/mLKmHLfYEiaL99ZVVtxSDsCLRBHitqbScK6PN9s9UuOCW
	 SjVmDDKE3kEKc3MyYPOK6KiiGg+XUuSKp5u74s/H4aOnRcQXt+CTguSfRjo8drUcTGgYP
	 UqnrnVUws4pzlOjrQQEHJd4BKBkTSiC989gaj8C6GkPYtnh0AK5jJ1NQD0QcscjNWsHkH
	 e/o7CwpHsVQefkDWTdWhVKpLYEuQv45g5pGc0PUfv5LKqX47ppc1b8Vy8e+WcUKnw0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SSO1J8U6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F6A606A31E
	for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SSO1J8U6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667391F01825
	for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 17:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792776622;
	bh=9TWm1lR2/77ixWUk0wn8e/sarWzldpnztTpDCLDekyo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SSO1J8U6cspON1ZhahixNKWDkTcuhe2YDkjj2IohNdIAOcmQX5ZwTJrrTHHtk/85/
	 7RzJKCyJ1sgC2YkcBg0u7wsatZbVASvMhtwgEHGCY+CkH8uONZeXdy3hF/Amqve8mz
	 vKQSSsIIAcWrh6zqJBkFrSDc1HSmTlSdtYGKfJbtxdx0ufC1uwlGecwxTFMZP7EZxa
	 5nxxTFtKFAhiz5wIGyieiIAfnGZdCiHx6EnDf8f8MqpiW3dBDTWIeiqlhgisgyu4gg
	 BkQK2xS+TNGVFeOj8Z8Drc9t0KFkoN7oaKXk3tSHBCTALhAEqu0MHuxmv4/gkUjtQu
	 n6ydNmSEX1bOg==
Message-ID: <sashiko-outbox-183002@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] loadpin: allow untoggleable enforcement on
 filesystems which don't appear to be read-only
Reply-To: sashiko-reviews@lists.linux.dev
To: linux-security-module@vger.kernel.org
In-Reply-To: <20261023171508.3460300-1-acrate@waldn.net>
References: <20261023171508.3460300-1-acrate@waldn.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 17:30:22 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] loadpin: force_enforce fails to enable enforce and locks it to 0
--

commit dc93f122a0f976e677fefeb791538922df5a6557
Author: Amelia Crate <acrate@waldn.net>

loadpin: allow untoggleable enforcement on filesystems which don't appear t=
o be read-only

This commit adds the loadpin.force_enforce kernel parameter and a
corresponding read-only sysctl to prevent toggling LoadPin enforcement on
filesystems that are not backed by a read-only block device.

> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index f71861f98e1ab..b260ad299a2cc 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -45,6 +45,7 @@ static void report_load(const char *origin, struct file=
 *file, char *operation)
>  }
> =20
>  static int enforce =3D IS_ENABLED(CONFIG_SECURITY_LOADPIN_ENFORCE);
> +static bool force_enforce __ro_after_init;
>  static char *exclude_read_files[READING_MAX_ID];
>  static int ignore_read_file_id[READING_MAX_ID] __ro_after_init;
>  static struct super_block *pinned_root;
> @@ -60,11 +61,19 @@ static bool loadpin_root_writable;
>  static int proc_handler_loadpin(const struct ctl_table *table, int dir,
>  				void *buffer, size_t *lenp, loff_t *ppos)
>  {
> -	if (!loadpin_root_writable && SYSCTL_USER_TO_KERN(dir))
> +	if ((force_enforce || !loadpin_root_writable) && SYSCTL_USER_TO_KERN(di=
r))
>  		return -EINVAL;
>  	return proc_dointvec_minmax(table, dir, buffer, lenp, ppos);
>  }

[Severity: High]
What happens when a system is booted with loadpin.force_enforce=3D1 while
enforce is 0 (for example, when CONFIG_SECURITY_LOADPIN_ENFORCE=3Dn and
loadpin.enforce=3D1 is not passed on the command line, or when
loadpin.enforce=3D0 is passed)?

The documentation in Documentation/admin-guide/kernel-parameters.txt states
that loadpin.force_enforce=3D1 forces LoadPin enforcement until reboot and
only requires LoadPin to be enabled in the active LSM list, and
MODULE_PARM_DESC(force_enforce, ...) describes it as "Always enforce
module/firmware pinning".

However, force_enforce is only checked here in proc_handler_loadpin()
(under CONFIG_SYSCTL) to reject writes to /proc/sys/kernel/loadpin/enforce.
It never sets enforce =3D 1 in loadpin_init(), and it is not checked in
loadpin_check() or loadpin_sb_free_security():

security/loadpin/loadpin.c:loadpin_sb_free_security() {
	if (!IS_ERR_OR_NULL(pinned_root) && mnt_sb =3D=3D pinned_root) {
		if (enforce) {
			pinned_root =3D ERR_PTR(-EIO);
			pr_info("umount pinned fs: refusing further loads\n");
		} else {
			pinned_root =3D NULL;
		}
	}
}

security/loadpin/loadpin.c:loadpin_check() {
	...
	if (IS_ERR_OR_NULL(pinned_root) ||
	    ((load_root !=3D pinned_root) && !dm_verity_loadpin_is_bdev_trusted(lo=
ad_root->s_bdev))) {
		if (unlikely(!enforce)) {
			report_load(origin, file, "pinning-ignored");
			return 0;
		}

		report_load(origin, file, "denied");
		return -EPERM;
	}
}

If enforce is 0 at boot and force_enforce is 1, won't LoadPin fail to
enforce pinning in loadpin_check() and loadpin_sb_free_security(), while
proc_handler_loadpin() simultaneously blocks userspace from enabling it via
/proc/sys/kernel/loadpin/enforce, locking LoadPin in non-enforcing mode
until reboot (and making force_enforce a complete no-op when
CONFIG_SYSCTL=3Dn)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023171508.3460=
300-1-acrate@waldn.net?part=3D1
