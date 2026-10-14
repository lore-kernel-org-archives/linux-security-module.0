Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8354A5EDC
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 22:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792016409; cv=none; b=gZTCkJkviNhz2R84S4XP5LaGHEu3SY4KbTAoaBiqyWojD5+ZWPkvZWKmfCF8avwjXB6LAW80iQFrDll5Y1WjBLusBtmma6fhUd0ZgFZ/eYiYGOsxqj+HXc7PW/xX1rhZTxOW6oRspelyC60ogspGpaL1mgX0JH8ufzT9/IEmHw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792016409; c=relaxed/simple;
	bh=6DSWzMACH+AiWMfbgT1k2L8n39WkKm2+SsLu1wyK2yQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YaUMsns2y1Nm76ppdHu/5nbr8Yqh2mxeLcEf9OwbIMMPQVKiK/BCr1agEniEBAF+/76TwOY5a+QPx8s3HmxZmYa7XCp2FougtxzuvBFaHAtpehiJl7cZhmdk+t+R2NWB/Ex3jfgs1N9e4IP66HlSDFNtyuGHeI9yl8Q329Wdmyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=KwRp87n5; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="KwRp87n5"
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A547F3F8AE
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 22:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792016397;
	bh=WW99p8YnO9Zw17VaDY4W2ZbzPrCwoGi5anQCgb6s8LQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version;
	b=KwRp87n5VfBr+bmHLF2U60CPDFCTb9qaq5z+kbTcjoygfxLPtdpVxveoJGrD8Jj68
	 HmrcWqlDQ5qwSpGe3jv2AutZWrAKAca08g7SI5XcCzpWBZ6DdqemPFWKb0H3aLTeRl
	 fYYsgNyf72vcH6f7RisdZYU9qXQmbjwSlZeHXNvpzQwJZoUDDUHbGSz/che+nXewJv
	 6+aey+VzNDZUFgrBoAq1obsRzpgoZ+VeifyLXJYtICzDoX34VRQlCyAPCAKr/zbEUh
	 zl74TmVEKYcWMnTFhK+Ho0ntL4PA2EQvOMY9lq+5e/6//5LraGGrmoRjhkloRAqiPp
	 IEF1woTvziTptoPsUuvXmdvp6OyerEs0cltOVZXxc1U1QJkRIBMboZZ0QrrTxRJ9JZ
	 tgyL5sSiJxGl6MBVpe9CXRS0LNyV3dbnUr6MUNwNCQZKjtkhJN7VyJYE6QbbwpDP+V
	 nVXmDjDkQp2sqFDC7AXHwRMPGFgn1Nhc3PUAOg5v1KtulrmnmPYS/NaWRDOz5NkcxG
	 fkAbvegB46rCQrxbr06flXbFFxYM/bzn0lg+qH7pdaXDLlmD1FbUnyQYkFdnm9g8o9
	 Mqfua2ilWrseKp0kQTOp9U0PVooCAxyO3N7iDO6RE5pax640pZYXy3l3rPFePtEADP
	 72reQuxfr1S46f/7PqQvyiP0=
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c0d568830so9436883eec.1
        for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 15:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792016396; x=1792621196;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :organization:references:in-reply-to:date:cc:to:from:subject
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WW99p8YnO9Zw17VaDY4W2ZbzPrCwoGi5anQCgb6s8LQ=;
        b=vkuY0lVLg2crQ++tfQ29B88Hgnmh8TW/ZRmeygv45yl/yHO7Wds/XpaG5jgpbuHWsv
         XHV3Zgu+6WEzJiAhENY0hJxNvVuNVD6/d+xMxCUfOp7ZVgQh5iv06cRgWHCXSBxih6f7
         AnaoWvvRA5bENSYH8ljjsEuruTEcZZwZyWjewhi0XGaYH8kfyUx8xNx+u2bnVy9bXc+t
         e2RPM4Ak0U++P09C1uMb1k9I0x/vnp/5kzmxm3+2bY6c+alOyPdTFDV4SowYMQi6a4r3
         psO39Y0ccSDgjRqwZRE4pGAZuctCCA4C52AFMVmCDF8Z+sycaU153AVPmRkyI1VhE85Q
         xj0g==
