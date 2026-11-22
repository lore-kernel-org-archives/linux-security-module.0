Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795377757;
	b=H5cL+YTvDZW5Jb6VtLvEJyOpR6fcRBcmRmUhd1fNaAOmAE70eRToduKZoRIrD1S+6CP3
	 HD+yBxHkIkdFJbSIwKAYqCqCmZdJSpwmkwAxm1XgdlkW9dyujPO6/PRxjyY+LQP26KqO2
	 PUprDAFjRMkJ5mPXtngJ/s0R0YEPWRj3hJxSmP4cn3sOsoabUBqWani4UvCK19Lgy2YZ7
	 keWH6bDPqh1nA+Nru5lw4w5ix0nFlDhJ8yo4U97O85Gs4oCWNPTxDnFTrMBDolX0eVQ3x
	 VQEvqjtDEcs4VjEdNXHFyV5LLYAfoaH2yvPWES7PpCChxojzSfr7vgiQaXDt1wmWnZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795377757;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JaJjkwdjsuthCIR31B8yCOpvVbzH1az3i0dKy7BlJwI=;
	b=AVVPR7jjBJdAt326t0tM8gqIyz1z+jcup9sncZ5vFSrf+OqvCKrtdMVYfiKlCBwrYEec
	 q67uinC9cHIYG84bV7yAUqyu8/oRlKDF9Ip2Wr27a6ehEvfmn7oCbDJdtxXg4s++/4dbG
	 cv97i/k9VIp3qCu3ugTchymefx60lLjFrCoY9fOG9jndM0YgMTB8EtYjMV+mlr921Qfsk
	 gxLfNXWU3vL9Umx0+JR9p2syATL5k0CO6t6EMLN97FmMKAMudE/0wsxA/YomahADaC92m
	 ek6b4LvFJbTh6O6V3A+QmcZyBm+DM/cs0VgadvIQCdodTX15Z6z0heiP/GIKi3IRe/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iYDuuwsM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD210606A31A;
	Sun, 22 Nov 2026 20:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iYDuuwsM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8511F000C4;
	Sun, 22 Nov 2026 20:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795377757;
	bh=JaJjkwdjsuthCIR31B8yCOpvVbzH1az3i0dKy7BlJwI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iYDuuwsMu6QqZhpSArwN97LlxRt4YeKDxUs+o2Nn5r3yIABQmHIMyV9K7e2yRsVfo
	 GN+H3WMaZJPYo2jFkVt7t1+dqhDMSPmXyW5X3osUTUJJqCMADnu1rOypIhaA4nwziG
	 /ugW+Y1lfibrU2igij3QthyRHY4X1VfrX2cSrdhF4Z/SgM4hjm+BnlwnPL6pr/EyIn
	 NRPsMgqa3uiX5Gamvq+LHrUhCcc75fLKA5XT/RmX0qNBDYCI0yaGG9omsHWngRL5ro
	 dq7RtmddyliPPihPBmWojLUn04dom2+QoWcDzTQzttPVN0zKtLR6L0hNC7AgVgKOzL
	 j2CvGCoaL6XZg==
Message-ID: <sashiko-outbox-228306@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v7 06/26] mount: Support MOVE_MOUNT_T_MNTNS in
 move_mount()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Aleksa
 Sarai" <aleksa@amutable.com>, "Alexander Mikhalitsyn" <alex@amutable.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Andy Lutomirski" <luto@amacapital.net>, "Arnd
 Bergmann" <arnd@arndb.de>, "Christian Brauner" <brauner@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Eric Biggers" <ebiggers@kernel.org>, "Giuseppe
 Scrivano" <giuseppe@scrivano.org>, "Hugh Dickins" <hughd@google.com>, "Jan
 Kara" <jack@suse.cz>, "Jeff Layton" <jlayton@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Josef
 Bacik" <josef@toxicpanda.com>, "Kees Cook" <kees@kernel.org>, "KP Singh" <kpsingh@kernel.org>, "Lennart
 Poettering" <lennart@poettering.net>, "Neal Gompa" <neal@gompa.dev>, "Oleg
 Nesterov" <oleg@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "Pavel
 Tikhomirov" <ptikhomirov@virtuozzo.com>, "Serge Hallyn" <sergeh@kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Zygmunt Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261122193539.3334213-7-jarkko@kernel.org>
