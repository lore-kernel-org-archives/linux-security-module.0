Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795306258;
	b=RMXChvEzeGxOU7TrjgDEP6l6eElpZjtNki0+cbXhWKTLV8oyEx0cgfTQw3QsEG+5S+Dw
	 30dEEGAdaOhA8SEO/NW4M/bJA3hl5GEuSfHaPFaNwITYQEvpurk/RPHegY7yOq+GGWFF8
	 EqtTbxu0ZK9Fh0q3Qttf+YzpRCvYnCewy1ykOX0xJIsyIA2doZLACzy8AY3SZRp8yYkBp
	 7mhx2g+AiXb12ou74RmoOW4NRppUEK2SNSMJf+PuosCMttpPUO7hUBsb9aRGPGkqtbFF3
	 CvQZXdBXNloAum1MJ5eVvo5AYVi3DBxLKJFSNEc+shx7BaA8ERRZVLjf4cf1GlKFyCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795306258;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EbgxOiqmmBi3yewFZr5b+07XHs7HwSgwp25qc8+WQwE=;
	b=UlwFyPFTac1SWyrNvwYRKt0WgDvXNJj+ytFe7C7fKC1/9MiODs7I5bYQe/fNxk3ZOoLB
	 iPp49xQt1k0rg47Jb2ByI3XLwyxVVKQXg3uja+39P49swvyTJhRB5b50R6HYk+TJBXtMo
	 e/19fYHQ2pRXNAp0tqD/pNwBIdqJIjCQ5j3oOaQAA0qMAea9TGoVPkxa/YhdVE6LigsX0
	 rHo0xP97coqUAQUt/wqWoLIf6Q1swkI/9R6kV5H+xfDkWU5aTSmKHeebD9d4Dtn0+AoBE
	 CeNC7pABhVuYjwNjLODEZiCd7tZet9Ze909n4cjkrv+MEQhTxgbRlxejm90T9nmy8Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QpDPTYxN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061F3606A320
	for <linux-security-module@vger.kernel.org>; Sun, 22 Nov 2026 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QpDPTYxN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0326C1F000C6;
	Sun, 22 Nov 2026 00:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795306257;
	bh=EbgxOiqmmBi3yewFZr5b+07XHs7HwSgwp25qc8+WQwE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QpDPTYxNZ0dyL/3bfX9WdEbiawhUbKYzJu4rS35Zu+XQDdfqJAA8ZWLVlNTgXMLic
	 dAoFwzVzgB+nU85nwnqGUjJzzt+bMcqtGmclTeXZAG0iB2X0jP6MgI1fH3sOhdjp5P
	 E4PoLpxAeJMrUg2b4EeGjg1QOBDjtTuJ/jFhqtFwBvneDDcYODTv3CqJ1s73i4rrGM
	 k4aac75BzIshiZN6V7ViWC7oZNg6oatS+/1CoiVfDG0TjyT7DR20UhK88JpKo+l/1b
	 nT1bnDgGVecQYzfvg50xZFFjpuzfMj2f7e8jRpmMcBerZtUjQA6sEHcXO/ETFgs5NM
	 QwidqMAjJDvgQ==
Message-ID: <sashiko-outbox-227542@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 07/25] mount: Support MOVE_MOUNT_CLONE with
 MOVE_MOUNT_T_MNTNS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Alexander
 Mikhalitsyn" <alex@amutable.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Andy
 Lutomirski" <luto@amacapital.net>, "Christian Brauner" <brauner@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Jan Kara" <jack@suse.cz>, "Jonathan Corbet" <corbet@lwn.net>, "Josef
 Bacik" <josef@toxicpanda.com>, "Kees Cook" <kees@kernel.org>, "Neal Gompa" <neal@gompa.dev>, "Paul
 Moore" <paul@paul-moore.com>, "Serge Hallyn" <sergeh@kernel.org>, "Zygmunt
 Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261121000844.1863324-8-jarkko@kernel.org>
References: <20261121000844.1863324-1-jarkko@kernel.org>
 <20261121000844.1863324-8-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 00:10:56 +0000
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
- [Medium] mount: missing SB_NOUSER check in do_move_mount() for
  MOVE_MOUNT_CLONE
--

commit 0d056169d39e8a161d1951b83a6a28ab91fbc2ea
Author: Jarkko Sakkinen <jarkko@kernel.org>

mount: Support MOVE_MOUNT_CLONE with MOVE_MOUNT_T_MNTNS

This commit adds MOVE_MOUNT_CLONE for use with MOVE_MOUNT_T_MNTNS so
move_mount() can recursively loopback-clone a path from the caller's mount
namespace directly into a target mount namespace file descriptor.

> diff --git a/fs/namespace.c b/fs/namespace.c
> index b65f1fdd92811..1e7d776c09660 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
[ ... ]
> @@ -3835,6 +3833,35 @@ static int do_move_mount(const struct path *old_pa=
th,
>  			if (m =3D=3D target_mnt_ns->root)
>  				return beneath ? -EINVAL : -EBUSY;
>  		}
> +		if (flags & MNT_TREE_CLONE) {
> +			unsigned int copy_flags;
> +
> +			if (!check_mnt(old) || old->mnt_ns =3D=3D target_mnt_ns)
> +				return -EINVAL;
> +			src_user_ns =3D old->mnt_ns->user_ns;
> +			copy_flags =3D (target_mnt_ns->user_ns !=3D src_user_ns) ?
> +				     (CL_SLAVE | CL_COPY_UNBINDABLE) :
> +				     CL_COPY_MNT_NS_FILE;
> +			cloned =3D __do_loopback(old_path, true, copy_flags);
> +			if (IS_ERR(cloned))
> +				return PTR_ERR(cloned);
> +			old =3D cloned;
> +			if (d_is_symlink(old->mnt.mnt_root)) {
> +				err =3D -EINVAL;
> +				goto out_cloned;
> +			}

[Severity: Medium]
Does this allow cloning and attaching an SB_NOUSER mount such as the
caller's base nullfs mount?

do_loopback() pairs __do_loopback() with graft_tree(), which rejects
SB_NOUSER mounts, and the non-cloning check_mnt(old) branch below rejects
!mnt_has_parent(old).  Here __do_loopback() is followed directly by
attach_recursive_mnt().  If old_path resolves to a mount namespace's base
nullfs mount (for example via an O_PATH fd or a pre-init root) and is
cloned onto "/" of an empty target_mnt_ns, a second nullfs mount is
attached on top of target_mnt_ns->root, causing mnt_ns_get_root() to treat
it as a live root filesystem and permanently blocking subsequent rootfs
installation on target_mnt_ns with -EBUSY.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121000844.1863=
324-1-jarkko@kernel.org?part=3D7
