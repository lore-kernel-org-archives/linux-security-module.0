Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9276037A836
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344855; cv=none; b=TAtIV3EUT2sD2lnZ/3DveGzYfoAkgEZf3u5Gt44PZ16KRzNSp2tD8S2NC8Aw0NZ+rlZhEV4k7/ViX17xJAcmcM4845mbXhvA/PPTmhCjTiDzgfLqX8HCBss1zHWBJsy+mdtmMTk0YF3vNUlaQokeJx2SFCseAJY21x8mV4EJJnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344855; c=relaxed/simple;
	bh=ZqnBtWSglKfsm2tzxvlnprbe1WN9WvAysvsmeiMXkYw=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PvkGuRDXv4cWmL79WUGb9+gZ9VhzMWp+BKVQt5orMiAmCLmadE130RwmFtIe01M6n/KSAWkdcbYwKqwWUF2O8SOvjwKGvhHcfXqdbH+3HvnnJDSePPEo2F8DUup2gYcV9oww/nh5MuPiHUMzG25l2kAhH8drAyM0U5r7UjTLLPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpAPdUi6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpAPdUi6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631031F000C5
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792344854;
	bh=ZqnBtWSglKfsm2tzxvlnprbe1WN9WvAysvsmeiMXkYw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=XpAPdUi6CASgKBa/SyodoD1TTbqhDQSAuhlIZBuCYddH9bzYJOi1OYe4rde/9bHGf
	 BNyDPJoFhhSxOyca3qIKUcxJIh/ujaSi7hVBgrQG8k+Yjv1u2m9hc41qa5DQdFkvUK
	 IQ8V7VmRClUiJczQ79OdPwhd8773oCgkrvfjRVM6wcinHdAV0N1EQKd9hF/2OxpukA
	 VfPNzNsh2Vz5mOtqF3NJDWACdU5PIG+go4WHKYv4zJz9z6ypYzHYveL2zoRKLONiRH
	 QbeCrW9wZeDcC6v2GrRA7jqxvcHGKYzGR/mT6tZZBR1+iYTd1uyPHU1u4mByGeGR0z
	 9eEZOpCrLXKlA==
Message-ID: <sashiko-outbox-176320@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/13] sched: use cred_ids_allow_sched()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261018-b4-cred-ids-v1-5-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
 <20261018-b4-cred-ids-v1-5-7bdf2db4ea9f@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 17:34:14 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Use the library in check_same_owner().
>=20
> No functional change.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018-b4-cred-id=
s-v1-0-7bdf2db4ea9f@toxicpanda.com?part=3D5

