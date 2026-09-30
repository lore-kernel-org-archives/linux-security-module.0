Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F4D3F58C2;
	Wed, 30 Sep 2026 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763613; cv=none; b=ERLxnh4ZDYVusjqTIst12JDU5UzFXP6AvKtWTfxgZeZPc5DX22+AuasHkHRZZ8VRWMBPD5yjqgrlcjlkTxyjo9s9/IK5z+DEgl6OyqMYAek0R0ckRY4nGbxUm49Mf+54cp7hNslGhRR9DTsFjkhPH7BUEjA7QzKwg9C3uctSfIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763613; c=relaxed/simple;
	bh=KFZpG+GqbCUyP6pa4OrLY7SJDV6NDylKoci6ExXpMXM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:MIME-Version:
	 Message-Id:Content-Type; b=ueV8a+9e8ndkGhVHyRJzetJ2GEH+hplz+ZNEs/MWMUTPMqzW7eQhm8rMPXU1JfPRAx+Quhq1zT8F2U2VHFmj46GS2Oqb5DAsDGsHLJl1s1Q0NJqevgYTW7QXYwsOOdGCC32LEEHTaz79UARFU0HMB4EwDswE9yDQ8GS0qLOiNJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B5448455C5;
	Wed, 30 Sep 2026 12:20:09 +0200 (CEST)
Date: Wed, 30 Sep 2026 12:20:04 +0200
From: Fabian =?iso-8859-1?q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Subject: Re: [PATCH] apparmor: handle NULL peer label in AF_UNIX context
 updates
To: apparmor@lists.ubuntu.com, Maciek Borzecki <maciek.borzecki@gmail.com>
Cc: Georgia Garcia <georgia.garcia@canonical.com>, John Johansen
	<john.johansen@canonical.com>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
