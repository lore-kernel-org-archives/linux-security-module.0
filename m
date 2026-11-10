Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282202;
	b=C/OvnJH6Mw+EyzLDTLX9tpadwpSpBDZuMdxqpm/Mo/rJZ9/hjwTV98WZ1WdQfQ7v56Fb
	 poRj9YJGzXrBZT6BKEfufXP8LCoo6UwaZuIgxb1J4TWTAH7PYLVs+w1jpK8FCtRgvR3BG
	 694n/C8casVxLD8Cy/uZOy04cU2OUg0sEHeLsmX+smFuWd3E6OcskjUXeafpEjM+4VDuw
	 EqmMJVdfdAL4us37v/y9Id6dLGlsHgcduI/+CMh1j7KqPLjqUG/5LgGKPLWJREDELAVao
	 4WqBY3PGN15UtVGjjChE8h24/3mwVRP/aZcbCTRw9bhg04Mn1jRDzWKqvc8XcEq+JyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282202;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mgqo1vJKMBqKnHcQe/+8jHS2yefj+6xohgFzZnFoVf0=;
	b=jE7HJ08w0iNCYracZindPtcxg3IhwDHPl8XElsUZWQKkpLtHx89uMuiy1QPufut9Sn4h
	 TWlHWB2e5d547Vmmdf6W/bmcr6rnIU8lvIOsssZvQBS5Wai6qHoG8jxnbKZsIejQCakrY
	 FY2JI0gSp92AZjH6k4GWqm9ppbmQVpHMd1BK0ONhgMXzbFpX8YSWZvM/1Rb1BHKmpkC11
	 OwElKxXQmBd2SMabG+emG5FIezlwZDzAEdfe7mc9fBhccDcMd2omI7X1nck1YxFOEe1U2
	 YM65Kn3oRZ3SGLCT69/tXU+YsjiExnyLXEZZWMMQ9unmCHeA/fWeyf8m5XZMiFjt7cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OIanQBSI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45427606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 03:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OIanQBSI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011B11F0089F
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 03:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794282202;
	bh=mgqo1vJKMBqKnHcQe/+8jHS2yefj+6xohgFzZnFoVf0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=OIanQBSIVR3UhV5fo8XAPe8QRbWwtvoM/PiGhcnONNsBQg+VCpAVBOY3B8QJo5o3d
	 QDEKGijyJgH/RfY0KT56KX53xVM3sfoKobSTNLJ6R1BGa20xl8+MJpQIUie0xhh6FA
	 EZtrkrwsIAIDDYpcSeF3wJTCl5ItuH6KpnFDa9IFaDkmBbV5PVvHHL/KbHxGCdRa5I
	 Ja6r81YADlG2zpuB1UzPwLlEW2l9x4y2VUTew0kBeBuHBtY3uj8b54SAbn+uKdZ8FC
	 ytUhWP0xfDqMI4yGiJhpAcmTr6+uwPihVfBEaB3et2+C+hbVJHbAWxu3nqK45B7AIv
	 aWkUktZYbCvYg==
Message-ID: <sashiko-outbox-206142@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/3] KEYS: Introduce keyring_is_empty()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110033738.2495880-2-jarkko@kernel.org>
References: <20261110033738.2495880-1-jarkko@kernel.org>
 <20261110033738.2495880-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 03:43:21 +0000
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
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110033738.2495=
880-1-jarkko@kernel.org?part=3D1

