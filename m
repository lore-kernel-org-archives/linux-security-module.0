Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2013DAAAE;
	Tue,  1 Sep 2026 23:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788304052; cv=none; b=Vfi/Fbp2IpHhYCu6TWOVNxby6rvK74RFQeVJ7pGfcQOdVD/JQ3z93yEXL8ulPzlzCkLolBuAOjHZZgV6aKZgDNLDKEI2LIaFC1AIHMTU7p+627ZMrZmfLra+CFiOL5FxEO1lLBnM21oQ08E4LB6w5C9S6JcMe6BgeBRxV9orYQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788304052; c=relaxed/simple;
	bh=i63y7r98zPdQhcmDnBCiNOhfAZFF71DuJYrpPUzIFWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/+o24NG2+ufewA3NqV2Km/pQk7GIcFfJHcwaclOuYP3uQmjwgjVIIkaKQeKVT51Tdx9HCtbNr+ztwT+mmvPQtO8sKwx6+52INvJM9HTMDK7mCo1Za+0FZWFFymFf9QIjt7/bf/EM8FXd9e/Ax8C/GKFHZiLLPw8bA4UhIVsQ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHqPdlv0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHqPdlv0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165091F000E9;
	Tue,  1 Sep 2026 23:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788304051;
	bh=C3anIUeB1bB58RQmTGiNdJUaxEJ2R6teXFLUx/u9Y3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hHqPdlv0zWTfOqpyAorrq1BUAPYRxDE0+9/9NBWB4+t64z+3FpWiLxhHavPnLJDvq
	 ZPwbarGNxBeExKE3qfQRM9scHGW14xfkLZwcYB7CqvlW6/KpFomEa8z9JDP+VHxP/s
	 uytYtFAjtRo7v3tbYoG0VNtF5IySJz+2fRJfRSGtBmf5SzUFuVgDgXIryD0qo+TeUM
	 VGCwIghYTktnHn1prcHYcuKjsWDnJtFxZMSXjTURAQwQvYl4uVsp5dOYZwPzAw3MQa
	 B/3hjwdUVhlVrJX6LPNkaHrz3xdahiEgxfM+pdfOc7bw8o0keXJRTZDN3OaYVhUOOq
	 VJLf2i4oBh6MQ==
Date: Wed, 2 Sep 2026 00:07:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
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
Message-ID: <87236b36-fa99-4588-8181-f3ab6dcfc777@sirena.org.uk>
References: <20260901-rust-reverse-randstruct-dep-v4-1-3bfa19efe1fa@kernel.org>
 <CANiq72nOk-gbd+C9oG5y5RKrYhqNx+BLcwS-8u-uHxUjVTwEtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3KtuDqqo+l8OieTH"
Content-Disposition: inline
In-Reply-To: <CANiq72nOk-gbd+C9oG5y5RKrYhqNx+BLcwS-8u-uHxUjVTwEtA@mail.gmail.com>
X-Cookie: Prevent forest fires.


--3KtuDqqo+l8OieTH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2026 at 12:59:59AM +0200, Miguel Ojeda wrote:
> On Wed, Sep 2, 2026 at 12:52=E2=80=AFAM Mark Brown <broonie@kernel.org> w=
rote:

> > Work around this by disabling randstruct by default if we have a usable
> > rust toolchain and rust support for the architecture, circular
> > dependencies prevent us directly depending on !RUST. This means we might
> > end up with a configuration that disables both rust and randstruct but
> > hopefully it's more likely go give the expected result.

> I thought this was already applied:

>   https://git.kernel.org/kees/c/3844a38c9c4a

>   https://lore.kernel.org/rust-for-linux/178733378275.2181196.31861729113=
25132761.b4-ty@kernel.org/

> But it doesn't seem to be in -next -- that branch isn't merged there I th=
ink.

Yes, I had thought I'd seen something saying it was applied but as you
did I checked -next, didn't find it and figured I must have been
confused.  The link in the mail above to the commit says it's missing
too.

--3KtuDqqo+l8OieTH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqXWqwACgkQJNaLcl1U
h9CETQf9Guyx2148TKM91A00sc3QY+19XqXFnGPJSW1A5EIxbcbVYdzBofl5fvyV
52mmkV//F0KZ1TPIZ7lWckDdV5+a7gp7cTjmZKty7xmnLlEUuALBMeURJ7NrldjA
YWW9ZKUKR9fTNcZUYfzJNf2f9xhwdqr+cvFG0l+6WhFYF0ClWrVQpWRWYLqfnxKa
1NHlTRZAI+ZwbdYVdLYqPwZVrTBJ6zLetAomGw8Ap/XCXx9GZzDwAHF2sP1LvuWX
bjou0TdI8tj6SqI/kN/cCNAtZPA3i8h1qWWhjrIIkJivNRjASM5q1VsXmVMSG85w
/O6gMIrk8ws9o15GtlDLQkRGDScPvw==
=k7Aj
-----END PGP SIGNATURE-----

--3KtuDqqo+l8OieTH--
