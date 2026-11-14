Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794685618;
	b=m6OytPxYNPwFk1Fpv8GYp8p9kr641lEzH/ZBLFpYcAQt3c8BrMpL24Qru9DwJJEg5ykt
	 qFUPc9FCj9woji5O6C7p5DgTQGcGZCLFz+BlycO3lFOmA7AkVDSyTtMS40BG141Kw/T4z
	 TBP8smfTqA7gYEfx+LRLD1Tq0qzbawM9xXDfzKuiuPAJst1fqDbRkVBuePoR0UTyYSPbE
	 lTkM7ItQK6kV5hk8wvH4gwb87J97xR1jOLt4Smqe7Hoaz3oRU3bWASvSd7f6MFArKfCP7
	 k3LrsSAHcSSyJHuEK628cApGKAh0SGgi0glIAgylLr6sUCNMhWIwAo72zSg7+mG1Feg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794685618;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xIsAuKYbEiTvg6RCIidOuiMSbV5+WpHrKjOyIZafyvw=;
	b=HhSiP1BoI8Vx9+pm1I+fj/z367Yzk4FzEGJABq4uBOYH4Nrbm//KDuWgdSJ4GlsMWet0
	 4L/ORe2NWkBoXPhNihkjBzZrZQJpHJufL9gMfJU2PAeJO/J/rpLcFMnFvqqTCYPzm1Gee
	 C0bGw25tDB9StKJFoDOaSj9/IsftECwVNxDszPmBlO4gS2QS6V+GRBBG9eIJQqVjmoAuR
	 9pQCrdg/foBA5TqEq3bpnmyhQ92o2dI4YhM//dB0hOzN266Q5yqMNNXyV4ghqwsQw5Bcm
	 yGgEskBZjtOyNXLH0hL046HEbcECUQ5+qSvUgLl/gtrqp+RGsG4dXwHy+oWpvmubalQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YV4y8k4r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56640606A329
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 19:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YV4y8k4r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB191F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 19:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794685617;
	bh=xIsAuKYbEiTvg6RCIidOuiMSbV5+WpHrKjOyIZafyvw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YV4y8k4re1fvW/deYnq359MLJOc6QPupNO+/11yr9et9g7onSYqqe5WwyCsq0pBFz
	 zSX5EDlCr7NB/fwGp2EJQGWOtmmgqw/5ETIR5wU+vJdcoNGokGivCIzIscstoj9TE5
	 iSTAnlOFhDTBjFjvLeTb3xNuRP6hDCn0aJCk4VrrxGPpKoI5wAb8YShSNnForXffPb
	 V1Y+aOWStoCXa9kORvhI3Vfw+XPZkbVAEMryNIeliIki0jXpWc5lhKlCUY7pNGwgQG
	 0OiwrSC1MEdoirUDwGkayb55aORbk6r3u56Ha+43I+4yIyO9pYjdqi7aVj8wddbgbQ
	 c0AOcP1T/U7pg==
Message-ID: <sashiko-outbox-214984@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 3/7] s390/cert_store: Skip keys that disappeared
 during invalidation
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261114193631.731615-4-jarkko@kernel.org>
References: <20261114193631.731615-1-jarkko@kernel.org>
 <20261114193631.731615-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 19:46:57 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> key_lookup() can return ERR_PTR(-ENOKEY) for an unlinked key. Skip such
> keys instead.
>=20
> Cc: David Howells <dhowells@redhat.com>
> Cc: stable@vger.kernel.org # v6.6+
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114193631.7316=
15-1-jarkko@kernel.org?part=3D3

