Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635141FE44B;
	Tue,  4 Mar 2025 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083291; cv=none; b=bZgv1Hbi994ZoFcsCHCHi3ZDK946Tzm3VonofEXjR2vsMl62cvqfZjWGmJ5Mp1aqQvljBXTcgbQPFUHraV0DN8hHpvfMKAcgOndQ9rvsL1ZjSdRYzE3X/EdSM+dGuBXqE4D6EjE6sOFT0hOR/JlriXb/T3QZAXfO5JO7nL4gqRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083291; c=relaxed/simple;
	bh=TjLOJqtB1F8hWRkkxRuwtt8t9SXz+Ki1Fz1mo89VUes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUcYXqsk1aujR1Jq74jXvSzlnSIlyS3jaI3EJ2Npj7rMQEMqsiv32eDsLzy9BOPtD9GGCBW94zTg/ZojLA7q3vqhOFvN1I0nlC5y4dusfo1gdozohGn/DkdpTXsOXE0yp9fqAEsGWZnY6AF1NjK+8CaKHZSpHcmqsvk3HFHroC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3m302a/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3m302a/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682A1C4CEE5;
	Tue,  4 Mar 2025 10:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741083290;
	bh=TjLOJqtB1F8hWRkkxRuwtt8t9SXz+Ki1Fz1mo89VUes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3m302a/k0SfOsBi02IpT15HnKL9GkqTwtq4VDlznbcFLhhbO8qGT5stRieyuqFUU
	 Esj2vlfXMImK2e8p+rT7XVIsld8Hd2GUg0KnZuZZDkfNxT6kCD24DlDwCP5Dpmj8LX
	 yd8nEeKCEdhs8jkxw1jcMuQAXvPDxiUz5kKgB2tjLp/TZI5numzst116MB9d0vuED4
	 qOqPFnysZefOCUrxGMpo1wLKlJCGiDgCS/xvXFbKH9jFUW1hRtNSBevBsZm8oY5Jhn
	 LOrg73y4t72P2COBKf3cRfc1VAHGgpGYxWwHwF3SnswPnz0wu4pcyn8BfDlyecQRNC
	 Ae7EcWqlzVDVA==
Date: Tue, 4 Mar 2025 11:14:45 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] hardening: Enable i386 FORTIFY_SOURCE on Clang 16+
Message-ID: <20250304101445.GA2529736@ax162>
References: <20250303214929.work.499-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303214929.work.499-kees@kernel.org>

On Mon, Mar 03, 2025 at 01:49:37PM -0800, Kees Cook wrote:
> The i386 regparm bug exposed with FORTIFY_SOURCE with Clang was fixed
> in Clang 16[1].
> 
> Link: https://github.com/llvm/llvm-project/commit/c167c0a4dcdb998affb2756ce76903a12f7d8ca5 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Yes, thank you for catching this!

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

I assume you'll take this?

> ---
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: llvm@lists.linux.dev
> Cc: linux-hardening@vger.kernel.org
> ---
>  security/Kconfig.hardening | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
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
