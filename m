Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826835;
	b=eAiiy4Tdjnsl3zQA8HO57NQ0Zb8mJHYx8U1r0rnchfujR2II5hH4g6E50fG2lKrcMojO
	 VKUAkIb4LJIVwX3aWK52sM82/YNv50HH4UJRuloeVZMZUjNUYhrBCkI/0jeOvIqcxOAim
	 csdC9F7MYWPkEz6F+CgfnGZkM402/Tes1GwjXS+sfEjTVmIqkH0Ry3KV5i0vAleioY4li
	 M+4LUJP1DF+zrEZtWUBnETHYDOYQAx+x2B9n+na7/ICfTo1NKWS0KtTmzj97mNRu6p7Kp
	 1BIGlrzZlBizNIpsImFmijskb88nnCw7nlAzrooyuIkgHyFlLezhDlFC+q+8B82Tpsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826835;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NHNgjOp5VuTj1KYuO+WAQoJ3HbaK2qkFN8ohURO0ReY=;
	b=gUxWxwPUiLNYkh/Uo6dksKCubbyhMVO1jfUmhwN3SPOHmNIkR4Pew1Mmk1OIH4cO1CWc
	 KaYx7N8C21ZDidYrc7856eoT9Q6sgpe3wD3qd8Fbfaf51KkkZ7LtW1yfeHwZ3WQnrTyQO
	 eTWzMIBDHYcYjHHoDPH4tooZ3AR4YAOvZY6sI7/j4X/S6uqDYmNv9/rgTJ4XUmXwPAlRc
	 nid7rtbH9gTGhqmpMGH6gZz5yCky/JAD4HjKpmUJACbqLoPQ8RlxExWWQZRFgxWc4C5pE
	 y5t0HwwTCq9XjsZHZsm6FSWJ2C34czTXnPmrNXEMGHp2UQoRp4Dl3xsKUXfmaQkFJwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tgdov9uH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C5E6072F7C
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tgdov9uH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2A31F00A1F
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826834;
	bh=NHNgjOp5VuTj1KYuO+WAQoJ3HbaK2qkFN8ohURO0ReY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Tgdov9uHKIeDlGsaAVK6drajzTx33a9kt6fEp+ttHH/i2u/BRbv3pMszEJd0VUqpX
	 slhva6pawGjIulgRphL8bwAJO/2QP42hyyOrvMiQ4PicE7yPfpD6eUIe4BSuZD6Jya
	 /vhOkes/PK15Lark/KvoB9/X7UE2YVTyyLx6JSg9AauWPTyoVBqTEoJ8GvLDtWT3P0
	 odTGQDVKmQGHvDllC+noaR7Ad/JbCcSINfI9fDUn3ln3Y319wsRom+9gSGK7SKaY0v
	 oZBkf/4VL87WF1Ji1vyS+aDayTRm/oRhu6u9We3GOaVS9E1p3VDZXESkOdmoV1dpTE
	 3kX7Dt+WlXpXQ==
Message-ID: <sashiko-outbox-198060@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/27] selftests/landlock: Propagate grandchild
 failures in unix_scoping
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-1-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-1-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:13:53 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> scoped_vs_unscoped.unix_scoping starts a child process and a
> grandchild process.  Add the missing check for the grandchild's exit
> status and propagate it upwards.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D1

