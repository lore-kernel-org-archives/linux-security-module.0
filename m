Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E36A166F0C;
	Sat,  8 Mar 2025 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741425473; cv=none; b=fW4bujYhYNm17n0WUxcX8/PXEELqDp6yg5Flhc0kOW91pAoiLKyOqfAg0WgM864XF2YwhB5GnbC0g+qcyDF+Vipmwkmmn6SEP4IaIRESj2Htm8grIEGYUM77vK5Mrj/fVr9cEWoa753MqDDHrtHAZtAdJ1jKuA/JPRPn9Q7KgHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741425473; c=relaxed/simple;
	bh=8yWi5YlMaRusNxN05xdETgqejjnPLkH6v1+Nb4QMNMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFK9P8MJIg3bwnO7ifGtyAHz60sN4HmwnAipqMGC/X/wusA5WiIBrwCTXSud18wtyp2eFcGQQjsbBhF8R1USwMOC+jcHdgL+WrZPlum5v5fBBYAgeMksTgGZE+cMf+wQD6yBUEGgrrX0jZ92Zge4yup0pfpflz10wt4VY5opwMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxHZjqa0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxHZjqa0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0378DC4CEE0;
	Sat,  8 Mar 2025 09:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741425472;
	bh=8yWi5YlMaRusNxN05xdETgqejjnPLkH6v1+Nb4QMNMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxHZjqa0vNuPBfsrKJbkd2lA7ZBGEVwI7vkXvyMRN0i6OES6/rhurb/+xjy578AI7
	 c3TNheYp2fA8Ol561+ddzIH5kbo2UsddYb3pSVCwg9jpQhHv7PzMKs9yGhdfYGwwtu
	 2OpxkcQj4MR1tjPREXiUforCyN9BKwhF76nzO0rjIN2O0+NF2rpKPgK4jcKeYg6+P3
	 Naq74Ex70/LNqoES+3a25WwdbPgBPuCKIc+mp4UZowh5RrthTNJv6SZ/JTrMUHZXk1
	 2Xtja7rgabNeM9qVkVIUl3F81SeoCPnlSQ/AZBcnHJhHRWsvUi/M49jRZqvkDBNKJ2
	 z3AE9HhMymizw==
Date: Sat, 8 Mar 2025 10:17:46 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 1/2] x86/build: Remove -ffreestanding on i386 with GCC
Message-ID: <20250308091746.GA707537@ax162>
References: <20250308041950.it.402-kees@kernel.org>
 <20250308042929.1753543-1-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308042929.1753543-1-kees@kernel.org>

On Fri, Mar 07, 2025 at 08:29:25PM -0800, Kees Cook wrote:
> The use of -ffreestanding is a leftover that is only needed for certain
> versions of Clang. Adjust this to be Clang-only. A later patch will make
> this a versioned check.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

This could also adjust the comment but it is probably not that big of a
deal since the "temporary" is already pretty stale.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>  arch/x86/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 5b773b34768d..d25ed25fb7d9 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -137,8 +137,10 @@ ifeq ($(CONFIG_X86_32),y)
>          include $(srctree)/arch/x86/Makefile_32.cpu
>          KBUILD_CFLAGS += $(cflags-y)
>  
> +    ifeq ($(CONFIG_CC_IS_CLANG),y)
>          # temporary until string.h is fixed
>          KBUILD_CFLAGS += -ffreestanding
> +    endif
>  
>      ifeq ($(CONFIG_STACKPROTECTOR),y)
>          ifeq ($(CONFIG_SMP),y)
> -- 
> 2.34.1
> 
