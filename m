Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807A830CD95;
	Sat, 10 Oct 2026 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791655555; cv=none; b=MVcGLdg9nhM3MvDUJ6UcJBmaEDxkzlVqW2ynCkDaR+5voaLAQH7+i0EXo2I4sv9UJrCGEWitA5qrmVU1vCQ0s9TrEciPdSBdoGJz695V+Z7zmGGOHgVr30gsUPTczjuqz6s7tOlKBHfOz5i5U7Q2CMphzMIxX1nXL/+3dKMZSnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791655555; c=relaxed/simple;
	bh=fRErfaj82Xt3ikHCFtmpu+BlicxkEXdkU/jXvK2nqv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbdmRX4KHGZ1IhxumYI0yh0bQsurmx1Mdnqa1EN0X50uGqQzpVUorux2HrO0nFLQaPO+nHDhDwySuRq+310e6h7lxSmm/vcA2HQd3yInL85R25xRwxFqQMXyrom1G3f52knynxqJakAQFbMvKWXnHYB8OGWJTMqkRp99RVmBC8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UB1744li; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UB1744li"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51131F000FF;
	Sat, 10 Oct 2026 18:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791655554;
	bh=edFpq9EBQn1xiwhLheS6F85LgTZr7TGSR64qSZhkUMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UB1744liFqupjCSEgUKZT4avu12/qtoEWgIwArr7nFZjb/W7sYexJC8xY7w0MCNpc
	 RbwfiQSJpfaozp+i0S6Nf/jD6BnzuaR+Iu23EDCD9WzDYsC/igG+LNZsqgVo/wqdrw
	 aCY95ntVzVOGlOAiexaDGv6wzpKTlMHveHChFx36w3f6mp44WH3rvsrXa6OTdrebIH
	 p2PbtZcIxh78fxATQBU6cSj/kaOK7AvnnkJSJmzwP/Qxrm6+fZLNRXls2osUdJElOf
	 ypIEG8T/Vr09VZ6NGHUxoMCvuNvQvTDEFiusYigZRcE4ALPNTeSVaIJNdiK0EkOaP/
	 fifOsauX+cKfg==
Date: Sat, 10 Oct 2026 20:05:48 +0200
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Tingmao Wang <m@maowtm.org>, 
	linux-security-module@vger.kernel.org, Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, syzbot+a0eecb22de4d821a9e5d@syzkaller.appspotmail.com
Subject: Re: [PATCH] landlock: Drop __counted_by from landlock_domain.layers
Message-ID: <asp9mzpa4eJWvij0@debian>
References: <6ac91e98.bbc4c7f9.15faa7.0023.GAE@google.com>
 <20261010164450.194439-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7xx4jggh23ryewkr"
Content-Disposition: inline
In-Reply-To: <20261010164450.194439-1-ngocthang2710.1999@gmail.com>


--7xx4jggh23ryewkr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Tingmao Wang <m@maowtm.org>, 
	linux-security-module@vger.kernel.org, Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, syzbot+a0eecb22de4d821a9e5d@syzkaller.appspotmail.com
Subject: Re: [PATCH] landlock: Drop __counted_by from landlock_domain.layers
Message-ID: <asp9mzpa4eJWvij0@debian>
References: <6ac91e98.bbc4c7f9.15faa7.0023.GAE@google.com>
 <20261010164450.194439-1-ngocthang2710.1999@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20261010164450.194439-1-ngocthang2710.1999@gmail.com>

Hello Nguyen,

