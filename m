Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795764773;
	b=DFapkszjxBuVB8cYyT/zF4E2hySSOraVHaeOolfaoeM/Q8a5xQzvl8Z0P3N12z07cJ9e
	 0gd/wW3MspawbJ4a9mAt28rVw6idTnrrug/0m0tHomn6cf1PNKDA2+s+i8fqubqK1JOgC
	 417ig9vUGMxWaNZFz15HOUgd6CL9EErxqXnZ4n3g+Pz38enRZTMVF51G6IaS0rhCFKh2I
	 Hm4RHyNvtVosiKYDis5Hwdkome99K8vDzmk/5fy2xyoJ+Q7rJiJh6XTrqTKs1gJeIQnmr
	 2ySXzgp6C8Gaed/2OjHt+MfRZWcldl8VG7teKVg7v96eNx0JQIxDtD/3DjHGNyF7lcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795764773;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+/80xJkmmXZqXDtokSsMqfENMshQtvf+sk2YmUtYROw=;
	b=pM5pttoAckJBfOceoMhliH/9G4kKpIqgTWWrU04hONKIz+Q4Tm3B2KYXEWFfSEzqjfhn
	 WnhoMf2wpd80pFiely/hsIdczipoHmz01EvK/cDRSiBuNyQGRd4ssDgXgZ/UPRVaNKBns
	 HwhY4DvvWFo84tn5LYs78f3tiwMf3cFmbYSqecuCDmx6CxwUhOv159v9gH749GEbDrgK7
	 1Z3+VqKTpL2H3NSjXrCmQ5G0dviOw5jeBfccty/uWXFnZafimrkQhVgGfZBPo7dW1z8NT
	 20Xj7XvIR3dUL1lu5elEiNfmHQE5shslwUQPGscpVpOKHf2sbxDAvYLWJS5TUX3Tgww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TFByQw15;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5DE606A31C
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TFByQw15
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF491F00893
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 07:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795764773;
	bh=+/80xJkmmXZqXDtokSsMqfENMshQtvf+sk2YmUtYROw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=TFByQw15fsMDXsFIHqVePueRR7wMVBz62X/i3Y66zBWMPx7t8ACI8ZF0+6siN4jYH
	 0b8RkITzv8ARQxvpwey62hfVyDdvFLV/qTTKpUAsAz0zrWeXGBKX8cJ2jQVDDmsgth
	 74LyND7w3x4UrNLOM7cv/mabCzFr810zjIC+BBWPpFrySS4OSCGRganufMhHzFZ0EA
	 3PdxqGYVOyLgOBHnpG2Hg8kLXHOU4UoO9EJNJaLSGRBYIPcqdPpRdixt3XH20cK8nF
	 Z49MoVwcZGtWvw6brJoWVacrPK0sU5YnP0Xwm25u7DMIcnsgxbn4fGKYPlU/AgjSvo
	 pIxUhOqkyiSeg==
Message-ID: <sashiko-outbox-236809@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ima: free the rule label list in ima_free_rule()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261127072927.172066-1-congnt264@gmail.com>
References: <20261127072927.172066-1-congnt264@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 07:32:52 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> ima_parse_rule() allocates entry->label as an option list, like
> entry->keyrings, but ima_free_rule() only frees entry->keyrings. The label
> list is leaked when a rule is freed, for example when a policy write
> containing "label=3D" is rejected.
>=20
> Free entry->label next to the keyrings list.
>=20
> Fixes: 47d76a484050 ("IMA: limit critical data measurement based on a lab=
el")
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127072927.1720=
66-1-congnt264@gmail.com?part=3D1
