Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081723;
	b=LREnQEIWlDkaqJrY3cOWES0tMtjSEebsIUnNI1EVc9rc9gOSfQTN5pjUJWy/nPDVUt1b
	 FMwX/Hw021IMMRsCKu+4NWTubDXUH7np69Dekqecy+YsQrirG0PEoCgn5hkTBJ2WDjRSB
	 7kiWKgeGS+UU08l0VKyX5m4S8YtpM3n4ZRmL1u5LzMyo8Iz+T5hggOIyNmKo+UFnU0/jz
	 1f+74OJ96RrRAJnrf+Qa8b1n+xfkDm1uf975Pq8EOOAhD4EDAF1Q6C6jGYX4lmDmTcOYo
	 +Z9e/UPQI6ORz4t0ZHyvQ9pKI8mM0HgQMpJVUVQktUv6u+/hFqX9bRzbpXzeh946hcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081723;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1qf6D2w3Mp9MxIaAzMYblvLR2fR+LWXIi+I7MptclUk=;
	b=BMxAoffSgpp2jP1+V6LFT2OmurqQFofeIx9E1uosUAzKRiyZ6yCuBD6SAQ9hk8NYVLfq
	 PvwUSr0JHFBXdy7dvl15dnAoYFSjVgBhkY6xKzHob00hQUsVLnRe+2qjGUt46L3v/zdkn
	 ppgJvE2hgAaJtKiH9C+7x2BcTQzT/eVmS0xtR7cYjc1w1wKaKnU7UU5+kouc2WoA2gyHM
	 IZ4N2gGUlVzIQOZU6ZmKEgHFzChWskRlNRvjcwQwg7R0qTdEwQywDWY4NkELw7O1gQVCB
	 bb8SsvHZqrVAD7cscB2CiXqXMKQB0kGIKfICzrR5UpFh3srS0b1J6eZwLdRKoc2HDMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQ8kf8Mv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2517B606A326
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQ8kf8Mv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E68B1F0089F
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 20:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794081722;
	bh=1qf6D2w3Mp9MxIaAzMYblvLR2fR+LWXIi+I7MptclUk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=cQ8kf8MvZg07XXyf7YtOVFPV2//fhWTgqfEZ0gIKhPEcHrWwk/hnMxg4Bf1kPXgpi
	 +zaRlFBhEsa+LpwJzKBMWpAS918nbQCdqGNcST0cFYeJlIzd/7ZeNyaQSU7IMjuS1a
	 vYFO3xDVrabQQwQ1DbHKFtzkEmwygPsQmgG8a6tPFmd4JnBDhlbRUgCm2L5LuHppST
	 rj1SVkMlrxh2GvAaoyX+XA7xJr5Q1tzSqKP4mFcNDtOJ5k9zGNH/QOfPXHgQifbzKF
	 hdBRuPHjV4tDOvBsoqZrsM8f9nAeup+zojAEcFBS+U26/ezsIbmZCmSQR6SyvNToqP
	 WI4MS2wUbakRg==
Message-ID: <sashiko-outbox-203241@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] evm: fix TOCTOU heap OOB in protected xattr reads
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261107194909.1061154-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261107194909.1061154-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 20:02:02 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] evm: incomplete TOCTOU bounds check in
  evm_read_protected_xattrs()
--

commit 94961f480ee0e6be15409d6ea100ede9af939446
Author: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

evm: fix TOCTOU heap OOB in protected xattr reads

This commit adds bounds checks in evm_read_protected_xattrs() to reject
protected xattr names, lengths, and values that no longer fit in the
caller's buffer if an xattr changes between the size query and the read.

> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/e=
vm_main.c
> index b59e3f121b8a8..d00b050edb811 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
[ ... ]
> @@ -407,12 +415,17 @@ int evm_read_protected_xattrs(struct dentry *dentry=
, u8 *buffer,
>  		case 'v':
>  			size =3D rc;
>  			if (buffer) {
> +				if (total_size > buffer_size ||
> +				    size > buffer_size - total_size)
> +					return -ERANGE;
> +
>  				rc =3D __vfs_getxattr(dentry,
>  					d_backing_inode(dentry), xattr->name,
>  					buffer + total_size,
>  					buffer_size - total_size);
>  				if (rc < 0)
>  					return rc;
> +				size =3D rc;
>  			}
>  			break;

[Severity: Medium]
Can total_size still exceed buffer_size when total_size =3D=3D buffer_size =
and
an xattr grows from 0 bytes between the two __vfs_getxattr() calls?

When the first __vfs_getxattr() returns 0 for an empty xattr and
total_size =3D=3D buffer_size, the bounds check passes and the second
__vfs_getxattr() is called with a size argument of
buffer_size - total_size =3D=3D 0. Many filesystem xattr handlers (such as
btrfs_getxattr(), xfs_attr_copy_value(), and fuse_getxattr()) treat a zero
size argument as a length query rather than an empty buffer, so if the
xattr concurrently grew to N > 0 bytes, __vfs_getxattr() returns N instead
of -ERANGE.

Assigning size =3D rc then advances total_size to buffer_size + N, causing
ima_eventinodexattrs_init_common() -> ima_write_template_field_data() to
memcpy() past the end of buffer (or dereference ZERO_SIZE_PTR when
buffer_size =3D=3D 0). Skipping the second __vfs_getxattr() call when size =
=3D=3D 0
or checking that rc <=3D buffer_size - total_size would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107194909.1061=
154-2-Jeremy.Jean@oss.cyber.gouv.fr?part=3D1
