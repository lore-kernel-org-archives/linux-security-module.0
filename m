Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795855610;
	b=ZjEN6MvhOkC8FzitX0geLb83qKv8teo0/8qLN08MbmZPviLnkLm/JrYcE1URx5l9wiam
	 VMCrPmMs4HEi42wYMwlRBRIV1oLJ4pGRed6zpb+rIV+X1ZwZ0qi6TKURONnaKKpxroCCT
	 XdhPW/TGKyBmoDDZ6mqoRhwVx5UDKZq0KCVpRUGPsk7JyZuDSKZtySo5urd1WrJaANkZF
	 1DHu9n0IdhRtSAgyeGAsb1otkDjBI3tqarZ2sga4H/2DRI1p4P9MU0r6YadX8AC1UEleM
	 XII8PZjg/YlVTURErnDV+jfWxkFpkoa8dsTn/CXqpsz5M8zjlE9v5GDliC3Tu1l6IOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795855610;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WK4lxjjOTVQ1LOQiOZru0wJs9Ga7c/N5UyYMvyr4UJQ=;
	b=jcz5i4Nn4Q2uJ72Pu9vLlR4K0D/ekpy4m8y7Zi1LCmOGo2Ok/pAdgs59jFAXkzKkLW1F
	 sDlojT4W2fmJ9FbiGXCEQDa29CyMMCPPVD1Tj+vxyhEJAl4WK0u7SAAmuKS1XXqTSiL1E
	 3HQBXGKF06REOBJponchBwgRE3w6PdTGx+5RDqbjZVAsjNesXeBDbLCSnB+MweQhTEJ2S
	 eTO8rRD4+I1a3Tbdz24cHmHFifEMlGWhaQ1BtN7xbQIfOR5f0JGqZXUUfQE4XakcGWkI0
	 XZK3J6akSUxoIQ75TsoZFRqCM63NJ3xyEFssgpAJ6FnhWscCi/1Nm4Q8xloXnrS2pow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hKkVX6xx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C09606A31C
	for <linux-security-module@vger.kernel.org>; Sat, 28 Nov 2026 08:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hKkVX6xx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9000D1F000C1
	for <linux-security-module@vger.kernel.org>; Sat, 28 Nov 2026 08:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795855609;
	bh=WK4lxjjOTVQ1LOQiOZru0wJs9Ga7c/N5UyYMvyr4UJQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hKkVX6xx+QWHm0/jO4BGiDv55d/Y3oTPd/7VxbbfH5uDk7NkOWgi0nrCem5I91YLp
	 D6rTbrbxBUKH7/vqdeVsV3qRMKQ+o6gryb7XyPJnSRYH9jcXsCiify0ES4K/1o0wlR
	 +Tybczzfe2Sni8wcFAUrvE+3GbgqxAEVqDnCuvuODvvIZmc5LHHBKcGvJV4Wn1jJwn
	 6/qzS2VvMAgNyozX2Qx/vEOvQnY7wc7TrJKhgyhUVSx+Sn80fZVMoN18fbKWdcMppW
	 l/BywwEXdqLBnG0LUaovzQ23fBq+IqOB0KC/kZ7nQVb7zXGgQlRcO0ZXpwL6ORlmxI
	 GYSMu5cKLw0Hg==
Message-ID: <sashiko-outbox-238561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] smack: mediate file attribute syscalls
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261128082823.3074924-1-shawnq1@163.com>
References: <20261128082823.3074924-1-shawnq1@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 08:46:49 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] smack: missing IS_PRIVATE() check in
  smack_inode_file_getattr() and setattr
- [Low] smack: overly verbose commit message with greeting and
  reproducer harness
--

commit b900878f18c1c73fc5f6dfbdfbd197ec123d665a
Author: shaos <shawnq1@163.com>

