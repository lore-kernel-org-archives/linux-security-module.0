Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E8582D89
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2024 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720613743; cv=none; b=FZd/Xp9VYpFwcQC2Xvjm3/piCSMjVLKJLnZS7C1YIoes29tirQYOX8O5VC+wJWO/iB9MmGX0Q8vvCYm1QEDCl41Q/uJ79DmZp/6lUC5iNplHARSmPt32VtCeO/9n6v6SIFw9VfA0N3fwBEsby+RLGgyW3oaZW8E5km6QKZOVi0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720613743; c=relaxed/simple;
	bh=b6To7UhMRmlANAAyFXSjpmeFrC3zNwMSausBB/a+2C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSK94ZbzhC4ORxUJSnZ/haqoGnDoQYrvu2VJ7yb8g9HD2yZCokjuErIk/fbunXvIqKMErKk1FHRLV/IYhw6lXdcJYFGe0nxnAw8Ay+vfPdizYiYV4yHK+H0TUxOHPRxB2K9/sPcB8k0ALvvxZjfQU3cy+w5el01UY2J+BI47bMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ro5YlTIJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ro5YlTIJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E63C32781;
	Wed, 10 Jul 2024 12:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720613742;
	bh=b6To7UhMRmlANAAyFXSjpmeFrC3zNwMSausBB/a+2C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ro5YlTIJtHBEL45LcsNx5L+9x6MKtH52JUHmNSy5odAPqhRskmLgkwcothY45YFRy
	 afVTLpnya4DWTEyc1UENcYlzQrgTW+jO12H7hcvCeik26DU2mDqUfSEV60pIx0/Kdk
	 3DJwBRZMUTBrPCELtFGRE/dO6X0+BOwNtnlnAuNZANG1ct+y6uUlUBQd4tnpMFeACV
	 0XQzRCqqrt8K44y+gYKd9evKDUV3tMWl4Z4MCHd/S1I/stfoWBc7S8EVNDNjzDZo+K
	 1wlwTlu01SwpZOJS2y8j0jfGAxc0zyIY+adahdyRFSYH61Hd4MUWuKyDdYKAewqey/
	 Y1DnoHbUC588Q==
Date: Wed, 10 Jul 2024 14:15:38 +0200
From: Alejandro Colomar <alx@kernel.org>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Matt Bobrowski <repnop@google.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH] landlock: Clarify documentation for struct
 landlock_ruleset_attr
Message-ID: <Zo57anTiRthDqnj_@debian>
References: <20240710120134.1926158-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fuwuI/GmVOAFU14v"
Content-Disposition: inline
In-Reply-To: <20240710120134.1926158-1-gnoack@google.com>


--fuwuI/GmVOAFU14v
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jul 2024 14:15:38 +0200
From: Alejandro Colomar <alx@kernel.org>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Matt Bobrowski <repnop@google.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH] landlock: Clarify documentation for struct
 landlock_ruleset_attr

Hi G=C3=BCnther,

