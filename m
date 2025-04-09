Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D361D798E;
	Wed,  9 Apr 2025 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744219756; cv=none; b=TQn/lwqo2y8M7LSussbgp94yLiIiwxu6eypuWjQFQi1YUqjjywCozZq2pofqRgSMtZ5NK0m61ESaflwlDno9vfPxlOug4UAN2Z5xdcUVp6dTc5ByFmKvfkfCVe5L4CZvKtiADTb/M6TJ5fd6RK+OdjJjFtxdYe7jBiVJb6+Njb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744219756; c=relaxed/simple;
	bh=aTuSCwgdVaBUdeNe9t4AGglX0jBWeFaVwB7NThEqaW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRq2VYBAPeUSON/sNQMjYkOQ8EEWYvSj6clfvOPGmz6fdWM5WAYQAz1rdZHAHD16l4O/0UjfcquAs1smk45cYdbuBGISivhQrl0RZF759KGPrL3QlJjcLUwTStSTpZ03Y3Niw7ISidi54P6BMuenkvz64XumNb4T9n8dNRdYcv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTmGi3lV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTmGi3lV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FF2C4CEE2;
	Wed,  9 Apr 2025 17:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744219755;
	bh=aTuSCwgdVaBUdeNe9t4AGglX0jBWeFaVwB7NThEqaW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YTmGi3lVc8lAJ7l+7nribuRCxGGy6ixSsGRHywtuKdAwydgpiOpQBMz36b55bravA
	 7Z7FfYQBFctJ28bUyPzUEz66ugNBjwfVRtyMGCPBP+hYe3TMOFt668Fu/YKwMi70IN
	 ML2u4iXkF6D8/+wAxPu0pgbnBTUSiO9cjaj07uFfRXcGYw87YQaIoeS2IzHqXnvRkN
	 rL8ifwB31XgrUtuOO7FdZvIys3K5jVD/nfl2alMbfP5t4nVy6TYjSpzSJHaZrnT808
	 iTD1H9s4XpZhv3sGMVApIPKYCSMxbpHVpHbDjqqRx047wizhe4lFmyNST30mmFYMpC
	 o3t2T+Xj0BpZw==
Date: Wed, 9 Apr 2025 18:29:10 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
Message-ID: <a9a459c2-674d-43dc-9e27-41de0471f602@sirena.org.uk>
References: <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
 <202504081630.4CE88E855@keescook>
 <db50faff-7290-4193-b861-f60e36f1d1e3@sirena.org.uk>
 <CAHk-=wjc+piYyUw36s4ttEkY32jVkxhRtyrt431wew7XcDS2Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oKNkIFplktdD+Ua3"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjc+piYyUw36s4ttEkY32jVkxhRtyrt431wew7XcDS2Qg@mail.gmail.com>
X-Cookie: Words must be weighed, not counted.


--oKNkIFplktdD+Ua3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 09, 2025 at 08:33:03AM -0700, Linus Torvalds wrote:
> On Wed, 9 Apr 2025 at 05:20, Mark Brown <broonie@kernel.org> wrote:

> > Note that the patch is only disabling for build coverage builds where
> > the resulting binaries generally aren't going to actually be run.

> Well, there's a reason we do build coverage - we also want to test
> that the non-build coverage case builds.

> And it's not actually obvious that it does - it's in fact rather
> likely that the gcc plugin is broken in general, and it just so
> happens that it's the build bots that find it.

Sadly it seems like the build bots didn't find it, or at least if they
found it they didn't identify it well enough to end up with reporting
the issue to someone who'd fix it.  I ran into it because I do
allmodconfig builds as part of applying things since both you and
Stephen do them and that exploded in my face at -rc1.

> Which is why I honestly would prefer to just disable the plugins in general.

> Because the problem is the plugin, not the build coverage.

Well, yes.

--oKNkIFplktdD+Ua3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf2rmYACgkQJNaLcl1U
h9Drxwf9H5il27jRBILGP+QjSU3+3p74WMPdhqaddbNGK7u2LIRaE3653IOe/zI/
EHFZ2lvQxP9nb3jSqlWEaQkz8GgjnVdMubj4wYF8NAR6vQ25W1X0ui1ao+WVKPNV
zJimWUhXcAT3vNtTH9ZPxr3lYKgYQJucYByZZAcdwuQW7TGExzeC4wafP4lcSYBQ
T9FXHkEDftAVUuQcqzcvJsq6+XiP9A1t7AF9ZjWYnRoivh/zqVohiCv6R12kmwEG
joITwRhpu+IKdxrR5MMQ4YgxLLT+QSA4793r6mZwhJKC9MWxtfpglr2/Vs2djkH1
Ow15XFZbcP3jZzDfV4dl/hzjw/D+wg==
=JNPu
-----END PGP SIGNATURE-----

--oKNkIFplktdD+Ua3--