> smack: mediate file attribute syscalls
>=20
> Hello,
>=20
> Smack does not implement the inode_file_getattr and inode_file_setattr
> hooks.  As a result, the file_getattr() and file_setattr() system calls
> bypass Smack's existing read and write checks.
>=20
> The reproducer runs as uid 1000 without capabilities and changes its
> Smack label to Subject.  A stat() on /mnt/secret is denied, but
> file_getattr() on the same file succeeds.  The Subject label has only
> read access to the Control label, yet file_setattr() clears the file
> flags on /mnt/control.  Ordinary open() checks continue to be enforced.
>=20
> This bypass exposes file attribute metadata and permits changes to file
> attributes that the Smack policy denies.  It does not expose file contents
> or demonstrate privilege escalation.
>=20
> Tested source revision:
> HEAD commit:    8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
> git tree:       fe970b05333fb8e41da21e9e289f652abcc7cba7
> source version: Linux 7.4.0-rc4
> compiler:       gcc (Ubuntu 11.4.0-1ubuntu1~22.04.3) 11.4.0,
>                 GNU ld 2.38
>=20
> console output:
> https://gist.githubusercontent.com/shaos26/fbf8b7f663ee82593d7d41623aa2e2=
c4/raw/2ad22ab46d2cf376b59ef361d9c7ca2b691c6eda/console-output.txt
> kernel config:
> https://gist.githubusercontent.com/shaos26/fbf8b7f663ee82593d7d41623aa2e2=
c4/raw/f9e1ceca2f52ead87738af313610fc49834654dc/kernel-config.txt
> reproducer:
> https://gist.githubusercontent.com/shaos26/fbf8b7f663ee82593d7d41623aa2e2=
c4/raw/d9b447aad65076391390d150d752b6b9cb116abc/poc.c
>=20
> Build the kernel at the tested revision with the attached configuration.
> The reproducer is a static init program and expects an ext4 image on
> /dev/vda containing empty files named secret, control, and public:
>=20
>     truncate -s 32M smack.img
>     mkfs.ext4 -F smack.img
>     mkdir mnt
>     mount -o loop smack.img mnt
>     touch mnt/secret mnt/control mnt/public
>     umount mnt
>     gcc -O2 -Wall -Wextra -static -o poc poc.c
>     mkdir -p rootfs
>     cp poc rootfs/init
>     chmod 0755 rootfs/init
>     (cd rootfs && find . -print0 | cpio --null -o -H newc) |
>         gzip -9 > initramfs.cpio.gz
>=20
> Boot the initramfs and ext4 image with:
>=20
>     qemu-system-x86_64 -m 2G -smp 2 \
>         -kernel <linux-tree>/arch/x86/boot/bzImage \
>         -initrd initramfs.cpio.gz \
>         -drive file=3Dsmack.img,format=3Draw,if=3Dvirtio \
>         -append 'console=3DttyS0 rdinit=3D/init lsm=3Dsmack loglevel=3D7'=
 \
>         -nographic -monitor none -no-reboot
>=20
> On two vulnerable boots, file_getattr() on /mnt/secret returned success
> while stat() returned -EACCES.  file_setattr() on /mnt/control also
> returned success and cleared its flags.  With this patch, both denied
> operations return -EACCES; permitted operations on /mnt/public still
> succeed.
>=20
> Implement both hooks with the same Smack access checks used by the
> existing getattr and setattr hooks:
>=20
> Fixes: defdd02d783c ("lsm: introduce new hooks for setting/getting inode =
fsxattr")
> Signed-off-by: shaos <shawnq1@163.com>

[Severity: Low]
This isn't a bug, but the commit message includes an email greeting,
external gist URLs, step-by-step QEMU reproduction instructions, and a
trailing colon before the Fixes: trailer.  Could the greeting, ephemeral
links, and test harness instructions be moved below the "---" tearline so
the commit log stays concise?

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 8e88ac65fd7fc..9ea1c574156f5 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1308,6 +1308,34 @@ static int smack_inode_getattr(const struct path *=
path)
>  	return rc;
>  }
> =20
> +static int smack_inode_file_getattr(struct dentry *dentry,
> +				    struct file_kattr *fa)
> +{
> +	struct smk_audit_info ad;
> +	struct inode *inode =3D d_backing_inode(dentry);
> +	int rc;
> +
> +	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
> +	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
> +	rc =3D smk_curacc(smk_of_inode(inode), MAY_READ, &ad);
> +	rc =3D smk_bu_inode(inode, MAY_READ, rc);
> +	return rc;
> +}
> +
> +static int smack_inode_file_setattr(struct dentry *dentry,
> +				    struct file_kattr *fa)
> +{
> +	struct smk_audit_info ad;
> +	struct inode *inode =3D d_backing_inode(dentry);
> +	int rc;
> +
> +	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
> +	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
> +	rc =3D smk_curacc(smk_of_inode(inode), MAY_WRITE, &ad);
> +	rc =3D smk_bu_inode(inode, MAY_WRITE, rc);
> +	return rc;
> +}

[Severity: Medium]
Should smack_inode_file_getattr() and smack_inode_file_setattr() skip
IS_PRIVATE(inode) inodes?

Unlike security_inode_getattr() and security_inode_setattr(),
security_inode_file_getattr() and security_inode_file_setattr() do not
filter out IS_PRIVATE() inodes before invoking the LSM hooks:

security/security.c:security_inode_file_setattr() {
	return call_int_hook(inode_file_setattr, dentry, fa);
}

When a task calls ioctl(fd, FS_IOC_GETFLAGS) or ioctl(fd, FS_IOC_SETFLAGS)
on a kernel-internal S_PRIVATE tmpfs inode (such as an anonymous shared
mapping passed across a Smack label transition), smack_file_ioctl()
explicitly returns 0 for IS_PRIVATE(inode), but vfs_fileattr_get() and
vfs_fileattr_set() then call into these new hooks and fail with -EACCES if
the current task's label cannot access the label of the task that created
the inode.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261128082823.3074=
924-1-shawnq1@163.com?part=3D1
