Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631157;
	b=1oGHyXdHB85X0/d2LP+iaIzJFNA2mAQPbjs7e/i2gLWfRu+PMKZ9CMIykgdFU1y7GO8s
	 FUQsB0IFJQICzmmB0ApxUNAdtI4qXKYyjMH9JIZYxOQMha78TgGJEPDrnXiNM8sPhVkeF
	 Hdd9u7kNQHbUBt80T8m4pU+39Z+ztOgspGomQyPGRzydSIOCYUuupjHpxDZM/eZzNB5ou
	 lbRd8sVjOOjJZ6b0csE5h2YXneajFH7Zgnr5vYmS72bgPr5m3Z8B55bxX0bCLFCYZUodN
	 FECHOZ7FGx+tgGnvwE+4O/4Xho/tydxpvXsfD4unmgG3Stgo4n6Kq5za4Cd7tC84XBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631157;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=k2CAU1RrDnhKj8CyJiocVyGiOApftc+XTiUeIh+8VUU=;
	b=IP9pAWkiRLI20DIz9HBPr5RLH+PAARnOOAm0vQNIGt5NsAowslYcpf8VfmfMYuOyDnV9
	 +CqYC9uRYBJzO21MVJGsfCkd6gH95EXceYS6yU8oL3bXnQSvPA3cd5k3ufLYSNdsZgjUQ
	 K6KyCXqGbXHK2co8P2bbk5cWndhwkbzLRjfpkGz6muvHL+sRku5Tkot/Fkkm0q570D3Vn
	 PBWBaWbxZfQdWMNE5xkPbhEgvaiu43aMY9snIoxmNWB12iWJZBpL3jZy608SHF2SVemOP
	 jJurFtlMkrG3iH8QC1UFLIG2X0gdu9PwoKkE+vDJWI11bC5etrssFaFRimsmOM7qi1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QhWfPte3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD1606A31E
	for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QhWfPte3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BB21F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 18:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795631157;
	bh=k2CAU1RrDnhKj8CyJiocVyGiOApftc+XTiUeIh+8VUU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=QhWfPte3EmQIiuhDGV/6SaagbQx1xdEWVohQtE9o9d0btWoug/bGxWcWS+bv/c6sb
	 N51oBlaIgV8tWMCq+wVNS2jqpHvHb//QM0+Bpc7iRCLVy0ma/3otC5vuUxKM6H0vNZ
	 ufps+Z7O+4rWTbFqCzklt28e82/SaRKhF48GqXkQS1xdBOFrOCPzqboceZdHAl6dOZ
	 QCIRshKszGj2ihEe6R6C8tIT/j9sdhX9qHwh8EA/hUzoo9YFFODVTI9tT/XTrNxalq
	 BOuO/Qh2V8RJzmCe6S4YicZEyWyLz9qGiNru47ufCSgMUPqKShLugRqtaLOzfyONWV
	 hzXzS/urR2XiQ==
Message-ID: <sashiko-outbox-233987@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] security: Add missing const
Reply-To: sashiko-reviews@lists.linux.dev
To: linux-security-module@vger.kernel.org
In-Reply-To: <41df4fcaea9d5eb41d07ffb4119621fb2f233b79.1795630921.git.alx@kernel.org>
References: <41df4fcaea9d5eb41d07ffb4119621fb2f233b79.1795630921.git.alx@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:25:56 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> This pointer is derived from other const pointers.
>=20
> Signed-off-by: Alejandro Colomar <alx@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/41df4fcaea9d5eb41d0=
7ffb4119621fb2f233b79.1795630921.git.alx@kernel.org?part=3D1
