Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E25E14885B;
	Tue, 15 Apr 2025 20:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744749787; cv=none; b=odZv0h3BwUDwlxN0pzKjKE8HDab5q7Drtx94e+SBxYkIJlG2tjenPMjRKYDdx5I8bwrfp8WDC4QhvTbFnlp6XUZs73pCXThY6eRYuJ52U6CXvNDff/Nh+OJ1Jd2wQAm9LRQa0libt/WLzCy/aHfm0+68lUwcs/OyahTdi0ABQGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744749787; c=relaxed/simple;
	bh=IWBiglTolvzLbRC/SC2dX9CRUSNYAntMqay4thynEUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrghhFqxCVbB4Ncjvu8k3uz9c5CClRGuWn/enDyTqcq8tagK4XYuBB45WB0lwCCDsrKpfJRB6KirA8ng1HR57eUJqN8MeWu6VUFAYGAGtl48/DTwd5GzlbviKJbAdmiMV74uti80qz02B+cdBp+yGM/Vnbpt3IaY6npry38u3rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzFgMtHw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzFgMtHw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD18C4CEE7;
	Tue, 15 Apr 2025 20:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744749786;
	bh=IWBiglTolvzLbRC/SC2dX9CRUSNYAntMqay4thynEUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gzFgMtHw70ba/StwsTeOqiTiEaFnXsWu6wvk6v7vouyOgeEnKAwsWwUVMH8IVYBOL
	 w73sOhTq0ETxgmTbVQREd7nwJ9VfYJM3XvIQtoZmO/3UosxKvCsNw/dwmAglAlItdC
	 BWgDZCX8Typ+BM2YIiqdiyzfXs8qC0F8jK9FVCHfH1nVufqgupbtkyMMXRcbaXjz7g
	 jDoCvN+cL/qTJ3g/lPzo1WHxCCjPM+72kUa9BsM7r8GqAeRNeB89XqUVvFFXzoroMT
	 RGpl94J0O9AE1QGS36s+q3pIaiwKMP3B33OL7FNd2pz4l35Ek3ADAY6fky2/7o5JAw
	 92mgYiefBCZ5w==
Date: Tue, 15 Apr 2025 13:43:03 -0700
From: Kees Cook <kees@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, mic@digikod.net,
	gnoack@google.com, Arnd Bergmann <arnd@arndb.de>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
Message-ID: <202504151342.7362AD8817@keescook>
References: <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
 <mhng-812ee330-2f86-4561-8b88-cbb6a51f8515@palmer-ri-x1c9a>
 <2a4a73bc-03a7-4bac-9d56-dad85df3e1b8@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a4a73bc-03a7-4bac-9d56-dad85df3e1b8@sirena.org.uk>

On Tue, Apr 15, 2025 at 09:41:06PM +0100, Mark Brown wrote:
> On Tue, Apr 15, 2025 at 01:26:34PM -0700, Palmer Dabbelt wrote:
> > On Mon, 07 Apr 2025 13:57:32 PDT (-0700), broonie@kernel.org wrote:
> 
> > > In current mainline x86_64 allmodconfig builds done with tuxmake GCC 13
> > > and GCC 14 toolchains (which are Debian ones packaged up into containers)
> > > generate ICEs in landlock:
> 
> > This one's been biting me too.  It manifests for me on gcc-12 and gcc-13
> > (both locally built toolchains off the release branches, cross compiling for
> > RISC-V).
> 
> > Tested-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> Kees has a narrower workaround for this:
> 
>     https://lore.kernel.org/all/20250409151154.work.872-kees@kernel.org/
> 
> It's in -next but not pending-fixes, I'm not sure what the plan is for
> getting this into mainline - Kees?  The commit log mentions getting it
> in for -rc2 so I think the plan is to merge it as a fix.

Yeah, I missed -rc2, and will send it to Linus for -rc3 (with other
stuff) probably tomorrow.

-- 
Kees Cook
