Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB451CF8B;
	Wed,  9 Apr 2025 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744222185; cv=none; b=iAqPpRK8nL28xVQ+KltRq0fF9NWxlsJK93qa2wRFNzVjkWgTl21bME92hDfzu1X/Xcr74WIBlN+89oAMxlAMewW0CQNtPXqaK7zjR+r3wurzI9fonjHEG/+G9WpT99CKhL/B9j6YrPEjRlHDNKJy9e4Tq3GpcdM0+VX00KRgpRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744222185; c=relaxed/simple;
	bh=kCI21FTKGNcphhvldNNqlklI/r6/6piUInLJbiHh91k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D//rubttSi9QNrvoV0+2GwO6hA4w5SYunlDKdYIUQbuj2H4qcBOh2UXtg4SYUnKByMAKKnkK0ooK0cLWAimuM5xWhvAhlSzY764h7ulEBg91cxnQG1/VpRjIx5lBk+7fpvIAmjXgZcMl6RBD5Ld0vy8TVVxAZJgwsMQIpTw0LLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/25IWCv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/25IWCv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF413C4CEE2;
	Wed,  9 Apr 2025 18:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744222184;
	bh=kCI21FTKGNcphhvldNNqlklI/r6/6piUInLJbiHh91k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h/25IWCvI+Ek6aGjEzNWfaxumM7PeT29lRuYNYu20DXeA4wd5h2juFd9UoPhNaMvF
	 h4qS2z6usFESZ4Hf+2Ri+hZQBUWzDo4cw48csFsH7u5wHJEjKqsF4+JktepXiuPfP2
	 3fn/U7l9YgN9XDZZxRq3XS5+JKt/MfQfKUNrjNnkgkGG6TW9aogy9WjR7kaPHxmEJy
	 tESR43ZCr40x+JTwHrJRwWyak6u1l/JTylgrHYm67jxPEwR78egsvJ9pHU0QkX5mtv
	 MGicyaJgNq3xeHcBfkmsmQkfnVNn+gFm3hWAxFo8Dz/OE9mjjRnmpMcpbJcE188KgC
	 u+2o00hcJQgqQ==
Date: Wed, 9 Apr 2025 19:09:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
Message-ID: <815b2990-570a-4603-b33f-2af1f0851434@sirena.org.uk>
References: <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
 <202504081630.4CE88E855@keescook>
 <db50faff-7290-4193-b861-f60e36f1d1e3@sirena.org.uk>
 <CAHk-=wjc+piYyUw36s4ttEkY32jVkxhRtyrt431wew7XcDS2Qg@mail.gmail.com>
 <a9a459c2-674d-43dc-9e27-41de0471f602@sirena.org.uk>
 <CAHk-=whKEuQQh2JymabBQLrLs=pEfx0qYVmUnYZRq_tOFj90sA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yDyFX6sToBiDf73T"
Content-Disposition: inline
In-Reply-To: <CAHk-=whKEuQQh2JymabBQLrLs=pEfx0qYVmUnYZRq_tOFj90sA@mail.gmail.com>
X-Cookie: Words must be weighed, not counted.


--yDyFX6sToBiDf73T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 09, 2025 at 10:42:19AM -0700, Linus Torvalds wrote:
> On Wed, 9 Apr 2025 at 10:29, Mark Brown <broonie@kernel.org> wrote:

> > Sadly it seems like the build bots didn't find it, or at least if they
> > found it they didn't identify it well enough to end up with reporting
> > the issue to someone who'd fix it.

> I wouldn't be entirely surpised if a lot of the build bots end up
> running old distros (because "enterprise").

I know bunch of them are running Debian, often with a default GCC of
whatever the base Debian version they're running has at any given time.

> So this is presumably only happening with certain compiler versions,
> and I expect the build bots have a fairly small set of compilers they
> end up testing.

Yeah.  The other problem we have is that AFAIK unlike clang we don't
really have people actively working on GCC coverage specifically,
everyone mostly just assumes everyone else is doing it since GCC is the
default (me being as guilty of that as everyone else here).  The work
Arnd's doing is the nearest thing I'm aware of but that's more
intermittent and I gather his toolchains don't have plugins enabled
which wouldn't help here.

--yDyFX6sToBiDf73T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf2t+MACgkQJNaLcl1U
h9Ar3gf/bNjNiXDl7G09DGcsgAUaQr9cKmUaIKMRVIGFn6IX6T97ZT6Q0ShC960u
iyDQ0hZQmYF6gGzuZFW6YOBiq4SAK+oiy4t9+hqGJqshNbg/GzsTsjf1nfA3qXF5
i29fMHYyBzuZckBypge04FtsZtqs3JMlpdeqix9God7Zq0gVXI93f6KUC4uosY2P
0NJv+wzpppd42rI8CgPQJfcBQWpGfibjvGupubBEcnp6RwVW/7OL5IEErn13hbOS
x6GQOQ63UdJVHykkM200vF++qoVnOwUy1Mc9nMbgL9WFkyOh+nJ5s+k2RzJ/LOFI
U6b/+9NcaE2H+xSgfGLgoFMQnIs2Qg==
=BZW+
-----END PGP SIGNATURE-----

--yDyFX6sToBiDf73T--
