Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117010;
	b=rKaMReiV82eIkcG4SsjNQZzNKIxPwFn1CFm1/He5Ddk+5a/9b/xpRrMHGGmqghDbtkeW
	 MBz1haw2Fy3wjhTY6tvZIItlhZDzZbC3+PnCXOBPBiL5FjakwDOmb2px0WtOYGXLPLCyB
	 VFo76MhjdSejuFt6DeBjmQ2QQVe2cxeU0XOU4DcKhtBx8OrF/tR0d4C6AKaXiafcTSE/N
	 3ZT71gdr1TZds3hayfxYc+Q/E+RobcgZSwh8Pa5SLpJOSS3MIBYeD9N8WnnolEqtCudaL
	 YZjiMVQERjaRUlbeiMEtqxqQnDSPAD2uyoJcphcCehgDwec7BqQ7//C1WTf4tuDuFqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117010;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=69FBcp3lKSOlBtwzPsPboJk+r7hrUUGABevADIduVwE=;
	b=efGpT27ClbWSOVBHqNjUSNqKJlmEIh6oBjzl4hl0LpfuV142v1Rr8ZmoOeD1yy6t6fY8
	 OYzGOJchprMWt5N1yChd3YeRZNPnoOSUZ0g/ydIIAzyT37g1U473WDR1Z8o/vBqrbBtJx
	 FdvFu/vhHxGvIZWedvvinYO97tJZGjrFCgXkIM/A5rgVvHzwhXG/Ar2xqCrq3ETRx8aTl
	 lFeGRkBECXoiGMcZmY4EiyGlol1CCIK7eNmLkqUnJUL+1Y9bDRD2FA6SYZ0St7Z88bkei
	 vW4yTCLvQJCXVYc03453nuL9N6pKiqHyUxXPOV0gCfNeQ+4r62QjXYRI8WXkpq+PwCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lD+u2qMx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED16606A33D
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lD+u2qMx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1521F000C7
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 19:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117010;
	bh=69FBcp3lKSOlBtwzPsPboJk+r7hrUUGABevADIduVwE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=lD+u2qMxpQ0HHkIB7v1bxcBOXNABYkb1AMDqkewNoQaRI4g0Dc7bMYKJJv4/bWFOO
	 ZksjiF+i2ezfVhFLGUOWpM0TunXLzlmSQsOTb80ZJv1WaBVAH14IXiF5wTfAPVfm1v
	 eysphQE9rGer2H4rvqNSyA8CUEEG1J/6Kidct15+YHhZMQFlF1c0FxUL8oAWWFiJzM
	 +pwBFeOkRPsT3QJcymU4qCZN4K+Tmo1qJA53/Qt/FGExqAKrJ2tKtCJjM9uKU1odQ1
	 JKNuTJ2QltsHOmaUBABPVgDJoQA6u99QQrSdEHNNi816PkAJU7ANoUEh3h0hm8EPQ3
	 9UkKKkm2Yl0Og==
Message-ID: <sashiko-outbox-223945@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 03/13] rootns: Track init lifecycle via
 copy_process() and pid_namespace
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261118193539.240065-4-jarkko@kernel.org>
References: <20261118193539.240065-1-jarkko@kernel.org>
 <20261118193539.240065-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:36:49 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> A root namespace needs to record its init thread group's PID when
> bootstrapped and capture its exit status and resource usage once all
> processes in the root namespace have terminated, without serializing
> normal fork() and exit() paths inside the container.
>=20
> Commit the bootstrap child reaper, bind pid_ns->rootns, and wake waiters
> in copy_rootns() after attach_pid(PIDTYPE_PID), and invoke exit_rootns()
> from zap_pid_ns_processes() after the root namespace's PID namespace has
> killed and reaped all member tasks.
>=20
> Co-developed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118193539.2400=
65-1-jarkko@kernel.org?part=3D3

