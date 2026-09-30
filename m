Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493ED19E7F7
	for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 04:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790742488; cv=none; b=CIuq/tD05fQ4EY3Hn8fG0burmZGyceOCQf9BAhiGDdQezSuoigbfdBjjFK0rmzjBGc1yPii/JgzBZZ6puAJrd3gUB5yQ1z4LQItAZBiuMZ4KLLBaMWO3/qmXvqqY7lr3rLy3O6cbxkVLHLFB2F2vo2TxGYBGVpS4NA10oh99zYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790742488; c=relaxed/simple;
	bh=7ny9qFatrq5CwynaT2hzrBghzZHdB/+QmjcSxK7KMUo=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H7OXQABn9pAG95tn7LuIOm2Vj1jGuJCvtnxFGdSk13d9ScfEdJEayYDWF8VtynprnjiNYJveyZ2R2JiZEuBO7AfFd/1E06gA4ueI3i7fTxYbJ2WaZ2X7JVePyzTaS6gVAqb1a9S8sc+0KLgOYGWqfkTJ33k2xT6coLz/2x/OIRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbPX6EOC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbPX6EOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABFB1F000FF
	for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 04:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790742486;
	bh=DjKVmmg+IgFwa2/bRd7K5wNI5mtBDPD8h9n/XKzpcx8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=MbPX6EOCFiKwBKxr9fP91da1PR+pejn2IC/ta9jawFDIhR7DOe6HqsHsiJUpY+nMU
	 PNSY0YO6uKkFk7xTqqCh95yzDTGucPMmkMrpjvV16tC6VP6mjShBa/sXUS6P29g+GW
	 C8reAh9Oflk4Nx+j8SareuhD34ftGzmuZuMpQarKfjtT0/eACDAyZdaM5+J7dUDKlP
	 mamXOGhhCRlv7ZWgvDBnGRHjDY36Vi4e0WgaBqP0OohdQqpBEz2OygTj22/wpIF+Jl
	 saAYGJeN6jFI0AHuGc7lFaE4k6FviHNt2+VINFPyFDCdZD+kH5r7tbeKzSWbN8jPzD
	 1I79voCxCgcPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KEYS: Fix add_key() race with keyring restriction
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260930041802.6114-1-tjdqudcks0424@naver.com>
References: <20260930041802.6114-1-tjdqudcks0424@naver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 04:28:06 +0000
Message-Id: <20260930042806.AABFB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: =EC=84=B1=EB=B3=91=EC=B0=AC <tjdqudcks0424@naver.com>
>=20
> __key_create_or_update() snapshots keyring->restrict_link before taking
> the destination keyring's semaphore.  keyring_restrict() installs a
> restriction while holding that semaphore.
>=20
> This allows a writer to observe no restriction, wait for the keyring
> owner to install a reject-all restriction and return successfully, and
> then link a key using the stale NULL snapshot.  The writer only needs
> write permission on the destination keyring.
>=20
> Move the restrict_link read after __key_link_lock() and
> __key_link_begin().  The read and the subsequent restriction check are
> then serialized with restriction installation by keyring->sem.
>=20
> The race was reproduced on v7.2.8 in 19 executions where restriction
> installation returned before the link completed.  All 19 linked the key
> despite the reject-all restriction.  With this change, 312 executions
> reached the same ordering and every add_key() call failed with -EPERM.
>=20
> The issue was found by manual concurrency analysis assisted by AI-based
> analysis and independently verified with a QEMU reproducer and kernel
> instrumentation.
>=20
> Fixes: 5ac7eace2d00 ("KEYS: Add a facility to restrict new links into a k=
eyring")
> Cc: stable@vger.kernel.org
> Signed-off-by: =EC=84=B1=EB=B3=91=EC=B0=AC <tjdqudcks0424@naver.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930041802.6114=
-1-tjdqudcks0424@naver.com?part=3D1

