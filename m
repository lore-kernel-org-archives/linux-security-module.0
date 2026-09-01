Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8593DAAAE;
	Tue,  1 Sep 2026 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788304035; cv=none; b=eoHiQ1hAvLM2PO7nFJ87cQHVjwlZVaux8m7vP31MonGteYLbMDPBz+ypY6EOr9lX/EbIVO7AZ+D0J3n10prxRe5POV2kAY7NLtscLA48RRntYioW9KGMUO/JIvRyFIzMN5lQx42A0Bkqz3lgYNe/Rr8IJjSScSeGtKfoROye2sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788304035; c=relaxed/simple;
	bh=XPhBZfERHFCRM3HyBhuajafOUu1dexMUZgETVatNwr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zyzz6kPjqOLvZzWcUo39dgLAlpJeIyOcRYM4j9+by8yXffMg4n9UfOArQu5WadlLGUipBLFTL5BDyjOUOycDGNqUBQfiPj/G22lRGs0YlYh9YRQjBfm9bAMjZyRVGShy3EJvNXas123BoSvx8O8n3sGRsk7wxipqZtft/98AAnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h712+2U/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h712+2U/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FB21F000E9;
	Tue,  1 Sep 2026 23:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788304034;
	bh=Ta6tQ2H32bjPrPWTTtaFrxbICPs3CdJebq84JHMBupw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h712+2U/fntCWjNhtKisPucYG4ukrvp5X4uQQkcUOFws7Wr/rPFv4Q7CO1cORXIKM
	 cIrZPnClO0MDEUSdE/JJ+/fYwxLpw3YdxQ1NE4qqCRva5V7yH27jCHohGVMFu7RSeM
	 7h9gZV7yYRkXEDGfX54j35Z/UdHyUurh8QS8z72Yd4diNWRmPMs+/1QD+8Z1xopwMO
	 IAqn7TdFgeK97y9GOAlqi04g7JikqLqMLhKCoZmY3En/rH3om/6Ma5Zsbya8U+cMsS
	 KJwumwSO6c1BNdbvGP2vS1c9PzKm5SHlk2rrrjSc4r+3FJWYmo9Xf4OPcjIq/ONeM6
	 unCLPVI4g/FvA==
Date: Tue, 1 Sep 2026 16:07:14 -0700
From: Kees Cook <kees@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
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
Subject: Re: [PATCH v4] hardening: Default randstruct off with rust for
 better allmodconfig support
Message-ID: <202609011606.566F49A@keescook>
References: <20260901-rust-reverse-randstruct-dep-v4-1-3bfa19efe1fa@kernel.org>
 <CANiq72nOk-gbd+C9oG5y5RKrYhqNx+BLcwS-8u-uHxUjVTwEtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nOk-gbd+C9oG5y5RKrYhqNx+BLcwS-8u-uHxUjVTwEtA@mail.gmail.com>

On Wed, Sep 02, 2026 at 12:59:59AM +0200, Miguel Ojeda wrote:
> On Wed, Sep 2, 2026 at 12:52 AM Mark Brown <broonie@kernel.org> wrote:
> >
> > Currently randstruct does not support rust so we have Kconfig dependencies
> > which prevent rust being enabled when randstruct is. Unfortunately this
> > prevents rust being enabled in allmodconfig, our standard coverage build.
> > randstruct gets turned on by default, then the dependency on !RANDSTRUCT
> > causes rust to get disabled.
> >
> > Work around this by disabling randstruct by default if we have a usable
> > rust toolchain and rust support for the architecture, circular
> > dependencies prevent us directly depending on !RUST. This means we might
> > end up with a configuration that disables both rust and randstruct but
> > hopefully it's more likely go give the expected result.
> >
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> 
> I thought this was already applied:
> 
>   https://git.kernel.org/kees/c/3844a38c9c4a
> 
>   https://lore.kernel.org/rust-for-linux/178733378275.2181196.3186172911325132761.b4-ty@kernel.org/
> 
> But it doesn't seem to be in -next -- that branch isn't merged there I think.

I applied it but the push broke. I've re-arranged things now and push
it; I'll get this sent to Linus this week :)

-- 
Kees Cook
