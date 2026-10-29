Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283807;
	b=ooxlSeL7BbmKkW+OI6w5zSlESHF5n2a8WRCJIEJiKItvL37QjV6eIrmpoD4KlW1FYsMX
	 qpbKMsA481/VOIlixCAyRWQWf38cDFrxEj3wn5qh/GpRKS/Y11FHhFGng/cBCkWFX0fNJ
	 nECmHsgG4sd3p8ZtTPXp7qddNBA3YIgr/0AL7UkrOBXBjNcOW/b3xsodgo9xhG6/LCrbZ
	 +WAMHGyt2d3hR5tIg3UeTQnK9OXZXBBzbifzFUKya16fFpc5Gxr9gLI57ERnTo1gg8MQo
	 BDxsbVCSbEVexG7NIVsFGfnvtgLVupxiIUo2Kmp6XPXDJWmNmCCZstA3ZkaARVFqQ1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283807;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uJl68TXVkuZGw+CbvOYD6xh28KV9B1iytb4E1uc1LRM=;
	b=CPjND4wll+GWH3gUQzXVSEZhSIlXyEWTJvqZhqVL7Y4tWl/w6aZDYyttmO45WC7u1Hm1
	 rjY8O8ERkN6zSJET94kaesQu9yXVMybWt75V/4DJ0kWYsQSuFNgERCq00t6RzoM0LyE0a
	 Maw4SZ7hJHBicOFGesi9QzN6gYArzCagLdY8wXhhCbkXJoFa/bMVH3oi91vsfeTFXsru9
	 rUr5/0j3P381w5TU3CzKomcoIqiLmuPdzF1tNFsEq54ZffELevMY0NNL1xujZy1Wwp/lF
	 kNvai3Qux8jHNlsvSnDVRFMRRqDaIGACExUnpimVGVkQJMQjqiZURDfOJ2ZvmCPCZcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IcjfGO2f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13D6606A31D
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IcjfGO2f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA711F031E0
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 14:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793283807;
	bh=uJl68TXVkuZGw+CbvOYD6xh28KV9B1iytb4E1uc1LRM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=IcjfGO2faj3XEEBc0A929AG44180XepocwjZJgECK+pYnWrPgL1HnYIrGlpuX5F8s
	 iUaSR+ClqxmW1GqwjYy8jVmrU28OqWaS0J7/H1IxES18H2xU/DTjvrtV8amlnaexd7
	 gwy0MI/W9iWjCOt1JPVd2GtWk0u7T5RcngpujvGUcrE3v5cY/Ok4Swjcx54NQm4PAl
	 YZZxXwVysIayRXnpPYqFopgYVB+K8Oqc6ScJxxTVfvMBmhrYPiN9QYLLlAzlsUeHJI
	 UgJygOSIdEHtLuiitoAO7MtdGeLwDkb/Gcizosq/CUegVhX52ohReAYNIV/UBzkrTm
	 9P8/4KTIdxpNQ==
Message-ID: <sashiko-outbox-189506@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] KEYS: key_garbage_collector(): process in chunks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261029140707.2010100-1-jarkko@kernel.org>
References: <20261029140707.2010100-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 14:23:26 +0000
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
> Fixes: 0c061b5707ab ("KEYS: Correctly destroy key payloads when their key=
type is removed")
> Reported-by: syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc15de43f1e7fffbb7b9b
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd-=
test.git/tree/package/keygcbench
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029140707.2010=
100-1-jarkko@kernel.org?part=3D1

