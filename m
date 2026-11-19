Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117022;
	b=jZLv+//BCZX9+m5X1Y6hucVE+zzy5iTXoc0rlgq0BXU9RUoHSUqEn2gxUT6RiD13u2y3
	 PAtAZj50wKlWHAZsZKoudBGq2ZkUB04vmjchmHonz/lYAiOycwekneRSH7P1uYwZ9Y/sa
	 X8wIzzW2qMv4F+EJVUr8Zzw2XODvSaN3YdkWpJAIYm8OLw5hGJqrOBvCwSDylezywEFA6
	 N/0eEOxjiRrmsGBd+1q3aarGe960GEowemVV5rqMKLjJJTCkiDNDn+w7GzUIYfVFzmxvg
	 k6+FmZ71RDwQd7w5aDRAiQkXTuCMDQMrL90vP6YzpbujwLywJPaVQhfXCO4K0jly0rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117022;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vseJADEhUVR3qJjeERQiwT718kqYTn+mJBjn439uKzA=;
	b=WVovJJCvm/chDVfrMzGdE1f1lBd59+BEcPmfT9aBTwApEz0AAjnPgAGlpB35q/BVh1SF
	 +0SZwYaYFcli+ceBbdCT/IzLqvr7tQg3Kin1d0wFIy5mMSnRJQXHdcCEFee/fYXFPtcI8
	 BabFoGJb+/QFWI1jHjHNH2DvMoZdHzH4pv7C0A7j7AUIuch2eOMQ3luPIyfntPmbfFY8R
	 FxN0N9PyYUDDZ0V2nQnKrKaNPdWleq2zk7P/l3s0u4izP/2NlbzRyZPbOD6Pv2R0L/NnK
	 1x6/rPuXU592DnIOzL6glAXxrBvBOb1F2+pgBrhaGaspDR1furw6F/8A/J6GLq1/MLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSqRwwEJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD1660A2603
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSqRwwEJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65F51F000C4;
	Thu, 19 Nov 2026 19:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117021;
	bh=vseJADEhUVR3qJjeERQiwT718kqYTn+mJBjn439uKzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZSqRwwEJ8v4/msck0OfXw6FUg3Jt3gV/YlSN4DIMq1XeYrk2JkRDgNFgsE1N80bkU
	 rZ21PaBtXNKUfzL3wcF1Hn3VkOVldEg1rSLkmb2Til6VdQG6whARsqq1nEW1FbtF7O
	 EH7xYYae4R3l4EBUCDhqIz/L7jd90PxNi1kl1pDyhPeDEx4+eptmJFLS4MzbbIjLQ+
	 tJQkTgiRl2aYpNTQm+4FtsCQ48SgFtOdmeSCbXndys9b8jnRA6ehlBO5Dw8jTmZxVt
	 FEFY5/q7eEUJf0pNatAa/SbQBcdfa0wxeHAZA2akxGuny2LmNWL+H4vz2PDXX1olJO
	 hLIbMmL71OzlQ==
Message-ID: <sashiko-outbox-223951@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 09/13] fs: Support MOVE_MOUNT_T_MNTNS in
 move_mount()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "David Howells" <dhowells@redhat.com>
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Andrew Morton" <akpm@linux-foundation.org>, "Andy
 Lutomirski" <luto@amacapital.net>, "Anna-Maria Behnsen" <anna-maria@linutronix.de>, "Ben
 Segall" <bsegall@google.com>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "Davidlohr Bueso" <dave@stgolabs.net>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, "Frederic Weisbecker" <frederic@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Jan Kara" <jack@suse.cz>, "John Johansen" <john.johansen@canonical.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Juri Lelli" <juri.lelli@redhat.com>, "Kees Cook" <kees@kernel.org>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, "Liam R. Howlett" <liam@infradead.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Manfred Spraul" <manfred@colorfullife.com>, "Mel
 Gorman" <mgorman@suse.de>, "Michal Hocko" <mhocko@suse.com>, "Mike Rapoport" <rppt@kernel.org>, "Neal
 Gompa" <neal@gompa.dev>, "Paul Moore" <paul@paul-moore.com>, "Pavel
 Tikhomirov" <ptikhomirov@virtuozzo.com>, "Peter Zijlstra" <peterz@infradead.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Serge Hallyn" <sergeh@kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Thomas Gleixner" <tglx@kernel.org>, "Valentin
 Schneider" <vschneid@redhat.com>, "Vincent Guittot" <vincent.guittot@linaro.org>, "Vincenzo
 Frascino" <vincenzo.frascino@arm.com>, "Vlastimil Babka" <vbabka@kernel.org>, "Zygmunt
 Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261118193539.240065-10-jarkko@kernel.org>
