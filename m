Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA3D154BF5;
	Wed,  9 Apr 2025 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744220762; cv=none; b=Njy9LwJ6BqOEalf44kcRguL4G7fnziKMadGdjCXQhjFha7MJ9Oi2GFXljirsvrt/xBonM61mOM14X/rKyH2f93eYZLpxePjj3yICu32db7Z3SiA9aGxY/896j9GjyICYg/xgEqizU86P0TLtuarw6cBpbLR65eW06PL1irz6OS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744220762; c=relaxed/simple;
	bh=na6ZoLxeeX0ojFivzOHFzwSgZW7m9e80nuO5eO7Ks0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsSuezBrLgfnNuEvu5Ac8JaQp8d9U3lPpmNsb1ybIAfncMbVz/k0el147003jdPdijLLyj8qiDcKY3/zq+sUriHk057SlB5FSvMA8/XfJ5jJbBoQtaDSIv9sUHGLVNpDQZF2gS3Spe1Wzlub6L+1fVO7dRokxYuv+TaDkhJF+LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LItFba5a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LItFba5a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C50BC4CEE2;
	Wed,  9 Apr 2025 17:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744220762;
	bh=na6ZoLxeeX0ojFivzOHFzwSgZW7m9e80nuO5eO7Ks0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LItFba5a2fGWUh4T74rv/Yv7sOHSYWSiQaRTufCQuIpUl01OymMZxZbncbXDGvZc3
	 2HKjNPnETwST9ycO5LEyJ4u/bCxiDv8aiRPjAugYzesPPjOYUFqAKAx7u2wijhifFP
	 Vv5+w9EqxrQ1m6Wfyu8h2KDmjdH6mCm89NnSfj6Lgifj9KKLOcfUMG6RZ00rccq2aP
	 EjVm96MX3kJAHTWZGrP9TC+pz3y7+a9cskwNFEzq++3bmTppO0jY7+D1uCsVRLrtbI
	 r5jSPmj+9PfbjVbLW3Zu68FrcIcCPV+uN3t6nV/Q+YxGGInXB1CrJ3XY46fK2tCp2p
	 X0v0XF60Fwntw==
Date: Wed, 9 Apr 2025 10:46:00 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
Message-ID: <202504091044.D789172C@keescook>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whKEuQQh2JymabBQLrLs=pEfx0qYVmUnYZRq_tOFj90sA@mail.gmail.com>

On Wed, Apr 09, 2025 at 10:42:19AM -0700, Linus Torvalds wrote:
> On Wed, 9 Apr 2025 at 10:29, Mark Brown <broonie@kernel.org> wrote:
> >
> > Sadly it seems like the build bots didn't find it, or at least if they
> > found it they didn't identify it well enough to end up with reporting
> > the issue to someone who'd fix it.
> 
> I wouldn't be entirely surpised if a lot of the build bots end up
> running old distros (because "enterprise").
> 
> So this is presumably only happening with certain compiler versions,
> and I expect the build bots have a fairly small set of compilers they
> end up testing.

I'm still trying to figure out what the matrix is, because I can
reproduce the crash on Debian's GCC 12 but not Ubuntu's GCC 13, etc.
It feels like there are a few corner cases involved here. So it's
not just the regular "new compiler changes" that usually break the
plugins. Regardless, I'm still digging...

-- 
Kees Cook
