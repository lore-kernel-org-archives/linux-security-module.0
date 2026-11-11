Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794430981;
	b=BQ7MTEi9lBwjv4e4pVZyz+oqkBZIH4d9ieJKxGzKHWoRMBSmS9rr77rwafcS7KpxKidE
	 yKLcyAdWCgbwlyxyvwKbdtVwFICrK51Wc+pfz9tPonuqLNtA5ya7RgIq57SSwdxmJBGYy
	 ndIAI0D719keVFrhaByk/bkKbVRI2W1RZJJuYu1HKDzhZCRwMm6DwI8Rx6TbyAdwd0q/w
	 ACK/vpqAl2WeHMhKW1g3oMMIOv2OSjwnsDzCxObQvOq0v+inE13K3MAiut1FOOLxexyR9
	 tioi75W5u+JCxmF9d6FPJVz7ocaMTum3Lg8JU7lwZ/SLOMvdfTl3MN2ywXlD2LXX4CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430981;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3/+DBhzKKsytFwjmyP6QEA2aYlik6COKTU0ZmZMobLA=;
	b=IGcJ+TY0J/Zx7hZjcnVN4FvckZQHxpblrVBFFyv/9vt4s9VqEUauybS0eirN4C6AUPxr
	 XOqUtGVSHbTtVuMkCcNdclGHgYmGmDGnPgzOBVN1tVVhYbR4iU2XiQ+BJpbF/3SS/XLIN
	 alTc4OyDx0hvYmSzPfk2D3LA0E0UOgHVfETg3Lsm5bsIq4dCCFquGdGTiq4naJciAJhOb
	 Ldhb5D7nKeR0Atzo+ahvbn2teBJtNA+JawOcNOz3ogOtOdtERqioQVHNeKU/idmI91d5X
	 e4L0uMB8xyHM1HqEYDyfHrok7yCGoe4hlw83LyJUV8jTbSC7MClUmsWfJ7d3Uf6Rqdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F7Xb3Qot;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D71606A32A
	for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2026 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F7Xb3Qot
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B767E1F00A05
	for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2026 21:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794430981;
	bh=3/+DBhzKKsytFwjmyP6QEA2aYlik6COKTU0ZmZMobLA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=F7Xb3Qot19Tsq6u2nE0vhL26P4tc0TpiXwdFOIV+Gg/cz/3Lx7ccJlHYRlyNPm2Q1
	 +jsBekEEmKhpsIcBNECAgOX+29/OpjVfpNqysUZiEMC4o3NnIMpVkGw+V74yUboEMd
	 Lr31mBq831Iy6gHpeEsOs6fU6xW0L7p7M9rWDBjtt+LjCvq0+NCEKfhTrXu1dhYAEW
	 +ddXxVTzx48EFqdJFcVVeqZJR2wSZ7CbrmSiyTPzE6aXSJUxXVPeNQKhT/XczHytU8
	 TdzLsMeC1E6p5+N5NVlyTXeNziYQDE27/gL5StGNghrcWffZzXqHmkZ5i3k47TiHn9
	 SFsS0XbWfkN7w==
Message-ID: <sashiko-outbox-209685@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf, lsm: Mark backing_file_alloc/free LSM hooks as
 untrusted
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261111203614.1221188-1-snizovtsev@cloudlinux.com>
References: <20261111203614.1221188-1-snizovtsev@cloudlinux.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 21:02:58 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The backing_file_alloc and backing_file_free LSM hooks get the backing
> file as "struct file *backing_file", but its f_path is not populated
> while they run:
>=20
>  - security_backing_file_alloc() is called from init_backing_file() in
>    alloc_empty_backing_file(), before vfs_open() sets f_path, so
>    backing_file->f_path.dentry is NULL;
>  - security_backing_file_free() can run for a backing file whose open
>    failed and whose f_path was already cleared.
>=20
> Neither hook is listed in untrusted_lsm_hooks, so bpf_lsm_is_trusted()
> lets BPF LSM programs use the argument as a trusted pointer.  A program
> attached to lsm/backing_file_alloc can pass &backing_file->f_path to the
> trusted-args kfunc bpf_path_d_path(), and d_path() dereferences the NULL
> dentry on the first open of a file on overlayfs:
> [ ... ]
>=20
> Fixes: 6af36aeb147a ("lsm: add backing_file LSM hooks")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5-2
> Signed-off-by: Sergei Nizovtsev <snizovtsev@cloudlinux.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111203614.1221=
188-1-snizovtsev@cloudlinux.com?part=3D1