> Date: 2026-10-10 23:44:49+0700
> From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
>
> With clang 22 and CONFIG_FORTIFY_SOURCE, the second
> landlock_restrict_self() call hits a bogus fortify report in
> inherit_ruleset():
>=20
>   memcpy: detected buffer overflow: 16 byte read of buffer size 0
>   Call Trace:
>    __fortify_panic
>    landlock_merge_ruleset+0xc46/0xc90
>    __se_sys_landlock_restrict_self+0x2bc/0xd40
>=20
> layers[] lives in an anonymous struct inside the anonymous union
> that overlays work_free.  For such a flexible array, clang computes the
> address of the __counted_by counter as the start of the array instead of
> &num_layers.  The bound is then read from layers[0], i.e. from
> the first layer's configuration, which is not a count.  The same layout
> crashes clang itself in a standalone test.
>=20
> The annotation was added as documentation, so drop it rather than
> restructure the union.  Keep the information in the member comment.
>=20
> Reported-by: syzbot+a0eecb22de4d821a9e5d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Da0eecb22de4d821a9e5d
> Fixes: bd3a19800dd1 ("landlock: Add counted_by in landlock_domain")
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
> Reproduced with clang 22.1.8 and FORTIFY_SOURCE on mic/next (64b9e6eff524=
):
> the second landlock_restrict_self() hits the report, while 16 nested
> restricts run clean with this patch.  Micka=C3=ABl, if you prefer to just=
 drop
> bd3a19800dd1 from next, that works as well.

Is this reproducible with Clang 23 or later?

Should __counted_by() expand to nothing for bogus versions of Clang?
That would allow using it, and just ignore Clang when it's broken,
rather than not using safety features.


Have a lovely day!
Alex

>  security/landlock/domain.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/security/landlock/domain.h b/security/landlock/domain.h
> index 60e8eb2d6ac2..4bf1555a4349 100644
> --- a/security/landlock/domain.h
> +++ b/security/landlock/domain.h
> @@ -246,8 +246,12 @@ struct landlock_domain {
>  			 * properly handle merged rulesets without overlapping
>  			 * access rights.  These layers are set once and never
>  			 * changed for the lifetime of the domain.
> +			 *
> +			 * Not annotated with __counted_by(@num_layers): clang
> +			 * miscomputes the counter address for a FAM nested in an
> +			 * anonymous struct within a union, which trips FORTIFY.
>  			 */
> -			struct layer_config layers[] __counted_by(num_layers);
> +			struct layer_config layers[];
>  		};
>  	};
>  };
> --=20
> 2.43.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--7xx4jggh23ryewkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrKfnUACgkQ64mZXMKQ
wqm1jRAAmHJsIzz4I506kwsrlw9CLFxJAs+PK6VqViVhVKmiW+798wiQr8NvreBC
Lkd7R8mEMk6g69lDckvT7z+RSj/mT5OGgwsTf5pj1m5T8IjgfaHmpmn8NfZ6LnO4
hDuanhpYjL0zPNburDThkxOxhwNVPwDc4h93lIyfXfbPH93QBbbwuMeTPNtZU/Vl
zFqE98Pg+OS7K7Gf8seeMFCYvp06U/b+tnamosRBp2Q5edQFa3W9u0ggszOhtLQ9
59/OyivN3dvWIyOfVBcYURPDzoOXNQDXH+ZssoadkvXldfoQIJCSMqgnMav5wuvB
vBsmODVylTUQ2Ulb+HjjxTeWCrYA/Fe1VwueLPGnReljYRyplKfkSj+v77sSfbE1
eXe5Rtx07LiweNZrI5LA6hV1NrVqB6f6OKg02g1tYzTkIIw+NCqQVbuxMO2JmXJt
IzC8UD0K0QTYkCBeFoYmCfWw7di6SfqTGbHvTXkPgheOFmOZt5a8wasp4hllPvaQ
DXNSskB4f/Bel2DpxML1eOyVBm2o11EpW8MyGa4PpNEA3lWO4GxDKLVCtfMwUkid
YYWHBNrwF/COM/6WnG/7tDPHM59tlXznre1rQCt/3cvw0lsT4rJYSHPAeN2kxXYY
7AXO22nrJhiIV/MOnelFdgcBeD2HscvDxH9ntbIZ07GAnw1fICc=
=OLoS
-----END PGP SIGNATURE-----

--7xx4jggh23ryewkr--
