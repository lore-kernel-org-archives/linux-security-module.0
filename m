Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488677;
	b=U/KJlarGh6NU3PJC1n9KO85iexjTdqzsH/VWmBkybS4t7E9deobFpA+8SUfp5yDen9zt
	 urlnM5xfrGS85+noXgKjBCBen3KqJ5/7AZat4Pzd0IEOjqLw09LGjfa2gCGmGS6k2Ktx+
	 Sj70KutYh0/dnL8hUdv6dLj70QZo8aCbmALfJKvuTczYmDNKOpAv+raS1Dkx36hrXrl6M
	 cQ1UFyfu+1wZUA/sX2wbYhXcPskc1NmoosoSwSUAU349GpeqBJmMS2vgcl9/Cm/LALpgs
	 x7qYMAHOxumbYxRi+IdjLRzySWSsO0GfR/r9vGudU/f5eyIbwV2cHG2+AlE/3lzVzzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488677;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QAOHUkP8mSVb3HAPGFMParJEVsdRpkeqE84YURBdhqM=;
	b=Kb2f7kMcT/WJl7AYu72lGuWqNreSG6Z4lTNPqkUv0d7gqfD9+qhuHvTOVQ8Lzxj401lF
	 MoPANUhigB0pAwNBR6jwpUNHNwBfi/8u9Il+Qnd9yLtdHsLhvUjooNNvZ73foKHxaJ9nO
	 V41blGwqzb36gdsK8Xx6T+5XkPBlyLpewFFr3Mib0ZUVfI8fYA85x5JC5lvoO9WH7LEBi
	 uNJwTuFN753OJmR6ekHEcTrJNzAD2sH4x/FqymAd6cgleux3pDb56yORvbdNG38Ruvbkh
	 4ErShdohhtxkQXlgeHGJ+T1erCObJXpunKYC+bBOizkgwM4bs6z9JpowOYT+M02mcBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6PgRtqs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888B8606A880
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6PgRtqs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC231F00A06;
	Thu, 12 Nov 2026 13:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794488676;
	bh=QAOHUkP8mSVb3HAPGFMParJEVsdRpkeqE84YURBdhqM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N6PgRtqs29KHDXsQ7UeI69eCsrzwKzK8VTk/f3dgFq0YFPGbF0m03vVBQHTM6vZC0
	 KxgTM5SsaYi4tdYDwzOu+7exKRp/LJEEZhGvARa+QxPbM0Es4Qyj4ECCECCsLJj2Nj
	 AM2cg5Ylg7RAYsz1okzRNGVkRYu7QvmXHmsA046Nw7wpI6OapmSOQmjA/ZKlKEYUAz
	 ki6oKczTdol0SkmZKXoK0oLdzA5jLwDwqUdlwhMsOJZ3ugWHrX/UGsclXtCi2Z5YY5
	 vsLDlm5xORG0V7S/BitxOfJjOXOZgYwYoysEIZCIBaZnQ0s35v1sEo6uRIWWsUPSiy
	 ZrUIHL6smBQGg==
Message-ID: <sashiko-outbox-211136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] kexec_file: update IMA after machine post-load
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>
Cc: "Eric Snowberg" <eric.snowberg@oracle.com>, linux-security-module@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261112125246.2715174-3-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261112125246.2715174-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261112125246.2715174-3-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 13:04:35 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> ima_kexec_post_load() replaces the global IMA mapping with a mapping for
> the new image. If machine_kexec_post_load() fails, the new image is
> freed but that mapping remains. The installed image no longer receives
> the execute-time IMA update, and the notifier can write the
> measurement list into freed pages.
>=20
> Call the machine hook first. Return its error before updating IMA so IMA
> changes the mapping only for an image which will be installed.
>=20
> Fixes: 9f0ec4b16f2b ("ima: kexec: move IMA log copy from kexec load to ex=
ecute")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112125246.2715=
174-2-Jeremy.Jean@oss.cyber.gouv.fr?part=3D1

