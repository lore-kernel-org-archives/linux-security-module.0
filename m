Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BAF2DCF43;
	Fri, 19 Dec 2025 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766141714; cv=none; b=NosmHRlqaN8NmOMF6umCYKdgOQupNaw4hfa+QFZ++kUB5/fuGgfdSaD+E0mnx9psTfJduSeBpF7Ipk41R9RdV6tQD/ZcHQobdhBTFTPmcUPexcm6E+P2+lW2KY55DLp21IIQj+SQs75zB9Ptk5fDAPJiqjL+MHdz3agU7k1LrnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766141714; c=relaxed/simple;
	bh=VuyvJfkFNGfzV43/QFieGCkNZ1YaLZW0Uybj9DU9VVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJH56bUs46x4j/g1euILG1cxmjFQbOaVx0Dr/JlzAdVqbWvdniv0WuU0ahkfnraz4uwqbBVbXyRgxakdIlggQBXCnsHdqwc8hkXjybweFCOM+My8LsDanrO4TmFDYU01ze6E9+p4Rag2NPNcBdxgnpWmDAA8asMU3nRpR11G3Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSamioUg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSamioUg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D9AC4CEF1;
	Fri, 19 Dec 2025 10:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766141714;
	bh=VuyvJfkFNGfzV43/QFieGCkNZ1YaLZW0Uybj9DU9VVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KSamioUgRXPp8aymmD4ba7x8M/B6J0WiqgzxXZmhvOcArBZJ0R1Rx7cJjBLrECGO+
	 1JyM8D0M9ZT4lHGgNfb8BUpTEv2r9yg9dVMWFBXfy52wiTm8dPgN7tTfP/5XSbdaFe
	 fr7vKBDHCwaSXM2cTEqG5f+ttVFwDiL/ioY9nkbfDFpJC4X0RuTLClvLrB32l/9Qhq
	 VHx5ioJEVGAhIDAP9aDSLGeIDwviy85yrGsl1pwu2TgGFjQoz8emFLiCOmCKEyDs/A
	 40B26eqDwjI5Gzs5c8jlDxDDmdjPCfWk1O2UxuoplUkO4d/XUKPGpyy7Z1mprl/ssG
	 FRqGIJ5GZ6gvw==
Date: Fri, 19 Dec 2025 11:55:07 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loadpin: Implement custom proc_handler for enforce
Message-ID: <s6eugs6crrncqrqqt7bwt7khmjfuwyhqunsmwuts4wcv4bog33@4gxywv7lrxda>
References: <20251215-jag-const_loadpin-v1-1-6842775f4e90@kernel.org>
 <202512160028.8F11A5D19@keescook>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ir3rd4gqymz3hlak"
Content-Disposition: inline
In-Reply-To: <202512160028.8F11A5D19@keescook>


--ir3rd4gqymz3hlak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sent out a V2

On Tue, Dec 16, 2025 at 12:37:29AM -0800, Kees Cook wrote:
> On Mon, Dec 15, 2025 at 04:43:48PM +0100, Joel Granados wrote:
> > The new proc_handler_loadpin returns -EINVAL when is_loadpin_writable is
> > false and the kernel var (enforce) is being written. Move
> > loadpin_sysctl_table to .rodata (by const qualifying it) as there is no
> > need to change the value of the extra1 entry.
> >=20
> > Signed-off-by: Joel Granados <joel.granados@kernel.org>
> > ---
> > Const qualifying ctl tables is part of the hardening effort in the linux
> > kernel.
>=20
> Ah yes, thanks for getting through these "weird" cases! :)
>=20
> > ---
> >  security/loadpin/loadpin.c | 21 ++++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> > index 273ffbd6defe1324d6688dec5f9fe6c9401283ed..f049c81b82a78265b6ae358=
bb2a814265cec9f16 100644
> > --- a/security/loadpin/loadpin.c
> > +++ b/security/loadpin/loadpin.c
> > @@ -53,18 +53,29 @@ static bool deny_reading_verity_digests;
> >  #endif
> > =20
> >  #ifdef CONFIG_SYSCTL
> > -static struct ctl_table loadpin_sysctl_table[] =3D {
> > +static bool is_loadpin_writable;
>=20
> I would rather that load_root_writable were declared external to
> loadpin_check(), and then we could remove set_sysctl() entirely, instead
> using load_root_writable as the thing to check in proc_handler_loadpin().
>=20
> And also rename load_root_writable to "loadpin_root_writable", just to
> make it a bit more clear.
>=20
> -Kees
>=20
> --=20
> Kees Cook

--=20

Joel Granados

--ir3rd4gqymz3hlak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmlFLwoACgkQupfNUreW
QU/0GgwAjaCFsB/K+eRZFNRIRyXdF9722RlUTwuVCPGDf3B5C5u4kERTeCbYhQe4
Pam7JqUWxY81AQojX2SD508JCjFUwLPd9ZvG7fl8umt0+kaMRGGwS9gqlXH1xRWb
Dj/Mvmi85kan6T2+4jQyEga7ejHufkAZx5tk3FCl22TA18GBTtef6TZDk8PXNvKM
JfuQjhKmpJ/uwKXZr8B+E9K0EZnNYZc/ZHLDjy6C2EUdvm88KpSnTjE+1gDMi3o4
Qw+WTb7HkqMEJsaIS98+oP9tWbtCOq/8S8g7PuVADnpR662u7ygZ+O9bFGvWii/o
LcKTNA2YJPoRNBdYWErOx5GnACOEoXSE4MBjMsLyINK+gv+HJphy+pA3jUSxkZy3
iDM3wWUe0JqmfvsU/hBqArERqKBGOquNYieKLWUM79rNGXR2Zx1dLn5quEq7nuRt
FGg8JgvFj95S/q5ITOfza2RXG3Wp9N1wung5WtxYUibHw0Zr8SJfpokZ2qXoJLbi
YVr7z440
=va3Y
-----END PGP SIGNATURE-----

--ir3rd4gqymz3hlak--
