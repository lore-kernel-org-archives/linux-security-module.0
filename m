Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854126;
	b=Eyy+gfzEEatcGK2Oe/g3xGMPVy4grKmA8sJNXItsdP49BfiNkgWt4fzBRycR2clLTHEf
	 73SUpwStmr+uL5TVGOxirtj20flvF9WRCvKl18aEh5vvlJ0hn7yTlMQHpo7HCVlcCejSB
	 Sl8+L9zfD2JU6dRbZ12hGj0z9KgZcRxCVoLapXKa3bz4mO3Kqf3wNeD2JrlsCrp3rVeSP
	 TksgkbUNkDD730Stm54vVmEhPZbHzzgEnbaTlvkX1OisTa/AFdnWMs7lHkC197wvgeu8Y
	 aeGi/cli21jzJP6nCkqHbhui6y5yScD1Qp1SJpsuIJ0wLuMwbCC7H60yiyql4xo4OEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854126;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gFvOCFp2/EKFFr9s4uKN0MKTPBSwRlq+xVRJ3of269M=;
	b=t4eQI4+3SCT5sbEerb9zyyeCcvBMIB4zzMOpdv1WvzrT/jetIAiY80NfkeNbc70rXpuy
	 lnZY6Y8pqoIL533jMpU11/l1tqQoN3Teg4qyytgxNkYVYJ5tUY3oE+Jq/iHxiaMsku6It
	 zDQ9bulN9U6twvJyuk/vaYFnmrcaHYo7rNfHMu3qRsNXdzEKoMWGmZ3OZ5crTlwEy9WW9
	 bU0Bh35sHO0jwKpkl6b3851YJ/Pm2nooPZ/A1bSQyDL+cpC1fRqQhm5zEdWCP3Y9AKenz
	 fl5yNManSxqo/x7PrFIGKv8FLxAClI05K2U6IGoJImE2kKFBQakDkGS1scCqYXzLzkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fytWIuXG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06E9606A326
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 04:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fytWIuXG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C90D1F0093A
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 04:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793854125;
	bh=gFvOCFp2/EKFFr9s4uKN0MKTPBSwRlq+xVRJ3of269M=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=fytWIuXGHD0erVXfjrq1usTTmf+f5E6BUdRrTmO5mFaX1+tdye4Ybe3wFcv29KX7G
	 Xn97xHEVX3pzDKgoKM2QIywGUInqpCGVc/P+neCaQaZRju7KuDCXA/WOqBh5gsmFug
	 xEolJ7aJundLx4uc1G4kwSH0QaiviNLbpvFTDI3/Q3s7YyTXTQkwGL3yAatCscq07U
	 TJBEAZCmGmvcw+f2nuek8S3eMOCl2PMfsw7vzzM59J9K5QQA/v/ciV1EWfwhyXnazi
	 GbtaU7QCPljZpd4J9/eATTFZwjWl38n8hssnHc/vMLP5dqq4N2TxqgeilVw9XNNICw
	 7ikGK3dmNjJsg==
Message-ID: <sashiko-outbox-198566@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] KEYS: Protect pkey method checks against type
 removal
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <9d47e202bd11857b3555e6b95694b3c3a4f2460b.1793852399.git.0xbeac@gmail.com>
References: <auv35Ljgz1OA1zUZ@kernel.org>
 <9d47e202bd11857b3555e6b95694b3c3a4f2460b.1793852399.git.0xbeac@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 04:48:44 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> keyctl_pkey_params_get() looks up the key, and keyctl_pkey_query(),
> keyctl_pkey_e_d_s() and keyctl_pkey_verify() then dereference
> key->type->asym_* outside key->sem.  A reference keeps the key alive, but
> does not pin the module providing its type.
>=20
> unregister_key_type() calls key_gc_keytype(), which retypes every
> remaining key of the type to key_type_dead under key->sem for writing.
> The pkey paths read key->type again after their checks, so a concurrent
> module unload can turn the checked callback into the NULL key_type_dead
> member and call through a NULL function pointer, e.g.:
>=20
>   KEYCTL_PKEY_SIGN task              Module unload and key GC
>   ------------------------           ------------------------
>   keyctl_pkey_e_d_s()
>     if (!key->type->asym_eds_op)     unregister_key_type()
> [ ... ]
> (925c84e3cc21) and update (aef3a8a4f988) methods.
>=20
> Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops=
 for asymmetric keys [ver #2]")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuansheng Yang <0xbeac@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/9d47e202bd11857b355=
5e6b95694b3c3a4f2460b.1793852399.git.0xbeac@gmail.com?part=3D1

