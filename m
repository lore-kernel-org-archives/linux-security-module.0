Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814433AE1B4
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343603; cv=none; b=tx2D4e0D0X58TKHjjqthc6+JQx3gjo0xJ+hA1XJltxjNhm6glQqNhsBnfNepCFBrNma65ZJH0tG2C+J8r0rWHvyWpxHG7c22Ud6br7FNR3r3eOr/ekVqF7pKNqJVCdghJWhvF8jKOFDeW/tRQZbPHxeLtM6XuXDStiJr0XexxNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343603; c=relaxed/simple;
	bh=/Q9NkfsEsBow2WPBmsVH4Y4YClR1SngmrLznxz/jjWI=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=fn94utaW168aut2PUn54Cpa7wxuZUldMuukJ/+De5Ul6AbMPQM1TI78kjAWHuY9CaEpsb4sqddHQcqeyTFDL0q4M6eUNzbdq7Sornes6PPBj5uHoJUQ4TQo1cv1nelkyJwMJ657vZA3VE4N3cXa5irtfXYA9igT/4/BC/dMQRJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTSbXpt4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTSbXpt4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444BC1F000C5
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792343602;
	bh=/Q9NkfsEsBow2WPBmsVH4Y4YClR1SngmrLznxz/jjWI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=HTSbXpt4whJEfJIDSFXqb0JGLR5TlNzNOgvxh41cVGVhHeKeE9/naDEKmz5bK6iof
	 Iy0g7Fkv4JPNEiCGRr2ozunh1BaJCbn4oINNjgfscnAe/7/RjBHsYTBJNB41cLp+2U
	 0QeBK6KbtqxXw2rkw7HQN5XKfBZ6wuzzb9y0leDReMHGI4/uyV5ucQaWYvl/Pb51qH
	 P9hKqiuHfgN4sGu3nENUbSXjy7xKhxzWRqb1IYVDuS0vcFJkWZvIKo5qbbig/wBInj
	 4sl9ags6iVqGle3WCHp/DMxKRb48EwJ2pBTaveaO+aJblOVutpQ1WPd9L1fZw88QC6
	 MIyS5jRas3VHA==
Message-ID: <sashiko-outbox-176307@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/9] keys/trusted_keys: clear sensitive PKWM buffers
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261018170844.491252-7-ssrish@linux.ibm.com>
References: <20261018170844.491252-1-ssrish@linux.ibm.com>
 <20261018170844.491252-7-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 17:13:21 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The input buffer to PKWM seal and the output buffer from PKWM unseal
> contain plaintext trusted-key payload data. Freeing these buffers with
> kfree(), without wiping the contents, can leave sensitive key material
> in memory.
>=20
> Use kfree_sensitive() to wipe the sensitive key material when freeing
> these buffers.
>=20
> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted sour=
ce")
> Cc: stable@vger.kernel.org # 7.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018170844.4912=
52-1-ssrish@linux.ibm.com?part=3D6

