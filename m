Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910685;
	b=Epslig0pvKXVaiKgwWouqDlftl35Q3kUwNX6SwrvfAIWNpVtV9ZgROQq1Ai0QJA9wEzC
	 xk7zurbKck3HPya5jEaEzeAEuvaU82CIBbsc//PygC2v57lIER+90HsLtrnhG1rFx2PnQ
	 sXS6Z/erboFXlesgO2uljckbzN0GYo87YpMahIvegMbaf43EydlVlOeAZhpGn0hXZoe2b
	 X9o1t3tJsWOAWM8ys9H8V98uRUOFUPvogNzJY68TauX913yaqhlv3b9jYFhpXaXYmqc/W
	 PcijQ+ycq5hdrqgcAw+lrjbVlbWssop0RZIzYg0qEzGNrMsmbcnSgTPVXLy6MuyjRfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910685;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sSFk5ThbL+Rel5aqNpVnPlu1WzmBGwUvs+kNCEavBIU=;
	b=07SwjyV0IcOsNEPKsd1foD4fWrBjMzsUrgnWHWbGNR6hATlT9COfuGPY2r0pXYxIVy5U
	 UpDkwEq1IYWnoPTe6gpkrXNlqIPZ28eK3KgSZtyRSJyUTiUsLr53uOF0II7dJSEbcgp63
	 UdJ3eSX0M1VEl5MZejzhpqJuddk8OnkQg0uZrPww8rCdUb1BiWj2097WseBdWQ8hPtGFj
	 X1pdDQDY2DC39k0b00jEM0xLZemEFZHteOaLrGgX9xvvNZVk31xluQhPtf5H/Da22KvM7
	 dm0Yfe1P4Uc99As6QgTkhP6GdcLnc9ycUDypbicS3jQxx4/DGJRwnoupQL0/o5OZVcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJwMc2ev;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC67D606A323
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJwMc2ev
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750461F000C4
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 10:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910684;
	bh=sSFk5ThbL+Rel5aqNpVnPlu1WzmBGwUvs+kNCEavBIU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=HJwMc2evqjrVklCcxn6j5EqTOqSj2nhVYEUm7jLd16IY5dfI6GfGz0i4Ifr5OD8ga
	 QgS7Q1Rn5ZF+WKDj7Sx3zxGLow2MhCJL7mVYWs/xHflMbpasN1R0wYiZa1+vVneS3t
	 qmEU72vTZwaPFrN5faWZHtqZXWZZHZBccNytBuXw5O6g/A4hoHsUSZzyRMv9AGeB/3
	 iN3V8nkAJmQntktvADU+Fn0O30GxYozSg0/jFLK9M5DOizYSdsPaEFheLs2gzZeb5w
	 x/9skYMHPCVpSrW4GCTH31+4lZ4lno88lcz3XdPvuG9VaEj5NjD3IsZ5xDJvZyMaLA
	 npH2Bj5evyAKg==
Message-ID: <sashiko-outbox-218587@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] landlock: Mediate CAP_SYS_RAWIO for mappings
 below mmap_min_addr
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117101157.2520463-3-mic@digikod.net>
References: <20261117101157.2520463-1-mic@digikod.net>
 <20261117101157.2520463-3-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:18:04 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Until now, a process in a domain that denies CAP_SYS_RAWIO could still
> map memory below the vm.mmap_min_addr limit if it held this capability.
> cap_mmap_addr() is commoncap's mmap_addr hook, and it checks
> CAP_SYS_RAWIO with cap_capable(), not security_capable(), so the check
> never reaches hook_capable().  Mapping the lowest pages is what this
> limit protects against, because it helps to exploit kernel NULL pointer
> dereferences.
>=20
> Add a Landlock mmap_addr hook that checks CAP_SYS_RAWIO against the
> domain under the same condition as cap_mmap_addr().  With the same
> vm.mmap_min_addr value, the hook only denies mappings for which
> commoncap required the capability.  security_mmap_addr() stops at
> commoncap's error, so processes without the capability get the same
> result as before.  This also covers the x86 vm86(2) and vm86old(2)
> system calls, which use the same check for address 0.
>=20
> Making cap_mmap_addr() call capable() would also fix this, but it would
> send every low mapping through the capable hook of all LSMs (SELinux,
> AppArmor, SafeSetID, BPF LSM programs), adding capability checks that
> their policies never had to handle.  For instance, SELinux checks
> mmap_zero in its own mmap_addr hook and keeps it separate from the
> capability on purpose.  LSMs with their own policy for low mappings
> implement it in this hook, so Landlock does the same.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117101157.2520=
463-1-mic@digikod.net?part=3D2

