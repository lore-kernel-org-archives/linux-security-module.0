Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3839EF12
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 10:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791023992; cv=none; b=UVzD3e3kXtC03Ev+juaxAm2QcQwgVEJJNU3EGL7ZY37KQ/ZdOrHq3V3JFTNOQJkf9naT9d8erhmT02hvwAGAZcJZKv+0kf4b4zvRaqI3jQ0LFFfGVVKlSrtvvTXnK8rUXgbqs30Ja3aU1k5LKcIWd1YRnYOJ84dVpNMeKFNbJrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791023992; c=relaxed/simple;
	bh=fPQSRDUuW5f4zD4+StAtnk/nYzG6YjhUPLsXQrtOF3w=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HsXhdn0QN0M8aY52QuXMD24q8JYybPWA/WAQKaSd9Fd8emm5UFoHtOWkj1nN7cREZV0Eyti+qPHvWc4CPPeRWzWMAc0gnmV/H7h/WyHmqqfsMbCdvOmlrklcheNRwouVCimsT9UN5YCHnGI9Y8FzyFz1FSTOkH17RBcKhIe0zOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpXmrGTk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpXmrGTk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754C41F0089B
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791023990;
	bh=P3xgPKDoQtH/WUmZSd6oOcCtU071GuzGbVh8C70/Tsw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=cpXmrGTkfw8oylREKZOOrkkCbz1zKXU1fDpZW+NR+iUSR7lwuHLURER8z9uNZS3aR
	 lq4W1bAi9y29uiOK+HJKlvsNoWU+hHy6ooYvAS9T4FnxdMiWjN9vtj9gE2c7LH7zQu
	 Yyr8Vzl790d9JA17e0LB8YscZGsWJgffoZP2vuZ3jeM5lRVcUzlL/F3eREu3YWwQYa
	 Q1Cc8MksfIUWm5irrSGhZXcBWwQPQYjKiBi1Yj6FHnx45oRIN4pBYzVL5KOyuLwryY
	 fI80l2S/4eXcl99Phk6lt7+t2hziwTNzYRKA9fPIv11g0rREfe9DPQQkbNGgDDJcmw
	 ErXMXQxQpbvQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] security: safesetid: use real GID for GID policy
 lookup
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <d7e10b50556ab3b79c7132018249f6f7c608411b.1791023194.git.tjdqudcks0424@naver.com>
References: <cover.1791023194.git.tjdqudcks0424@naver.com>
 <d7e10b50556ab3b79c7132018249f6f7c608411b.1791023194.git.tjdqudcks0424@naver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 10:39:50 +0000
Message-Id: <20261003103950.754C41F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Sung Byeongchan <tjdqudcks0424@naver.com>
>=20
> SafeSetID policies constrain the ID transitions available to a task for
> each source ID.  id_permitted_for_cred() always builds that source key
> from the old real UID, even when it is checking a GID transition.  If the
> real UID and real GID differ, the policy attached to the real GID is
> therefore missed and the lookup can return the unconstrained default.
>=20
> On current mainline, a test task with real UID 1000, real GID 2000 and
> only CAP_SETGID obtained non-allowlisted GID 2002 despite a 2000:2001 GID
> policy.  The bypass reproduced for setgid(), setegid(), setregid(),
> setresgid(), setfsgid() and setgroups() across three clean QEMU boots,
> and enabled access to a synthetic group-protected resource.  This shows
> a SafeSetID GID policy bypass and group privilege expansion; it does not
> show direct UID 0 elevation or a universal local privilege escalation.
>=20
> Build the source key from the old real UID for UID policy checks and the
> old real GID for GID policy checks.  In three fixed-kernel boots, all
> tested non-allowlisted transitions were blocked while the allowed target,
> existing-ID, no-policy and UID-policy controls, and the existing SafeSetID
> selftest continued to pass.
>=20
> Fixes: 5294bac97e12 ("LSM: SafeSetID: Add GID security policy handling")
> Cc: stable@vger.kernel.org
> Assisted-by: OpenAI Codex
> Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791023194.gi=
t.tjdqudcks0424@naver.com?part=3D1

