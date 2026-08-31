Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AB23911CA
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207918; cv=none; b=JzoCBzgge0e3HjpPgn7buPy+3uTv2AlUaGTSFh3HxBW7+jUt1xehbC+JZQLotLxHP5H8cZBp4OnHg2SaTspsuODL9sGujMPaWneu6OwAfDYm7sVLn3F83At9oHy6IA2raQk7sL6Gj+SsFIUbEJN/jBRys36+YNnJKguPJDX2tfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207918; c=relaxed/simple;
	bh=L6l70q17jC/OpWeaujtWsq3PxyTypPGVsK1lb7Soh30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6bUoIqCKozwiJsTjTW7jEfroLNqBAjcv9nQ2yfKFZNfJRjB+sZn0Na1Tdlq+pFY2N81maruX8nLo+imNfRC1TPzlTbcAPVjazZWJAGfLFK24iGhsrdbrwlCTeirBFJVj/iLd+EanflTmp2MPj65cDgzF5hM+Y1WAvxZ+ImdGD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=svKtkNeM; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="svKtkNeM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=yY6IiQ6Nr5iV9r+yHlGSVTBizMYQ7z0DK4taIN2Xox0=; b=svKtkNeMS2lYfxWFPr/rNs5m+L
	5T6lps5Ma6w+MLSRt4X0Sq8OpGWrzAMCrA21FbbKNGGoBAW/IwJTLHGWgWZHzBlY8DdIJX1k5YZxn
	sl4OxjCDT+B8ra+0ZZr8e84J7SL/A+2vpUVFXG5Z0/ImegtpbO1IMBg7tFyC3R9IfZR+qltw+o9y0
	k8JP2QPVmyF+BfNczz+jQnRawJZjK83DXq2SVf97l+naSvnQ7kB2muaL+XwMSSQzUuzdCIA55aM+L
	4ePb5oTGaCcD2gsRdj+QNvjmZ8nSClnjQpx2+YRu0W71L90By9H6UI325esHu7Afjn2JCffSiF+3H
	xvqPDivw==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1x18Z1-0000000Bkh0-3h3Q;
	Mon, 31 Aug 2026 22:25:07 +0200
Date: Mon, 31 Aug 2026 22:25:07 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Maxime =?utf-8?Q?B=C3=A9lair?= <maxime.belair@canonical.com>
Cc: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] apparmor: fix NULL ctx->peer derefs in unix socket ctx
 updates
Message-ID: <apXjIw4NK4okChLn@aurel32.net>
References: <20260824155822.9214-1-maxime.belair@canonical.com>
 <aoy4UAvUp4ZS0gnn@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aoy4UAvUp4ZS0gnn@aurel32.net>
User-Agent: Mutt/2.4.1 (2026-07-04)

Hi,

On 2026-08-24 23:32, Aurelien Jarno wrote:
> Hi Maxime,
>=20
> On 2026-08-24 17:58, Maxime B=C3=A9lair wrote:
> > aa_unix_file_perm lazily refreshes the AppArmor context cached on a unix
> > socket. Two of the helpers it uses assume ctx->peer has already been se=
t:
> >=20
> > 	update_peer_ctx ->  l =3D aa_label_merge(old, label, GFP_ATOMIC);
> > 	update_sk_ctx   ->  } else if (aa_label_is_subset(plabel, old)) {
> >=20
> > where @old is ctx->peer. Neither aa_label_merge nor aa_label_is_subset
> > allows NULL. So both fault on the aa_label->size load.
> >=20
> >   BUG: kernel NULL pointer dereference, address: 000000000000004c
> >   RIP: 0010:__aa_label_next_not_in_set+0xb/0xd0
> >   Call Trace:
> >    aa_label_is_subset+0x3f/0x70
> >    aa_unix_file_perm+0x5e8/0x9d0
> >    aa_file_perm+0x45a/0x550
> >    apparmor_file_permission+0x44/0xb0
> >    security_file_permission+0x40/0x100
> >    rw_verify_area+0x56/0x180
> >    vfs_write+0x7c/0x480
> >    ksys_write+0xbf/0xf0
> >=20
> > ctx->peer is only recorded for stream connections and socket pairs.
> > unix_dgram_connect sets unix_peer(sk) without going through that path,
> > so a connected AF_UNIX datagram socket has unix_peer(sk) set while
> > ctx->peer is still NULL, and the first write that needs revalidation
> > reaches the helpers above.
> >=20
> > Both derefs date back to the Fixes: commit, but the update_sk_ctx() one
> > was dormant until commit 4483efe4f215 ("apparmor: fix shadowing of plab=
el
> > that prevents cache from being updated") stopped @plabel being shadowed,
> > which is why bisecting the oops lands there.
> >=20
> > A NULL @old just means no peer label has been recorded yet, so install
> > the label directly instead of merging or comparing against it.
> >=20
> > Fixes: 88fec3526e84 ("apparmor: make sure unix socket labeling is corre=
ctly updated.")
> > Reported-by: Aurelien Jarno <aurelien@aurel32.net>
> > Closes: https://bugs.debian.org/1145111
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Maxime B=C3=A9lair <maxime.belair@canonical.com>
> > ---
> >  security/apparmor/af_unix.c | 20 ++++++++++++--------
> >  1 file changed, 12 insertions(+), 8 deletions(-)
>=20
> Thanks a lot for the quick patch. I confirm it fixes the issue I=20
> reported.
>=20
> Tested-by: Aurelien Jarno <aurelien@aurel32.net>

Any news about this patch? The kernel oops can be triggered as a simple=20
user, so it would be nice to get it fixed relatively soon.

Thanks
Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
