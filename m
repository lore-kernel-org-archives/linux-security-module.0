Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013857;
	b=WJRlNLmb7/kUMQFKExmyAMJ1CTRrxE5ojTkXk8ZMTJomHB27HWi4EuwU3E44y75x0CiR
	 4mqbOyPbecEpb3nhRTc2pFC4BV399d+SP/8hIuNB7m1JDVJfJP8JzoDcM2K5OIPf5XUA5
	 GaZ4BEr1jrLE6CngzJEwQIcHBK9Am7oqLS5Qsq5jTqVIhzlpV0M8sIHrgXTM0F/nmWlyk
	 g5nNB8E6ohJlJwdSO50nzZD+i1H3RaV8pQno27Shkbls0cfyqdj7poJGfzpGiKMkDWyfr
	 VBwA+F0H2sQL8KvRQKAjwWsNKycrobU0dTNHW5Ypt6GAZJllIpzRGNkgfRCCXc3iW8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013857;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WO1m3ju+DtQKj+B1Wpad3OERZD8rv4RNdIJxn/DSFHM=;
	b=Rwu+buBt3yz3NZse5WaJqj4M4nCzISmsI0NNUfMB7NGeFBEBp3kXg+8QusBlTMi3QHIy
	 FSQuCkNkqHu0YeY9v1WFsKi4kzKMjxeTklDj7G5UkY5XKmNBaaReNeKoCI8O0WzhH1k69
	 HCAfTonRqT0H1m2FcTX/19PkFRF9snC7Q+pl5kRA28V37WKfmzOx4BL0V/na2CJRiae2K
	 hmzYEDmUAoY3M6Z3SexnyFiathbSEwZYzhjhrA7E6uEY2f82Z4BuR0+xruTOJYEG7hPge
	 TLz23Y5gTxg1Nk8oBMo3YHJvMTM1SR5Si2FyDr0cxK27v8Q6UIcm89Yk91eUbh4FQAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aVU1wfVT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E931760A2602
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aVU1wfVT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7011F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795013856;
	bh=WO1m3ju+DtQKj+B1Wpad3OERZD8rv4RNdIJxn/DSFHM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=aVU1wfVTTnQbuhXIRAaHzEox/vVrOn41+QTfldusxjR6o0d4DW6ybuUfrWxnvyS1n
	 uvLDMspSNqM7imH6v/tUtJbw9tsIUzBvCnzg+tCuBb0/R8CKvv85jEsZErVzFnC/MY
	 Qfu7u2P0G0hLhwaDI/j/WG6G5Shs8AdRPodck92+2m/XgbW7MP+XSYDkvC3EWRqJLo
	 2rH27DTONkR51c/HD/W4bW90ndZ9DjPPvdgEiYBOleR4JibP6ywfGApnBtBr34Ttra
	 Ac0r+iPYd42qP7ZtqSKtsXn6JRMi0ZjfQcEosMoheCPST0BXnNI/u/FzQHREwsDU50
	 VqLf0Izue081Q==
Message-ID: <sashiko-outbox-221272@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] landlock: Mediate CAP_SYS_RAWIO for mappings
 below mmap_min_addr
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261118145217.2551053-3-mic@digikod.net>
References: <20261118145217.2551053-1-mic@digikod.net>
 <20261118145217.2551053-3-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:57:35 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> commoncap's mmap_addr hook checks CAP_SYS_RAWIO for mappings below
> vm.mmap_min_addr with cap_capable(), which skips the capable hook, so a
> domain denying CAP_SYS_RAWIO cannot prevent these mappings.  Mapping the
> lowest pages helps to exploit kernel NULL pointer dereferences.
>=20
> Add a Landlock mmap_addr hook that checks CAP_SYS_RAWIO against the
> domain under the same condition, as SELinux checks its own mmap_zero
> permission in this hook.  commoncap runs first, so the hook only sees
> mappings that commoncap allowed.  This also covers the x86 vm86(2) and
> vm86old(2) system calls.  Calling capable() from cap_mmap_addr() would
> instead expose this check to the capable hook of all LSMs.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
> Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118145217.2551=
053-1-mic@digikod.net?part=3D2

