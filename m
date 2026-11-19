Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117014;
	b=aXtY+MikrAneYhawJWnYJZP8vcG7shKrOWTmG4fVgt7A9ctR7jIhC+CQnSLP+cnBi1pJ
	 TxxLDG4AH7uTNFyRvLttcH/1ODSUXAKgWtlbqAqDT2OngEl2F4Tzm+7fAmOoTNnf1QDnS
	 463DO4jSiSwcjxR01cEL2OfmEUREdb6q++UAXZnpjXekele+r2ZMfFm/pOdPAY8PBBT2M
	 1tAb0JIYC7SFz/AkxmDRX2OHy+tcRxUvVefiYhS/TXYzJGo4M8+6dBbrE4RkCMtM1L/i5
	 AG1QeDslo7gPfjI0sbHln+yfke7AI15qeGwqQ1WWHssc0oAIelU4F0XpXJtNeUOY5fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117014;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=u5emiBmUYiVpWt2AUyDYhGZujZMrbMIiOWx3eLc9gGM=;
	b=2J/+ZBGLZTLW5qA+4sRdHU1B6H0E/4GGIzSHUg3OklREN8IW5HzX6PzUexpV06QAUSw1
	 J/YTx72GtbbfbDrvCIj7Bu3uikP8r2d9ZdEvm49guWWtLxYWTr5ydQ2pi3NGpZtrcnCjM
	 lJR07NRddKdHxyLA6zneP6jEJ1HYW0wTauA717S2fj/ZKr4j+ixN/EvSBgO0YBxj9gvYT
	 3sasWxTy2JKV9CaZNiKEQuCSbrcoM0Xr2DUiUpu5L54RxTeQenOND6GkkqWu1AKYmAVR+
	 2t3kTl3WzTMZ+Ck4roR1ioM43t1Di/d52AI+oAzNRv6qzXY4y7FVtd7z+d+DvJDXHuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LKUnVRdw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81C0606A32C
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LKUnVRdw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F741F000C6
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 19:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117014;
	bh=u5emiBmUYiVpWt2AUyDYhGZujZMrbMIiOWx3eLc9gGM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=LKUnVRdwQTSOFrIBnmqkXhHSW1ThtJT5UdZmcWonE+5AtthTcA2zcfP5IpYV4LYLy
	 x2EwZtGS5IVsufJiwarQ9lNHEULTQbp3RwBxNt5fY0T3OW+BRB1RqCOQcy08ufNA4j
	 jkgvBXszX0VgNQ8wBA1Z5pcUc6fEsF62c7OoqD0XakNsJB8C3rxvIT7L9bIp6pQ/d0
	 6QzNF3bz2wUV08OIJ2r3DgkJdIVxxSP2LRrCpoyYx658RniRkpqHgS0FdhPYfRRtLA
	 UST4c25dUp53LWn0e+S2yIn0he9taTmfGKjTsgigTyN7RBBPKC4tfQSvTtCNHmYu7u
	 L/SYSczcqnPHg==
Message-ID: <sashiko-outbox-223948@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 06/13] rootns: Add rootns_kill() system call
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261118193539.240065-7-jarkko@kernel.org>
References: <20261118193539.240065-1-jarkko@kernel.org>
 <20261118193539.240065-7-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:36:54 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Signaling every process inside a container from userspace via /proc is
> racy against concurrent fork() calls.
>=20
> Add the rootns_kill() system call to require an ancestor active PID
> namespace, walk the root namespace's PID namespace IDR under
> tasklist_lock, and deliver a validated signal once to each thread group
> including in-flight forks, aggregating per-process delivery results.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118193539.2400=
65-1-jarkko@kernel.org?part=3D6

