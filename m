Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3BDC2FA;
	Sat,  8 Mar 2025 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741425559; cv=none; b=oTcIULLNGnenquPGw6GZkIfIFge+qp3ln17fbRKyHGE+FSQ/ud8s+uJ1yLr/LKgV++JY47zLsC9fO6x5GmA/tj485Fi4Y4/76o9fOnEvlcfGQhQS2frBGqVVv+AqVKr3ZkXtpDeKBjbxIcVhE/ACb/pArNMublwIAPZJzdGyudc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741425559; c=relaxed/simple;
	bh=Ieg1q79Hcv6gSb0ZE6qA+0UrSjfMW6nYXnbS6hAMk+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1OGHvsksf9jsW3rDaUJJfOtfbOmU26lg7IG074SOOv0BZPVUuA3iggXr/9j0cAq0uBtlTb0qPq4J0XdIlM2ASHt7Cfm6IlwaWcfxf3ufhWikQaxDF0IYZr1Tn7gYmuPf9+nfAZ6+RGwRNa32RpcwdyNED6UqhOr3IBy5w41UiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAp6aWmJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAp6aWmJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07A8C4CEE0;
	Sat,  8 Mar 2025 09:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741425558;
	bh=Ieg1q79Hcv6gSb0ZE6qA+0UrSjfMW6nYXnbS6hAMk+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fAp6aWmJeivv6QyATp3ReT0ECaz2v6QFa3bsz/ovFWr3P+gEO4WtTdj9mBb3shHbG
	 sOZ/QBpqyAfGeXLYW/guDzyOtAVVgIad1IDo+HlSY2AD++IGSIZb+S9NMIhLQ9yBvj
	 ba9CnPWx108dFCY4g5EcusV2QgUtt3I2kk/aPfK+0DpSPc4wYcWoaL1rhC35yUG553
	 s9cvwBs9YypMHs7zMhiaICdpOZcKulSrRaldeQYmz7LDMfMp1zVfDayZ5YSGbrAbk5
	 OkN36DTGyCgIlCvXOf/26IQWbjnSECMAf0Nf4/zLP2wS9+uiKRA8NfWYQL0yGoixQa
	 U2HMR6oX+G1ag==
Date: Sat, 8 Mar 2025 10:19:11 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/2] hardening: Enable i386 FORTIFY_SOURCE on Clang 16+
Message-ID: <20250308091911.GB707537@ax162>
References: <20250308041950.it.402-kees@kernel.org>
 <20250308042929.1753543-2-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308042929.1753543-2-kees@kernel.org>

On Fri, Mar 07, 2025 at 08:29:26PM -0800, Kees Cook wrote:
> The i386 regparm bug exposed with FORTIFY_SOURCE with Clang was fixed
> in Clang 16[1].
> 
> Link: https://github.com/llvm/llvm-project/commit/c167c0a4dcdb998affb2756ce76903a12f7d8ca5 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/x86/Makefile          | 2 +-
>  security/Kconfig.hardening | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index d25ed25fb7d9..917459d1ad40 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -137,7 +137,7 @@ ifeq ($(CONFIG_X86_32),y)
>          include $(srctree)/arch/x86/Makefile_32.cpu
>          KBUILD_CFLAGS += $(cflags-y)
>  
> -    ifeq ($(CONFIG_CC_IS_CLANG),y)
> +    ifneq ($(call clang-min-version, 160000),y)
>          # temporary until string.h is fixed
>          KBUILD_CFLAGS += -ffreestanding
>      endif
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 23ffb0d7c845..c17366ce8224 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -286,7 +286,7 @@ config FORTIFY_SOURCE
>  	bool "Harden common str/mem functions against buffer overflows"
>  	depends on ARCH_HAS_FORTIFY_SOURCE
>  	# https://github.com/llvm/llvm-project/issues/53645
> -	depends on !CC_IS_CLANG || !X86_32
> +	depends on !X86_32 || !CC_IS_CLANG || CLANG_VERSION >= 160000
>  	help
>  	  Detect overflows of buffers in common string and memory functions
>  	  where the compiler can determine and validate the buffer sizes.
> -- 
> 2.34.1
> 
