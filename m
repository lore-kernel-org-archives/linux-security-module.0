Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616859;
	b=wVMw2JDTPsnk+fary5PxBnB1jK7jJ8Q/1MOabaxzAMOnJwyKdzJtGyC2f1rPA6ShIT2O
	 DBQ5LJBB1mf8QNtyIzfxJ5a9Zp4CWtkJ7hlN0IqA8GKoJLgTolxBKznLZb81iJNU5KKxB
	 COtPVUT+yn4NO7LB9vIpmvGkuVaPXwjW0sNZMDUgkni1b5+TfxG6/Bc4uI+cqoH2aszvo
	 rRq+V6EUnxy5plgxPLV+74rRWkzdcFNDeW8kPOEut5gLSKE7GzboLOsBUgT1oo22blSZm
	 EaBzCt1mJfgTnxPS3GNOmkVCtdFCYvnjL6UKAmpvpzKR1DLjCeQOGMbAGEFRj3pJC3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616859;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U28JZfUWwaeywTVTxDJTeCi/ESd+ScF5vSp+cmcmBlc=;
	b=4i2ODSYS1YU+6TiuElor0iQyNs3paBZE5NhkHCDJGn3+d/yjVIh39hr1v9yx4OnFPwx8
	 4s01Vxhb7rFPiQRdlOpAEf95rpk+yx43CClRtjHQmfd6lWyojTdtKyL1q8kGZN6ZV0zJW
	 N3vk93wNM7PFj6m3J02uK1wd0wTdXMu6KInQ5g81NvCtJplQsWtYPGgM/Ir3xYSowKfAj
	 6cXp6tfFV+4TCGT9zAMBaoKaaSBmLQFvNADbauBVr6G6qOLAsQ5WxnmCl51g6w84fbzWe
	 e+9AqkAA/eRHHzsEoCbnoxO98acAZ1CwUHz/5wxPylXVwD/QXo1bZvUWDQR4pUMxvDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YSF28SdS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9BC606A319
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YSF28SdS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46A51F000C1
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 21:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792616858;
	bh=U28JZfUWwaeywTVTxDJTeCi/ESd+ScF5vSp+cmcmBlc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YSF28SdSomp8QOajXq4q79m022e43QKmWKU4j2AamzxW0ZeZzOTQHHpfvYYwZP2Q9
	 R9FH2wV/N7wrD/sr7Ig53+WU3p64G7zp12wcHXS943HhZA+A8dMF7aLVnPNQaKHNAe
	 YvKg8JC2PNhqpUVBorUOKxPP6hUyrxe/wIpxlu5hgHLKamtNBQLR3gDLZ+m3o5riLF
	 RBE8/s/hbv9jLy6pPqOBzy8G+dA5XOM61OUTrM3UFOOMTETAZoV9F4zRsMhkamoiMQ
	 ZlmmdZ9s0KoPvWw7TGIqDhrsHNVyhvOHGLph7YdpUaggsauhNUeIEJsUHUQGilEKRv
	 sJZxPuHU/eqWQ==
Message-ID: <sashiko-outbox-180684@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] capabilities: limit fscaps to where CAP_SETFCAP
 reaches
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261021-b4-setfcap-userns-v3-4-97c7ed4e43e1@toxicpanda.com>
References: <20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com>
 <20261021-b4-setfcap-userns-v3-4-97c7ed4e43e1@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 21:07:38 +0000
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
- [High] capabilities: v2 xattr bypasses setfcap_level check in cap_convert=
_nscap()
--

commit 06013f196f1052cfc90402268b0b1b3878c33f84
Author: Josef Bacik <josef@toxicpanda.com>

capabilities: limit fscaps to where CAP_SETFCAP reaches

This commit updates cap_convert_nscap() in security/commoncap.c to verify
that both the mount-mapped root uid (vfsrootid) and the filesystem root uid
(rootid) do not map to uid 0 in a user namespace ancestor above
task_ns->setfcap_level. This prevents a task that entered a user namespace
without CAP_SETFCAP from setting file capabilities for an ancestor's root
user when a privileged task has mapped that uid into the namespace.