References: <20261122193539.3334213-1-jarkko@kernel.org>
 <20261122193539.3334213-7-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 20:02:32 +0000
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
- [High] fs: propagate_mnt() before lock_mnt_tree() in
  attach_recursive_mnt()
--

commit 1a941bfde892dcdbb8ea855a00043b140fa232a3
Author: Jarkko Sakkinen <jarkko@kernel.org>

mount: Support MOVE_MOUNT_T_MNTNS in move_mount()

This commit adds MOVE_MOUNT_T_MNTNS to move_mount() so that detached
anonymous mount trees can be attached directly into a target mount
namespace specified by an nsfs file descriptor.

> diff --git a/fs/namespace.c b/fs/namespace.c
> index 1bb9f90a65239..93dd11da7e734 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
[ ... ]
> @@ -2725,11 +2738,22 @@ static int attach_recursive_mnt(struct mount *sou=
rce_mnt,
>  	hlist_add_head(&source_mnt->mnt_hash, &tree_list);
> =20
>  	hlist_for_each_entry_safe(child, n, &tree_list, mnt_hash) {
> +		struct user_namespace *child_user_ns =3D
> +			child->mnt_parent->mnt_ns->user_ns;
> +		bool cross_child_src =3D cross_src &&
> +				       !in_userns(child_user_ns, src_user_ns);
>  		struct mount *q;
> +
>  		hlist_del_init(&child->mnt_hash);
> -		/* Notice when we are propagating across user namespaces */
> -		if (child->mnt_parent->mnt_ns->user_ns !=3D user_ns)
> +		/*
> +		 * Notice when we are propagating or attaching a foreign
> +		 * source tree across user namespaces.
> +		 */
> +		if (child_user_ns !=3D user_ns || cross_child_src) {
>  			lock_mnt_tree(child);
> +			if (cross_child_src && list_empty(&child->mnt_expire))
> +				child->mnt.mnt_flags |=3D MNT_LOCKED;
> +		}

[Severity: High]
Does running lock_mnt_tree() after propagate_mnt() allow copy_tree() to
strip covering nsfs submounts from propagated copies when attaching a
tree across user namespaces with MOVE_MOUNT_T_MNTNS?

Earlier in attach_recursive_mnt(), when dest_mnt is shared,
propagate_mnt() clones source_mnt via copy_tree() without
CL_COPY_MNT_NS_FILE:

fs/namespace.c:copy_tree() {
    ...
			if (!(flag & CL_COPY_MNT_NS_FILE) &&
			    is_mnt_ns_file(src_mnt->mnt.mnt_root)) {
				if (src_mnt->mnt.mnt_flags & MNT_LOCKED) {
					/* Both a mount namespace file and locked. */
					dst_mnt =3D ERR_PTR(-EPERM);
					goto out;
				}
				src_mnt =3D skip_mnt_tree(src_mnt);
				continue;
			}
    ...
}

When a manager in an ancestor user namespace (src_user_ns) clones a tree
containing an unlocked nsfs submount via open_tree(OPEN_TREE_CLONE |
AT_RECURSIVE) and attaches it into a less privileged target_mnt_ns onto a
mount that an admin in target_mnt_ns->user_ns has made MS_SHARED,
source_mnt's submounts do not have MNT_LOCKED set yet when
propagate_mnt() runs.  Instead of failing with -EPERM, copy_tree() skips
the nsfs submount on the peer or slave copies, revealing whatever was
masked beneath it in target_mnt_ns.

Locking source_mnt before calling propagate_mnt() when cross_src is true
would ensure copy_tree() sees MNT_LOCKED on the submounts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122193539.3334=
213-1-jarkko@kernel.org?part=3D6
