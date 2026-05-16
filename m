Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F01129C35A;
	Sat, 16 May 2026 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778959156; cv=none; b=ZjiiAopBK6pdJKBVy6qwoA35MlrDeklz9QwAS7GQD8C+on3HyTPLMW31wzUU4wiu+CO/eqUdSdUJJ5K2yYS9l6Imbkdtytukf9x5rr8+nZKhw1lpOMwhFzCRhO78ld3mXJACXOrrK5Duyj8V7uSJy3TY+RdUBRmWzNUuUisNRn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778959156; c=relaxed/simple;
	bh=ftfldjVo82GvKdRrIhImiH0wSu5UwkvKcH8WnBsL2j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFsiulKq/mab3AQ54o3xaPb1xmciwoWEyDTUWLiVWFXEwLLQxE2Z9yAMEYdNzma2jpxSuvuItYl4T1J9QMwjfW4wfTvLL5MXJqLqscCnFMJmuY4pQPAs3CGLaW8M2/kq0a86jPwrPh8RqwnorElmoyebAcbdUbGebG39bme8dYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezlIFUQ8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezlIFUQ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60002C19425;
	Sat, 16 May 2026 19:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778959155;
	bh=ftfldjVo82GvKdRrIhImiH0wSu5UwkvKcH8WnBsL2j4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ezlIFUQ8sUTJkd1PnAHWM40f6VGFQl/6xDZibb9lmgD+jGZh9dkevA30ebON4X0QM
	 KOIUTbFW6rgf7iWdNKdOUExcLl3tmGyRJIIWhWtvRFQih3SUOeeEdJ0FpqLi32rxTB
	 2mPtcPI+HM3EwXsDtx7R4bhocX7gC4PdPWUiygFn9omFTn4JOAZSJ6jSczl4sSfNpa
	 FfhtxkT5ataezrAXPD/CQ0dhsc5z95v/+3lusvFd8KdaZq9W9X4/WCjmiJTw7Fqyuo
	 xtUkC+p6HVKX/jj8aMumWLjIhNxrNpYhvqiHWdQoo5NI9shAi4bgvhZ9XW95dxft1E
	 MFyLyn31Bkg1Q==
Date: Sat, 16 May 2026 21:19:11 +0200
From: Alejandro Colomar <alx@kernel.org>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] landlock: Documentation wording cleanups
Message-ID: <agjBUgqr1b908oWn@devuan>
References: <20260516190112.4924-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bbzhlxjnnqmvezvb"
Content-Disposition: inline
In-Reply-To: <20260516190112.4924-1-gnoack3000@gmail.com>


--bbzhlxjnnqmvezvb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] landlock: Documentation wording cleanups
Message-ID: <agjBUgqr1b908oWn@devuan>
References: <20260516190112.4924-1-gnoack3000@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20260516190112.4924-1-gnoack3000@gmail.com>

Hi G=C3=BCnther,

> Cc: Alejandro Colomar <alx.manpages@gmail.com>

I don't use that address anymore.  (The gmail account still exists, but
I'll eventually remove it.)

On 2026-05-16T21:01:12+0200, G=C3=BCnther Noack wrote:
> Documentation cleanups suggested by Alejandro Colomar,
> which we have also applied in the man pages.
>=20
> Link: https://lore.kernel.org/all/agW4yMK6CinJGqXt@devuan/
> Suggested-by: Alejandro Colomar <alx@kernel.org>
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>
> ---
>  include/uapi/linux/landlock.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 10a346e55e95..48c12ddf1108 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -255,16 +255,16 @@ struct landlock_net_port_attr {
>   *   :manpage:`connect(2)` as well as calls to :manpage:`sendmsg(2)` wit=
h an
>   *   explicit recipient address.
>   *
> - *   This access right only applies to connections to UNIX server socket=
s which
> + *   This access right applies only to connections to UNIX server socket=
s which

Yup.  As a reminder, 'only' applies to whatever comes immediately after
it.

>   *   were created outside of the newly created Landlock domain (e.g. fro=
m within
>   *   a parent domain or from an unrestricted process).  Newly created UN=
IX
>   *   servers within the same Landlock domain continue to be accessible. =
 In this
>   *   regard, %LANDLOCK_ACCESS_FS_RESOLVE_UNIX has the same semantics as =
the
>   *   ``LANDLOCK_SCOPE_*`` flags.
>   *
> - *   If a resolve attempt is denied, the operation returns an ``EACCES``=
 error,
> - *   in line with other filesystem access rights (but different to denia=
ls for
> - *   abstract UNIX domain sockets).
> + *   If a resolution attempt is denied, the operation returns an ``EACCE=
S``
> + *   error, in line with other filesystem access rights (but different to
> + *   denials for abstract UNIX domain sockets).

I.e.: s/resolve/resolution/

I miss semantic newlines!  :)


Have a lovely day!
Alex

>   *
>   *   This access right is available since the ninth version of the Landl=
ock ABI.
>   *
> --=20
> 2.54.0
>=20

--=20
<https://www.alejandro-colomar.es>

--bbzhlxjnnqmvezvb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmoIwycACgkQ64mZXMKQ
wqmQgQ//d1Zjm4nq4I64zFgwLViUIPtmBPuV5AAA/PKh8FlnvwFUYXqhOVioK6wK
cUsFOAliFNSfOB6fYNWR3qxOE4l+79/3VrEbxKdgeqfN6wZD6g7pVJAew/7SyV1K
R40Gknn0FfoPgyL2eCVjkegI/eyDa/lZKa8O1MFkoDHsfmB0CKeJ/nc6ZfTOs/yk
p1UyGoBs1YEm4nQj163lkAUrhpJsH2qCnLiuBDq1+wBTghmSHrhiMUU1Qn++2i6o
k7GIb5F2kQa7RpVehEZDaWChWNye8URZ2K857fVwVDWi/KX6pncspM+BkfuTHMRP
rgSgvhX1TSqZ2O9vt4gOr9rK/6RpA7o7OwF4Rsh0jzHwBnAaxqg0NMaUizCgaxL1
M/QWQj3dw8yH/KKUepk120sChiT8n6CfBd2fB0KWcs6mvORwwD7eJkyEUFrHGWUq
4CkA+OuzmVFvMnMGAvamHTwkYwdeeXl85YPAM8PFZcUQDCoAB+hYKvbRQk3P7mfe
qKJY5I5JV3NSSYv9NgnFtW98XiNx89bBKp4W1+Iu0aho79tlmINCPHAyw9pRKcqY
gln+U3lD31WctKNMTSQjdj2ldnmm0AD8HLkpRcR1JxH/NzHA6E4n6KnAb4scjsY1
2+ga0J0XWC5PGSi/BVQvGj8qNwQ54tWGppPsELBUnjKx6dtCSfw=
=DZlG
-----END PGP SIGNATURE-----

--bbzhlxjnnqmvezvb--
