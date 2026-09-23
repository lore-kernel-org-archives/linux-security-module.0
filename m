Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB55A53F681
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180476; cv=none; b=dD8qqqQCmBRoKxUV50vdPYsnYUDO6KKxsN1KxC2tuSOkxhrmO+hSAcczS4+X5GdrGP4POZPmEPzIbDL5aMXDL5bfYiHnwnuWvdKcmYIZLzYIRwPW1Qh7LFVcGlznyLAmEEflY4xy6hjqUwWEl2hfRIz/Z7GJczmPbwUak9vDMb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180476; c=relaxed/simple;
	bh=GnkKZYrdP6m7CeFBCrGb8uj6HTIQB2LzX5bt36C3XW8=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jZYnIdi2f3ERmrpooTZUvl8V+Xf/ZD2xU/mzFNzxeVDSChiY482IN5yEEhNQ5xE1lyy+dGO0HY5t7Np36rWy7imFcKu8ouEzbGdnrEktNo7V44aCTvMBkVhdIPiV6fsSDLFWZosQFzpCNPd1srL0ZFMH/UdlJV9D/s0dd/XDmMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMZp1VgV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMZp1VgV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424C51F000FF
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 16:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790180475;
	bh=FUMWb0svFeYUhuaMYQ6WKkq0Tkv/LVlnGEgw2vdcAhc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=XMZp1VgVIbQqEwzzNvtLhOioSaUc1MF8ab5DbPKx9ZWEK0LO4g5xqkS19CWAKty02
	 CAuv0aksg0sWm808pTBD01wCUQwmkJ+lR5ZWhcX40Ezr/L0Wm9rkSTArYGamoH/3j0
	 Aa4pE24taVax7JgNGvZFQQ/UChgz9Q2dap0QcIukVmSEsZfE2HTR7sKE7PiujHKg/J
	 GZaAReFx5OtooKm1bn+zXooVmLES4i2BqhRS/haYvKKRn9zhQb3X/+Ztpmo1J4xYHN
	 ZevY2jXyS6RPDPnVaM4EK0/833KMqVIqLIadB6BKTm2KqVHnWg5vaZz233NtugCtyG
	 cGX/sxyyG1jEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y v2] selftests/landlock: Add tests for whiteout
 object creation
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <aee05236ad5600be7fc35c089b345eadf6bcaba8.1790169454.git.mic@digikod.net>
References: <2026-09-18-daily-reply-0003-re-landlock-whiteout-5-15@kernel.org>
 <aee05236ad5600be7fc35c089b345eadf6bcaba8.1790169454.git.mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:21:14 +0000
Message-Id: <20260923162115.424C51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: G=C3=BCnther Noack <gnoack@google.com>
>=20
> [ Upstream commit ee890889b30b22f9a21636061def7a04e4f89380 ]
>=20
> Add tests to check that whiteout object creation is guarded by
> LANDLOCK_ACCESS_FS_MAKE_REG, in the cases where these are created from
> userspace:
>=20
> * Conventional creation with mknod()
> * Linking or renaming an existing whiteout object
> * renameat2() with RENAME_WHITEOUT,
>   which creates a new whiteout object in the source location
> * renameat2() with RENAME_EXCHANGE,
>   with one of the renamed objects being a whiteout object
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> Link: https://patch.msgid.link/20260813093157.1436894-4-gnoack@google.com
> [mic: Update commit message as requested]
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> [mic: Backport: add enforce_fs() and the missing s3 fixture paths, and
> adapt tests to ABI 1 without REFER]
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/aee05236ad5600be7fc=
35c089b345eadf6bcaba8.1790169454.git.mic@digikod.net?part=3D1

