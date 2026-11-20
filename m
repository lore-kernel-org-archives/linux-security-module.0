Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795214692;
	b=y5BxDMF/mPV4EcReUVuA/129a3QjZD0NY/w5vUHbI0seH6cTGq5zxKvB96dJntPjKR+1
	 gjUQNsMpPskJ9nZPyllPD0vYOefS8j9IH2CqZMkQQYIGaZ5IN50XYjZ9pVqWdFZOQLraO
	 tFp56AIVGvSgWqBh6RHvSpvuzy8MmOzATqF1D0BLlK/dVTGPluMUt1vCNNRhiBb5uO7eC
	 BAxqkByJHi0QurTXOA9AmvZbSUybAXaI/ZjkL1mPISEt5P0jAgKlyFJcI2RjPXUDzaNm6
	 X0Jc2f5JxkOk7yT/TO3p+JNz3vjO1W0MEbs3KhGWexoE0RGhmOXQyjnJVV0CVPES0Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214692;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CQuR/rEK9xvDJFqiz1UABVYdb4hEzkHLUCVdirqFjdI=;
	b=v5d8J3k4yZiJtxdeRYHU/iWEfYQlVt7UXZ+OXp64wTa8hvkx6xe/3eUqKH+7Vo/11Vp7
	 kZGewXvYl4Ojr/AR9jc1OVeQIRtRMfc0jhcDsLs5XhxWeJSf2JpKKrxkpHP7sP6QEQw+X
	 p8ZPq20siTuldN8vRz8d3Wcr1AcNw2OphY9Drr1AEjHL8+7ythA0mz4S1TCW7JQgo4wU3
	 GXkBDYy4Z+fASbOOmMcAkdB73BaFf+Ztr1NV7uVp+4SW8hsFhwewbOJpJ3/hmSZ60A75A
	 3LZz5mG23NeaNQURgP1Ba/wmBzzH9WdK1WKYT99IjfLgikWdP10u17lfFd0t/F7tEmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FHjb350R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82565606A694
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FHjb350R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7681F000D8;
	Fri, 20 Nov 2026 22:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795214692;
	bh=CQuR/rEK9xvDJFqiz1UABVYdb4hEzkHLUCVdirqFjdI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FHjb350RwdNDx+9XuxWJKnHSqDA9YpQtSsjVFqc5E/Z2DizU/rETAQCu+K6C4UQMw
	 vJwKkDcVgW5PB4n+A5c9zJvU/QP4l4tJh45s0+W0RsNAdfjNeOtm3v9dLn/pajZQz6
	 QaNsDlA0dPYdtiX6FaKpemMRh/bPS1Aa+aI315I2S9uJGjLxs929UVu7EQRtnguBaQ
	 XmaEX1qKmqHj9Nss5jQXzZN9UgQOcwhWPoKWl9DcAcYgcSS9FPO/mlsF4+H+p4rVpJ
	 ddeL+H/Pi2P2rGjrGj+7+AQPpF7Dk1aOkW1mkyHni3cZYWcJPXhVfnQeCMSkFM6L35
	 7QPTv0XAAeqpw==
Message-ID: <sashiko-outbox-226301@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 09/14] fs: Support MOVE_MOUNT_T_MNTNS in
 move_mount()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Andreas Larsson" <andreas@gaisler.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Andy Lutomirski" <luto@amacapital.net>, "Andy
 Lutomirski" <luto@kernel.org>, "Anna-Maria Behnsen" <anna-maria@linutronix.de>, "Arnd
 Bergmann" <arnd@arndb.de>, "Ben Segall" <bsegall@google.com>, "Borislav
 Petkov" <bp@alien8.de>, "Casey Schaufler" <casey@schaufler-ca.com>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Christian
 Brauner" <brauner@kernel.org>, =?utf-8?b?Q2hyaXN0b3BoZSBMZXJveSAoQ1Mg?=
 =?utf-8?b?R1JPVVAp?= <chleroy@kernel.org>, "Chris Zankel" <chris@zankel.net>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, "David Hildenbrand" <david@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Davidlohr Bueso" <dave@stgolabs.net>, "David
 S. Miller" <davem@davemloft.net>, "Dietmar Eggemann" <dietmar.eggemann@arm.com>, "Frederic
 Weisbecker" <frederic@kernel.org>, "Geert Uytterhoeven" <geert@linux-m68k.org>, "Hallgrimur
 H. Gunnarsson" <halg@google.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Helge
 Deller" <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@redhat.com>, "James
 E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, "Jan Kara" <jack@suse.cz>, "John
 Johansen" <john.johansen@canonical.com>, "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "Jonathan
 Corbet" <corbet@lwn.net>, "Josef Bacik" <josef@toxicpanda.com>, "Juri Lelli" <juri.lelli@redhat.com>, "Kees
 Cook" <kees@kernel.org>, "K Prateek Nayak" <kprateek.nayak@amd.com>, "Liam
 R. Howlett" <liam@infradead.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, "Magnus Lindholm" <linmag7@gmail.com>, "Manfred
 Spraul" <manfred@colorfullife.com>, "Mark Rutland" <mark.rutland@arm.com>, "Matt
 Turner" <mattst88@gmail.com>, "Max Filippov" <jcmvbkbc@gmail.com>, "Mel
 Gorman" <mgorman@suse.de>, "Michael Ellerman" <mpe@ellerman.id.au>, "Michal
 Hocko" <mhocko@suse.com>, "Michal Simek" <monstr@monstr.eu>, "Mike Rapoport" <rppt@kernel.org>, "Neal
 Gompa" <neal@gompa.dev>, "Nicholas Piggin" <npiggin@gmail.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Paul Moore" <paul@paul-moore.com>, "Paul
 Walmsley" <pjw@kernel.org>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, "Rich Felker" <dalias@libc.org>,
 =?utf-8?b?Uml0ZXNoIEhhcmphbmkgKElCTSk=?= <ritesh.list@gmail.com>, "Russell
 King" <linux@armlinux.org.uk>, "Serge Hallyn" <sergeh@kernel.org>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Suren Baghdasaryan" <surenb@google.com>, "Sven
 Schnelle" <svens@linux.ibm.com>, "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Thomas
 Gleixner" <tglx@kernel.org>, "Valentin Schneider" <vschneid@redhat.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Vincent Guittot" <vincent.guittot@linaro.org>, "Vincenzo
 Frascino" <vincenzo.frascino@arm.com>, "Vlastimil Babka" <vbabka@kernel.org>, "Will
 Deacon" <will@kernel.org>, "Yoshinori Sato" <ysato@users.sourceforge.jp>, "Zygmunt
 Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261119224312.1037966-10-jarkko@kernel.org>
