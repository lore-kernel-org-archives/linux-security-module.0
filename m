Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146596;
	b=L7ndMYxFVM24wmdanCPJchVfEkqq9yuZ8ZFWNdRbFsCrUV+GiQNZsaOmih6KpJqXx4Ao
	 wMzD/ts+OpGn2sa0uMuVKksHPWHEhnZUaZIYajV8WhMpUZ5xWNONuhYgEIz5vxAfTxMR6
	 R1yB1z/FgIuEjJobHje6y8U/aRwJ+UmjzUft/DG4PowGYQvGtaKQyRop91iAUDQcLiJc3
	 6Oc/9noZhIOaHIGkEPTGgxlCJyL9fpvgQIMkO90sJBT2Wdk4JkJsFwFAiIZT+O7IW6jyK
	 h4mFqd6OSkWYU/o9j/p8h7ykAb/jHQFdahI4iIxvGhMP56Yhd5A5zCHkQKqKN88SrtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146596;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N+YA5FB/Z9CKT+tzIwS3g3ZoJwSo34i6eUf6FZbZTqo=;
	b=hu7tUUS36ooXanyJwquEYi5/X44afuEasadeWlX/qttAfeQtYU1h10q0Vv2JTBK/27i1
	 PGVHOPF0fzxXh/IgxeOK1kKrG4ZOm5zTJLJlxUkLMYE45lEf8yZhk6eY1JNT+ApjR8A96
	 046Mcd94pZC8VWZGfXCBmY9KzpGWib4ED1wgcXHFwoAxc2iNXU2wXPq70yUhTXCPdg+n1
	 k7Ysq2bRWbaefdC5BYjvmP3NogsFxv705bQX9upPE5Q0JcAyia9jBQ/MS3OuuBeNXqL1e
	 gi9Jwzl1mLbrMxISv0XPLe60oE+4uD1GsiMR1c+dsdWC66uQuGlMLPBEKH+YTpkJ6Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CV3FABSI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A3E606A31A
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 00:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CV3FABSI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E701F01825
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 00:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793146595;
	bh=N+YA5FB/Z9CKT+tzIwS3g3ZoJwSo34i6eUf6FZbZTqo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=CV3FABSIKWPQd5qsmPqSahRTx4+MXnhQILvtnVEX78Xg5y0cG55KfsvPXxEFjwr5B
	 vKKfC6u2M+BX5H8sM+j7swN9xSLPNXBnhgUEPPrU9gdTCCiq+U44Kbx6zDuNBR62vX
	 gxbbSm6TV3yI9+qpjoBzvjS/SHXqlNO81HyhtL3R8cInMBAX+d29lZIhX//+Jym91c
	 eU9CpE6uxh5UK7WvhSKQQt5RN4KFitw/AomTLJDFcEpZxDDTrztJ0brMX//f6QAo70
	 QeDbZ2b3vBelXmI/s8phj+wRWR/a5pc0d794VQ8DMd62COHX7dxsh5wynMdb5UNUAL
	 8meSUVou24WZQ==
Message-ID: <sashiko-outbox-187267@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KEYS: key_garbage_collector(): process in chunks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261027235820.2002072-1-jarkko@kernel.org>
References: <20261027235820.2002072-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 00:16:35 +0000
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
> 2. Define KEY_GC_CHUNK_SIZE, set to 1024 keys, as the bound for the number
>    of items scanned and destroyed.
> 3. Define KEY_GC_DESTROYING to mark resume to destruction without repeati=
ng
>    the RCU grace period. Drain the graveyard before advancing key-type
>    reaping.
> 4. Define KEY_GC_REAP_REQUESTED for preserving full-pass requests across
> [ ... ]
> - aarch64: chunk max: 235 ms, total increase: 6%
>=20
> Tests were performed using a laptop with AMD 4650U Zen 2 archtitecture CP=
U.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027235820.2002=
072-1-jarkko@kernel.org?part=3D1

