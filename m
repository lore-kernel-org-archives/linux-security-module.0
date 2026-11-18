Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013901;
	b=bf/FFEK1iaCWxWv1JGdbAoIL553fU5H+qctTj9nSWzYCbp2dIcLJWFK3NADf0LsoDzvp
	 f6+n2GUCjIpQ6fjUbrOG0bK2xkFsrbZEhRBhRKtyZOrYVR/AYLdha1aDm/dK9KclCCnpf
	 R23IQKI7ucuDxnebhmCGk0rA8t7fOjU9/3nzbSdnRH0qqCl1OEXvOIMx9Qxr6/G5OQGp+
	 Zhjk1zX8tVOsCQpEMLnA57yYKNnZTuPHh/FIFkLk2OLKhYdW1Yar8b8Yx6XrU0FfNCuBx
	 WOZPxmKeeFAsvDiG6C8EmtZpSZ+FfNi7joGo/51QzwxO/HZbGtA4hqFdReNR+Vj6qAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013901;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=J3pi350sXeKcGS3GDXS2YB7Iek11/SjS4KJ3ELecJmU=;
	b=wuzCJahA9qz8HoNxrEb/nC5exC089Tz9Jxsvo+xf090cLFT0AfdOqs8ozvoXmkeSXlKA
	 st90xjc4+CP4BpkAyCwtVCsWsAdZCNEKT9/gICQRtxUxuh1hhYM2zCGDnKPwpdXbm5IFf
	 hltTlSBc62ElYx7NbABF1aXloSZZ+x7ifd2omMSP5WhoF3hT2l2YKkoqSyVNegyn97g4a
	 H/mqgTs9rS2eXX2s/zK+f99wj4oAgIdeFfCWUOZoPF3soWhsR6NSxfLfPHAAfWtMpZb3C
	 liIn5tQL0SePSeXDyHTEt3yhDNhJOFrQ/kKWDWPWwAg+F2sYbMkDycXQSn+9aX7tHpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2Yd5KPd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89F9606A32A
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2Yd5KPd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B369A1F000CF
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795013900;
	bh=J3pi350sXeKcGS3GDXS2YB7Iek11/SjS4KJ3ELecJmU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=k2Yd5KPd6g4T5gXisW49dAKrxgQqN4eKWPnnHl3drB23ttl/+gdXyNTshFcoqStZ+
	 hVIZ1NpbfdYYiZlhjBuH7CCLxhamS1p9eUr6rpHEHzEeCMf7//v7U8Q/QZd0gMbClu
	 Dp/u+bbxx2mCHuqePOOciipak4shyq/mOV5sRtdUUogp8DpOQkB7YOp6OJsh6VDcdA
	 f+s8cpPGBKL4Tu4Jewd8VKBuJfsH1f1fWjDGcQKEU7gYoLnlg0MEZ47XZMwkY8liQl
	 EScKaMMZpNmzwhwOCxL4wYn87DQbbsljOEUv6ASAYPhw+pficATsVIf3HEJLTfZy7L
	 kY3knEmEXnpNw==
Message-ID: <sashiko-outbox-221273@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] landlock: Mediate CAP_SETPCAP for inheritable
 capabilities
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261118145217.2551053-4-mic@digikod.net>
References: <20261118145217.2551053-1-mic@digikod.net>
 <20261118145217.2551053-4-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:58:20 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> cap_capset() checks CAP_SETPCAP with cap_capable() (through
> cap_inh_is_capped()), which skips the capable hook, so a domain denying
> CAP_SETPCAP cannot prevent adding capabilities outside of the old
> inheritable and permitted sets to the inheritable set.  Without
> no_new_privs (possible when a task with CAP_SYS_ADMIN enforced the
> domain), file inheritable capabilities can then grant permitted
> capabilities on execve().
>=20
> Add a Landlock capset hook that checks CAP_SETPCAP against the domain
> under the same condition, as SELinux checks its own setcap permission in
> this hook.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
> Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118145217.2551=
053-1-mic@digikod.net?part=3D3

