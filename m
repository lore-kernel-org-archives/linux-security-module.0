Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793295691;
	b=iM/e8Ml/kc3M/F3nRPpGZ4x5LURVUEMcSmDPFQiaSWHzjpLanemW1QIkCgdvGSBk0YJD
	 zzf6jqOf4U+XebV9gqUNBL75Ndf6PeZaVqT9JxUM1hak2nRORzjyxdUik3pZCj7ilwIr5
	 RjssDUEdqkJ+gFnkPexAGuhfAE13rnGByEqpcAU9ntWZ5SBT1mdS9Ap+zV/tHlCYTpVCR
	 hyJpjLyhaCYX02atq7bdhEGm22yhUO6Pm8A1KY5ReTzqrmj5qXEucRHZD6LGyitUBqRmS
	 amQ6G8fKS0SKtXyMjsfHr4C6IVqMiP2KbEOZiTTAlbFJi2PJ+qIRP7KYDdy/bBmc2tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793295691;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nYk5llZz9rr0N5MQYyNEQSB4NCmFIYkln2wqZ2smUIw=;
	b=CBpGCt0VC8zJhhe9JN6zTeXjDLf9xjE1Wi+JIIj3KRrDel77S7yzOEbx61ZcNYrrsuCR
	 Ss+1JivxRLfqUq8eKBlIGK7/4W32GFLJm1Og88DYpiMYHTRcKbXBm4IUOgsvuyJ8mhI2w
	 vwMM93yGvSQS3XThmRUdRUhroK55ij3cCm5G83vlqvZmcNy62RCpvJipREe8C+GeZg9Qi
	 Ia3HH7JDfVMX3HMOa5fj7JKnFDOQJhJQZClGobyY6RqiK2SO1sf3ZyCwZr7UfAyX1v+Fx
	 SuUeZ3DBUD2Xb51zlVoTjpj1/PrsSzabtG9PFNGZLnRLmfijUQjrqoY8Zwhh5I8ZY4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hL2WOplc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A1C606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hL2WOplc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FA21F01816
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 17:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793295690;
	bh=nYk5llZz9rr0N5MQYyNEQSB4NCmFIYkln2wqZ2smUIw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hL2WOplcneOxRQIZPYDNk6rY7YDx1xewSw9uOO/L787UUOHyQuuKi35Ngy+4+yXi2
	 SDjJLvLjyIf2M25VJpMArHDj9oocVdeOxyJMAVFx3lYuOvWcplaQYlHFNqG5AgCWDn
	 S5ZmkzF7aaFQUYjfs5NMEQX1d2Qei+B6dLVWWFR8VCBjbAm+Qe3f8Jh8DO0x3OSuOq
	 tAb06qp2AwQ75BHvDrMGNOjJS1dVE9Ku0YO8FEA4dFHtp9xpkJzfBQKClyLpxsXuO0
	 anqEWHztDT6BBAKhrFa+6m5Jw1GCc+++h9IBabBsoEd2YZLdUSU2lMr5e63YONxo0Z
	 TJiBNUENXlijg==
Message-ID: <sashiko-outbox-189742@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] KEYS: key_garbage_collector(): process in chunks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261029172918.2118600-1-jarkko@kernel.org>
References: <20261029172918.2118600-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 17:41:30 +0000
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
>    the RCU grace period. Drain the graveyard before advancing key-type
>    reaping.
> 4. Define KEY_GC_REAP_REQUESTED for preserving full-pass requests across
> [ ... ]
> Fixes: 0c061b5707ab ("KEYS: Correctly destroy key payloads when their key=
type is removed")
> Reported-by: syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc15de43f1e7fffbb7b9b
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd-=
test.git/tree/package/keygcbench
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029172918.2118=
600-1-jarkko@kernel.org?part=3D1

