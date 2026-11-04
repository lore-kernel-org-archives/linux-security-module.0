Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761390;
	b=F50LHjSvRIjkmiDQ8GWi89pzbvJbCjmG+UH8v16tOU0vSTurtOBe2hE/30Z9fsBTS2Sj
	 w2K7ibtkUItkM7gfmJDVYqHdDntGW5JtbaE0qLenimPJsHbJxyOkGvnLwyN2qb1O6witi
	 pP6zxDmhuz5PJo8ZneJYlMSk/XDUPI7MCubJ/AruvfrqeaBZzrg3kC6BX1jHRTnfYxj8w
	 9Gb/B7b69Fp51fY6gnbOE2M7CJMfQP6SAUrvaB4GZC2zEBWwndCpkDgF9utNx+nu1FdLc
	 a+21rbHGmA44JnTLnkTzdZZNjFl4i6awqZDAvb0Zq23T8/VThjcAVDo+ynf0mKesuGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761390;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tZ/biovr15ZXWLPc2qkqVzE6PORTpz2+ta29Zd17KdM=;
	b=s09Tc7pNgM2Xc7yl6XGF7oD2jwEIWy/0yMZ4bU30CV9vYtwbkcetme9JZl+6axRICNP/
	 o6ujmqQaWS2hQwBLgSYJmxM4hqo0m2h08gWPm2w33kZU6rea2DvtuBhbqdttFSks6qOzB
	 zO9wBP/5lTkdhTZR1Z5ID8bgULR8WvuYww21Oiq7zRC826AupV+y+AZ2k8h2De9YjrlIL
	 wWVfCp+A1/cmvi+BpZ2isUdFYJ2RcEz77owWG0SvLw1B7VEVPdPPkTlZmpolisVxHCVo/
	 kzWv2vuIZupAvEhaOAntBaToLe+we5OfXkSXUngBVt2V0CNZkHDC2Yfm5FDOnB0bF6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X3AK/jl5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38107606D81B
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 03:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3AK/jl5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CF41F00A2C
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 03:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761390;
	bh=tZ/biovr15ZXWLPc2qkqVzE6PORTpz2+ta29Zd17KdM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=X3AK/jl5v3v/xQxjSNHEf7jQqnsiTuBObPvvTgc7kkuID4Z8Mm8XHwo3dhP6qvZbT
	 ns86VDEfffZhWRSK2QWv70JY/uCzOhSLis/h0QSmQf1ohN0QaXD3aVrVfJgI51miRz
	 Dc17D968wRWpytHaIqAPxyx9Ql4s4EDnKL/hC2oowniOjE5L6VAd77dVppNqSYHh7X
	 zXarTa9zvr3346B9HOTPTl94PGF7rMxXXjxy5y1xu6TD0mQePEoe2VO3zs5HwApc2g
	 KYkwxsc8MVkhB8O1KB7JnJlnaO569oVJkV2n48eb6kPsR4a1I5YjN24E1TllOagfPx
	 9eGJ+pAKnc9Zg==
Message-ID: <sashiko-outbox-196575@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 11/11] KEYS: key_garbage_collector(): process in
 chunks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261103030226.2685251-12-jarkko@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-12-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:03:09 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> key_garbage_collector() has a design that is not resistant enough for
> workqueue lockups. The duration scales up relative to the number of items
> in the serial tree, which causes a reoccuring theme of being guilty of
> causing workqueue lockups.
>=20
> Resolve the problem by processing in chunks:
>=20
> 1. Declare a static variable key_gc_work, which owns the garbage collecti=
on
>    in-flight state, and key_schedule_gc_work() for re-scheduling the work.
> 2. Define KEY_GC_CHUNK_SIZE, set to 64 keys, as the bound for the number
>    of items scanned and destroyed.
> 3. Define KEY_GC_DESTROYING to mark resume to destruction without repeati=
ng
>    the RCU grace period.
> 4. Define KEY_GC_REAP_REQUESTED for preserving full-pass requests across
>    the continuations.
> [ ... ]
> decline.
>=20
> Fixes: 0c061b5707ab ("KEYS: Correctly destroy key payloads when their key=
type is removed")
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd-=
test.git/tree/package/keygcbench
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103030226.2685=
251-1-jarkko@kernel.org?part=3D11

