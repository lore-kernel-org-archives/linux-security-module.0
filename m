Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0873718991E;
	Fri, 30 May 2025 05:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748581947; cv=none; b=aEiTyQpz4Y8Nsym1zEWaPbe66vE9xj9lBdTFb8/gat3UpkyIjRLuEOVGHF6+q7eOv/zNAPvpwHx1NkmLCbQo3CNR/ZpHoMgDrVDupe0Q7UHvgjtoAT36K7LBkvNfs8NfRBQdghKjo06z1pgELvgJkbaBvoNRyv1X5jmCbBXMTNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748581947; c=relaxed/simple;
	bh=HtH9UrXXUqLFmGSWe/vDckMHlRYEnS2W+1K5vek19d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3P3NtMTLnpN4vpNuWhuLO9s91brsQ9Yvw902VSV/Pt07/BQEfMTcbhFXo9XEnVtidaL+7cnjWzCm3N72+2tJQnT4vGZZQYiaYOyA0EWdAlVQZFgyuh4hvs4VJ4qBFvZM1ghoIttDmIFpowgTVlVnF/cQUCCsCu4ikS88zmXbcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+0g+mc9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+0g+mc9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688F5C4CEE9;
	Fri, 30 May 2025 05:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748581946;
	bh=HtH9UrXXUqLFmGSWe/vDckMHlRYEnS2W+1K5vek19d8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I+0g+mc9stSvads61VU+EWCCKmJZBv+FWE3/q4OfviImpz/dbtV2EJo7GgtbAFWKG
	 W0f7mmmlUiRKL9cO9Vy3gQsY/DRqw9m4pmahObHh23M4KvLjCGIXx9vEAb4CwmJzal
	 GlisZ/IXRbEIE4J+AjfCULM4zaShxF8kKV0HpbL62iTsJw/ausgevlrG6INpK+EQib
	 MtFqdwdhVUJ2scdEk1UZ6lHROjDkCEbwEtk5eG9y86fnWzTQk0PTjn2RiPhQX9qG6T
	 NbC6CdpvnVe865BimHtTXHw/uaPJXoQ78HMyh9qbQbGuCIxlD8KKYGcvj/isP0HbES
	 4QDwb37r3iFng==
Date: Thu, 29 May 2025 22:12:22 -0700
From: Kees Cook <kees@kernel.org>
To: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Cc: akpm@linux-foundation.org, arnd@arndb.de, broonie@kernel.org,
	davidgow@google.com, diego.daniel.professional@gmail.com,
	gnoack@google.com, gustavoars@kernel.org, jmorris@namei.org,
	justinstitt@google.com, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux@treblig.org, llvm@lists.linux.dev, mcgrof@kernel.org,
	mic@digikod.net, morbo@google.com, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, paul@paul-moore.com,
	pmladek@suse.com, rmoar@google.com, serge@hallyn.com,
	tamird@gmail.com, wangyuli@uniontech.com
Subject: Re: [PATCH 3/3] Revert "hardening: Disable GCC randstruct for
 COMPILE_TEST"
Message-ID: <202505292153.14B0A688F8@keescook>
References: <20250427013836.877214-3-kees@kernel.org>
 <20250530000646.104457-1-thiago.bauermann@linaro.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530000646.104457-1-thiago.bauermann@linaro.org>

On Thu, May 29, 2025 at 09:06:46PM -0300, Thiago Jung Bauermann wrote:
> This commit was reported by our CI as breaking the allmodconfig build for
> the arm and arm64 architectures when using GCC 15. This is due to
> https://github.com/KSPP/linux/issues/367 :
> 
> 00:05:08 arch/arm64/kernel/kexec_image.c:132:14: internal compiler error: in comptypes_check_enum_int, at c/c-typeck.cc:1519
> 00:05:08   132 | const struct kexec_file_ops kexec_image_ops = {
> 00:05:08       |              ^~~~~~~~~~~~~~

I'm not able to reproduce this. Which specific version of GCC 15 and
on what distro are you seeing this?

This is Fedora 42 for me:

$ aarch64-linux-gnu-gcc --version
aarch64-linux-gnu-gcc (GCC) 15.1.1 20250425 (Red Hat Cross 15.1.1-1)
...
$ make O=gcc-arm64 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- allmodconfig
$ grep RANDSTRUCT gcc-arm64/.config
# CONFIG_RANDSTRUCT_NONE is not set
CONFIG_RANDSTRUCT_FULL=y
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
CONFIG_RANDSTRUCT=y
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
CONFIG_RANDSTRUCT_KUNIT_TEST=m
$ make O=gcc-arm64 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- all -s
$ file gcc-arm64/vmlinux
gcc-arm64/vmlinux: ELF 64-bit LSB pie executable, ARM aarch64, version 1 (SYSV), statically linked, BuildID[sha1]=b53656cb73bb82f4e19edbfa54241c203daa3fed, not stripped


And the new KUnit randstruct selftests all pass as well:

$ ./tools/testing/kunit/kunit.py run \
	--arch arm64 --cross_compile aarch64-linux-gnu- \
	--kconfig_add CONFIG_RANDSTRUCT_FULL=y randstruct
...
# Totals: pass:5 fail:0 skip:0 total:5



-- 
Kees Cook
