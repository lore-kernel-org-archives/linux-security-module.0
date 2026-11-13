Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602858;
	b=GNuwnuUVGlEDpt+AnT/x0OqtaH3mtc4FKafCOJCsiAtdlbRX1UibOFRySWuG3gkXvqIq
	 X0EXBdypWdIiVBIVxauU9tFbUkj5BbCk9UpiWAaHsxHYRGYNK4aPd8waCiECYjsFGuyor
	 q2fv56lxBT/R386gnE7AACdNYmQ2dy0IcGIdusudv3JSjl9gjviCCNdpnMCBDs8LJEifT
	 l2XlAN7S0RcSmEaCot2ixQT3U2p4gEvw6Kc1rLjD09sHT28/AvuC9hyAj5gHTzT0PAZZ5
	 C4gy/pL7Fvu2SxHK8W20dQ38KaDUOdmBU+P5ex+l9clf+1uYSgp0/2CS/U6CeJUNScw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602858;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GmH0BC5+SvWCSmzn6bJxR+k0DSBQCXF0CjeJ/L9+B58=;
	b=1P5OuLWuWuB8gqtbpmShyMrjl8EsTeNBCeMyFCJWKaXIVmAvoxEFK/R/tB27aCm5UdRc
	 l1V7cCWPiSe6Ae5z6EkPhd9zi51ABoPz88ifCrXBENJnuOdQ1nLgqBH+fypBo85GOJWn2
	 HklpnRPbpD6ILK3cligL9dlokDOM1qrg4O20uap6Mor6Tdo4QEIQjfEUJ7r+Jf7JQAM9O
	 N9GkeMJwjHOtsU8Q60F1ckovR7wFAiicKl38SzHfReGnTWacy+Cb7E0a79CYl7DTEwjQU
	 MMpiDO3EOjFW9/XWaX+6bNT6aQKtSFf4OVchzDYDWdfUK53Iz+QO4/eTT5xW15hN1eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=caBqNM23;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EFA606A332
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=caBqNM23
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7391F000C4
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 20:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602858;
	bh=GmH0BC5+SvWCSmzn6bJxR+k0DSBQCXF0CjeJ/L9+B58=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=caBqNM23wsIzIprc2bdOcRYm6XarE+TWudxk+bZb332WnamiaTkYNUXyOBZUzS9Mt
	 QYDabsY2FfuTP2dF+kd8Ki1/b5ZwfoF/sf1KAkX3ihAGNS+AgL5j+pi4SuATrb6v70
	 YHYEpncL9OQu3vcDd8hm+5aq0KdykP/4m1Rsy/1+bM89+aLPxhFqJ76jNG2WFeqryo
	 bWSWvDToL7ZOumlIiZdHdy5tH54Nk75PJ063q6/kU0O0Qand7tR1ctNDSN3PRHo5/P
	 ftm3FbK0v19/wxpnrzBCrRj4SvZYzht/9WuYfnJD4oYsSxzm/t/mMtVQlqGP+tLEYE
	 kpP1RZba3O9Sg==
Message-ID: <sashiko-outbox-213680@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] landlock: Simplify landlock_get_fs_access_mask()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261113-b4-landlock-refer-nonfs-layer-v3-4-02d7e42bcdfd@gmail.com>
References: <20261113-b4-landlock-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com>
 <20261113-b4-landlock-refer-nonfs-layer-v3-4-02d7e42bcdfd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:47:37 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Return the handled FS access mask as it is, instead of artificially
> adding LANDLOCK_ACCESS_FS_REFER to it.
>=20
> Since commit d6c7cf84a24f ("landlock: Simplify initially denied access
> rights"), the merge operation already bakes the initially denied
> access rights (LANDLOCK_ACCESS_FS_REFER) into the a layer's handled FS
> access rights. -- They don't need to be added explicitly any more.
>=20
> No functional change.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-b4-landloc=
k-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com?part=3D4

