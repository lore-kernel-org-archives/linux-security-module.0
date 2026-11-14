Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794685649;
	b=gWigrtqfkcSSIr6Z1Z2bg+7TVDOAjZ2szbxEVByKdPPS1uRoIS9bylWkahUnWUCTNEGZ
	 8lGV0RfYyqYkxG6ojjUVVpxoRznfkWzAgUB8D1ZMWfAejnAyEL3EV2aP7u3VWbhYRlery
	 GeB78Jm0YN7psH0NLZ7N5UcToJ1Yrkk5qvYdcxBNx0yzioq7i6QgZSYLay61+yN0h/+gH
	 +8ri/briTaWfDlIlUQUphgCiTXalk+a3SKCPPukdBcDdgOZ0w54j8Mp2nvXyT4bzKnAI8
	 XN5WAKDlEIW8nl3yVi9P/AnH0mLU3pFiFxkPmT6AlCVMA+eEX9eICW9+HpZr/ocPnww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794685649;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UAwQa1HZ0Nr920wf/6rUaKYo9nqCkiZ7rjExItnI0Jw=;
	b=kIBNYdd3R6DMwmZXAY/2uaI5VUtWmyL3UuoAllAGqpzAjAJ1zxAyGhPRCwD8VyOJr/D1
	 euGS7b72M5dDZ2Ctgzd29aaQFsuQ38sd8YjGXmN4kb/v4ZWAGrrOxccFJE85hCEsvrwxR
	 U8diHHur4noPpzXWf8+uqGe324FaLsmftHUYnOi63sS7PCEsK0F8B4/pPbvsiHAS6vQ/K
	 z50xIbZS+3g5ofRbG5JyqMIOaGZv5nmU6zAKmyyggB7K81RLLTY7QsOinUGNHo7o2ZlFY
	 WhbPXedTx0XOZYCfp+zG12G2X4BzCkQC3IBm7bCmezvUncg8E3rJtAmmxEFe85M+KMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g/cz1NYt";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D141606A327
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g/cz1NYt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9681F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 19:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794685648;
	bh=UAwQa1HZ0Nr920wf/6rUaKYo9nqCkiZ7rjExItnI0Jw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=g/cz1NYte4za4kt4zS/vrfIcrdwxz115aXzmu+xCJ5YsRsT5Rct4t0FWxjHD/lLxO
	 lIhRWfx0HchED07YZydBPSSR4gid+VgAaxEOV+jpeNJV7TO6RitIHBk/c/6PG2K2D9
	 Q1h12FI3uzdTb6+BNPNMPgZe7oLNo09edD1hCejAT44oVzvzklacfrSgtvpetK5pBV
	 8pfLJy9oAXE0Y7+TzFGho1dMJA9uxUZhTQanXPIiiO1Y8JVF7cJ2uJH8E/w2ImDuru
	 JexEdYNMRswXwtCvdL9mjCPPYXzdxmtsJ2lTr3M+D3SWC5ZQHD7dJPGMmMVb00k2kb
	 i8YGmpDN1BoyA==
Message-ID: <sashiko-outbox-214985@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 2/7] s390/cert_store: Return an owned reference from
 find_cs_keyring()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261114193631.731615-3-jarkko@kernel.org>
References: <20261114193631.731615-1-jarkko@kernel.org>
 <20261114193631.731615-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 19:47:28 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Return an owned reference from find_cs_keyring() so that it will not get
> dropped.
>=20
> Cc: David Howells <dhowells@redhat.com>
> Cc: stable@vger.kernel.org # v6.6+
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114193631.7316=
15-1-jarkko@kernel.org?part=3D2