References: <20261118193539.240065-1-jarkko@kernel.org>
 <20261118193539.240065-10-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:36:59 +0000
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
- [High] fs: broken cross-userns mount locking in attach_recursive_mnt()
- [High] fs: relative root-mount alias bypass and unlocked check in
  move_mount_mntns()
--

commit 444327893c38a5707689f91b2605debf89b46300
Author: Jarkko Sakkinen <jarkko@kernel.org>

fs: Support MOVE_MOUNT_T_MNTNS in move_mount()

This commit adds the MOVE_MOUNT_T_MNTNS flag to move_mount() to allow
attaching detached anonymous mount trees directly into a target mount
namespace identified by an nsfs file descriptor.

> diff --git a/fs/namespace.c b/fs/namespace.c
> index a6c0a31e275ae..2bd973a490d34 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
[ ... ]
> @@ -2639,6 +2648,7 @@ static int attach_recursive_mnt(struct mount *sourc=
e_mnt,
>  	HLIST_HEAD(tree_list);
>  	struct mnt_namespace *ns =3D dest_mnt->mnt_ns;
>  	struct user_namespace *user_ns =3D ns->user_ns;
> +	struct user_namespace *source_user_ns;
>  	struct pinned_mountpoint root =3D {};
>  	struct mountpoint *shorter =3D NULL;
>  	struct mount *child, *p;
> @@ -2662,6 +2672,8 @@ static int attach_recursive_mnt(struct mount *sourc=
e_mnt,
>  		user_ns =3D current->nsproxy->mnt_ns->user_ns;
>  	else
>  		user_ns =3D ns->user_ns;
> +	source_user_ns =3D (!moving && source_mnt->mnt_ns) ?
> +			 source_mnt->mnt_ns->user_ns : user_ns;
> =20
>  	/*
>  	 * Preallocate a mountpoint in case the new mounts need to be
> @@ -2730,6 +2742,12 @@ static int attach_recursive_mnt(struct mount *sour=
ce_mnt,
>  		/* Notice when we are propagating across user namespaces */
>  		if (child->mnt_parent->mnt_ns->user_ns !=3D user_ns)
>  			lock_mnt_tree(child);
> +		if (!is_anon_ns(child->mnt_parent->mnt_ns) &&
> +		    child->mnt_parent->mnt_ns->user_ns !=3D source_user_ns) {
> +			lock_mnt_tree(child);
> +			if (list_empty(&child->mnt_expire))
> +				child->mnt.mnt_flags |=3D MNT_LOCKED;
> +		}
>  		q =3D __lookup_mnt(&child->mnt_parent->mnt,
>  				 child->mnt_mountpoint);
>  		commit_tree(child);

[Severity: High]
Can cross-user-namespace mount locking be bypassed when a detached mount
tree is staged onto an anonymous mount before being attached to a target
mount namespace?

If an anonymous mount tree S owned by a privileged user namespace is
attached via move_mount() onto a subdirectory of an anonymous mount R
owned by a less-privileged user_ns_B (for example, created with
FSCONFIG_SET_ROOTNS or by a task in user_ns_B),
is_anon_ns(child->mnt_parent->mnt_ns) is true, so the new source_user_ns
check is skipped.  If the caller is in user_ns_B, user_ns is also
user_ns_B, so lock_mnt_tree() is not called either.  commit_tree(S) then
moves every mount in S into R->mnt_ns (owned by user_ns_B), so when R is
later attached into a mount namespace owned by user_ns_B,
source_user_ns =3D=3D user_ns_B and S is never locked, allowing tasks in
user_ns_B to unmount masked directories or clear read-only/nosuid/nodev/
noexec flags.

Conversely, when a privileged manager in init_user_ns attaches a submount
owned by user_ns_B onto an anonymous root mount R also owned by user_ns_B
(via FSCONFIG_SET_ROOTNS), is_anon_ns(ns) sets user_ns to init_user_ns
rather than ns->user_ns, so child->mnt_parent->mnt_ns->user_ns !=3D user_ns
spuriously locks the submount.

In addition, tree_list contains all secondary mounts created by
propagate_mnt(), and for normal mounts or automounts source_user_ns equals
user_ns.  Every secondary copy propagated into a non-anonymous mount
namespace in another user namespace therefore hits this block and gets
MNT_LOCKED set on its root even when q =3D=3D NULL (nothing was covered at
the mountpoint), preventing unprivileged users or shrink_submounts() from
unmounting uncovered propagated mounts.  And because source_user_ns is
computed unconditionally for all !moving mounts, regular move_mount()
without MOVE_MOUNT_T_MNTNS also locks detached trees intentionally handed
over across user namespaces via SCM_RIGHTS or inheritance, regressing
33aadc7c7205 ("namespace: handle mount locking for automounts correctly").

[ ... ]

> @@ -4751,6 +4778,127 @@ static inline int vfs_move_mount(const struct pat=
h *from_path,
[ ... ]
> +static int move_mount_mntns(int from_dfd, const char __user *from_pathna=
me,
> +			    int to_dfd, const char __user *to_pathname,
> +			    unsigned int flags, enum mnt_tree_flags_t mflags)
> +{
[ ... ]
> +		lflags =3D 0;
> +		if (flags & MOVE_MOUNT_T_SYMLINKS)
> +			lflags |=3D LOOKUP_FOLLOW;
> +		if (flags & MOVE_MOUNT_T_AUTOMOUNTS)
> +			lflags |=3D LOOKUP_AUTOMOUNT;
> +		ret =3D filename_lookup(AT_FDCWD, to_name, lflags, &to_path,
> +				      &mntns_root);
> +		if (ret)
> +			return ret;
> +		if (real_mount(to_path.mnt)->mnt_ns !=3D target_mnt_ns ||
> +		    to_path.mnt =3D=3D &target_mnt_ns->root->mnt)
> +			return -EINVAL;
> +		if (real_mount(to_path.mnt)->mnt_parent =3D=3D target_mnt_ns->root &&
> +		    to_path.dentry =3D=3D to_path.mnt->mnt_root)
> +			return (flags & MOVE_MOUNT_BENEATH) ? -EINVAL : -EBUSY;
> +	}
> +
> +	ret =3D lookup_move_mount_from(from_dfd, from_pathname, flags,
> +				     &from_path);
> +	if (ret)
> +		return ret;
> +
> +	return vfs_move_mount(&from_path, &to_path, mflags | MNT_TREE_MNTNS);
> +}

[Severity: High]
Does the root-mount alias check in move_mount_mntns() miss any target
mount namespace where more than one mount is stacked on
target_mnt_ns->root?

mnt_ns_get_root() follows the entire overmount chain on
target_mnt_ns->root (nullfs) to the topmost live root mount in
mntns_root.  Whenever two or more mounts are stacked on
target_mnt_ns->root (for example nullfs -> rootfs -> real_root in a
cloned namespace, or a root that has been overmounted), the live root
mount's mnt_parent is the intermediate mount rather than
target_mnt_ns->root.  A relative path such as "." or "subdir/.." then
resolves to mntns_root with mnt_parent !=3D target_mnt_ns->root, bypassing
this check and allowing the caller to overmount the namespace root or
mount beneath it with MOVE_MOUNT_BENEATH.

Also, filename_lookup() does not enforce LOOKUP_IS_SCOPED (or recheck
reachability from mntns_root under lock), so following a procfs magic link
inside target_mnt_ns can escape to a mount outside or beneath mntns_root.
Finally, these checks inspect to_path.mnt->mnt_ns and mnt_parent without
holding namespace_sem or mount_lock, and do_move_mount() only revalidates
MNT_TREE_MNTNS_INIT after locking the mountpoint; if a resolved submount
is concurrently pivoted to the root of target_mnt_ns before
do_lock_mount() acquires namespace_lock(), MOVE_MOUNT_BENEATH will attach
the new mount directly onto target_mnt_ns->root beneath the namespace
root.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118193539.2400=
65-1-jarkko@kernel.org?part=3D9