> diff --git a/security/commoncap.c b/security/commoncap.c
> index b069142230395..1a419a4a872c8 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -703,10 +703,24 @@ int cap_convert_nscap(const struct mnt_idmap *idmap=
, struct dentry *dentry,
>  	if (!vfsuid_valid(vfsrootid))
>  		return -EINVAL;
> =20
> +	/*
> +	 * The root user may be the root user of ancestors of our namespace as
> +	 * well.  CAP_SETFCAP that we got for entering it doesn't cover those.
> +	 * On an idmapped mount the root user is vfsrootid as seen through
> +	 * this mount and rootid as seen through every other mount of the
> +	 * filesystem, so both have to stay within reach.
> +	 */
> +	if (cap_root_level(vfsuid_into_kuid(vfsrootid), task_ns) <
> +	    task_ns->setfcap_level)
> +		return -EPERM;
> +
>  	rootid =3D from_vfsuid(idmap, fs_ns, vfsrootid);
>  	if (!uid_valid(rootid))
>  		return -EINVAL;
> =20
> +	if (cap_root_level(rootid, task_ns) < task_ns->setfcap_level)
> +		return -EPERM;

[Severity: High]
Can a v2 xattr bypass these new setfcap_level checks in
security/commoncap.c:cap_convert_nscap()?

Earlier in cap_convert_nscap(), v2 capabilities take an early return before
reaching rootid_from_xattr() and the new cap_root_level() checks:

	if (size =3D=3D XATTR_CAPS_SZ_2 && (idmap =3D=3D &nop_mnt_idmap))
		if (ns_capable(inode->i_sb->s_user_ns, CAP_SETFCAP))
			/* user is privileged, just write the v2 */
			return size;

Because a task in task_ns has CAP_SETFCAP in task_ns,
ns_capable(inode->i_sb->s_user_ns, CAP_SETFCAP) succeeds whenever fs_ns
(inode->i_sb->s_user_ns) is task_ns or a descendant of task_ns, regardless
of task_ns->setfcap_level.

In the scenario from the commit message (task B has uid 0 and CAP_SYS_ADMIN
without CAP_SETFCAP in init_user_ns, unshares ns1 with ns1->setfcap_level =
=3D 1,
and task A writes "0 0 1" to ns1's uid_map), task B can mount a filesystem
in ns1 (s_user_ns =3D=3D ns1) and write a v2 security.capability xattr
(size =3D=3D XATTR_CAPS_SZ_2). While a v3 xattr with rootid 0 is rejected w=
ith
-EPERM, the v2 write returns early and stores a raw v2 xattr whose root user
is make_kuid(ns1, 0), which is kuid 0.

If task B in init_user_ns then mounts overlayfs in init_user_ns
(ovl_sb->s_user_ns =3D=3D &init_user_ns) with that ns1 directory as lowerdi=
r and
executes the file in init_user_ns, get_file_caps() checks
current_in_userns(file->f_path.mnt->mnt_sb->s_user_ns) against
ovl_sb->s_user_ns (&init_user_ns) and reads the capability through:

  get_vfs_caps_from_disk()
    __vfs_getxattr()
      ovl_xattr_get()               [fs/overlayfs/xattrs.c]
        vfs_getxattr()              [under with_ovl_creds(dentry->d_sb)]
          cap_inode_getsecurity()   [security/commoncap.c]

In fs/overlayfs/xattrs.c:ovl_xattr_get() (and similarly during copy-up in
fs/overlayfs/copy_up.c:ovl_copy_xattr()):

	with_ovl_creds(dentry->d_sb)
		return vfs_getxattr(mnt_idmap(realpath.mnt), realpath.dentry, name, value=
, size);

And in security/commoncap.c:cap_inode_getsecurity():

	if (is_v2header(size, cap)) {
		root =3D 0;
	...
	kroot =3D make_kuid(fs_ns, root);

cap_inode_getsecurity() resolves kroot to make_kuid(ns1, 0) =3D=3D kuid 0 a=
nd
returns a valid v2 capability to get_vfs_caps_from_disk(), granting the file
capabilities in init_user_ns.

Additionally, if task A maps kuid 0 as a non-zero uid in ns1 (for example,
"0 1000 1" and "1000 0 1" with ns1->setfcap_level =3D 1), task B in ns1 can
unshare a child namespace ns2 and map "0 1000 1" in ns2 (permitted by
verify_root_map() because lower_first is 1000 !=3D 0 in ns1). On a filesyst=
em
mounted in ns2 (fs_ns =3D=3D ns2), a caller in ns1 or ns2 writing a v2 xattr
satisfies ns_capable(ns2, CAP_SETFCAP) and writes an unconverted v2 xattr
whose root user is make_kuid(ns2, 0) =3D=3D kuid 0 rather than make_kuid(ns=
1, 0).

Should the v2 fast path in cap_convert_nscap() be moved after the vfsrootid
and rootid checks (or verify that vfsrootid and rootid match and satisfy
cap_root_level() >=3D task_ns->setfcap_level before returning size)?

> +
>  	nsrootid =3D from_kuid(fs_ns, rootid);
>  	if (nsrootid =3D=3D -1)
>  		return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-b4-setfcap=
-userns-v3-0-97c7ed4e43e1@toxicpanda.com?part=3D4
