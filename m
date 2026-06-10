Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAD731D759;
	Wed, 10 Jun 2026 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123841; cv=none; b=h05e4KwHhXSIdPiwO+L3zBtuuJ4SXKX90MrAADXkXM6Q1gzSkZspyEq1RAFqBByJq5wzYMspRWBsreut18+Fl1fHa/nyVqx9aFaMD5UdhOnKAYEVIIySnI+hJLKoJogRJ5lp0bhl7yHoXBQaDU89baVuvxOI52/t13lrk/POJuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123841; c=relaxed/simple;
	bh=I0CuHam3k6p138EbJhw0Ap3auK//qiMALgW7F81Qygs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZisYtLLzZsAqpl8tCCqXXUxQLvrgAFRLTPlXbovGLLn4qfPRsEqQ+MNz92gG+2NQ+Bqgqu+avJ+NQKHJoOl9FR++4C3kVNiZ8TuZEZLyn1nF96Zx5BEZOjv2EUY6o+KGpSBtyHhfvZ0RWIdzTtiiVl3Gp6PRYkWcRVxovIThvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmQetrxY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmQetrxY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A0D1F00893;
	Wed, 10 Jun 2026 20:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781123840;
	bh=WNLuc4BrQv6uydgtObei4m+qke5JuIFLlxLDNItDAoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jmQetrxY6LJMWtAd8dggq2GE/vTXJHlpVNtxRbF0WlyDt0fFrcwgoSaIjrIPIa0kl
	 yGzxn+rI4d/6xXjy4x8k9IAYy5pEAZgdixC7TiJ4parQPep8k4I3o0h4u6JWLU8IOK
	 gy+GI3O/wJqewSp71eVbPupPcy5roga5NMGL49cyJbcm7Uf5iRmWDwltaZlQ/wTSoD
	 8SYwtb1eKUBQIvXy0Abxn8oihKJbSwVVoAHDbhe9bQs72ttI8sK6ujMG0grsxPJKbf
	 aRefretYk78oRvReVGQ6vhJHfM8WDlKrHScxnr+79o8fHd6CAw7GEjAJ0LXqYT+dkv
	 WQoxn4If3YinQ==
Date: Wed, 10 Jun 2026 13:37:19 -0700
From: Kees Cook <kees@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] hardening: Default randstruct off with rust for better
 allmodconfig support
Message-ID: <202606101335.648C6993@keescook>
References: <20260605-rust-reverse-randstruct-dep-v1-1-45ce9ee8d0d1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-rust-reverse-randstruct-dep-v1-1-45ce9ee8d0d1@kernel.org>

On Fri, Jun 05, 2026 at 05:01:46PM +0100, Mark Brown wrote:
> Currently randstruct does not support rust so we have Kconfig dependencies
> which prevent rust being enabled when randstruct is. Unfortunately this
> prevents rust being enabled in allmodconfig, our standard coverage build.
> randstruct gets turned on by default, then the dependency on !RANDSTRUCT
> causes rust to get disabled.
> 
> Work around this by disabling randstruct by default if we have a usable
> rust toolchain, circular dependencies prevent us directly depending on
> !RUST. This means we might end up with a configuration that disables both
> rust and randstruct but hopefully it's more likely go give the expected
> result.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Can we instead just allow it? This has been ready to go for a while,
IIUC:
https://lore.kernel.org/all/CANiq72n=hgH4bqJjp8MsMHAaxaAo75GSBcHGTvFT3NTSaVPGWg@mail.gmail.com/

-Kees

> ---
>  security/Kconfig.hardening | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 86f8768c63d4..1677c4f9637b 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -285,7 +285,7 @@ config CC_HAS_RANDSTRUCT
>  
>  choice
>  	prompt "Randomize layout of sensitive kernel structures"
> -	default RANDSTRUCT_FULL if COMPILE_TEST && (GCC_PLUGINS || CC_HAS_RANDSTRUCT)
> +	default RANDSTRUCT_FULL if !RUST_IS_AVAILABLE && COMPILE_TEST && (GCC_PLUGINS || CC_HAS_RANDSTRUCT)
>  	default RANDSTRUCT_NONE
>  	help
>  	  If you enable this, the layouts of structures that are entirely
> 
> ---
> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
> change-id: 20260605-rust-reverse-randstruct-dep-5a504c861128
> 
> Best regards,
> --  
> Mark Brown <broonie@kernel.org>
> 

-- 
Kees Cook