X-Forwarded-Encrypted: i=1; AKwUvBxKkUNtP6HhB0Kc6yz/UUpTrGfcnAHYwMiUjGMLyXMRtGw97UIp7qLmGdkL+rG9LqFXLTpXj6+0SbA5u1gQ46KYLSZ/GVk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIswtGqoY6ze5OGX/zACgW5A9unrAVPiKOX1hzpznpQuVJt9qVr
	j0pTAkVZln0IpMJf2Rxs+jLDuOxvJbMyWf5YxrsoIUp+hXY58+s3JuUwj6BYFPcX02opwFkXsnw
	trSKUbB+nr6HBmMQv583xN4SbGMI99D4c1GHwa63nZKP7yqOu6jotL+RkwVTm6UqMaJs4gsLPDB
	fD3j73au3RvqFliSQTqYuE9Ilt7Mwf
X-Gm-Gg: AYBFou064sQP4SgvCHgE3QPcrRG23qkWLho+lEvCeFHlmODJaAOrRgv9pDk7sqRATKa
	+CryWZqJxkYGMqcLxi408NB0SUMntR4Q0cfgtSnEep970WN5LDRIOc8JfAOkFE7TL4bGFO3a/rX
	8+aoT1V8d2HZDtgmHnNN5FlP2+oQhJY+6URWcOvKGIl0iq5RKciZ5q2PQidbKHWYtFRezLRb9JQ
	Ts8a7/zvHeaU8XF+7BbsKe4Qiul9a1E2lomcnmn4VzIN/DohDoD27eOW3ZdodN8brv/ATo+hF+a
	i0pbPJ99K6hPulXKVWYEPQI/aD0n7v9Z2Ut08eyOEnXLnIrWM5qigIT4DxXLMcNneHdiPZlHqt0
	NBR1PQUj5YhsGfAE9wm92PXa8do4OXs1REIzbHGJ8RjhQxno=
X-Received: by 2002:a05:693c:8951:20b0:35b:782c:aa31 with SMTP id 5a478bee46e88-35b783bf575mr11609807eec.28.1792016395575;
        Wed, 14 Oct 2026 15:19:55 -0700 (PDT)
X-Received: by 2002:a05:693c:8951:20b0:35b:782c:aa31 with SMTP id 5a478bee46e88-35b783bf575mr11609759eec.28.1792016394847;
        Wed, 14 Oct 2026 15:19:54 -0700 (PDT)
Received: from [192.168.0.106] ([138.204.27.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-359789fde97sm40802989eec.20.2026.10.14.15.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:19:54 -0700 (PDT)
Message-ID: <92a78144e5d91ce75ab4cc68538d92ecc1739512.camel@canonical.com>
Subject: Re: [PATCH] apparmor: fix NULL ctx->peer derefs in unix socket ctx
 updates
From: Georgia Garcia <georgia.garcia@canonical.com>
To: Maxime =?ISO-8859-1?Q?B=E9lair?= <maxime.belair@canonical.com>, John
 Johansen <john.johansen@canonical.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
 Aurelien Jarno <aurelien@aurel32.net>
Date: Wed, 14 Oct 2026 19:19:51 -0300
In-Reply-To: <20260824155822.9214-1-maxime.belair@canonical.com>
References: <20260824155822.9214-1-maxime.belair@canonical.com>
Organization: Canonical
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-24 at 17:58 +0200, Maxime B=C3=A9lair wrote:
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

Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>

> Reported-by: Aurelien Jarno <aurelien@aurel32.net>
> Closes: https://bugs.debian.org/1145111
> Cc: stable@vger.kernel.org
> Signed-off-by: Maxime B=C3=A9lair <maxime.belair@canonical.com>
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

