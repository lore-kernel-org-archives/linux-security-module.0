Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924056;
	b=x9hWvoRfwBgBh2DQv5VtV5yTTMc19PCqe8Jwp3YncrtH6f0B62YmDoidEVX9QGTeHaOI
	 UTT3yPLNl4uo1kcK6Ce0yVDInjpDUAu8sNQA3uoiXD9HZqGvwh7VA+sOVuvhTi2Qjdwtw
	 bnR4ktMrFrHjAwj2YmuxKvIvtQo9SM3yfYnoAy/bd9Ev2MEFtfvC5L5Zo91QAjdBoc8Va
	 JYe4KiSPkQzfNEzY0vYjAQP9AHEKa7J9gAqrc8OBkn1R0153zfQyo0I6QJzvUDmbxHTy2
	 fEnGUTnSCRORX5L+zCqk5gxa04Ujd2JC3ul+rhtThz9qnvTW4gf+HdefQckY7WXK36w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924056;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JK5q/u2ICmyyDbN3msXRTCdUBr8dC4VmxPnPcusssTI=;
	b=pblhWu8w02nnxwdq8OHLvf5mA80BNQHJv0PzTVsL49jhr5bobFlfuLDkS0nWh4GqhnIt
	 RFpBsppgTvR1sZNKvzhnOYJILC5amP7dZWWOWZ3D30gxuYZ+hxnOzOXal5e3COg7ghcIA
	 KDtBlLrWdcVLvzOkLPEjh7Tx7OepZlxMF2owUsrwOj+sZVl8ZD1pJnrPAqveOjDjDbcHk
	 r1XhEh/Ex9Wyjgtv+pXBllPsOC8QKswt0XPfDyaW27SrNSY4I105kGTQxfaK1gEWN069N
	 JhVoxNQSPp/uDVdmVvRbLDtnFywb+lSM3OmvVXdxw1m1B12kAL2NtmmpqOcBLhegByg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Q06IT/YL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671C7606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q06IT/YL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8241F000C5
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 14:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924056;
	bh=JK5q/u2ICmyyDbN3msXRTCdUBr8dC4VmxPnPcusssTI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Q06IT/YLt6cmKmcJiLuuC/uibiykpgSR3AL/xZw8QAyPFdXHTJbkqPFgbEV1whSft
	 H2hBUsJar1IDEPPU+ZOAFvtjEvNRMOG8aH0gyuPLvk/xyL3CHitAqrDEm/w2e+qyPG
	 BenKcjb5mj13Ve5pSSY+6kICsIu4wX3ef8/kVSGuDJlcy9BqP29SgkyyhEPLjpaMsW
	 MSeJd7K/6q3v11aqyAS/YANPXqHPFDBRybYFuIPALYX+F1Llq/yrx7AMNLvf9SRCGi
	 zudsBScUi1jC65g3v399X7mhMA2NpuaK7oHJGqupt0aWoEFS0+h7IgZf76nKffOiDK
	 ywpZsoJKRV/CA==
Message-ID: <sashiko-outbox-218917@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] apparmor: write the feature set to a file at build
 time
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117135042.78238-4-maxime.belair@canonical.com>
References: <20261117135042.78238-1-maxime.belair@canonical.com>
 <20261117135042.78238-4-maxime.belair@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:00:55 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> apparmor_parser compiles policy for the feature set of the kernel,
> which libapparmor reads from /sys/kernel/security/apparmor/features,
> and the policy cache is keyed on that set. The cache for a kernel can
> therefore only be filled once that kernel runs, and the first boot
> into a kernel with a new feature set compiles all of the policy.
>=20
> Every entry of the features directory comes from a static table of
> constants. So write the set to security/apparmor/features when the
> kernel is built, in the format that libapparmor flattens the directory
> to. Policy can then be compiled when a kernel is installed:
>=20
>   apparmor_parser --kernel-features=3D<file> ...
>=20
> Signed-off-by: Maxime B=C3=A9lair <maxime.belair@canonical.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117135042.7823=
8-1-maxime.belair@canonical.com?part=3D3

