Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923745;
	b=ivgv4geNlck48pbOeuQ6WoCOqsmpI8Xe8DnQlMUpIHMgGGMsy7BMg/ydQouOSZMk3c4f
	 im1GKKoeEdPYh6ZWKCUV6YRV52jggIngaB4dNQnEGk0P0237m2OFONCQYd5rjySHvy4XO
	 31nx3IsuMAlFbL5ClDy4gxnpUDJrhSgtjGu0PvU9nFjWeM2YrfAzm/xmVRpdpjUrqmJcg
	 cT3chs8BmuDzo4mM9DUVb4br1QZZaBqjjzwAYp+ZP3emC8JIRgtmfx3NkC0y5MnAH9ZKZ
	 xCh9jnJgp1ovVNfEt92SVPTPepoUX98w1ZwiqxLaNhivBfxzxsXtxzF5kDEc4F02iwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923745;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gzsTcO3lQpYoueyt0qieEGQXTz7ACczsI6cHAN+Ap1g=;
	b=5oAh2Yabr7g9w0xFO09w0OHnbUhpBfBssKy17/PV88pxKD9gaod56QeSPjUi+WtzsX4E
	 FraPwxID0+cSJ4uIGgQ4T7Olj7t5K7SUXAO8o7Ovbyis8hcLhSdNxUjT5PVGX3bv6ZewY
	 JA/DEQBpTTmIYcDGUIpDYedZk9O2OLAu8A5+LCsM1MSlknxoSdv/evKLozTOPmx71eoCs
	 DqezIi1S2Zkj4dB6iGIwQ5/qzTkFkz1R3cH53eAkNcrzY022mi7S6sKQqKBnoTV27V273
	 981EuyP/r77Kp0eO3VC9EjYRYci+fq/b1cb5MdYwM6YQphp8eRWOa+SQYXpIMZVSqZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFMGt0Df;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9555606A32C
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFMGt0Df
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83B01F000C4
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794923744;
	bh=gzsTcO3lQpYoueyt0qieEGQXTz7ACczsI6cHAN+Ap1g=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=SFMGt0DfHwuwI9trZ19kdSkQCSDW1K/yfCWoX2CGi2b0MX0SVagP2Cd3H7aegCOK3
	 FTqGWcB6WaMn41CN2RtoCAIjCRcIWA7ma7U/XNbV8CfG3i9fuhidzS63fbPlvYlxLa
	 xp/DIKZE8uF+TGA0VblC8d2lVB/ua6Z1UBnfMj+xGuuw+MDW9IoRfT+8f/tpBoBA39
	 6ekdD5r/PCwMUuwwTyD1pespRAWjPOFijtzJKuV4et/dKMK7rp9Wol0lUsUmqgGgYW
	 hBeW7hNZEQad+9ySRhGc2sl0G/7Cs92Yc8oq2qF6NelD6QC01cdHVuwHcRfbeRS/9U
	 jOzf9MSTKxN1w==
Message-ID: <sashiko-outbox-218909@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] apparmor: move the feature tables to a header
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117135042.78238-2-maxime.belair@canonical.com>
References: <20261117135042.78238-1-maxime.belair@canonical.com>
 <20261117135042.78238-2-maxime.belair@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:55:44 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The tables that describe the securityfs features directory are spread
> over apparmorfs.c, capability.c, net.c and resource.c. Move them to
> include/features.h, so that a later patch can also build them into a
> host program, which writes the feature set to a file when the kernel
> is built.
>=20
> Three of the tables use a generated mask. Collect the masks in
> feature_masks.h, apart from the name tables they are generated with.
>=20
> The entries are moved as they are, and the content of the features
> directory does not change.
>=20
> Signed-off-by: Maxime B=C3=A9lair <maxime.belair@canonical.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117135042.7823=
8-1-maxime.belair@canonical.com?part=3D1

