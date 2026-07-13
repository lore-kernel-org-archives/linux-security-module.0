Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC8343DA53;
	Mon, 13 Jul 2026 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951371; cv=none; b=ja41GLR7PZzVLQY/pz1aMGHJSIDNZRD7cCMY4zW2hb87wrKh18CZi3vozMejSKPY1DEu1jr7NQ1MZ17QjVYF8IQVf9v+1HcKBXArisaeGyj6XmDJgid4HLHuuYjpEYCVoHouTpX4ILO3boc4giHIsPMVCWrotqDopBEHlg1B0mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951371; c=relaxed/simple;
	bh=XjolIzzY2Tc1xblemFkryo5qNEr23sD2CggZqCpEuZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMj1HE3AiZP6iKFLNZeYtT90vK2N+o7gatEAqtqxsjigOxzoWTn2RTCRDBOrHJuA8D8hDzHfaPfNaNEW28o7ZAOxp1G6ibAp4b7VJQyvb38By1pdc9l1gZJb/PV3ghMpkgcnmUld0+g4mHcMSEoszOP6I39zE/FOY0y5DRlba78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJCjIbUj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJCjIbUj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD491F00A3D;
	Mon, 13 Jul 2026 14:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783951370;
	bh=XjolIzzY2Tc1xblemFkryo5qNEr23sD2CggZqCpEuZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UJCjIbUjk7esa+IkF3hYs9ANTXztF0AUJrCn++Wwd7wKVV1uCxIE1Mi979xhL5hr6
	 uVOXOI3zXY7VweMm/t0NaX6JGnpyb4objY5O/JqRSn2AWwhU5xbqc8epCIGL6gmnJR
	 sGr2LhWtxZUlGQ3aQBlGbp8BUQ0avkC5VLPfvuriLNBQv9hmH5h2uEVvHWl/+kT44F
	 X6mTGGp4WxYimnyf+gpem6CDu3df266cGLEqOFqyXjzWiGyqiNEZ0NI2TFJj13Xg/j
	 9zEYO7Ei23Nzc2El0x0EssCR9uAB9zpkpxrqLxxil7kmKtsN9LSaQnwNnnUdVdGTf6
	 0Ny1Jn0DgE2Pg==
Date: Mon, 13 Jul 2026 15:02:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3] hardening: Default randstruct off with rust for
 better allmodconfig support
Message-ID: <1a9148a3-da1b-4386-97d3-62c55c3e5d96@sirena.org.uk>
References: <20260702-rust-reverse-randstruct-dep-v3-1-e4e09c50014e@kernel.org>
 <7cdb2407-924c-44a1-8c68-917efadd4e92@sirena.org.uk>
 <DJXHTB615I2J.POTXT6L2LM5K@garyguo.net>
 <CANiq72kNYRBW88VwYyDX8_2b1L7dLv_gDwgE5SruMELR7KPmig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TEuJpuswX2OaX08Z"
Content-Disposition: inline
In-Reply-To: <CANiq72kNYRBW88VwYyDX8_2b1L7dLv_gDwgE5SruMELR7KPmig@mail.gmail.com>
X-Cookie: Courage is grace under pressure.


--TEuJpuswX2OaX08Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 03:58:11PM +0200, Miguel Ojeda wrote:
> On Mon, Jul 13, 2026 at 3:55=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:

> > I thought Miguel wants to add support to properly support RANDSTRUCT wi=
th Clang?

It would be great to have randstruct support for clang and Rust but we
do not currently have that support.

> I am happy either way, i.e. whatever the hardening folks prefer, but
> regardless of what we do, I think recovering the linux-next coverage
> is a high priority at the moment.

Yeah, when randstruct support is added we can remove all the constraints
around it and clang/Rust - this patch is about the making the current
situation work more usefully, it's not intended to be a final state.

--TEuJpuswX2OaX08Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpU8AMACgkQJNaLcl1U
h9AEnAf8C08rWR2J+LlDhnvdUsW8FfmIZxPHJOOw7aq8rbp79koBHEF7MWL/Rqx0
dFQr2Hq57OiL4sxSAAs7/xmBWMIOyxg5mRGvTWxrLHThsH8nYy5qALuVzYirwUEi
YxoByDhn6CNn3gMUyKn0TJz6lcx/6P/KYwlnTQvMab4rlRv/0LkHIJSwzVbh/goS
DOoxgEQGHUgEw+ukYjhbiYzaYN0RrpCKf5TCJbCpIdNJh+oZeiFwSVqR463XR9Be
T/m83k1xVt19J+NzKQj35nwLvtBAPHX6cZQMA8s6F7Zl/SRGitPjMMyBiYtLh+8i
WLZSOowFjWkFfnEPlMM5oeEPzR4fiA==
=XjjB
-----END PGP SIGNATURE-----

--TEuJpuswX2OaX08Z--
