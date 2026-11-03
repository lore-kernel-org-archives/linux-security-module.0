Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710070;
	b=FpzG+DojWj6PuVc10P98trOCKGgcOtDcM/+gvUlFfrsmdCzdqHPCX8pNG3eCObwuXUp0
	 6jq+LQCfSdV0VDVdGePY3bIMspq9KWJXkPnP6ofvIEgPOwxb4t0B76IWqNss58gWKzbX2
	 aBrj8M3sxwiBJ6/0/W5h3Rl1C4ixB9bo5KWlRoOaVicRX6NhsX2aTJ0SWs82UIVVhNrZs
	 jqRAjw/5aOsq9a7HNmt9C+Gj607WMpGEVUaAO3Ev1QSmTj/oV46nXNWHdQ9u67fU0m04N
	 lNFYmSIb+PKE7iwkA77RvNEgAGwRckEk7v3d1fl8gYYNUpquILVAnmiJbk8kFKbHvjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710070;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X67Yp24Ipqmku4DxYEnO+GOUJ35Ax0vm+5h13202J74=;
	b=wqY/Zhm1kHQZ/z2HLHzXCr8Hku9uDa3/fOCOCSI21tsz+T8JmqCrYFhop6KMRlPIjf6l
	 OO8FpT2ln5uJfh2aZ/wHhWRGz16KefwEUoieLKn+utUGqDQYK827N6nTl/kmrb04V/26U
	 2F0K35tBDKjTSjLc+MkJtT94JUa1y8dTaUOMIwl58X++Bflc46C50wZ6RfMFaBHrxcfng
	 iBgC71svawQ6hD8ejOe585UkKAUdTnx3E+HPhPcOrx4sk7Cyvg5vEZn099pgl43FhQ244
	 a065P5Vx+16L1K0yWh/ZLVQsGt+pDNUwhvd31iogYzhEd8Yvka6CmCeyWv/lKESC7VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LF/YrT7U";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC89606A324
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LF/YrT7U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8A51F000C1
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 12:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793710070;
	bh=X67Yp24Ipqmku4DxYEnO+GOUJ35Ax0vm+5h13202J74=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=LF/YrT7UmMntYBCTJKpAanfrPjzkxhVz68/QekaLdB1oSWwbcyp4SqvBARIUVwzpS
	 YUcCNyo9wMWD9f4PRFmtunJ8/SPsZLLmiLJ3sdX/PnxwKF2Nil/4fvijjv2vMXJHrV
	 TwmtqO7TidsCUXkWlZxG8/06F6b6BClpAPPhEybiYQM1mV+0G9S2U5zo0pP3A0C/bv
	 rozhzlU4IFBzRRE36CzcBijI6iNp1d+L4aANP+I56TQTYFwkb7Rd9C/uRD0zIx81TI
	 sqZohppnhitHGRoLeiym/rAabNVgJmper6vi+k9D5HBpYgfiRBoJotuwDNp7Tu4RdE
	 D8GHwkdAPCaTw==
Message-ID: <sashiko-outbox-195276@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9] KEYS: key_garbage_collector(): process in chunks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261103123629.khFxH4JZrg_affHboqbJRBUuRVhBDIszGHJdJ9upcjU@z>
References: <20261103123629.khFxH4JZrg_affHboqbJRBUuRVhBDIszGHJdJ9upcjU@z>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 12:47:49 +0000
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
> picked based on getting a reasonable variance with a minimal throughput
> decline.
>=20
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd-=
test.git/tree/package/keygcbench
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103123629.khFx=
H4JZrg_affHboqbJRBUuRVhBDIszGHJdJ9upcjU@z?part=3D1

