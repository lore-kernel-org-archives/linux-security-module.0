Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD4E36403B;
	Wed, 10 Jun 2026 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781124080; cv=none; b=ss25ohpdAZsMcK7ptxVKrMZzyWh2e1nNZuD+2rbn/x09vFxpf6z5P0MpGrRQ/U63krrDLXiXgyGNQoI+jM6h1uBR3o3N5n2LpDxU3nlvTMK6su9/+S6RRlVqODS7+tmcOtPcWwdnsMr31iGYAtLpX/3QblMyYr6xoeq3v/JOsUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781124080; c=relaxed/simple;
	bh=CrYU9c+aOzFxaaEv3bIfY6aqknlJ7eFaNLpNhegs+LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8svsfqY8+eCUKYhBbiMdc5ZW7WEbQx15X3U6jlEYDcgNVJrj67R8UZobcWSVRvmPGfuNd6N1UKA9jhfj7/8ag1RPopxCuuKJEz30qKwPRtOI3dImmczbvijbU7xcj4LYRqgWZ2tbEnSZslxpK4dufAfGBcbKgi/zih3kiiA1cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpVeEsPE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpVeEsPE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A9E1F00893;
	Wed, 10 Jun 2026 20:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781124079;
	bh=bIYmc840JBehM1qGGcBwhXb/MKLSDjWNFq2WMKIFXnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XpVeEsPEvuDIVCkF00769WEqBgDO9mYnM5SivgeDQXHOVq06z8I1ua1/bvMob2Do/
	 iw0RFvIx1Aij+A2RpAS5DcH71yxhoj8zZcYI45IL6ykix/NR4MCYK1wZJppyh5oRQH
	 6lIerJiAusjm1/xMl9Cn3rhRJS3ZcINUKxAKr2djojSdMuiRwR2COgWMTROE+LromF
	 MAJEhq9SPXBFPM39bONcU9okDVJkFNr6Z+5t4frpbh0yViUrSrFnZH3nELrV+T8hBz
	 13y9w2ijGzPDWA3gEhC4baL/1nLHONDXoM+EkKu4Z9B3KbSAHmOrN6Twq9nelvcf0v
	 nLY05JL7io1FA==
Date: Wed, 10 Jun 2026 13:41:19 -0700
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
Subject: Re: [PATCH v2] hardening: Default randstruct off with rust for
 better allmodconfig support
Message-ID: <202606101339.66BFE3AA67@keescook>
References: <20260605-rust-reverse-randstruct-dep-v2-1-93d38023b6f9@kernel.org>
 <CANiq72mmzfBg0_y+TMTsUUuO0cJFE0=n60-ttwOynai06_y=zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mmzfBg0_y+TMTsUUuO0cJFE0=n60-ttwOynai06_y=zg@mail.gmail.com>

On Fri, Jun 05, 2026 at 07:22:54PM +0200, Miguel Ojeda wrote:
> On Fri, Jun 5, 2026 at 6:51 PM Mark Brown <broonie@kernel.org> wrote:
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
> Thanks Mark!
> 
> Kees, Gustavo: applying this would help Mark's testing of Rust in
> linux-next, which is important to keep.
> 
> An alternative would be to move forward with `RANDSTRUCT` support:
> 
>   https://lore.kernel.org/rust-for-linux/20260323130224.165738-1-ojeda@kernel.org/
> 
> Either the conditional (on the Rust side) or the unconditional
> approaches (modifying the C side) should be fine, i.e. whatever
> Kees/Gustavo think is best. The unconditional one would make things
> easier on the Rust side, but it is a "bigger" change in terms of
> impact. We can always start with the conditional one instead.

Oops, I missed this v2. :)

For the linux-next testing, are you doing GCC + llvm rustc builds? IIUC,
then the support patch mentioned, I think, doesn't actually solve the
problem?

-Kees

-- 
Kees Cook
