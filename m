Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C236823DE;
	Mon,  7 Apr 2025 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744063340; cv=none; b=DpFl13cp8vXE8hCcwzYeX80gzmB89bxw5zIhak1UlGluczH4lJ0yrCZTFTxTyd364o4tt0CbhOa4N5kH5jipdRKwu6nwC0NkntFUSk7v5qlb2fAQ6lHpi/G0pCYD3d5hbjHKGbowURHvZOceptnVr3BaJ5iwp6RQGrEWQSh1s8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744063340; c=relaxed/simple;
	bh=/4WGk6kSr8LKKFwu6dzWcmgp0DckK2KU9bDoF1Fe3XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZCcAFmgQn7lzVpk5lf3nLFKseWiieYCA/D9uK1HlYlNIG2Qdnmx4GC02pVwaAArnYaYv+m7nKClwCHnaT72FqSKAnlGRpRweuL5JN5dq2u0ftmt447RW8ISC/qQdQeNTxacvrRhziexP1/UWud3cpNLbHvQfNxl6Hdu+BKxpNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abIzyW9Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abIzyW9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDDDC4CEDD;
	Mon,  7 Apr 2025 22:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744063339;
	bh=/4WGk6kSr8LKKFwu6dzWcmgp0DckK2KU9bDoF1Fe3XE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=abIzyW9Zkbud1gngvmI5WfdQn1IgbCOEqr5RaAXnmDb4onbzTAQEiFgU4QxxBIJ4s
	 j7D4g7WfoIfQvhb4Oh7n9gnUGvl21Ngmh+V0yCLQkVVur3CBp9h6u4z5VxwyV2C0/5
	 g7eppUEarOJH76yIXNAprZCsi3YSTBHTI9ha3LMbtrpHK54/8NdRFmFFLzFJScKqqN
	 ECrwAkFYj73uOqUKrmv/xiS/StqHyypHqPzL0lm1ZXY+FXpmDDYiBkqKZdITLGj0rG
	 HIKr03lt3vuwpOzRSEb0ezOdBD+3djOzP+s8FqAZD/5sbLY9VQX/V2CxsMxk2LsznH
	 KsXSKuNNin5Cw==
Date: Mon, 7 Apr 2025 23:02:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
Message-ID: <8cbe0cac-2952-47b6-9b0d-1400aec0bf25@sirena.org.uk>
References: <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
 <CAHk-=wjTbWiYwfj2wF9iP8SSVk2A_cZFDr5hu1bgU_PfxhyiiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NwExeGW9LH0vNNUp"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjTbWiYwfj2wF9iP8SSVk2A_cZFDr5hu1bgU_PfxhyiiA@mail.gmail.com>
X-Cookie: Meester, do you vant to buy a duck?


--NwExeGW9LH0vNNUp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 07, 2025 at 02:33:40PM -0700, Linus Torvalds wrote:
> On Mon, 7 Apr 2025 at 14:10, Mark Brown <broonie@kernel.org> wrote:

> > Arnd bisected this to c56f649646ec ("landlock: Log mount-related
> > denials") but that commit is fairly obviously not really at fault here,
> > most likely this is an issue in the plugin.  Given how disruptive having
> > key configs like this failing let's disable the plugins for compile test
> > builds until a fix is found.

> I'm not against this, but I do want to bring up the "are the plugins
> worth having at all" discussion again.

> They've been a pain before. Afaik, the actual useful cases are now
> done by actual real compiler support (and by clang, at that).

> Who actually *uses* the gcc plugins? They just worry me in general,
> and this is not the first time they have caused ICE problems.

There was a bit of discussion of that on IRC which didn't summon up huge
enthusiasm for them.  Arnd noted that:

    https://github.com/nyrahul/linux-kernel-configs

indicates that Talos 1.9.1 uses latent_entropy (but we didn't check how
accurate that survey is).  He also noted that GCC_PLUGIN_SANCOV is
obsolete as of GCC 6 (!) and both CC_HAVE_STACKPROTECTOR_TLS and
GCC_PLUGIN_STRUCTLEAK_BYREF_ALL as of GCC 12, Ard indicated he wasn't
worried about loosing CC_HAVE_STACKPROTECTOR_TLS.

--NwExeGW9LH0vNNUp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf0S2YACgkQJNaLcl1U
h9Bsjwf8DugHLbBoWvF0qOUkI8O6UnAzYv2laisq1JEdRzmgVk+lPLamsjJuTwAC
99LlD9yp1ZCNdTkNBWgZkWGv4qCOYqnC3wowU0aP0OJOUUHkGaSfprmDbCJr6otD
yJXm13aomzsyFY6ah9368UVoGHKAZpsvNRr8q1c+FM5myM7W2iNUmy86uR8Gu5Y/
wrp5T3AkMX+F58VIi6n6XLZjp7xxMc19j0osLF+MgAosaUfy3djgDhPomVAUp58r
FeR5hlIMb6TbmucPC8Mdxommt4gqUJhfZi3CZZH4cT6pKh7ryhvkJ5H2MzaDnYmI
uez22860AYJD6fBPaPpNyToVS6oonA==
=otop
-----END PGP SIGNATURE-----

--NwExeGW9LH0vNNUp--
