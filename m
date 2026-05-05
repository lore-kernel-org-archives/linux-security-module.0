Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF2A39A04A;
	Tue,  5 May 2026 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997141; cv=none; b=ISMH0gbe7uvGm6/lu+l3WBxCoGeYN4JU7LynH1FTQRY6fVqmwXGI3OSAMq13yl8VTnOOM0YLmKOqZ6whciaUUEda6sl/GjSRZj2r0RpIHnimFmDaMCDteNNoEzMfgFaihB8kK65lJvSbjUaETpuC5aBwTC02mePT8hOoL+AQQRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997141; c=relaxed/simple;
	bh=rFm9xnJSKG9HZzI7L5qyW88aCxcU0vE9Z40hIbjznno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFo9lhmiuXs1XZi1oDDQo/iIpqy1kXOhQLMvU2cXxRjaGd643JK2s/Eqr4Vt63yS6TbbM2w81mtDEr68pdRTGjDU+QZqzhT1kUM0oPjWZDA/woQOT9Y79TWwUKffrHoBqHAS9/goWjxpuO1YgbaSk3sihG5S4A2WHeETRdlf8+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWfB7JnN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWfB7JnN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B633CC2BCB4;
	Tue,  5 May 2026 16:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777997141;
	bh=rFm9xnJSKG9HZzI7L5qyW88aCxcU0vE9Z40hIbjznno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FWfB7JnN6pQERqN0+aQ8xcM0jiwYk+bKy0KO7hkIcE825Q/6GPAiHgqpreVNRSuSN
	 M6OysJaauaGvsd3NG2YgX3RPGoaML0Vwu6cpCfecTBKQ6+dJx+s+7R6YeIzPAxg7Vt
	 sKjoe/BAcKD4f6U9QbHymO0CzVj9yWIz26SY5HNkZDhOdRPj6SoV1gbZhJtBgl7kzg
	 ILiWnm09w39w6qxiZjUl63hmwhdmxKHfrOHSC8gZR/iis/9jlaGk+ZiN66l0xjK7oF
	 y+XxbB9xwq8v/KxBHgs9vzpBBl7kmWeiTqrQEvzz9MfBhaUHuamKMJvit/KaTMJFKH
	 8KwN5MtRKpHpg==
Date: Tue, 5 May 2026 17:28:32 +0200
From: Nicolas Schier <nsc@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-kbuild@vger.kernel.org, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 03/14] security/Kconfig.hardening: Remove tautological
 condition from FORTIFY_SOURCE
Message-ID: <afoMoBlj9g6y53qJ@levanger>
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
 <20260428-bump-minimum-supported-llvm-version-to-17-v1-3-81d9b2e8ee75@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-bump-minimum-supported-llvm-version-to-17-v1-3-81d9b2e8ee75@kernel.org>

On Tue, Apr 28, 2026 at 10:59:09PM -0400, Nathan Chancellor wrote:
> Now that the minimum supported version of LLVM for building the kernel
> has been raised to 17.0.1, the '!X86_32 || !Clang || Clang > 16'
> dependency of CONFIG_FORTIFY_SOURCE is always true, so it can be
> removed.
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Cc: Kees Cook <kees@kernel.org>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> ---
>  security/Kconfig.hardening | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Nicolas Schier <nsc@kernel.org>
