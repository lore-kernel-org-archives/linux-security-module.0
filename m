Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5E7259C;
	Wed,  9 Apr 2025 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212407; cv=none; b=KAXgJTEjUfx/iUYqZP6gbe8ty6AoUGVweDwLQ82VBej+NGzCHWjVZSZiee6HI7vKbakPXu4en4JwVenZV0s2P6RIT5++sysfrCizDd6EUsdhvbGeMeinXzFI+KY4RSCWWxnotDqzzaCxsOqWS5a1Qb+G73O853YEetERllHTHpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212407; c=relaxed/simple;
	bh=R/aQddKs3YMt/C7SEiky1/tQprV+6iKiz1seNNyPyuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4MMepTFA0BZnvKI5uGJOLsA42o/whbK7p1HVLhgIQUJkj1R9q5XbZvPHl14ZpxWcozMO38ixau0l8+Vs2pSMtSG9Eog6i3CwawkUx+CF8LYkxocI+IjKBU1viLKMWjRXaelc4WLynOTlixxVDl+xTy/VicSrZcypETHtgXTKrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOuiMVJ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOuiMVJ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E214C4CEE2;
	Wed,  9 Apr 2025 15:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744212406;
	bh=R/aQddKs3YMt/C7SEiky1/tQprV+6iKiz1seNNyPyuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZOuiMVJ4fO+xUGl3dwYhodLbZieE4rbwdHU5hjcdMC03izBHtNTGs3/rVjHvNzVF9
	 zoX1fdg/Hjq+pN7Y2WcfhJQtE5/FDxIdIMasLAoeKLhffAaoSxT8zk+frwk8aSA0bU
	 xAVI1+MAPdFjb8P0SJwBWwJrBPmgEdUnkD4z9V97KHB5BN91X+/zZg0Ogdu+mIlCNP
	 7zetACsvkks7qPfRXN6jN/s4wyjCMLZLlNPo5iJkTdl5bXZuvTKhm4fAyGYOtpNdFw
	 tQd6BLExAf3IulHYgMYx2j1K6f5uRHWOercOZd36ogiWRdcLXV6GCAjBWq3MNHWLyj
	 cBAwk2UY2PA3A==
Date: Wed, 9 Apr 2025 16:26:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hardening: Disable GCC randstruct for COMPILE_TEST
Message-ID: <c2d2d602-ce25-42b9-8b73-7d533ddfdc8c@sirena.org.uk>
References: <20250409151154.work.872-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q0kJAVYXI0gsBUZ2"
Content-Disposition: inline
In-Reply-To: <20250409151154.work.872-kees@kernel.org>
X-Cookie: Words must be weighed, not counted.


--q0kJAVYXI0gsBUZ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 09, 2025 at 08:11:58AM -0700, Kees Cook wrote:
> There is a GCC crash bug in the randstruct for latest GCC versions that
> is being tickled by landlock[1]. Temporarily disable GCC randstruct for
> COMPILE_TEST builds to unbreak CI systems for the coming -rc2. This can
> be restored once the bug is fixed.

Acked-by: Mark Brown <broonie@kernel.org>

--q0kJAVYXI0gsBUZ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf2kbAACgkQJNaLcl1U
h9BD8Qf/RxOGqUIG+nlf8fn1vsoqnPfFhEvZzXoohhiCHUzGMlAauYzQWVnPSbCe
gEfK4f8Qpf2eZ5sBiIMo0LIyAsFymtJfYOEd9cX0aLqe0MBNWydhajrFfIRiifNZ
gp3RXSq8I01XZAT4eLOkNoniqvxreZqbPyV+HRx//m6fTOulVINB72k6X48N9atd
zIz1bEhAuVmzySwXBIKKE6jhqeUe4U6ocJXMhdLcNXt2wp2bTNq+GB1TvbDfwnmX
2yg8YLN3WGJ4WHZP3aURt4T1WqLi9AaJzFYKlg9Ktuz20NkoRKGu6axQY8OuYMRi
KckvCLhZBVntiYfAmmYS4YJM/xE32w==
=GhOF
-----END PGP SIGNATURE-----

--q0kJAVYXI0gsBUZ2--
