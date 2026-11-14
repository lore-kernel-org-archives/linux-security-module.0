Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794685816;
	b=Ox3Z5giT5WDuBxWOrai2+X8YdO0yn75Mk/ONo5WhhSZUYnhaeOCXbc2ZcR0teuxiXagW
	 omBR6Ept1hXp4fo667x9s4szt98s7dIrcnfsDkP15nWQVpKoMcDwZ0l4z+xHExj7M+zcP
	 BcxoNY6TsDk1ei84gmLbGx5ffxhDx8uPtrj6m9gE+znw3IZane19hJovMxds+ygbFR2nF
	 pH1dBa7K2TmXa4ma8DZLKWhhTIsvlHkG5uPj4g7dTuQIuunFxJnCaIMGPjOg/GQoiREch
	 1kJwm8N6+t0qmnM/j9zr0+2FHtot5w7uTvrGe6jnZ29mp/shcN8ZurQr3YDxHWaxZwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794685816;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tAqeZYHeVK8xaFE5i7XzWqcd5AtO1pZtD14rw3/Y4ss=;
	b=Nl0m9HWG1GsiOIVgLal+T2inevEcyu1JkyhRDAJ6dItDy/8BHOiMBUPjmoxzlEuFCa6v
	 dJ3rIRZX6n5OpyqEKq3epx2CMduKadTOisU6xJUpvb4waB2/g2sIc4FBwRbW9qnK0g+yJ
	 GHF2q69xRyU3zKQ8rjQcpu6VQRfNfIcjUyXmKynyLYJyb0ieb8Bc7oM89UW0N5dcX95LO
	 mb2MhSBnf08UMaY0bju7XTektxTFWdMLp3Pj14tB5SJQfPEWmWK3lmHDO4afhMnopwP8g
	 R2iLPpFJ4RhgAIszK+CNc/n3mwY3Wv1jjFzWlx6Q+ZZglz3MtsNgI4j9bWwqfmS1y3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xm6Cv4TA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D5D606A329
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xm6Cv4TA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8935B1F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 19:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794685815;
	bh=tAqeZYHeVK8xaFE5i7XzWqcd5AtO1pZtD14rw3/Y4ss=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Xm6Cv4TAkbjqhqHZfBKX+zzjIQADlzSvAqsajIR8AEgrKQs9ohF3Xgzp79v8BRl6L
	 ZAf79FV1gV3/ENKuqqIk1HtZymgAOhTbFqpOhxuL4G5d06jCvzMsUQnvMxSfcOKhj0
	 6NW3Z3Ip7gXtGTWe6yi9eAmCj5ez2KZZxSwSR6ROr7tTMITkVbVVzUkMc/4msnRnIf
	 CEYT/RzanRCkXzdV0fA6jCMf5i7tXeGlTAc4TPMJf8/LdmMV+Z5hG1jrfXNruGKDw/
	 xNkxKkHDpB6prG5bv5u2+fnGdUAnTLWkPytEinX/WEBuuSFKuLg50Gfsh2oYvt9/gd
	 W9gkO/OBoUd2g==
Message-ID: <sashiko-outbox-214986@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 1/7] s390/cert_store: Pin the user session keyring
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261114193631.731615-2-jarkko@kernel.org>
References: <20261114193631.731615-1-jarkko@kernel.org>
 <20261114193631.731615-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 19:50:15 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The user session keyring stays alive only because the session keyring is
> pinned by current_cred().
>=20
> Pin the reference at:
>=20
> 1. find_cs_keyring()
> 2. cleanup_cs_keys()
> 3. create_cs_keyring()
>=20
> Cc: David Howells <dhowells@redhat.com>
> Cc: stable@vger.kernel.org # v6.1+
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114193631.7316=
15-1-jarkko@kernel.org?part=3D1

