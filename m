Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F8148832;
	Tue, 15 Apr 2025 20:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744749671; cv=none; b=oCpkcDEcOSLFAk2yC2zSb2ZfK2g6FhZpyUrBuZZ8SboGV9LcdpNXPsoxX+ZSGbSi6/+n8qEmZm73Z38D/mmdvGu7mMe/baUeBNPjku3lrlgCA+g5ps9pPaNccDLIA9VWghSftpSvuNlYLsKPwtr/ElxCtvfLKjMePrc6h0oVMgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744749671; c=relaxed/simple;
	bh=Xujmcf0MnaYNwA9Y83KJUGceRZYh862QHOOGs5sRFF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4Z5RIKLPDDeT5ScJrQ0Y1tJrjAz6thbYbG9VNBnPG9DHMPck8y8sejw0TqDNrxlMWjC6jSSCYPaRzW1QRJrT4/BkauAdEBd/3YchikkxJ1skQKbrxobxbLImRQwDwA6mx7SdeoFFF0hYyuShCeDhiPH7b+MvA/SMGGDGJVe3QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMZvbxGn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMZvbxGn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D789C4CEE7;
	Tue, 15 Apr 2025 20:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744749671;
	bh=Xujmcf0MnaYNwA9Y83KJUGceRZYh862QHOOGs5sRFF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KMZvbxGnAcU/0LhQBLa/9BG47ab2wYqs+9twySee2VkeuUqYMg2zZz2W5I7tnVZGb
	 p/tZv+4onoyVbP0dcOW3If88TGWnOROMEo5rv2zLERfhOM87kGa8qk/Gud3x6+5foy
	 y+6yThVG+3JjHbM5Rtnt/UQKUy7Kfu2PBgVdTGZb9wNYShV3AHrywI90oXVsZAkO7c
	 rWo1a+39SLw2NGQqESlntZAGeaLcY5+uRWyxg+KXr6vTjV7OeH3iMW/qxjowc7l4H/
	 0n8GXwiEYMCcVr2CteqLs8s/JB1rPO/GbolK7xNdkQB7GfMKJ7Gn5x+J51M2FpQ7D5
	 SbhSpNkan01PQ==
Date: Tue, 15 Apr 2025 21:41:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kees@kernel.org,
	mic@digikod.net, gnoack@google.com, Arnd Bergmann <arnd@arndb.de>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
Message-ID: <2a4a73bc-03a7-4bac-9d56-dad85df3e1b8@sirena.org.uk>
References: <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
 <mhng-812ee330-2f86-4561-8b88-cbb6a51f8515@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AOZwQ0Y3QWlsCkP6"
Content-Disposition: inline
In-Reply-To: <mhng-812ee330-2f86-4561-8b88-cbb6a51f8515@palmer-ri-x1c9a>
X-Cookie: 10.0 times 0.1 is hardly ever 1.0.


--AOZwQ0Y3QWlsCkP6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 15, 2025 at 01:26:34PM -0700, Palmer Dabbelt wrote:
> On Mon, 07 Apr 2025 13:57:32 PDT (-0700), broonie@kernel.org wrote:

> > In current mainline x86_64 allmodconfig builds done with tuxmake GCC 13
> > and GCC 14 toolchains (which are Debian ones packaged up into containers)
> > generate ICEs in landlock:

> This one's been biting me too.  It manifests for me on gcc-12 and gcc-13
> (both locally built toolchains off the release branches, cross compiling for
> RISC-V).

> Tested-by: Palmer Dabbelt <palmer@rivosinc.com>

Kees has a narrower workaround for this:

    https://lore.kernel.org/all/20250409151154.work.872-kees@kernel.org/

It's in -next but not pending-fixes, I'm not sure what the plan is for
getting this into mainline - Kees?  The commit log mentions getting it
in for -rc2 so I think the plan is to merge it as a fix.

--AOZwQ0Y3QWlsCkP6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf+xGEACgkQJNaLcl1U
h9DFPwf+OYdfGrLD201NbAP7h2V0BlTol84qBYkpfizT6XKl3d7Qw0OkYMOND+em
080if3UDivFR1Nr5i4oJ+JIyt4/1VZTteBrHiXJQABlpCw4EwIcUMGjNN1troCYK
/fLl0X65CZBD6ESJ+HKh61xd4mJi/vZToOmYA9jrqwFOg/42lSjJmAeS6bdFI5Nc
nEPDxsA5XgXleiWA6Zh0h7yxwq9RajtfXQuaa3qafu92v+PRcxflpElhpW+HPc0n
IJFxd+gnsB7DFmUubz1HXPenOqixhj0KuSLdxgWlOOhjP/9AJ2YgcsbZAk/HHZoI
5l01qe6SGWDCOtpvRM86iY1szKLVEA==
=y8aF
-----END PGP SIGNATURE-----

--AOZwQ0Y3QWlsCkP6--
