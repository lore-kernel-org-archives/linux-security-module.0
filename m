Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795306256;
	b=1M5lbnB2Xpre9ggMZMRfex9xCAr/3SrhI3nLZEqP8Q+lbL720WwosRmndxRQBU4LFaWI
	 Wm0tGdYkEU1dodbA8pcjwHoDtd+DXb70BhAh+Sz3U3evvTh1C1D64uCtBKAtNN89eUE2l
	 4PlfXqcovNhz99EaUsZBaJOP71+OoS9hc1LqLRZJW2f/SJEHtNCUrigp6nYturvlsdpna
	 fKBfGlWyyIxjLipBpwNpT/RXFYBvn4Fi+CuJLuLmCD50BZyCVaTnhJ/blx0mL2wLJaY4y
	 ydUT4XypjZ6T5aTiFLForO7ix5oFh00htb1W8ncwxVVMbqHkSGiMpG0sN48msoDyBBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795306256;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s3oqHKKaMc4jz8f4vxbyN/0+IPUCihsP+4tQ8YCz0nQ=;
	b=WT7BQIIlKZ/nUslMfrpz/7OX7eMgSY4VM46IyqFeRG5MgRvDbYtTXLIaAZjB1nuJOTom
	 kb6xH9AuwTA8YaSOEhL7fhzgX3BdpDGumtW3rVVlFd9YNBe1IjYDRQgX/pXimmyrYLaPd
	 5Yyz2W4DIprIjaopL6+51j/3l7rtuQJXzOfn56UHxEY8JyMqffkhvQbwl5XFmWqWoN+Cb
	 RiMaMICHdDg1sw7wRLblBJ/qRH/lnX9RzVLmWFJ422VOmHEH1LywD0uzNzEj2VkToTCPC
	 I4j88loxlh7e+ryVibK8bSHz4RQp2zD+VHIwof91YYir/0dCYtt8tpeMTEjvnScSN9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nWkOOfqm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3EF606A320
	for <linux-security-module@vger.kernel.org>; Sun, 22 Nov 2026 00:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nWkOOfqm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C451F000C0;
	Sun, 22 Nov 2026 00:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795306256;
	bh=s3oqHKKaMc4jz8f4vxbyN/0+IPUCihsP+4tQ8YCz0nQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nWkOOfqmIL5Mm1bLeZK0VEN57SsUekCLltzuBfJSpeyK6F0lQZ6HpdlCmVWT712Sz
	 /SyiNBHQd6GFHU8eUl6RBjmqAiRcNAAlSLQy8Id1wK2PKZzeF0XuQSf0zFZ8AG6+s4
	 ZOMlYzZxGWV5SXTal8klHGwxqglveAKpAWK5OChtT4Lda1E8kv/dnkS07RQytBqU6o
	 jS8pixp6q9yTWiDryQ5qUfrfbFJsR3mT1a1ZtgGa15t8zrTEBxlFHsktHVtemEkfUm
	 SKVOtfJ/3V20orVOjqcZ1gdpkhSwRyUHY4TbZ9Ursv/wNL2yzynIpJWAJJEdhR2vwF
	 rIdRsR6dUf7Dg==
Message-ID: <sashiko-outbox-227541@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 06/25] mount: Support MOVE_MOUNT_T_MNTNS in
 move_mount()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Alexander
 Mikhalitsyn" <alex@amutable.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Andy
 Lutomirski" <luto@amacapital.net>, "Christian Brauner" <brauner@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Jan Kara" <jack@suse.cz>, "Jonathan Corbet" <corbet@lwn.net>, "Josef
 Bacik" <josef@toxicpanda.com>, "Kees Cook" <kees@kernel.org>, "Neal Gompa" <neal@gompa.dev>, "Paul
 Moore" <paul@paul-moore.com>, "Serge Hallyn" <sergeh@kernel.org>, "Zygmunt
 Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261121000844.1863324-7-jarkko@kernel.org>
