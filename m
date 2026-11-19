Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795085495;
	b=n7CBPc7LySweMjZVOoKXBRX5gZJ6BIuki2uA1mEnZnWgKDr4C1GRWrCerVYNr9U4tMcB
	 NPwnxEULcuKR9Qr9K0Sg8rAeUdZcgneh9Ce+VSEkmjkf8aocE2chMigTFriY9fAE67LBs
	 e98jXsH2ttCbePfIkjYHdBlC5CRAHTLDFHy09Nd3+fbPVuOboAa1FArW0bRxyolK4bQcF
	 LermHQN23OQ1bPN9F2XKLttL22UP0YJ6F2ChylwxEEplatJDIWd6VIH37/ZVqcRf5qiPO
	 GlGNKhJPC4lskIE2Mo064TiVi49nzqK/lC3AOHGZu8ce+ZtMnMpsztedPLr+vLsX5oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795085495;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZLGBwtrRIauCP46AIpuxxPhRfKiCHVdDkGdEtH3K3vU=;
	b=AkGjAom81SPRRDEm5XEmom3h0PAHbGSa9UlJFELK5P9i7bN72Duzvl5u9iYAS/L8Ohtr
	 ZRoJk1IbkBMao2qdU+s5QEoZA+fe9HvAghs+2tDqBg213LLBVb7Qmno/FTqURwkTPBR9d
	 X5nOWLTT+hNsPxfLEw3ZFo48jXGTEV0M4kDbt/lzq6K2QWRY0/C6lkzJy3HLY8isbwDxl
	 02aWVaNQUFDnfNajcTHN2s7swN97in6xaGhzKtpwm03smWYD2iJ+pJL34n3wNeVosMtRY
	 hVvNnolZwFf1bv+WgkC/AQtrbWMyiHs01P/m95r+BMC4ih/sHIbH43O9nxHn12W10fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gf6FDq5R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B35606A325
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gf6FDq5R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6C71F000C4
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 10:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795085495;
	bh=ZLGBwtrRIauCP46AIpuxxPhRfKiCHVdDkGdEtH3K3vU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=gf6FDq5R/kAazt+e17bcIsMEVqgXqYmMW2/Lqhe5TbgaSySIShZ5U4BOl+iJ+YEpJ
	 WYnYskCrc7i0dJQtgzSzCYy6uJt8LrrNUQ4fYvtwOyJZSGgMgw35TzjyzEJuNq/UCm
	 YdwoUlo7GJz6SKe5Y7JmVeZXa2/LHqlR0gsc03I2K7gRf9Sjqvzx17aPxtEooQVKHW
	 ceok4WiPOu8xdbrbhm7s39PY1+uVgd3ryecKYxqafU56YAz7l3BMVg1UDUAluSl45I
	 vyMezaSuE43mjidzjy0TbLeohR3iyuOnQBrYO5Bp8uAMA3ffHtG1Td/BytNw6skpLo
	 9RuG14VFLSBpg==
Message-ID: <sashiko-outbox-222988@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] capability: bound ptrace and cred subset checks
 by userns ceilings
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261119104208.782900-3-halg@google.com>
References: <20261119104208.782900-1-halg@google.com>
 <20261119104208.782900-3-halg@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 10:51:34 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Same-namespace ptrace checks only compare cap_permitted (or
> cap_effective), ignoring the userns capability ceiling. As a result, a
> task with a lowered ceiling could trace a less-restricted same-UID task
> in the same user namespace and use it to create a wider child user
> namespace.
>=20
> Require the tracee's cred_userns_bset() to be a subset of the tracer's
> in the same-namespace check in cap_ptrace_access_check() and
> cap_ptrace_traceme(). Cross-namespace implicit CAP_SYS_PTRACE via user
> namespace ownership is already bounded by cap_capable_helper(), while
> tracers holding explicit CAP_SYS_PTRACE retain access.
>=20
> Also update cred_cap_issubset() so commit_creds() resets mm->dumpable
> and pdeath_signal whenever a credential transition widens the effective
> userns capability ceiling.
>=20
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Hallgrimur H. Gunnarsson <halg@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119104208.7829=
00-1-halg@google.com?part=3D2

