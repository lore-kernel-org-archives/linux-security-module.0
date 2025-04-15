Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97149126C02;
	Tue, 15 Apr 2025 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744749722; cv=none; b=JpgN32wEKoU4zjmb/oLBjoWB2yW9zsUASi3irhyKJcBX7hX663M2ieFThqzmLiywydvZUGxjz34KpH3ORuRV7LKjGDaj7a54FW7I8z/AE1owEC9xvsdIzlEmw2YpUIClpkGiqyOJ9Kx+6hhzuKbgvIrkJ9TuOWF4c/+fF92fS7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744749722; c=relaxed/simple;
	bh=opheAtX//x+lw5vt44IeJqSekfCNd1b79Q3bJ8mQAq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaufDXnf9KzUzXu0LEMzCX2ap1tNbUGQ+XLT5oZAFdzxBWbCQV+iq8P61rlBxAhKwcsrzJldiwfzV+1niPRlDlFZ5hzqPhGBX9OgOjMSCj841bUfATEzLlTE7veRevfhM2Eudfk3o5CTvdOvvOgkVoHFmpMm1PkJqfzQms2oDXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tS795/B+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tS795/B+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36F1C4CEE7;
	Tue, 15 Apr 2025 20:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744749722;
	bh=opheAtX//x+lw5vt44IeJqSekfCNd1b79Q3bJ8mQAq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tS795/B+hWHKeS4pVkotwTwgDOco6yG4cFPSfgDl9HS8AThg0GV8hjjIPLl+ntx9G
	 CTugkMjpXUHFco2pmHxhxhcH3702TJht2Ko/0IxiritIioztt9nMeQ90MxkcCJwvVY
	 9/IP/cTXg7bHBn+BPg/05cHs4YVZRUSnpE6+NUgqyW4iRcBpfZRwpjWmaW+Cgw7KYj
	 KvAe6vNXB95NMh8eECHxBF8DdjlUDonOxkL10KntzGi/wH1qLp8VP0unDTdgbCWGIi
	 PWizGgWdC5yvpYPGIlg5l0RGwn7EDt1V66jwhTdHI2P3kwk7/onGGqxBW4j9aww3eb
	 WDzOWWFJDy6Fw==
Date: Tue, 15 Apr 2025 13:41:58 -0700
From: Kees Cook <kees@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: broonie@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
	mic@digikod.net, gnoack@google.com, Arnd Bergmann <arnd@arndb.de>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
Message-ID: <202504151341.C84890628@keescook>
References: <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
 <mhng-812ee330-2f86-4561-8b88-cbb6a51f8515@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mhng-812ee330-2f86-4561-8b88-cbb6a51f8515@palmer-ri-x1c9a>

On Tue, Apr 15, 2025 at 01:26:34PM -0700, Palmer Dabbelt wrote:
> On Mon, 07 Apr 2025 13:57:32 PDT (-0700), broonie@kernel.org wrote:
> > In current mainline x86_64 allmodconfig builds done with tuxmake GCC 13
> > and GCC 14 toolchains (which are Debian ones packaged up into containers)
> > generate ICEs in landlock:
> > 
> > Event                            | Plugins
> > PLUGIN_FINISH_TYPE               | randomize_layout_plugin
> > PLUGIN_FINISH_DECL               | randomize_layout_plugin
> > PLUGIN_ATTRIBUTES                | latent_entropy_plugin randomize_layout_plugin
> > PLUGIN_START_UNIT                | latent_entropy_plugin stackleak_plugin
> > PLUGIN_ALL_IPA_PASSES_START      | randomize_layout_plugin
> > /build/stage/linux/security/landlock/fs.c: In function ‘hook_file_ioctl_common’:
> > /build/stage/linux/security/landlock/fs.c:1745:61: internal compiler error: in c
> > ount_type_elements, at expr.cc:7075
> >  1745 |                         .u.op = &(struct lsm_ioctlop_audit) {
> >       |                                                             ^
> > 
> > Arnd bisected this to c56f649646ec ("landlock: Log mount-related
> > denials") but that commit is fairly obviously not really at fault here,
> > most likely this is an issue in the plugin.  Given how disruptive having
> > key configs like this failing let's disable the plugins for compile test
> > builds until a fix is found.
> > 
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > ---
> >  scripts/gcc-plugins/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
> > index e383cda05367..29b03c136165 100644
> > --- a/scripts/gcc-plugins/Kconfig
> > +++ b/scripts/gcc-plugins/Kconfig
> > @@ -7,6 +7,7 @@ config HAVE_GCC_PLUGINS
> > 
> >  menuconfig GCC_PLUGINS
> >  	bool "GCC plugins"
> > +	depends on !COMPILE_TEST
> >  	depends on HAVE_GCC_PLUGINS
> >  	depends on CC_IS_GCC
> >  	depends on $(success,test -e $(shell,$(CC) -print-file-name=plugin)/include/plugin-version.h)
> > 
> > ---
> > base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> > change-id: 20250407-kbuild-disable-gcc-plugins-8701aa609cb3
> > 
> > Best regards,
> 
> This one's been biting me too.  It manifests for me on gcc-12 and gcc-13
> (both locally built toolchains off the release branches, cross compiling for
> RISC-V).
> 
> Tested-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks! This is fixed differently in -next:

https://web.git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-linus/hardening&id=1ded828affa35f4b216e99f53d8d031a392f2b0a

-- 
Kees Cook
