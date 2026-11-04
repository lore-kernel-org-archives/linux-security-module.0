Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826923;
	b=PolWFUCP7Jxo60TjmQkE7NNjaczJsWUeAyFCn7WE/M9Fr6Z/mqn2CoVoAe/2qytjgx/8
	 NcPfNQQ2/Yd21DSxf0xV0RHwHgU1drbpxXTEV9IHfdVSkDfvlQt9/IHv+nPKyzoEHCuvK
	 o41jhjLIgkk2KzZ4jfr/ORczeQnbqEcDty0czCCzQBDlb4GcEi2HtFtzUzO8oily8a/G7
	 cPk6dy8tfrUoZUnKX/uZPm9/LcTX9yNNsHCY8y0ZVJRJhrn4qq1eiDDkmrHyKlhuZ9epb
	 5tmblhJSOGF5mVh0mTLoSJ9MBvzflBlXwx/cu9Y13nIUiRp0Xj2spAYrHvDi3shaplQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826923;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Iny1mwAG8XxZrLgd3gUMUyHG5KF0vHVd1DDyOrzTmI0=;
	b=uDP928EVhWUJ9ltXvLHfoLkwoGeqsA+W2irq7uXf0wf2Cjy3juIUj+8IcMZdFvEnfLJ5
	 yABEWV4avGsdWk/6L8bqcA3s69M8ghYUn6YE1e034PiWVztX2WpdR3p/nEGr354c7j6om
	 RBP+J7rSEDNW5luYMgQUZ1wbhdu4yH9JDfPj5/w+4HLB8PsSv/p7yfIOJ3bUFxR3JRBZY
	 2ZPoy8uJ6LqHO2EG4IJm92zA6pUFo/wnHeaEn1uP2AyC11KD/R5kOQKAEcKAt0T1wQDHa
	 AtpB7p5ULNopUEEnV4kdqfzcN5ggVYyn71XHlMDvFlkqxgDrfzSpsQ+GjkTK8KJCVfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maiwrJue;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3966070318
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maiwrJue
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BC21F00A15
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826923;
	bh=Iny1mwAG8XxZrLgd3gUMUyHG5KF0vHVd1DDyOrzTmI0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=maiwrJuewhGBzciITb8s6pOOcasSZ98Mm1Xk/Q2ysBNzA5TibNKBYC4rcFZbglL8b
	 HeJwjNHI9IiTEzW/POw7bSEw8qfUTExGQtMNp6RH0st0MMNTyJYYjo69Iab30yggG9
	 BK2BVSHj4YGPMec3Isomc4+nVlmF77xNk3ttiPK+zB4KBJNGHw0BFf7eIijo5WmCVQ
	 ZfvOr7deV4hd55YPDE06gQGGkMjeyzjAgS5yczyjFlbUeprMzO2UuKYunin+0xRevG
	 9oD4Oqu9btDZw9KNSxoD50Vxp91nw/0RmMe1fm2Mb2mMRBhnjln2lUFlP+crt3hkGk
	 +uGXBXD8VJnXA==
Message-ID: <sashiko-outbox-198079@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 23/27] selftests/landlock: Fix stale comments in
 common.h and audit.h
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-23-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-23-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:15:22 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> * _init_caps() lists more than three capabilities.
> * A 64-bit hexadecimal domain ID has at most 16 digits, not 17.  Size
>   the buffer accordingly and drop a redundant domain_id check in
>   audit_match_record().
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D23

