Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630965;
	b=bX0zpOIz6Zp1nRnMfK4JjW4zQMXm0DJr9uduJk/nTJabkZAcMTqEs2z20mMVtZmaRHoQ
	 ubS52Xlg4CGY/IayZSI4JWx70JBi9ipoY2jDekwsV3F0/r767eNCg6JQq30n/D6quvu5/
	 q6Kp9QZnbI26003w4ZNL+Z/MDCDgglvevivSuTlYQ1sHaYdhMPb5Ktwr/UGtUv0KjG7OS
	 VHOO5xn7zOvF/LA65T5WQxn+qaARJegoOebag3WTIskTedW67Lyopn5Zc6ZBjWHWFxSvm
	 654iOmXFqWLfly8nNp8M4/rKL89jj8Gpg67AAk4mD3JQV59x5aNORCub8jVGlxsCcHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630965;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=GRTUDrVuWJdRQcNk9NIFRLd7KZVNXD7cWbP3H9tK13E=;
	b=IwYt+H/kg2whHDN4akngrHJ9ciEzP/YHoVREtO8QYZqx8zN1V0h5zOz+ClkZEFYUuxrN
	 grvkHmFUEOJPtS5QQpQq25+G0ZE4mGQEn1f1pU2Hxj4Omepe55rHmfYckX1rDTmfLGcng
	 cUdz1Nu2ZEF0MtnlQotjZIlBdLRlVy9b9oVTQmTOjOFLezmoPAnHgMo9GGehoBxeSFsVz
	 pp5g0+ril8sAzjJDq5OMzDBsa6LGLVf+Cm3BHaJRwy8VrGaz4dI7E4VhDEkhRF+1H7d0L
	 HXtgU6HojCVEAUVXx9s7RHlrhRX79tXFOdUbcsDL9HjNfuMQNiRXRmNv6Sr953j3naw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mTvUcm4g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74087606A680
	for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mTvUcm4g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD461F01564;
	Wed, 25 Nov 2026 18:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795630965;
	bh=GRTUDrVuWJdRQcNk9NIFRLd7KZVNXD7cWbP3H9tK13E=;
	h=Date:From:To:Cc:Subject;
	b=mTvUcm4gTTTBXZxTszoi9gnGcoJ9qhbxkHmvRZ+7Es/UoDUB9L7CNkDjewkHMPbb2
	 dnqAn2CjLQi4WUOlGrkllTPt9fv2iz2Qtme01yfAFeuSaIkSrxHEh/bnNWlzAd4pWB
	 cH4cj6onio3H51P7UK1q3w5fd76ntigxMGJ0D8wHvFywhnimMfW1nPVaeIyB4adiip
	 kndKDssae6j1QN4Cn+yYSR03Lx1VFJP6AV+1RvtcXOPUzhTOjxLDWsLz4TzGQwa65x
	 4mYvpDN2twbNoyFSOgorRaj4TME9RfxuavL3kOIODcMpd8f6Xqbjo3itpKOofwbk03
	 ZlGsHfwA/OMbA==
Date: Wed, 25 Nov 2026 19:22:42 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>
Subject: [PATCH] security: Add missing const
Message-ID: <41df4fcaea9d5eb41d07ffb4119621fb2f233b79.1795630921.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b3uhcrqyifu3vntd"
Content-Disposition: inline


--b3uhcrqyifu3vntd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>
Subject: [PATCH] security: Add missing const
Message-ID: <41df4fcaea9d5eb41d07ffb4119621fb2f233b79.1795630921.git.alx@kernel.org>
MIME-Version: 1.0

This pointer is derived from other const pointers.

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---

Hi,

This was found while changing some <linux/string.h> APIs to preserve the
const qualifier in the return type.


Have a lovely night!
Alex

 security/apparmor/lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
index 73b88bde40bb..48c527170916 100644
--- a/security/apparmor/lib.c
+++ b/security/apparmor/lib.c
@@ -193,7 +193,7 @@ const char *aa_splitn_fqname(const char *fqname, size_t=
 n, const char **ns_name,
 		return NULL;
=20
 	if (name[0] =3D=3D ':') {
-		char *split =3D strnchr(&name[1], end - &name[1], ':');
+		const char *split =3D strnchr(&name[1], end - &name[1], ':');
 		*ns_name =3D skipn_spaces(&name[1], end - &name[1]);
 		if (!*ns_name)
 			return NULL;
--=20
2.55.0


--b3uhcrqyifu3vntd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsHJ3IACgkQ64mZXMKQ
wqn3OQ//RQJDpw+E6MXOfzn99sGWw5VSkMQMf4doosPdjPGydeF57SfzOjE4sLcM
jZ82r+tpq/gtgyT2+YJkSnn0xwUlq03iQKU+Ff6AZXEDtO39k7FdAFw5PoQOJg0B
w3QkI63Jkhn7N4epvgIhWY38iarspFwYxwGkz6VRVFVE8geevhDVe8kniqba3cxN
6C0svytjWmD0UbgLbksUKZ0jUt66ay98xRK4ZhvSHQtJ/UoZwzznmLmoxO0M8dnZ
y8qwxMa8TikN4BjuTzZbiNQtvdWtWnhGZLN+33oTGCa0Bqa8bU3cKIgOiMHjmbGo
wl/Y2PgcMPqgxESZDYSzEfSdzoI7Yc+T81KK+M4bctuLpDfb5vRkP7qyYs8A6LKS
27+sPwarKXNVzkjYJ59AWJsvBvGITIpEVHoiHJPFa4eJWXnHPNASYbjvLeBeGdIF
Oq+B1LQqb1mkqBArCYB8/bSOx82sI2vDLYSHTCEaLLhg3nBegX4HfImNcIs8vhEN
LUSWlSVPNwngGMkqtdPsBeeiC3eElgI6wlXRKylzoLdEiPBUXCmu/M/vMou6FESr
gGyVAxQWSg+07ra81vH5Qj15RCFLhCt7AcYFHBOzORf6czBJiXJ2fXatklhjhGGV
4mpm1IsFFTyhnwIzTMjrYMqamBKiQDXK/rsSSPo2BgVQ1QZu8Fo=
=GP9F
-----END PGP SIGNATURE-----

--b3uhcrqyifu3vntd--
