Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013728;
	b=TjZrcMIdIhGFFn7jQOMQygtnu+6vgmgn/QwKzDqgHbQPdn7LK6HVj1BCnWRTWIbK8ZXn
	 F1ZqOTnpXp2aQ4+sJCVKIkz/v+ykzaVTVwKIkGTv7EgMFhIFURVvCKG7u+TODfVFLWLi6
	 bI6SvV+6fHdu5cAxFXq1a9qYlUiFtqMUPxyKIR975ds8yXSNost142tGASb/LxZYHSey9
	 PM3fCFjPXvhf93403PaAPgpoWGhNm/YUkxywHAtJCUfg+DzotZGqov5WOVND8SzA3alLd
	 zfEvhKetNH3cRsYNSmsu2jzTV/1RGgwAViqu+g9cibrjthkqGkjbZC5T5yqqpJp+kMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013728;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RNQLRDC8bnnBXE4op2nYqjpB3yM7GRgkY2BPmiWnGho=;
	b=jSsoGQ1PUZAOJxdx4UPbqhyVAGXC/j1061KYJethr2/NRgUoHOHrJj4K0QtyI5ltUlqY
	 Q/Fa0cO/THek51AdP69gzEbJS+QSpo2UIJgakB643XgS1JdDUqOmcAIqcOJaqNncYTDl9
	 OVAuvOEdsGyq/07XvYoSV0H25d76A2oF3HH4ck39ZYSaPfLXvAkbZ5mQ15OgBUYvdZ8Dc
	 sAlzhLmUZZ2wTZPPVe4ED68B9KtumMQp6EYPGrPAXxaPDb9d2fLdPobBvz/kxdH+29LH3
	 Gu0JtMS0rQmqS7q21SyxGVzJeMHNiowvxDQVoMdPwFNtfh7T778NkW8vfxRI2OvxVZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KEKPy+sV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C4D606A31C
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KEKPy+sV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798E81F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795013727;
	bh=RNQLRDC8bnnBXE4op2nYqjpB3yM7GRgkY2BPmiWnGho=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=KEKPy+sVWUpA5vyf/zYOPBtJABwlM1rlWae3IwPFtR7AMTOd2T4M1n6zBo1XNROCQ
	 pRIR5sNFAW2o1MaOZUq+6DVMEsDKQlNapfFGVVwGuwMSBTzt1Wfv3q6nlEzlV8R9Y9
	 9zVw076GIFB7lCF+gf1tQQvA1FpT+UAhlHqgPTIwa4hMgxuP+IVnDnOCMrkSkgXxeY
	 iPYMfWqlW3lhwCZsGnfKWlDwEpwfVghOfAEC+drlG5gFrLRvuU5G7FaJwV47HGvzmR
	 kxzksGDizptCwuJWZy8O6ZboyMpdxcUPtaprer3SEloDz5o2ozMr3qZGNqSjHfHkCK
	 ZvCRzsg95sgQg==
Message-ID: <sashiko-outbox-221267@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] landlock: Factor out capability denial checks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261118145217.2551053-2-mic@digikod.net>
References: <20261118145217.2551053-1-mic@digikod.net>
 <20261118145217.2551053-2-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:55:27 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> commoncap also makes capability decisions from LSM hooks other than
> capable, and the following commits add Landlock counterparts for them.
> Move the check and its denial logging from hook_capable() into
> check_cap() so that these hooks share it.
>=20
> No functional change.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
> Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118145217.2551=
053-1-mic@digikod.net?part=3D1