On Wed, Jul 10, 2024 at 12:01:34PM +0000, G=C3=BCnther Noack wrote:
> The explanation for @handled_access_fs and @handled_access_net has
> significant overlap and is better explained together.  I tried to clarify
> the wording and break up longer sentences as well.  I am putting emphasis
> on the word "handled" to make it clearer that "handled" is a term with
> special meaning in the context of Landlock.
>=20
> I'd like to transfer this wording into the man pages as well.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Alejandro Colomar <alx@kernel.org>
> Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Cc: linux-security-module@vger.kernel.org
> ---
>  include/uapi/linux/landlock.h | 42 ++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 20 deletions(-)
>=20
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 68625e728f43..6f1b05c6995b 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -12,30 +12,32 @@
>  #include <linux/types.h>
> =20
>  /**
> - * struct landlock_ruleset_attr - Ruleset definition
> + * struct landlock_ruleset_attr - Ruleset definition.
>   *
> - * Argument of sys_landlock_create_ruleset().  This structure can grow in
> - * future versions.
> + * @handled_access_fs: Bitmask of handled filesystem actions (cf. `Files=
ystem flags`_)
> + * @handled_access_net: Bitmask of handled network actions (cf. `Network=
 flags`_)
> + *
> + * Argument of sys_landlock_create_ruleset().
> + *
> + * This struct defines a set of *handled access rights*, a set of action=
s on

s/struct/structure/

> + * different object types, which should be denied by default when the ru=
leset is
> + * enacted.  Vice versa, access rights that are not specifically listed =
here are
> + * going to be allowed when the ruleset is enacted.
> + *
> + * One exception is the %LANDLOCK_ACCESS_FS_REFER access right, which is=
 always
> + * implicitly *handled*, even when its bit is not set in @handled_access=
_fs.
> + * However, in order to add new rules with this access right, the bit mu=
st still
> + * be set explicitly.
> + *
> + * The explicit listing of *handled access rights* is required for backw=
ards
> + * compatibility reasons.  In most use cases, processes that use Landloc=
k will
> + * *handle* a wide range or all access rights that they know about at bu=
ild
> + * time.
> + *
> + * This structure can grow in future Landlock versions.
>   */
>  struct landlock_ruleset_attr {
> -	/**
> -	 * @handled_access_fs: Bitmask of actions (cf. `Filesystem flags`_)
> -	 * that is handled by this ruleset and should then be forbidden if no
> -	 * rule explicitly allow them: it is a deny-by-default list that should
> -	 * contain as much Landlock access rights as possible. Indeed, all
> -	 * Landlock filesystem access rights that are not part of
> -	 * handled_access_fs are allowed.  This is needed for backward
> -	 * compatibility reasons.  One exception is the
> -	 * %LANDLOCK_ACCESS_FS_REFER access right, which is always implicitly
> -	 * handled, but must still be explicitly handled to add new rules with
> -	 * this access right.
> -	 */
>  	__u64 handled_access_fs;
> -	/**
> -	 * @handled_access_net: Bitmask of actions (cf. `Network flags`_)
> -	 * that is handled by this ruleset and should then be forbidden if no
> -	 * rule explicitly allow them.
> -	 */

LGTM.

Reviewed-by: Alejandro Colomar <alx@kernel.org>

Cheers,
Alex

>  	__u64 handled_access_net;
>  };
> =20
> --=20
> 2.45.2.803.g4e1b14247a-goog
>=20

--=20
<https://www.alejandro-colomar.es/>

--fuwuI/GmVOAFU14v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaOe2oACgkQnowa+77/
2zI7JRAAhq6ZyhrTvxNX2oV4A8HdvPSzr6E58adNJWZzgHV4jh4001BuP+Gb7UxI
g8sINpZBochZpAwP5egTkyXiYJNXfiVvY6OTdYWntzDIGU5gfljmHmrvJjWNg1Lo
lZtJa9Y6M3nF/ugp9nb0f3tjIvbEva2CknwZh+YLjK6oRZhSdpzrr23fB3F2ZmgT
ddQmVKUZqMvnnrM+7DJgBB6ZtE8NvSa3e4PUXaYSJHqFxWsbdkJePkFn+Fk1g8Nt
eiQRbbmnxDgFDmA8J+l1/mxuGHh9mBTqpIGfmNzNbqKR64vTSLqeozENrHnmhFYk
CXucEAxPCnqvkFiah8Fyf2c/ihw1BR9w5wsR9o685nLGkuGBgvodJn5JtAiasaze
tfXoNnVRxwJN0OOSCS3djngDUZiuSwVNDPLWRUM80YImnpvJzlDJU1F2MXwFAJOz
o88wOm7lpRE6uZxrXoL+HM/HmvdJqhOIHzCXgmy279srSvWGXIjK++Q811GDUgGl
TwFOvoeUEFbSBZEXBUJKrPvZ48OOp1IBStaOoZlZtRc9whf5kUFFXc3Pmipjc0UM
LJIpJKcxTAyn4AlA+xws6RKxQ0Lic3OyGPERcTTaqw7ZwH0Ca7lmwUALZw6fod5M
G5xVNM93Ynpa3s79GQBBLgLegDbZULbUCRADrtaY2RoISdq7VrM=
=D5O3
-----END PGP SIGNATURE-----

--fuwuI/GmVOAFU14v--
