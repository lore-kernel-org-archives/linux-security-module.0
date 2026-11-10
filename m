Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286006;
	b=hEWvY6t7QpRh6GZV8Nc1II8H3TbbxNkRTWkPUJjMvdstzTM+xhIYQYXjxAv5MRNw//zR
	 +AaBWGMV5VrRbrI6YDr2rqEteYZ1XC+6Gg45ev15eZ7Cf87jHxEecwiZUW9P05Qk/24Od
	 B4WSLvZ/suoec76WMQ9CdMFBOSMF6hEm/pWnS9yZsKlCqAML9aqOY1EXhUzDn4rKbp4NN
	 meF7974WAeRs3YDJRVUc31p8iHG0I8MusG4oapih8hbhSHUuJXrP+Y6D2ML2D/+r0HntI
	 pCZhMyGCfCFn9THM9k7MXQg85X06uDRyh9BDriuErtuIDdS8U+r0kSgZsLZEchHv9YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286006;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h9pa6UZ18RZ/Tgw8R5WeQHkNYB7bGTHrygJ2XH26FIk=;
	b=jyZKW7ub96HidoqsDbYfzCnm2f2bJss2mqdcdVItBwvZPMxgmeutj6qTfX7hlwDC/RXw
	 P1DOJBeMwNEBhbte1THIlq4UEr97PrBJ1TuLO7fZYPZ91iFDrVFtCsOo4w8TrdptFdCCC
	 b47R60A3xBPea9DvF2t3mJLJYp2F+gef9znDUALEZhacll8RFwgEc3LCYK2m/eKE2fM9k
	 waWeejol/8tWYe3zkhcOBBLSHkIawHzc8f5bVqIumXlMCN1wm2oXqA/Tt9xPdVzSrxClU
	 Iq0LF9NlyqnJeWDluMK9/CZhEcvxVUbaOtlTGOTvHlPqye3DmHp7k0S1KdTasSvBKAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FxykHvBW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F87606A325
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 04:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FxykHvBW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4D51F0089F
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 04:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286006;
	bh=h9pa6UZ18RZ/Tgw8R5WeQHkNYB7bGTHrygJ2XH26FIk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=FxykHvBWFST9t3Bzhzr6nODuj7lMQCCeWknpdrcyavBAyGvJFZ4H+9+JFCPIi51/S
	 a0MHq/LuYGt6LTC4DfE+LoETmjyTEqcd4qWKM0JwPiCFDqOtzODca2ERcUXlYFuHa5
	 BjmsOoTSxhl6gL3CEg/uBoB1e5tt2tmYEHuqg43GQ/31oqAhrpNi+S4Jy4Lm6mpm4t
	 isQ+8TI4peINNOLYuIkDt6HGwAbdSVhZIAvy0ApZ9SmM0JaVXjQLaTMIhBb7J9SM7V
	 lkxvWIMXlBQH34L9FPgOyk9sZdruGR7H6BYXKdtlhDnLDFFZDKrwLs18O7UeF2/Jy0
	 l6iwZ4MLgQzuQ==
Message-ID: <sashiko-outbox-206238@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/3] KEYS: Introduce keyring_is_empty()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110044043.2608600-2-jarkko@kernel.org>
References: <20261110044043.2608600-1-jarkko@kernel.org>
 <20261110044043.2608600-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:46:45 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110044043.2608=
600-1-jarkko@kernel.org?part=3D1

