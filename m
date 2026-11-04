Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826939;
	b=nTCy6LCiY+rLpAeXG59hjton8ZV4Jn1DGVzJZE0+g5xIUqe92Ab9CSaTmXfJSkCPWnGV
	 8dkal9xfV3cCkmwicS9RfSZ0zm3D4F/Os+0wxajTt3YENEDugcn8zntJWwtqr5ElJVzLP
	 mnbaP22JJCEt/9HEvndhV/uJVat9F3Tykl3Pn4kzolhvsKHD/20nic4Ophf38rbclCtnE
	 T+eSG2NFF4KZmntrZo1ZsnVUBlGC/o7US/N7Pbj/EwQ9AwKMI8C9R6AhKBcPuz79xXOR9
	 sJcUPgnnmH0Lj8diioLBEbt8j/Eq/XYb7ChdAPak5JDVTGCKRKGFrBgPv6NRNblXJWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826939;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T1OsvjJfy9pZXWiXPyuJeUwxrwW58ChQMQI5ys58xro=;
	b=IzFsyxZ3s5ZDZ/qgGH9CLZLzPzc3NcFLZ1jDXlXRVhuPKV9BLYQlLKmAk0YpEtG0dH6Y
	 pFPnbRPMRRbECHLvGtJgB3WVUjvA0pULE21T+uu02IpTcaSe4jZtYBidd5YSR0GuGlGC6
	 prjAOHLXBMPf3Yl6t17dRamPZGGwD8QfdaVaJYFg35p+H218ZcNRkzFao5e50g1HfLaHc
	 6AfVs/IheQMeS8k9cFJQwND9zO4CdCjhv+mBGhe9xmeIbm7IisE6KW1s56h7B1Im4kR0G
	 s/6lADsz9Tnl+LyowSmI/uWKf9DKgevrJwCqnF520qG5BfMpV0jHp9LWQa15nXYWzRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzIpNgJN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CBD60B5A58
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzIpNgJN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C141F00A18
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826939;
	bh=T1OsvjJfy9pZXWiXPyuJeUwxrwW58ChQMQI5ys58xro=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=LzIpNgJNTPSXO+2sJEBkHdKOO/jtluKJ3MbiU2AwFwrbna4bPdrEjyhEAi1N2S6we
	 aE47MHVa/Ku+1kKgNA9apOfbpyx02bq/RW0+zdzsyxb4luoYlU/r+/ZiVf4hdWOQo6
	 a1WY8wfDfh6wWUC6w6QJ+0FKbvDKzyvlw2alakjBinDY/LGlc+tULQaFeHQCmr3ujf
	 23wmb0bfVYxXUUqFKRGHgxJscdnq2g5NzffeEXODzNpHR06z6piDCcXjuLuGFerPkF
	 HQXuEVuKyj9JnIBmARcm6WzKuaygKInrYTli0DrU+Gm3cSPFcke9M/tQDxLtSaofnY
	 mrefb4zGuS/Eg==
Message-ID: <sashiko-outbox-198081@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/27] selftests/landlock: Fix off-by-one in
 regex_escape()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-19-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-19-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:15:38 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The final check in regex_escape() was off by one byte
> and should require one byte less to put the NUL byte.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D19

