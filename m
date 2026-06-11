Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D563D2FD681;
	Thu, 11 Jun 2026 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781169828; cv=none; b=bBqSKcSQABUjhNHRoZsgZyrj1A5/9rwX8b3jEx/i9SiG8T7Y3ixWIMbuSnz3HZc8qu6DznneTFu5xhNUqX4JwPfqHBfXk8TGDNCfgqlZMplJEtYypKc4NkrLK5K157N38hp+r/H4xI3/6iRyTPnhyQHW4+mdySjrCGGQPfslbYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781169828; c=relaxed/simple;
	bh=n4QyMGbFQbeSogIxTyg8g3splgIaIsH26BzlrHn773A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvURTLBsrM8KpKxyf9Dcag9Z+YFLByf9ltiO4/mOby8PlIL/TLbt/hzCVIzptqYG9CD9uBaC6IPxK8Fg/LfhX/fxPd4hjdT/xHhSYIMz4Cra5oaQ+PIed7+dGNnwSXAL70R+fBRODZ1SUAV2bmbmUNhk6CX7Ra+Bm/xK7Z2b/f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZOu5gQL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZOu5gQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550271F00898;
	Thu, 11 Jun 2026 09:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781169827;
	bh=SLJxYuWn1JgaTUqmkYqvt9u1o2uLPDb56mE2MLV5Y8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JZOu5gQLyWUjcPodEFU369f++53aZ7WVUSj3nBTCo4m50DID9bK6QSwQEunjMzqbh
	 IcZI7EzXcc1ulbDg73BaXe58hx0fNo9EhIT0NEFpffu2NNd9369h5sfQEqRnp8SnyE
	 s1Gi62pU8yqneYYzZh+QRdq3ro6pt7Y22N3DWoPgiJL4QwDKbRZ1ZWWVy98OEGvV0H
	 +rKnux9Cn681B+NieJsRKF34cv3Zc04zJhaAv6Bzi268J1iERVubctNW1fKCvcbeMz
	 75FB6KPEPWCIWUUS2CL06vszvJmZryK2z7mSJogxHGILGmy4FZVpmQsyDIW9mJLata
	 2tYb8Gwp18OOQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id F0D4D1AC56C6; Thu, 11 Jun 2026 10:23:44 +0100 (BST)
Date: Thu, 11 Jun 2026 10:23:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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
Message-ID: <aip-oMvL_8zxRssJ@sirena.co.uk>
References: <20260605-rust-reverse-randstruct-dep-v2-1-93d38023b6f9@kernel.org>
 <CANiq72mmzfBg0_y+TMTsUUuO0cJFE0=n60-ttwOynai06_y=zg@mail.gmail.com>
 <202606101339.66BFE3AA67@keescook>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8Pab7+dFsmnpIdTp"
Content-Disposition: inline
In-Reply-To: <202606101339.66BFE3AA67@keescook>
X-Cookie: Leave no stone unturned.


--8Pab7+dFsmnpIdTp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2026 at 01:41:19PM -0700, Kees Cook wrote:

> For the linux-next testing, are you doing GCC + llvm rustc builds? IIUC,
> then the support patch mentioned, I think, doesn't actually solve the
> problem?

No, the allmodconfig builds are currently using LLVM - there's other
issues with rust+GCC, right now KASAN IIRC, and it generally seems like
it'll be more reliable to use LLVM to get the coverage.  Both compilers
need to work anyway.

--8Pab7+dFsmnpIdTp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoqfqAACgkQJNaLcl1U
h9AxcAf9E/oP1ZL3Gu06qhTqh4nYLlsl2eB2tx/jFQdSn1OKhVsmDjbjczaKsgZy
LHqGmINsqxdstTNwEx+dR+afTJbZApGKGddu2tiEsfvP0bptDaymDHebd1lVt5bG
g/Hr00vkEXyGOMK+M3BuIkZyiooP+5q02FZK/MbBRMN7yPTpJa6ldkeYxQXN4PWR
z0ValSlPt8JYhmZ7R2sHu62S7q962NfPx41a/6B4wk3vbcboSupITED6RKbjaBUO
wGUwmj+NFXHC5ZSy/JAFwI+JEM7eglgRC+L/aKUFfDLmVC4nGRuSflrf7RBGU5D4
XmLT0VzVKwbCySWEyK+zoLmP9sQK8w==
=fG0k
-----END PGP SIGNATURE-----

--8Pab7+dFsmnpIdTp--
