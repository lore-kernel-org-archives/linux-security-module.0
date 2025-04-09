Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F391ADC6D;
	Wed,  9 Apr 2025 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201197; cv=none; b=QLrRbFv97sAI+1JwIPMlowrR9++R7XLFBK1KjQ12B1Ii6FyBRJzQmUDHXXHROHDmbYpK0Z5oHB6v21uwCqEvhZ/W1+p8ekGeJbNYpQ1ZQARkAqpFaonwSyW1JqNad/TuPPFlVWMSzpoNly9uorNYfTZlYvNVzlH7TTKmoACMrfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201197; c=relaxed/simple;
	bh=m/80E9i8ulXdJI2miubeNh/kmc7nNlwcgFgZf7ctjmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyQ4yPUHs8Dtg9w/rQhjoSify7M9z7KwLnxQ5Z5qrsuFbEf+O6jevxDq3x6PA2BhMigaECnXtTl/dNSfNXWskr9XPHjIyjXnPNrKrYZwakDJKaJasT6u5nAZoYuEMc1ErS1vdvVDkIGCorguLv1KiY7YD1pAfgVuhdEUjAm3cuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgorUO4d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgorUO4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5ACCC4CEE3;
	Wed,  9 Apr 2025 12:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744201197;
	bh=m/80E9i8ulXdJI2miubeNh/kmc7nNlwcgFgZf7ctjmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BgorUO4duAWGYmnW52jt9dKAN0odOKAwcCjxRC0ERkaHc0JvtqFjWMH38bzBOViNF
	 /Pu8Ncm+XGTnpJDHI+em1ALoVQPDv7dA5HROlObPPT+XMqljvqp5FuV+vk+fp7X/RI
	 WRVJF4zO9OJUWrndLA9ewsZlLO66JN/NqGf9Sz84XNxaAKBClNukq82S+yLs+y0GW8
	 4UsvpKZevAuI1sW44YUOyKhPTufcKfjIZNHcna9hnaDKH9xRhPPPOuzxz9lNfRucTf
	 CIQtKyaGSWmoeRrGr9rs7l21tAXodg3xIsjuG378C3op5UWkB9USITxVUFaNP8ZfoC
	 QSH/qaUY8FNRw==
Date: Wed, 9 Apr 2025 13:19:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
Message-ID: <db50faff-7290-4193-b861-f60e36f1d1e3@sirena.org.uk>
References: <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
 <202504081630.4CE88E855@keescook>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SrCMCOVGy31wp5e6"
Content-Disposition: inline
In-Reply-To: <202504081630.4CE88E855@keescook>
X-Cookie: Words must be weighed, not counted.


--SrCMCOVGy31wp5e6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 08, 2025 at 04:32:24PM -0700, Kees Cook wrote:
> On Mon, Apr 07, 2025 at 09:57:32PM +0100, Mark Brown wrote:

> > Arnd bisected this to c56f649646ec ("landlock: Log mount-related
> > denials") but that commit is fairly obviously not really at fault here,
> > most likely this is an issue in the plugin.  Given how disruptive having
> > key configs like this failing let's disable the plugins for compile test
> > builds until a fix is found.

> Looks like this is a randstruct bug. We'll need to disable that one for
> now (rather than all plugins).

Note that the patch is only disabling for build coverage builds where
the resulting binaries generally aren't going to actually be run.

> I can reproduce this for GCC 14, but I can't reproduce this with GCC
> 13. Which minor release is failing for you? My GCC 13 is:
> gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0

Should have been x86_64-linux-gnu-gcc (Debian 13.3.0-5) 13.3.0.

--SrCMCOVGy31wp5e6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf2ZegACgkQJNaLcl1U
h9BgFwf8DwMSvZItKBSkQNtRQf00KF9aE+KT0RnfsGtWAo+NxKHRJKuddjh2f7gw
CfHIyNvg6/4Z1uZEO1DoLhMio8RDq2D9qQHBYNWtBzUBnfq6RoT8pBbaKhm6Ymqn
qZ2EIPig291hUkzYznDjJWo1n5wRmFZlvA/mujSYRiVuNHzrh1xSloqFbRv65V2e
QDt6tIvKVp8AeZbz10porVbG1dr652zUe1UM/K9AOujwKRhnjQU/gyLOO/i0Ms9S
Bs3UoebRaNStzM/wdMwiy8ifweGneGGpr9dgf6EezX3JrEXfvUShX54AscZsgBMG
P0Ila2VRl478coX5cuJinYj6KLsCLQ==
=JKz2
-----END PGP SIGNATURE-----

--SrCMCOVGy31wp5e6--
