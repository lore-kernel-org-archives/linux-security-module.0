Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7CA379C3F
	for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2026 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787607131; cv=none; b=QOt5woQXfuDo7fVood8UtJXCXwZeAX4wLJy5geqqwAeNQ0xdgN5l7uKH2DHQIdIdO82KnUS1xBX0rAoaDqT63iBRrh3W0TFpPWm2Z/oRfAt3RemthiRhhIw/zPQKm7P5aD47l9q79qpnDU5Q42GeviTPJvqbLPuoDgamq7GfNgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787607131; c=relaxed/simple;
	bh=al4N32npDDj73Pf7xbDuF15SQD56YFzFI62AMgngJIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbTOjhLwQjlekKD5xd5uPBEfsM68p0JVJdeP/yLO4Ju7gUzmaNa4I3wb7yJ1rAePAYfizhBh9TA2VlgaBXZ3OyfZA7p9UbyHYPGMu2VLir2m02xdr6q5RS4VlZgqzTM3gmIMv+Ys71A0uKPp+DSappb/PbI1TLaCfQ7aSIXEbb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=SbDb4M9k; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="SbDb4M9k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=j9rC5V0Lj5GhG5bVwBclaw3/JIUItS26kLdz5OQA7zY=; b=SbDb4M9k7lNWxps5uQrdmZVkkC
	hugkOb5vgQtYQAN1X5cbX4YgTc5oXw3vWFicMQCczAM9rA/pae/KNEc3sz1PidTDQF3rq+c+yp40n
	mVhGL0jFA+DAgOwzU61kH17cJ/2QfyrUCt7vPBYaNhjnG67IYqH+BI0KlbsSYvnNE4cBrkMU2WwwI
	MHZOYIr7WDEejWBF+cE+SGXS0BuvPCNKe2ZY0ihFE7i0ifHGWdkmJ1NkxqrCrxh8BxmvZoMZx1qKa
	DIxrBmT7fn2tskfyCHXY7FQdKjxknVw3Wnv5Zz9jY68hZkpaAIjZdgIG59gBOy+9VGZxX1vNUt8i1
	F8uSFCvA==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1wycGv-00000002Lnx-16Tz;
	Mon, 24 Aug 2026 23:32:01 +0200
Date: Mon, 24 Aug 2026 23:32:00 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Maxime =?utf-8?Q?B=C3=A9lair?= <maxime.belair@canonical.com>
Cc: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] apparmor: fix NULL ctx->peer derefs in unix socket ctx
 updates
Message-ID: <aoy4UAvUp4ZS0gnn@aurel32.net>
References: <20260824155822.9214-1-maxime.belair@canonical.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260824155822.9214-1-maxime.belair@canonical.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

Hi Maxime,

On 2026-08-24 17:58, Maxime B=C3=A9lair wrote:
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
> ---
>  security/apparmor/af_unix.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

Thanks a lot for the quick patch. I confirm it fixes the issue I=20
reported.

Tested-by: Aurelien Jarno <aurelien@aurel32.net>

Regards
Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
