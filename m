Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521968;
	b=IpnoUE9Dn8GZ4/HUZZpsueNw5lryszNPvxOwCxkSqJ+QHRQJQgMBHjg6DWs/4tXnvo9D
	 f6dxvcVnPrVmPK7DBzMgwCsn5HBZyoj0apeU4Rk2bSuGtiRhdU59znqcxagEhFjnF4/+j
	 CzOadV/A7EydMy+BKXO/yiWiT7oaU6i7gceGIEJLiQplP2WSI2C3tn2Shq9Pynn190OFR
	 iILGwd1GlRfkXusWpYG83+SV3jFtAhjJ2mqz9iuMV+23/yd8syLjqtFPGIDlwcf4GMKND
	 NippCNhCAjfl8dohFAqGP9sI3DHMOBZc7O5d7hyiIKWFyZocpfmrYbe7reolLhaRcSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521968;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZBIuOGstqMQc74DLEbMzxVRjsxBX1+2B+X1QIPOW620=;
	b=N7Vy6pERz4BhxuKC/oeY1+hFYT4vyhiAMBWcFFYkm5jiSyn3JdssIDOwtgoADxlnW13S
	 0B2KSA5MNvY1ft3wenoQSLSrrXLFaV7y4OZjUSma6WqjI33mxPKAGibRERo4Xh0NgaiPx
	 oKvphcNJPdi4donnQPq2Wg3BvaZlgzW5IaQwqKdLaquwXpNEjU9ChvtCEvxtldVc0rU8m
	 Qd3yREzToBYHWQVzdaj63pDoJA723UGZSMS4KmJXxtvfdGk6ov/fPOukF12lfzl6VqVIx
	 bFkQUCGPNt/chtjHnSZQObf2rlXzrjhZhg+jkb201p1pXtt3Zxylu8livjJkARXQCjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZC8l/3Ko";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A09606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZC8l/3Ko
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B92E1F000C4
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 22:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794521968;
	bh=ZBIuOGstqMQc74DLEbMzxVRjsxBX1+2B+X1QIPOW620=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZC8l/3KoMCD1gOAQIiKQPx1wYVmZtx6WxiGBJmQfNJJZLfposCN5+unvCRx0VaWad
	 r7xLJFfYDa2IAsotomj6slQ2pFcjCD8On4oP5w50NDpiWJTl/v6LcJ64TfJwYi4wF8
	 5uvTET97wWLA3AHm36J75ATf0zYO6IxIcX4JUd+rFDBQaiFG/HXIjhgDqErEzPkAEK
	 CNWzxlOnSucp4qXGiV8ZAPOh8j/oIokvjtb7TMadzGstz+2o/ieVw6knXjiSPaciE9
	 QOTtZ4ZPwd5ukqcvvDWvYqs+83VLWzE5bu26bLH4IgzRbpBHVhn2r428FxKBQLRPI0
	 Cf2ldiEGMCcJg==
Message-ID: <sashiko-outbox-211907@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/3] selftests/namespaces: test the CAP_SETFCAP rule
 for user namespaces
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261112-b4-setfcap-userns-v10-3-84f6f7faa903@toxicpanda.com>
References: <20261112-b4-setfcap-userns-v10-0-84f6f7faa903@toxicpanda.com>
 <20261112-b4-setfcap-userns-v10-3-84f6f7faa903@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 22:19:27 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Add tests for whether a uid 0 task that gave up CAP_SETFCAP gets it back
> by joining a user namespace whose tasks can write file capabilities for
> its root user, or by attaching to such a task.
>=20
> Each case runs as root in a private mount namespace with a tmpfs on
> /tmp.  It sets up everything but the step it tests and fails if any of
> that goes wrong, so a refusal comes from that step.
>=20
> The ones that must be refused:
>=20
> - setns() and PTRACE_ATTACH into namespaces that map host uid 0, at
>   uid 0 or another uid, or that have no uid_map yet and whose tasks can
>   still map it, and the same one level down among tasks of an
>   unprivileged user
> - setns() into a namespace without a uid_map under one that maps host
> [ ... ]
> create user namespaces, or there is no tmpfs or no security.capability
> on it.  The ptrace cases also skip when Yama forbids ptrace.  The
> idmapped mount cases also skip when tmpfs can't be idmapped.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-b4-setfcap=
-userns-v10-0-84f6f7faa903@toxicpanda.com?part=3D3

