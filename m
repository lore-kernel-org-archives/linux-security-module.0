Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A44827B51A;
	Fri, 30 May 2025 19:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748633830; cv=none; b=nBlvEvM0LHro/c9ZPvFAONhAcRwbiv6euBNJuzW5IbAYnc6bEod6favbOXJjXZyEQr/n0pXtNMWx7BAarMNWYIFRUWWepCIxluhs17SnZbeE1+SVZ9n1ibUtpD8BeeisaERMWvE2CaEN/hiBXNLZNtzyRiE5G9Z1HBw4mCThC2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748633830; c=relaxed/simple;
	bh=Z8/s+ELGWRd8al7z8iP6qbpzkL0lbCsk9LHxUuaiOhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnXBkR7U2W4B/+IFKkc2xW8y7ar1+YTv6dRmMzlGyYL/udSV+PJt+SlLYOXEF6P16kwBdrCJiTWml3iyIQNRCFASMTddS6AaDNUHyWmVhsWIAMy6m6JxdRhMsSwXOejQzlTBLjSDHRuOg8ZwtdrM6MzzQFQWfX6LTIhtHv47cRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyUx0JXo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyUx0JXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D1FC4CEE9;
	Fri, 30 May 2025 19:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748633830;
	bh=Z8/s+ELGWRd8al7z8iP6qbpzkL0lbCsk9LHxUuaiOhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UyUx0JXo4MJhrWOO+tQKZ+8X2pqucj1ZCZUOgMkv8+odPfAuMj2HMuM+qGhLw+P0s
	 QFj1b54h/4670eh3wDCF7zsSy6ofDE8kYsA9MxDKQ/EYHMjPpEZL2IKRsSbEF1Jv0Z
	 cTaZCdPqhQveNjHZSr3pIz+fS6FEuvfQKD1VavpKLMt1Oj0Yo7656dmW0rBDGmPb7j
	 yidzInEQXkTdY74ormGhnY9eKJZo8aGCKbuMytSeUg8ZW7ga55COe/wln4sNSIFbRF
	 i0RMnoaQqu+J6sWRLfWDMyT873j/xfTYHkt0kltClTJ5YxNbITwP8/jVjxpncT1cAY
	 r89CuKUpIppLw==
Date: Fri, 30 May 2025 12:37:06 -0700
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	akpm@linux-foundation.org, arnd@arndb.de, broonie@kernel.org,
	davidgow@google.com, diego.daniel.professional@gmail.com,
	gnoack@google.com, gustavoars@kernel.org, jmorris@namei.org,
	justinstitt@google.com, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux@treblig.org, llvm@lists.linux.dev, mcgrof@kernel.org,
	mic@digikod.net, morbo@google.com, nick.desaulniers+lkml@gmail.com,
	paul@paul-moore.com, pmladek@suse.com, rmoar@google.com,
	serge@hallyn.com, tamird@gmail.com, wangyuli@uniontech.com
Subject: Re: [PATCH 3/3] Revert "hardening: Disable GCC randstruct for
 COMPILE_TEST"
Message-ID: <202505301234.4F2C365F@keescook>
References: <20250427013836.877214-3-kees@kernel.org>
 <20250530000646.104457-1-thiago.bauermann@linaro.org>
 <202505292153.14B0A688F8@keescook>
 <20250530190904.GA1159814@ax162>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530190904.GA1159814@ax162>

On Fri, May 30, 2025 at 12:09:04PM -0700, Nathan Chancellor wrote:
> On Thu, May 29, 2025 at 10:12:22PM -0700, Kees Cook wrote:
> > On Thu, May 29, 2025 at 09:06:46PM -0300, Thiago Jung Bauermann wrote:
> > > This commit was reported by our CI as breaking the allmodconfig build for
> > > the arm and arm64 architectures when using GCC 15. This is due to
> > > https://github.com/KSPP/linux/issues/367 :
> > > 
> > > 00:05:08 arch/arm64/kernel/kexec_image.c:132:14: internal compiler error: in comptypes_check_enum_int, at c/c-typeck.cc:1519
> > > 00:05:08   132 | const struct kexec_file_ops kexec_image_ops = {
> > > 00:05:08       |              ^~~~~~~~~~~~~~
> > 
> > I'm not able to reproduce this. Which specific version of GCC 15 and
> > on what distro are you seeing this?
> 
> It looks like this was also reported to Debian (I originally noticed it
> in the #gcc channel on OFTC a couple of weeks ago but forgot to mention
> it):
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1104745
> 
> It looks like the difference might be whether GCC was built with
> additional checks or not based on the last couple of comments in that
> bug.

Ah, thanks for the additional pointer! Yeah, discussion has continued
on https://github.com/KSPP/linux/issues/367 which shows it's a problem
for GCC builds configured with "--enable-checking=yes"

It seems like this check is overly strict? I'm building GCC now to see
which aspect of the plugin is tripping it... I assume its decl
finalization, but we'll see.

-- 
Kees Cook
