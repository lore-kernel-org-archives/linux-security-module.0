Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CE4247DDD
	for <linux-security-module@vger.kernel.org>; Wed,  5 Mar 2025 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180401; cv=none; b=nqkhTkIELnTgFWY44xtEoDtvbEF4jqZe9AmQq1YyRET4i39e0rrB/61dpaD7D52bPFQZPpOdhEdd1CxLAhB6hpJTiSeXwKMRdo76Isiqv7rWv9U8/XULZqpMDmGzsZP6CYKfhGEFoJ6m2llY5znIrUZAwHhkEs5n4DDv9yrCCGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180401; c=relaxed/simple;
	bh=9emQwHWxb8VCLca77hMH9GFlMcpST0gO3AS01KnNkGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYGqwvl5zumj9juqqMsxZqu41t6daq4Jl9PjEucW5nx69lLy1fSitFoZGzUAYqleaSn0PPkw3WuU6lAsoI3HFUSZDk3vpsIziL9rQq9UZzCIU5M6SJUZeGd2tq3NtvqheYEO+4v73CfArxNmVdJPD57p4FVIQoIhPTBEiN2Q2eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqRKz+N5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqRKz+N5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47707C4CEE2;
	Wed,  5 Mar 2025 13:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741180400;
	bh=9emQwHWxb8VCLca77hMH9GFlMcpST0gO3AS01KnNkGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mqRKz+N5wDfN+Mn+ssTLOjb/Y8ySsnFbM9uTT134an/3gqKJEWIWFn8yopltEw+Ka
	 Gs6jFiDhJmHYvhjrj0Hj9DUcZn3OjEYTYUqnqpQ8jrGkobLm4dA72X7pom4F+5eKL9
	 p8RShZJQKm2ww44m2QCg7BZt0VYKq8jELCC+Rumj5MrBVetVl9VHgB8VDzUA8XsND+
	 ccOUuVYgSJKakt7nRhVyB4RhALYjSED5TC8EWXKt99XIqCH4u5ln9TIFtjnTG3blSO
	 bJwvLuuC+3aq1U/WqRWhigrx1HCQwFqzBvnwXm3NB8mmOOSIbEhJmJ5EYQvP3voZKM
	 w2d/drfX48yBQ==
Date: Wed, 5 Mar 2025 14:13:10 +0100
From: Alejandro Colomar <alx@kernel.org>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tanya Agarwal <tanyaagarwal25699@gmail.com>, 
	linux-security-module@vger.kernel.org, Daniel Burgener <dburgener@linux.microsoft.com>
Subject: Re: [PATCH v3 0/1] landlock: Clarify IPC scoping documentation
Message-ID: <5ke64hfsqorjpnrq347ubtyz6wa6r652kh44n537eeqrhbjy6o@rxl5uv4nyo5w>
References: <20250303194510.135506-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vcfu2hbzhqvwhuyk"
Content-Disposition: inline
In-Reply-To: <20250303194510.135506-2-gnoack@google.com>


--vcfu2hbzhqvwhuyk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tanya Agarwal <tanyaagarwal25699@gmail.com>, 
	linux-security-module@vger.kernel.org, Daniel Burgener <dburgener@linux.microsoft.com>
Subject: Re: [PATCH v3 0/1] landlock: Clarify IPC scoping documentation
References: <20250303194510.135506-2-gnoack@google.com>
MIME-Version: 1.0
In-Reply-To: <20250303194510.135506-2-gnoack@google.com>

Hi G=C3=BCnther,

On Mon, Mar 03, 2025 at 08:45:10PM +0100, G=C3=BCnther Noack wrote:
> Hello!
>=20
> Thank you for your feedback, here is the third version.
>=20
> Changes in V3:
>=20
> * Various man page improvements suggested by Alejandro Colomar
>=20
> * Squashed man page commits 2/3 and 3/3.
>=20
> * (No changes in the kernel side documentation)

Thanks!  Both man-pages patches LGTM and I've applied them both.


Have a lovely day!
Alex

>=20
> Changes in V2:
>=20
> * As Micka=C3=ABl already applied the first commit ("Minor typo and gramm=
ar fixes in
>   IPC scoping documentation"), this one is left out here.
>=20
> * Applied remarks by Daniel Burgener, Alejandro Colomar and Micka=C3=ABl =
Sala=C3=BCn
>=20
> * Replaced reference to send(2) with sendto(2), which is slightly more
>   appropriate in that place.
>=20
> =E2=80=94G=C3=BCnther
>=20
> G=C3=BCnther Noack (1):
>   landlock: Clarify IPC scoping documentation
>=20
>  Documentation/userspace-api/landlock.rst | 45 ++++++++++++------------
>  1 file changed, 22 insertions(+), 23 deletions(-)
>=20

--=20
<https://www.alejandro-colomar.es/>

--vcfu2hbzhqvwhuyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmfITeYACgkQ64mZXMKQ
wqlmiQ//XTMYQesbMzo+T6QREHZglKi9Ki43YBMD0ylWc+XSXW5/OrAiACCEy3iJ
Dg7DpsJduGXZWP2tW4LtjHbYjmOeF8eWQORuzSMMASMLGlJ6zcx942eef/wCuguD
e6eo/yXGGqh4Tn3fIXBGoHP0scIKMdhWkhOcEJnanDmf7dzKfWpccqFpyJhc83zs
PKFI6QhR6bc/XOYv6gUTQGte8xDSnjVkVdtM+FGlhzPPZ/lINPVk/LHRhD7tGE2+
12h8pEIT4zGBxCbOT6G5n5LUmXdX5IJLyc63mj3pCk50JHkWGgRTogP3Ft8OusLb
YdURlHwx85oO991VRlo5D69EJbEGQ2t9K4NnHnjt+JH8lFjkP18TM4Rw/Tr505xX
EMiBjkC52IKfhMuz5wRWi9hyKK18QyZdoIhvjEysvC52gM+sXXOcHYkOVINn2nWL
k3zMW7y/TBfTMu4ayG9Vk+xjePXB8YGOI6vBs74NyxKCDcZJNm+RC9g8DFT7rDD+
8fMCN/Yxy1uh0/W9i3e27PPZFjMjd7iXeeTiRBINZG+/zDtLraZmQ6De9+D2RUOJ
wiVjp2rw4TIcsK1rnDFM8Lryb6F86LmFWYo6m7v8KSJfOL/45NvrN9lKnjsYiv2B
Q8REMtHPszec6Ig8kxX+STdZ+5pMySlDQc1WXVtlZmUnmF7MRVs=
=0/fX
-----END PGP SIGNATURE-----

--vcfu2hbzhqvwhuyk--
