Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A93405C35
	for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763610; cv=none; b=jklbFaSQbxYR3TPyT5FVHKJsrHnpp6SpnNWzGMvtntImwxMNzSAg+ArfyQ9JMvMXAchoYl+eHuId5wSAg+AkbDwnszz1hNy8OH8AIPt5s+T0UdtXzsM2ppMdYMPBelnGWJkr5Ci7Y6HsBDHZJ4uby8JOPmltHME2mPheY02SdZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763610; c=relaxed/simple;
	bh=HM5lreZZ/OGC4qPSizGM+/0aYKQsnRMTlbhVJyNI7SQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:MIME-Version:
	 Message-Id:Content-Type; b=li58PU8ezu/GrEN59jVuw7iPNnIOX+AVPEnIDzm4kknmgedbyRANt89R+tudhpqcE4kTzmYhVPMdSUzKkXYT1yi/bm1Jf0niQk7tXa3F6QCUnqAWIq1yloFtNzZ7cNNUgSdasqD+4f5dqMnyYj3ppoX57a7hTXRmB1Oi2+47JXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 4823843D6B;
	Wed, 30 Sep 2026 12:19:59 +0200 (CEST)
Date: Wed, 30 Sep 2026 12:19:52 +0200
From: Fabian =?iso-8859-1?q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Subject: Re: [apparmor] [PATCH] apparmor: fix NULL ctx->peer derefs in unix
	socket ctx updates
To: Georgia Garcia <georgia.garcia@canonical.com>, John Johansen
	<john.johansen@canonical.com>, Maxime =?iso-8859-1?q?B=E9lair?=
	<maxime.belair@canonical.com>
Cc: apparmor@lists.ubuntu.com, Aurelien Jarno <aurelien@aurel32.net>,
	linux-security-module@vger.kernel.org
References: <20260824155822.9214-1-maxime.belair@canonical.com>
In-Reply-To: <20260824155822.9214-1-maxime.belair@canonical.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: astroid/0.17.0 (https://github.com/astroidmail/astroid)
Message-Id: <1790762923.ps091h0nv7.astroid@yuna.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1790763598303

On August 24, 2026 5:58 pm, Maxime B=C3=A9lair via AppArmor wrote:
> aa_unix_file_perm lazily refreshes the AppArmor context cached on a unix
> socket. Two of the helpers it uses assume ctx->peer has already been set:
>=20
> 	update_peer_ctx ->  l =3D aa_label_merge(old, label, GFP_ATOMIC);
> 	update_sk_ctx   ->  } else if (aa_label_is_subset(plabel, old)) {
>=20
> where @old is ctx->peer. Neither aa_label_merge nor aa_label_is_subset
> allows NULL. So both fault on the aa_label->size load.
>=20
>   BUG: kernel NULL pointer dereference, address: 000000000000004c
>   RIP: 0010:__aa_label_next_not_in_set+0xb/0xd0
>   Call Trace:
>    aa_label_is_subset+0x3f/0x70
>    aa_unix_file_perm+0x5e8/0x9d0
>    aa_file_perm+0x45a/0x550
>    apparmor_file_permission+0x44/0xb0
>    security_file_permission+0x40/0x100
>    rw_verify_area+0x56/0x180
>    vfs_write+0x7c/0x480
>    ksys_write+0xbf/0xf0
>=20
> ctx->peer is only recorded for stream connections and socket pairs.
> unix_dgram_connect sets unix_peer(sk) without going through that path,
> so a connected AF_UNIX datagram socket has unix_peer(sk) set while
> ctx->peer is still NULL, and the first write that needs revalidation
> reaches the helpers above.
>=20
> Both derefs date back to the Fixes: commit, but the update_sk_ctx() one
> was dormant until commit 4483efe4f215 ("apparmor: fix shadowing of plabel
> that prevents cache from being updated") stopped @plabel being shadowed,
> which is why bisecting the oops lands there.
>=20
> A NULL @old just means no peer label has been recorded yet, so install
> the label directly instead of merging or comparing against it.
>=20
> Fixes: 88fec3526e84 ("apparmor: make sure unix socket labeling is correct=
ly updated.")
> Reported-by: Aurelien Jarno <aurelien@aurel32.net>
> Closes: https://bugs.debian.org/1145111
> Cc: stable@vger.kernel.org
> Signed-off-by: Maxime B=C3=A9lair <maxime.belair@canonical.com>

FWIW, this triggers when running rustc's test suite on a system with AA
enabled, and I can confirm that the patch fixes the issue/prevents an
oops.

Tested-by: Fabian Gr=C3=BCnbichler <f.gruenbichler@proxmox.com>

> ---
>  security/apparmor/af_unix.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
> index b908e744818c..d04d9cd268aa 100644
> --- a/security/apparmor/af_unix.c
> +++ b/security/apparmor/af_unix.c
> @@ -682,7 +682,7 @@ static void update_sk_ctx(struct sock *sk, struct aa_=
label *label,
>  		if (old =3D=3D plabel) {
>  			rcu_assign_pointer(ctx->peer_lastupdate,
>  					   aa_get_label(plabel));
> -		} else if (aa_label_is_subset(plabel, old)) {
> +		} else if (!old || aa_label_is_subset(plabel, old)) {
>  			rcu_assign_pointer(ctx->peer_lastupdate,
>  					   aa_get_label(plabel));
>  			rcu_assign_pointer(ctx->peer, aa_get_label(plabel));
> @@ -700,13 +700,17 @@ static void update_peer_ctx(struct sock *sk, struct=
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
> +	if (!old)
> +		rcu_assign_pointer(ctx->peer, aa_get_label(label));
> +	else {
> +		l =3D aa_label_merge(old, label, GFP_ATOMIC);
> +		if (l) {
> +			if (l !=3D old) {
> +				rcu_assign_pointer(ctx->peer, l);
> +				aa_put_label(old);
> +			} else
> +				aa_put_label(l);
> +		}
>  	}
>  	spin_unlock(&unix_sk(sk)->lock);
>  }
> --=20
> 2.51.0
>=20
>=20
>=20
>=20