References: <9a2d420a1757516f1e9ad4e9a0e9f17b9ba92c72.1789628002.git.maciek.borzecki@gmail.com>
In-Reply-To: <9a2d420a1757516f1e9ad4e9a0e9f17b9ba92c72.1789628002.git.maciek.borzecki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: astroid/0.17.0 (https://github.com/astroidmail/astroid)
Message-Id: <1790763266.aoz82d3wso.astroid@yuna.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1790763608653

On September 17, 2026 9:15 am, Maciek Borzecki wrote:
> When a confined process performs the first file permission revalidation o=
n
> an AF_UNIX socket, both update_sk_ctx() and update_peer_ctx() can be call=
ed
> before the socket's peer label cache (ctx->peer) has been populated. In
> those cases they pass NULL as a label argument to aa_label_is_subset() or
> aa_label_merge(), which immediately dereferences label->size and causes a=
n
> Oops:
>=20
>   RIP: __aa_label_next_not_in_set+0xd/0x110
>   CR2: 000000000000004c
>   Call Trace:
>     aa_label_is_subset
>     aa_unix_file_perm
>     aa_file_perm
>     apparmor_file_permission
>     security_file_permission
>     rw_verify_area
>     vfs_write
>     ksys_write
>=20
> Observed on Arch Linux kernels 7.2.4-arch1-2 and 7.2.6-arch2-1, triggered
> by snapd unit tests writing to a connected AF_UNIX socket. The issue
> persists across those stable updates.
>=20
> Why this can happen:
>=20
> * apparmor_socket_socketpair() calls unix_connect_peers(), which pre-
>   populates ctx->peer for AF_UNIX socketpairs. Because of that, simple
>   socketpair() tests never exercise the NULL-peer path.
>=20
> * For an AF_UNIX SOCK_DGRAM socket that is connected explicitly (or via
>   any path that does not go through unix_connect_peers()), ctx->peer is
>   still NULL the first time aa_unix_file_perm() runs. The permission chec=
k
>   succeeds, then update_peer_ctx() tries to merge label into ctx->peer an=
d
>   update_sk_ctx() calls aa_label_is_subset(plabel, ctx->peer). Both
>   dereference NULL.
>=20
> The following reproducer profile demonstrates the bug:
>=20
>     profile aa_unix_server /path/to/repro {
>         #include <abstractions/base>
>=20
>         change_profile -> aa_unix_client,
>         file,
>         unix,
>         /path/to/repro rmix,
>     }
>=20
>     profile aa_unix_client {
>         #include <abstractions/base>
>=20
>         file,
>         unix,
>     }
>=20
> Run a program that binds an abstract AF_UNIX SOCK_DGRAM socket under the
> server profile, then forks a child that changes into the aa_unix_client
> profile, connects the DGRAM socket to the abstract address, and writes().
> The write() path reaches the context-update code with ctx->peer =3D=3D NU=
LL and
> oopses.
>=20
> Fix all spots in update_sk_ctx() and update_peer_ctx() that can see a NUL=
L
> ctx->peer:
>=20
> 1. update_sk_ctx() RCU check: only call aa_label_is_subset() when
>    ctx->peer is non-NULL. If it is still NULL, an update is required.
>=20
> 2. update_sk_ctx() spin-locked section: treat a NULL old peer label as
>    "plabel is a superset", i.e. populate ctx->peer with plabel.
>=20
> 3. update_peer_ctx(): if ctx->peer is currently NULL, just store the new
>    label directly instead of trying to merge with NULL.
>=20
> Fixes: 88fec3526e84 ("apparmor: make sure unix socket labeling is correct=
ly updated.")
> Signed-off-by: Maciek Borzecki <maciek.borzecki@gmail.com>

The oops triggers during execution of rustc's testsuite on a system with
AA enabled. This is identical modulo the first hunk to the other, older,
also not yet applied patch referenced by Aurelien. Both patches prevent
the oops triggered by rustc's testsuite.

Tested-by: Fabian Gr=C3=BCnbichler <f.gruenbichler@proxmox.com>

> ---
>  security/apparmor/af_unix.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>=20
> diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
> index b908e744818c9bfef1638c6abadec75c241dc9b9..4762b70cdc43b5dac87f07906=
7eca0ca74d5dd52 100644
> --- a/security/apparmor/af_unix.c
> +++ b/security/apparmor/af_unix.c
> @@ -659,7 +659,8 @@ static void update_sk_ctx(struct sock *sk, struct aa_=
label *label,
>  	rcu_read_lock();
>  	update_sk =3D (plabel &&
>  		     (plabel !=3D rcu_access_pointer(ctx->peer_lastupdate) ||
> -		      !aa_label_is_subset(plabel, rcu_dereference(ctx->peer)))) ||
> +		      (rcu_access_pointer(ctx->peer) &&
> +		       !aa_label_is_subset(plabel, rcu_dereference(ctx->peer))))) ||
>  	  !__aa_subj_label_is_cached(label, rcu_dereference(ctx->label));
>  	rcu_read_unlock();
>  	if (!update_sk)
> @@ -682,7 +683,7 @@ static void update_sk_ctx(struct sock *sk, struct aa_=
label *label,
>  		if (old =3D=3D plabel) {
>  			rcu_assign_pointer(ctx->peer_lastupdate,
>  					   aa_get_label(plabel));
> -		} else if (aa_label_is_subset(plabel, old)) {
> +		} else if (!old || aa_label_is_subset(plabel, old)) {
>  			rcu_assign_pointer(ctx->peer_lastupdate,
>  					   aa_get_label(plabel));
>  			rcu_assign_pointer(ctx->peer, aa_get_label(plabel));
> @@ -700,13 +701,18 @@ static void update_peer_ctx(struct sock *sk, struct=
 aa_sk_ctx *ctx,
>  	spin_lock(&unix_sk(sk)->lock);
>  	old =3D rcu_dereference_protected(ctx->peer,
>  					lockdep_is_held(&unix_sk(sk)->lock));
> -	l =3D aa_label_merge(old, label, GFP_ATOMIC);
> -	if (l) {
> -		if (l !=3D old) {
> -			rcu_assign_pointer(ctx->peer, l);
> -			aa_put_label(old);
> -		} else
> -			aa_put_label(l);
> +	if (!old) {
> +		rcu_assign_pointer(ctx->peer, aa_get_label(label));
> +	} else {
> +		l =3D aa_label_merge(old, label, GFP_ATOMIC);
> +		if (l) {
> +			if (l !=3D old) {
> +				rcu_assign_pointer(ctx->peer, l);
> +				aa_put_label(old);
> +			} else {
> +				aa_put_label(l);
> +			}
> +		}
>  	}
>  	spin_unlock(&unix_sk(sk)->lock);
>  }
> --=20
> 2.55.0
>=20
>=20
>=20
>=20

