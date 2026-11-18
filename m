Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794978587;
	b=L+FyGlEoy1gcYL7Kg4oubcunk5FJdsrXoixwsZz5aDIS861GBlOVSXKq7PorZ9nyWJkD
	 g/QCGmzmrYwWhbQqGBfLlxfXECcOGMlJS8c0qDY435/qvavkIpXqYHMegF06Ym2TV0lpy
	 8NIyUpxrrFCgc7vRV6jhXbm2Q2TUF0sFudWIMhJkhiZdiR9mEADFNjsAP96SNQCSjf4rj
	 QJm6YF6WcsLfuORan7tRbBnZEnm81gAHEGXDVA6fPU1GoTRyLv/n1QwOWBWjkQYzE884X
	 dbnjqswNWB6L2mhD0WyXzK00wgk/jBYDjsic3F2buJ21V9gzNlBcismQs3OD1Q6E5Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794978587;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P7ThLlaJpXNIYJ+pS7/xgAE+ths81/1BZ1VkMG2lDfk=;
	b=a6TU8t18oqQrPubpalMKjCR9iemMKStlOwEBSh2cu4KunHr3q0vdSs0+Un7I62xsT+Jw
	 LVHOUGDnLY9Iqt1iaKwRxZZ1wZyDbTeVM6ED3M7cg01Ar2k/QANwUQPyPsIZIU91rSSlv
	 oby2M8ud2Xym6c+DjsIOMM/kbgti1IrgZwzXlnIrcsqnFEFeUoFuJY+vegDsnEheVCcp4
	 V0+Umbxdcla6KSuB0RYJwCjhHXPRBDqMPI+tBMpnLOy5H0ZuMVHSnIa1bi+iy7aR/NySV
	 Kz0TM5LO5L54mpKzassoCKSfbLUKYliRiRiGOqp5vHt5uyV1uRyaBkqm7R4TL3X5rsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CBXLJ8m6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2482606A325
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 05:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CBXLJ8m6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C0F1F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 05:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794978587;
	bh=P7ThLlaJpXNIYJ+pS7/xgAE+ths81/1BZ1VkMG2lDfk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=CBXLJ8m6+D3bwiesUawuB67qBZG7wjBGdTRmH7dENWh73c8g82ucscDx16jaSWV/V
	 owqyDkgZWNTmdahXm5NBFPsUU3/OwZnNdL7TOFA6KtaH/Z0c10tNnFUfgUHSgFrSjD
	 CPl32MZYTuy23oyAfygxALsYa0z6EhFAgyAxiKR4lOw61sV+wpD0d4s/+x/KUDwRnF
	 T29TOqIWk1yw7eWIMNQxFW77iqNmkQ4wwBXNN3RMfe9zDLO1KSeUJVck+Z3WmB6JVy
	 tP7WxfcWAIseZCHdkZ+prAgLg13esoEDsM5/bj83peQ3sybVq26q73oKdoTjoSuBo2
	 GTvj0tvkzfwUQ==
Message-ID: <sashiko-outbox-220140@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 05/13] rootns: Add rootns_wait() system call
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117050841.3289652-6-jarkko@kernel.org>
References: <20261117050841.3289652-1-jarkko@kernel.org>
 <20261117050841.3289652-6-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 05:09:47 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> wait4() and waitid() only allow a parent or subreaper to collect exit
> status, so an external manager holding a rootns file descriptor cannot
> wait on a rootns init process forked by another process or observe exit
> status multiple times across observers.
>=20
> Add the rootns_wait() system call and its compat entry point to wait on
> a rootns file descriptor until its init thread group exits and report
> the recorded wait status and rusage. Return the init TGID translated
> into the caller's active PID namespace, 0 for WNOHANG while still
> running, or -ECHILD when the PID is not visible to the caller.
>=20
> Co-developed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117050841.3289=
652-1-jarkko@kernel.org?part=3D5