References: <20261121000844.1863324-1-jarkko@kernel.org>
 <20261121000844.1863324-7-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 00:10:55 +0000
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
- [High] fs: namespace: broken cross-userns locking in
  attach_recursive_mnt()
--

commit 74ae0b488300551c347e9b244e2d68e31f9a48cf
Author: Jarkko Sakkinen <jarkko@kernel.org>

mount: Support MOVE_MOUNT_T_MNTNS in move_mount()

This commit adds the MOVE_MOUNT_T_MNTNS flag to move_mount() to allow
attaching detached anonymous mount trees directly into a target mount
namespace specified by an nsfs file descriptor.

> diff --git a/fs/namespace.c b/fs/namespace.c
> index b2dc84c0d0d66..b65f1fdd92811 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c

[ ... ]

> @@ -2641,6 +2652,7 @@ static int attach_recursive_mnt(struct mount *sourc=
e_mnt,
>  	struct user_namespace *user_ns =3D ns->user_ns;
>  	struct pinned_mountpoint root =3D {};
>  	struct mountpoint *shorter =3D NULL;
> +	struct mnt_namespace *src_ns;
>  	struct mount *child, *p;
>  	struct mount *top;
>  	struct hlist_node *n;
> @@ -2662,6 +2674,9 @@ static int attach_recursive_mnt(struct mount *sourc=
e_mnt,
>  		user_ns =3D current->nsproxy->mnt_ns->user_ns;
>  	else
>  		user_ns =3D ns->user_ns;
> +	src_ns =3D moving ? NULL : source_mnt->mnt_ns;
> +	if (move_mntns && src_ns)
> +		user_ns =3D src_ns->user_ns;
> =20
>  	/*
>  	 * Preallocate a mountpoint in case the new mounts need to be
> @@ -2728,8 +2743,12 @@ static int attach_recursive_mnt(struct mount *sour=
ce_mnt,
>  		struct mount *q;
>  		hlist_del_init(&child->mnt_hash);
>  		/* Notice when we are propagating across user namespaces */
> -		if (child->mnt_parent->mnt_ns->user_ns !=3D user_ns)
> +		if (child->mnt_parent->mnt_ns->user_ns !=3D user_ns) {
>  			lock_mnt_tree(child);
> +			if ((move_mntns || is_anon_ns(ns)) &&
> +			    list_empty(&child->mnt_expire))
> +				child->mnt.mnt_flags |=3D MNT_LOCKED;
> +		}
>  		q =3D __lookup_mnt(&child->mnt_parent->mnt,
>  				 child->mnt_mountpoint);
>  		commit_tree(child);

[Severity: High]
Does overwriting user_ns with src_ns->user_ns break cross-user-namespace
mount locking when source_mnt is attached via MOVE_MOUNT_T_MNTNS?

move_mount_mntns() checks CAP_SYS_ADMIN in target_mnt_ns->user_ns
(ns->user_ns), not src_ns->user_ns.  When src_ns->user_ns differs from
ns->user_ns (for example, an anonymous mount created in a less-privileged
user namespace U2 is attached by a manager into a mount namespace owned by
U1) and dest_mnt propagates to a slave mount in a namespace owned by U2,
child->mnt_parent->mnt_ns->user_ns =3D=3D user_ns (both U2).
lock_mnt_tree(child) is then skipped on the copy propagated from U1 into
U2, leaving MNT_READONLY, MNT_NOSUID, MNT_NODEV, MNT_NOEXEC, and submounts
unlocked in U2.

In the same case, for the primary mount (child =3D=3D source_mnt) attached
into target_mnt_ns, child->mnt_parent->mnt_ns->user_ns (U1) !=3D user_ns
(U2) is true, which locks source_mnt with MNT_LOCKED inside the privileged
target_mnt_ns itself.  Also, checking move_mntns unconditionally for all
entries in tree_list sets MNT_LOCKED on the root of every cross-userns
propagated copy (child !=3D source_mnt), preventing slave namespaces from
unmounting propagated mounts that did not cover an existing locked mount.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121000844.1863=
324-1-jarkko@kernel.org?part=3D6
