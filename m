Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFCD48AE1C;
	Tue,  5 May 2026 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997139; cv=none; b=kl7aL8H3dfu9eLde6/GcAA6dYqugG1MbRBdmjUJF3vGL3qufWhefYOuZqepqZe/JZ3NKKweDGfO15VfSTxnwnFirIkGNExaVeSH/vpmXmy/VNcAO7IK0NWeLYKX7ho5W9qRxUR2HnGzT5CUqUPP7+L2X866QVXxt5jCDTFZldLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997139; c=relaxed/simple;
	bh=7zNPFc12exPhGgF7PMlTdQowXHey/2l+j7ROFylrMTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYOv2mMLOo+TcO4hKyY9Qmiz0VxQfBhQnc2BKXwDde40xgtPSuekaU+ZCyHXgrWaHv7L9uuAIioIGCO77ofdIfEf3X0BQjcQlw0rTIwidD4j0oxWaeR4XCuGm2NNPiCXGXXvq4QrjtxXnfY+XY31LPS5l7jnMJRfv3b4Va1BZOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ibgop1N0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ibgop1N0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F14DC2BCB4;
	Tue,  5 May 2026 16:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777997138;
	bh=7zNPFc12exPhGgF7PMlTdQowXHey/2l+j7ROFylrMTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ibgop1N0nl70mf5oo1cbtJnYLuubcY5vZMWpaR5BIXsiZYVqbP4SjbNlpO0UGdcHB
	 zrQHp+B57fdRYshzwWwBbctR0HXwpPvTZkoFpnT1h8PT696vV7FxeeFISUcV3QJyRF
	 pk+jnckNg5sQ+6blT8/ebTmJPifOACBbsQ9KY+95y2sDOkDE+eX62OJK0zoc56t71i
	 2ro56PAW6kEAjztg+iYsgUqnW4C/0aawQFBkHYefR7yhHbz6wbfmMIuOUQZEZBTN7b
	 97JjmcDydhLbAmDmXOYHRQBdnaU0PjJc/l4owkG5j1x3COXf9DxIrWSubCugsGe4KG
	 pybYfJNt9BhWA==
Date: Tue, 5 May 2026 17:28:13 +0200
From: Nicolas Schier <nsc@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-kbuild@vger.kernel.org, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 02/14] security/Kconfig.hardening: Remove tautological
 condition from CC_HAS_ZERO_CALL_USED_REGS
Message-ID: <afoMjYVaoWTq462w@levanger>
Mail-Followup-To: Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-kbuild@vger.kernel.org, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org
References: <20260428-bump-minimum-supported-llvm-version-to-17-v1-0-81d9b2e8ee75@kernel.org>
 <20260428-bump-minimum-supported-llvm-version-to-17-v1-2-81d9b2e8ee75@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-bump-minimum-supported-llvm-version-to-17-v1-2-81d9b2e8ee75@kernel.org>

On Tue, Apr 28, 2026 at 10:59:08PM -0400, Nathan Chancellor wrote:
> Now that the minimum supported version of LLVM for building the kernel
> has been raised to 17.0.1, the '!Clang || Clang > 15.0.6' dependency for
> CONFIG_CC_HAS_ZERO_CALL_USED_REGS is always true, so it can be removed.
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Cc: Kees Cook <kees@kernel.org>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> ---
>  security/Kconfig.hardening | 3 ---
>  1 file changed, 3 deletions(-)
> 

Reviewed-by: Nicolas Schier <nsc@kernel.org>
