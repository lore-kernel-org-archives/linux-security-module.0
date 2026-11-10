Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289167;
	b=pnIsHsuleLtKt6/9vND/h+saJQnK96Bo1nodVCCJZ8hMH1PzXYq5SQvMHjS5CNZYbhon
	 /y/C/VhFb9pSeL+HumQSo527C2WIyXOL5GsxmQ3lQx6P7UvLjq8YSW4+7kSPWhZheDt5D
	 2RoKNruBVtAxhKdEqAVmvD4yzPXDb43V9fEX+SCUZM/kPrwGSvgx6b7VbTWlgSiUdrdx/
	 tgQsVagfHoKcdBzKzHeddBmDizF+sdByXg6SmYCczRtvGKQiyjBpqREuAM1GttrPntFzW
	 CiNgJJcN+TxV5ObIO3v6a0sFzkfbCcuKJ3447n5CtcUhXOgM8B0KEvIw3H+bUXUUK8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289167;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nuXtWD70ofBVvoWkQ5OFRXvZ+x0qBj4cZlkzHhBOsdQ=;
	b=tA6+ymYrcKzj38yqvJnoypRhU8t3/6RivkTyPA0UfveWmYtWzxgvO37EUZ2J+ZlPOIej
	 tDdDiQO2lclGDp7mWZeQd+X4G9vfbVfLojQbRQ1AuHWgFQXJAieBpl8F2c+QFWSsvb5Z/
	 +bODF/pq8jhKMwuO4MR/Nj4KQC19tFHsmNHf6rSPUSBHn8APy5rvQDqVbFJc7Nq5v+EPL
	 bikXRtQfcprhsMfWQg3Tpn0no44gZSwNdbeGup5i3l8kacwWqGHmxBPClhKyDbjRqc31P
	 L7KOowLZgT1Hi9y1O61fXgfGfWNBI4zEvDSdMpzNfZE+SzrQqpe8BnP4+EKNmxlklbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nhlrim/H";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF33D606A32E
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 05:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhlrim/H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670711F0089F
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 05:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794289166;
	bh=nuXtWD70ofBVvoWkQ5OFRXvZ+x0qBj4cZlkzHhBOsdQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=nhlrim/Hbb8OLEREylBTc9ndL5jJoYl8rGMtj9SrY2UmoNhaKy59Oytm4VavGYrpn
	 l0H44EKhPy/qHOIFIqqd8B1i0u/TRDKYYTjNIR/B/emmUuii4JX7SPq9ldDGNAMtag
	 bStsRZ00L4b59rhNklFCuVXLFcU4alu9sTwrZ3yEDXo5jCsbrawoIpu7O+ckq7FlQV
	 w5XO8nHkxNoju9ZnIr3pvK8TYd4QzTmvu7ppkEVqDjZv5D1glnbQcgpb504gQUTFiR
	 1uGUWO9VdX9Ze6K+ugGSTT/H/9xiYhCyP4dhomhfmnWVIVuZWet2xKsVyUQlKLHUIN
	 JJvb5IiqVs60w==
Message-ID: <sashiko-outbox-206321@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/3] KEYS: Introduce keyring_is_empty()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110053323.2936729-2-jarkko@kernel.org>
References: <20261110053323.2936729-1-jarkko@kernel.org>
 <20261110053323.2936729-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:39:26 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Introduce keyring_is_empty() in order to decouple for BPF, dm-verity and
> fs-verity how keyring internally manages the keys.
>=20
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Reviewed-by: Ignat Korchagin <ignat@linux.win>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110053323.2936=
729-1-jarkko@kernel.org?part=3D1

