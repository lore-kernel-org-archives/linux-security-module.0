Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C5D322B;
	Sat,  8 Mar 2025 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741422375; cv=none; b=QmO6BMu4bQcfR0I/qlxQ4oLDdG7DcpS+bmWCaZvheSfSzfYJF9pczFak91NDxM9qKoub2ibDzsyu9ZlQirqDAIWkKRU7+hYhKgVPSlnM+4zun5Gs47wAQ3Nufb2gZM6Kf3SnKhphhLapc1HZx7u9/AJdSw1hGjYSodfLkj6Vvqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741422375; c=relaxed/simple;
	bh=5NmQq7IFrZ8PPMVbfFo861HS0RUiVMRm/7X61nWwhVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ct7phIvEaMvOye5QLRana5GoWW84+T0KV2zu4+RfaUu3o5h7UQbCscSIYK+Z8PvRLfYJuFvwb38L8f6Faqp87C6M/mnYEDQ6ABuCF0DWJO+BthRMQxdQ5uRVWR5a7jYuigHf+MLA0oue2zHb8Dz8LjL2q0iaX2hLqhSIJtRR20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YV+YV/MZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YV+YV/MZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F71C4CEE0;
	Sat,  8 Mar 2025 08:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741422374;
	bh=5NmQq7IFrZ8PPMVbfFo861HS0RUiVMRm/7X61nWwhVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YV+YV/MZ/xtTTaU3uMKpCnpzaLD8t5hEaaQhrA3utDfHjRj5U/JCRMBWLZr1QeckR
	 vLNZsrvAD7cDGvxKej7LevAKRCV8JwZJEyigeclPfDiErpKypZT3KfHRgw73cbDM2N
	 VzEJupgIBgNlTe4kdFOn+iS2vEXA0ngY+ONGzGx32GkEU4BPfUexf8SjKm3AIaZZKI
	 4lEWLkpEh1Xhbq/jjZYE/NbYQFt5TDswebhhpdLHqaaX83ie5vdgVJ2WFlCRhes6OY
	 GIIRCHx0rkA4hKMOEcIJCZMEWXdxZldCPp3RrZYpy4l/3+Au725MZkTQ9fMf1dOifx
	 uGgCDcFuujxvA==
Date: Sat, 8 Mar 2025 09:26:07 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
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
Message-ID: <Z8v_H2sLZ-cP_3NA@gmail.com>
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


* Kees Cook <kees@kernel.org> wrote:

> The use of -ffreestanding is a leftover that is only needed for certain
> versions of Clang. Adjust this to be Clang-only. A later patch will make
> this a versioned check.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
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

Acked-by: Ingo Molnar <mingo@kernel.org>

	Ingo
