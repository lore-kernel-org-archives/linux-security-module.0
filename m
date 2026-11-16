Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794790532;
	b=RLZvMyAVS33D+i8iv7XMahp9UJtht669tzWebrM4riTty2kAFCTjD1HEivo4+gzH5hu6
	 fyi29DM4WAIJew1A9dxKpl4Fn4L4SzQC5VPUoD48cjFRLgcbo2P+g9ulUWPLXt8EbwiaS
	 nQN3T9gyf8ao7F/LVW8oXzyR8JUVcdtWcNa4eretqRizE/8ZNh71h50LPkTyg+UJysLWt
	 +yRV7bN1sh/X5OFCqdMSbizJkkR4Zw3qA1W9rPRVBDq6Olly6ldKCIBMPf81uNz3/l+q7
	 G1wuw5pyNmb3aPbzBznRR+2puFydXDfQMx391e6xeBLBAsBTfV18+jRkej6XSDwQXFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794790532;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XUvXlVMxLfBuiyrIJI1sMLxba3SYOLjcVbYNdUgtkAM=;
	b=ACEkQigxWohK7xpvNBbXJyLX7Kjin81zSvc6K7p2z5KhA0Wi+0ZZlU0OUjZ7Z9hONAPZ
	 iAOOyVuvP51nxCrqbFDfkNeT6WTzfRpSFIjx1WkyIc2Hh6iUcMKv1j8in56m+62FuANUD
	 RKNz3QgZ7FBhpYKAXQ3LilsyYfYoat0ODmqcrbT/Jajsh2dpsfhQmGXk/aHxbryfjNiDP
	 z8qQQfbWxzu0cyofCPKRTI06efJIlKAIOQKQwcHMz6p6H/cnZA6jsef12EoXUdh/wyfoL
	 j9H71ndjRRkOpMzK7lEI0yRAWwwNkkDA4wvLQfpb6oQ1W1+OOMCzwWy/W7NLJL2zssA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbEnQ7Ne;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E730606A31F
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 00:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbEnQ7Ne
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DCC1F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 00:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794790531;
	bh=XUvXlVMxLfBuiyrIJI1sMLxba3SYOLjcVbYNdUgtkAM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=QbEnQ7Nel8+MTEvx+AeQ6zZLWJPH8waEkVUCd+i5rcdcI9GAWjQ7nZkVdfNqtiRC6
	 VzNDMGAW7WzFJjvMJ+cenYlc4vlf1orjrIOvsu3lGbH281AB7/FiLMOgqV7/2ER3Ga
	 cbP2ZwDE+53jLHDsxRQZSIqYBJvxsdW6/vVdfN/KEWPZuF/gpa/INTsc/C9JL7lR8C
	 OBWJ/oQTR3ytUJoeApo2OKkbyr8AzLO2ruGaciQx5hraQuOh3ImwbaCdsI80M8nmEV
	 dn6zqKJjfEZTKtXowdtHz1KNUjo1BdEeTAfQogoSvRtamfL9KlxQaP1nNEuANak2Gm
	 jyfQNICQulrjA==
Message-ID: <sashiko-outbox-215975@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] tpm2-sessions: Drop TPM2_NAME_SIZE
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261116005105.1573016-2-jarkko@kernel.org>
References: <20261116005105.1573016-1-jarkko@kernel.org>
 <20261116005105.1573016-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 00:55:31 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> TPM2_NAME_SIZE was left to include/linux/tpm.h when the base definitions
> were consolidated. Switch struct tpm2_auth to TPM2_MAX_NAME_SIZE and
> convert TPM2_NAME_SIZE users to TPM2_NULL_NAME_SIZE, removing the
> redundant TPM2_NAME_SIZE definition.
>=20
> Cc: stable@vger.kernel.org # v7.3+
> Fixes: 88c5a62c3af7 ("tpm: Move TPM common base definitions to the comman=
d header")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116005105.1573=
016-1-jarkko@kernel.org?part=3D1

