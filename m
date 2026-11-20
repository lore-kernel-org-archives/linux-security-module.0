Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188141;
	b=H9Zs5WAISlzhjpvmoeDHRvuEF9eCDj62ranRbrc87od04QXAQ4ArF11QHrU6/e9fly4H
	 9YfWgLKJBIXg1f1aTn8ikNOnn0Su9NqXTG1t7I1Jw+UqituZX2QyLxUGbZfRNgJIEFx6L
	 qIUC008LS+mory6lsZXaTwJtEXandJ4oFLueK+VQxq/5zzPjhhEwQxQPInr0ZFPyK2Rga
	 GtXG2RfRVC/8YdXaT5wh+sYTxjGXS5ya1G4FBVxXK1OtPEy+tHEUaUXloWltq9/iHwGcD
	 +F0V1nbI+87/pD/uvrTwwWEzJNOoyIx+HMaOWZCnZOLGlHCvFdVAfFH72/TzNFewbUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188141;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MzE6S0I+aePs5dyF+B3frU0wcNFAPFemi7Ebv7BUXSo=;
	b=unYEyhBFntyLYGZDNqyBXCEtg4kHJLwlAhiYrSRWpdmsxAukEGyv3wjRvDame+PdQOc4
	 E9dzdyD52rtDrX19ymxFqyF2CK3nYxzdFCPKLJXGIFMW4/Pg1LboTsvqqVE0esZ7NYnXF
	 +SvCpY9/ty3+Pgy1+2UAfR6Y9+8fVxGSegTAtL4PFgFpyOUZVRo9NvBdmSpcujXm3uH/r
	 HlcTHEQeikiJSixHrGcRBYI3AAlPDJsj0+FcR14nI0A5LoqUdY64O8Oel8ySDvPJL0Pqr
	 yUyEWyumyuTuPpHXUVhPva1/V3no4PzTiPKwWxtMgAzaoYtQr9lCBceaoMFmSHLCEGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b19oMLQK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE14606A320
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b19oMLQK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88A11F000C6
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 15:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795188141;
	bh=MzE6S0I+aePs5dyF+B3frU0wcNFAPFemi7Ebv7BUXSo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=b19oMLQKd0Jw2iJMP+r+u0p4Db937EBiW8lJKCzApjzHJJEXnKU3bO2RmYdUcywGp
	 B047yCkif5ycnd6pooga7yVgVHgtKF4U5KQoZecQ5DDgjz180CN4NuYuUF8oER0mDY
	 +X3NHvau95opseWL3xdPTpymLQMP00nOiJe8wdNWG8ThzieooqM108VU2UC5aSMkrP
	 rUwvOx8A8bcnX7JwCBoCYHhT3rLNLpiyTCyBRnSaNAgnc3dxpfkVMjqn5nW4OAsH5i
	 WKKqnR/LPnEn4Alc6VTkM6kLdfkNjqnfE6KhrOC4M+OikSIE+T2CswZXq3DpKT7ie9
	 riBYj2QHOl7tw==
Message-ID: <sashiko-outbox-225457@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] landlock: Do not hold exec_update_lock across the TSYNC
 wait
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261120151554.2651743-1-mic@digikod.net>
References: <20261120151554.2651743-1-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 15:22:19 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> landlock_restrict_sibling_threads() write-locks
> current->signal->exec_update_lock to serialize TSYNC callers, and holds
> it until every sibling thread has run its task_work.  This wait is
> unbounded: TWA_SIGNAL does not wake a TASK_KILLABLE sleeper, so a
> sibling blocked as a vfork() parent runs it only once its child execs or
> exits.
>=20
> Meanwhile, readers of this lock block, mostly in D state:
> /proc/<pid>/stat, mm_access(), pidfd_getfd(), kcmp(), perf_event_open(),
> etc.  An unprivileged process can thus stall tools run by other users,
> including root, such as ps and top.
>=20
> Only a per-process "TSYNC in progress" marker is needed.  Use an unused
> signal_struct.flags bit, protected by sighand->siglock, which is held
> only to set or clear the marker.  A second caller still restarts the
> [ ... ]
> Cc: stable@vger.kernel.org
> Reported-by: Lee Seong Hyeon <ihopenre@gmail.com>
> Suggested-by: Lee Seong Hyeon <ihopenre@gmail.com>
> Fixes: ff88df67dbf7 ("landlock: Serialize TSYNC thread restriction")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120151554.2651=
743-1-mic@digikod.net?part=3D1