References: <20261119224312.1037966-1-jarkko@kernel.org>
 <20261119224312.1037966-10-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 22:44:48 +0000
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
- [High] fs: cross-userns mount locking bypass in attach_recursive_mnt()
--

commit 5e90ce5c3ee9b66d7c6a41077c19c225ae139217
Author: Jarkko Sakkinen <jarkko@kernel.org>

fs: Support MOVE_MOUNT_T_MNTNS in move_mount()

This commit adds the MOVE_MOUNT_T_MNTNS flag to move_mount() so that
detached anonymous mount trees can be attached directly into a target
mount namespace specified by an nsfs file descriptor.

> diff --git a/fs/namespace.c b/fs/namespace.c
> index dfe0ee9ecdcd0..36ed48c3f6467 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
[ ... ]
> @@ -2632,7 +2642,8 @@ enum mnt_tree_flags_t {
>   *         Otherwise a negative error code is returned.
>   */
>  static int attach_recursive_mnt(struct mount *source_mnt,
> -				const struct pinned_mountpoint *dest)
> +				const struct pinned_mountpoint *dest,
> +				bool move_mntns)
>  {
>  	struct mount *dest_mnt =3D dest->parent;
>  	struct mountpoint *dest_mp =3D dest->mp;
> @@ -2641,6 +2652,7 @@ static int attach_recursive_mnt(struct mount *sourc=
e_mnt,
>  	struct user_namespace *user_ns =3D ns->user_ns;
>  	struct pinned_mountpoint root =3D {};
>  	struct mountpoint *shorter =3D NULL;
> +	struct mnt_namespace *src_ns;
>  	struct mount *child, *p;
>  	struct mount *top;
>  	struct hlist_node *n;
> @@ -2662,6 +2674,7 @@ static int attach_recursive_mnt(struct mount *sourc=
e_mnt,
>  		user_ns =3D current->nsproxy->mnt_ns->user_ns;
>  	else
>  		user_ns =3D ns->user_ns;
> +	src_ns =3D moving ? NULL : source_mnt->mnt_ns;
> =20
>  	/*
>  	 * Preallocate a mountpoint in case the new mounts need to be
> @@ -2694,6 +2707,12 @@ static int attach_recursive_mnt(struct mount *sour=
ce_mnt,
>  	if (err)
>  		goto out_cleanup_ids;
> =20
> +	if (move_mntns && src_ns && src_ns->user_ns !=3D user_ns) {
> +		lock_mnt_tree(source_mnt);
> +		if (list_empty(&source_mnt->mnt_expire))
> +			source_mnt->mnt.mnt_flags |=3D MNT_LOCKED;
> +	}

[Severity: High]
Does calling lock_mnt_tree(source_mnt) after propagate_mnt() leave
secondary copies unlocked when MOVE_MOUNT_T_MNTNS attaches a tree onto a
shared destination mount across user namespaces?

When IS_MNT_SHARED(dest_mnt) is true, propagate_mnt() clones source_mnt
into tree_list before source_mnt is locked here, so the clones do not
inherit MNT_LOCK_* or MNT_LOCKED (and copy_tree() silently skips unlocked
nsfs submounts instead of failing with -EPERM).  Then the tree_list loop
checks:

fs/namespace.c:attach_recursive_mnt() {
	...
	hlist_for_each_entry_safe(child, n, &tree_list, mnt_hash) {
		struct mount *q;
		hlist_del_init(&child->mnt_hash);
		/* Notice when we are propagating across user namespaces */
		if (child->mnt_parent->mnt_ns->user_ns !=3D user_ns)
			lock_mnt_tree(child);
	...
}

Because user_ns is dest_mnt->mnt_ns->user_ns rather than src_ns->user_ns,
secondary copies propagated to peer or slave mounts in the target user
namespace match user_ns and skip lock_mnt_tree(child), allowing root in
the target user namespace to unmount masking submounts or clear read-only,
nosuid, nodev, and noexec flags.

In addition, if a foreign anonymous mount from another user namespace was
previously attached via regular move_mount() as a submount of an anonymous
mount tree already owned by the target user namespace, commit_tree() set
the submount's mnt_ns to the anonymous tree without setting MNT_LOCKED on
that submount's root, and attaching the anonymous tree with
MOVE_MOUNT_T_MNTNS skips lock_mnt_tree() because src_ns->user_ns already
equals user_ns.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119224312.1037=
966-1-jarkko@kernel.org?part=3D9
