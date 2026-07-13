Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BF94502F;
	Mon, 13 Jul 2026 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783946726; cv=none; b=UQOdXYyH6Yvn6nn5oIZyuRfvH5nvbGgUqSqPQWv8CxSUH+kRvxNtFeajVLIEUQ8braJBLBytncHhl2/agTHiyxn1WQ4EXATtOJBOgzhPaQMtuX5LNPog5EMy41XFZETQlvWNxxqc5GvTg2qbiLhAj74hDYvB4Z5M45gh2bxg43E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783946726; c=relaxed/simple;
	bh=MoZnZLnN3wr1+v34l+4SyN7hBUWfVc8JTSKBai+cqMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbeWL+ymjzRUTjM93Xfk/QCLKSqhOIlbYh/mHQKGKiqQIb5LxPHOeZIQLnwiye2VTd13PvltRkPXSOrxcOem+GDWjWsOFfQTwr2VgG+HK695x5FfJR+6yRH5swuGEasvwdliLh3GnZSd/vapWdmEUdtVecadPc7pe0I2Wr238/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOu92ivy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOu92ivy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB931F000E9;
	Mon, 13 Jul 2026 12:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783946725;
	bh=AXGCpmoREIMnAzCLPYce3WlEizM3wmYlDxVRnYi6hd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hOu92ivy4kEtLI6RcYO3NTAPeuzCqA8EMq5txScKDowGUvfNjZ4SeMe4b5rEQuOW8
	 k8TvcznbCJi9E5pCPgyx/OTYowgbECz9immM2eulqFeo0c7Z8kwkN1N+7iqe4T4JzE
	 hIVb0RGWKyzW+TRPND/pp+/obeDfT+TS4c076vgLSWvC04JPARNobJ5vPQZpXRIWIr
	 Me4Q7qX6IbpY5XdbpkorEXvHUKC0yfOEK1FsJomc91zRxE+C50aUE7tWd/sTDw2eyu
	 GyO1FjW3bran98B68rPShifjtsdxCQzUR9LH8kBdR7tbup1LqQIM58sViVgZh3zTh4
	 pqP52S7yeXp8Q==
Date: Mon, 13 Jul 2026 13:45:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3] hardening: Default randstruct off with rust for
 better allmodconfig support
Message-ID: <7cdb2407-924c-44a1-8c68-917efadd4e92@sirena.org.uk>
References: <20260702-rust-reverse-randstruct-dep-v3-1-e4e09c50014e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KkKQRvq7fUd3CTer"
Content-Disposition: inline
In-Reply-To: <20260702-rust-reverse-randstruct-dep-v3-1-e4e09c50014e@kernel.org>
X-Cookie: Call for details.


--KkKQRvq7fUd3CTer
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 02, 2026 at 06:37:08PM +0100, Mark Brown wrote:
> Currently randstruct does not support rust so we have Kconfig dependencies
> which prevent rust being enabled when randstruct is. Unfortunately this
> prevents rust being enabled in allmodconfig, our standard coverage build.
> randstruct gets turned on by default, then the dependency on !RANDSTRUCT
> causes rust to get disabled.

Any news on this?  I'm flying blind doing -next merges of rust code with
build coverage gone, and I suspect a bunch of other people think they
have build coverage in their tests but it's silently vanished (I know at
least one person ran into that already).

--KkKQRvq7fUd3CTer
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpU3d4ACgkQJNaLcl1U
h9Bjvgf/UXM/ABlVwXmO0yhYbXVT+W40IPPfMsNSWSchDtT+Rt+69MAMwb+DGi2Y
yat4uyPHz/UAhdJEN9lOTfY8r6xx1GK+Do2Iy1Rxx+1IWwesHzixtFXGrY5QpmR9
umzRGBnNTRaCuxvE+F/gFg+pE7H4KeB1IUb11PSu2O6eE1jFMoSrO/XYuQOQv0sW
mqnxFzXcxBvqSMexdb3VY3W+8Ga/q3qmTDG0qgOFUX5LqNdncd+e/iljQw83cpe2
4U1tbxQRrdTXX+JUPqt/5LCoZlidSrr6/rt8Ejl2isihITtwEdskWeCv6FMi/LoC
TynDTs67zu+p3nKZ15/B3BQm5pikKA==
=QMrC
-----END PGP SIGNATURE-----

--KkKQRvq7fUd3CTer--
