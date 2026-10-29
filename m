Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793251202;
	b=HdxLezeJmNtlKDG5k/Uuqj9Btg8wcy4sqYixY9Mzuu6NdM922uJb6laC+DGNC/9cXXU+
	 ThQll6BKi4jB0NXGoOz8F1hDxtW5q51bmv0PZVOdz2YKQcYaVcTiM2WJguE5ShgY2dAWB
	 l/wE4cStFcVzW7Ua6g9ZVbR/CgfId+BZyo1G38xv9KEhQrIeMq7gdQ6OyI+C15Hcoc199
	 1J0BmOzRuIrdlJLrRr/9Wlo8Xgk7CF1vbYwFSzCDW9xNlIMf117S35KrnsxiHdm0RDTXO
	 GSDyv41vUqOFG47wJMxw1i5GQH71cvZODzn8Sjl1bntYfO43X6FKbiZFi/5IRiFL3fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793251202;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hqz7jtOnmjAZC8JiN71+9pRlF/BNfomhctbi/I9BiJg=;
	b=rNs5pt3jvhzmGabLeTz63OhG9RG4P+jKtNKe0+qG0csAV7AcmnrX/vEn88XUnifaNDh8
	 Ui/dyF9KEhH6xa/T/cNeZ0hWJvEvX3MvH81v4+gq9oxspuRW3TW4lAp/RupM3ggaMIeMW
	 4EmdpogmbWd4295w1pAKXftTmMy7lUA5PJNlIjQNyo0CQrDG0YhuuUHAZgW2Nfl7D1oGq
	 kHI0XjFCMqHdwnJRDpbAlCT79hZW37jNiZcvB8gyeRbXoLRWjhy0pSnP6jUEiML05MeG8
	 A4OE2I31gQPMOSgqC/5PNbjxrNMjoU5VuVs3mmHbnzgzpvjCy33vq/czBq410h1gzvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjolYzTK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B193606A31A
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 05:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjolYzTK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD781F01825
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 05:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793251201;
	bh=hqz7jtOnmjAZC8JiN71+9pRlF/BNfomhctbi/I9BiJg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=WjolYzTKu9Ufxxkfbi1TxhgoUN9PJncPVlEFhrIbmEa/gxar1L5L00wMaBjo4ZmuE
	 NoedpjXAKlky+fQeMO/WscvypIatMzv9BNzX/2EYiBVLnL9H3GcaivfE9mB1C2DpMz
	 6unDVjvmKDcJXMInr/x6/mkhwSnHQ6jvVaW0BEpfJ7OI2q6ZMcoBG/gxFMwM5dcNwp
	 FfvbIcoHKLtCENGfAtUkSVXkiRqa2bG5RC3rsVfLyE5ZYeNaoqjTpqFfjWm0BY/wjV
	 3u0+5sQqtVrbg1wkpX/vqfNeq3lReXzErFbVdcB7Jst8yaIXRak6z6+F8L8e0aZCGv
	 5GIXa8KgFqfYw==
Message-ID: <sashiko-outbox-188750@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] KEYS: key_garbage_collector(): process in chunks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261029050449.3346259-1-jarkko@kernel.org>
References: <20261029050449.3346259-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:20:01 +0000
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
>=20
> Tests were performed with QEMU/KVM hosted by AMD 4650U (Zen 2) CPU.
>=20
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd-=
test.git/tree/package/keygcbench
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029050449.3346=
259-1-jarkko@kernel.org?part=3D1

