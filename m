Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910665;
	b=2KPmJqrWY/XesFYXBpBmMv5sJd1SEkTipCeEmWtZZG8YEx31zg+ocnEtjdAWHYnvKZam
	 YRZFWyg7vTgoH2/sGsescxk4MAbShk2tJc0IngVnB5quZIloFGeUPWK0luGePJBRUVvA4
	 PjfsE0yW1TRR3yiG1bhxwtQPnU+JczqELcDvA1KG07iygq/Dj9xgCq8Jqjk3UPtJV42hD
	 V0Wx9HgqtIIUNM8LoRnvu4vxw65LEETyw6pT5s8Vzyr16StTso/869Q1+5oV/8ZFiQMM2
	 48XI7mrHorGK9qZNQQGR34y++iVN1hnEVOZgQMJx2ZpAvZqp1XB9oiMa+BNKnCfmhMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910665;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ySuzHjmG4uRFGXyGfa/u993RjgUB2Ug0Tu3eHKgx3Xk=;
	b=OqZYF2ExQVcB7KS3A5xFd9B+M0WdjgJlVFoE7DZTQlNK0FnN9dChywxDwEz7P3OJ3126
	 B9XY2jhzuT0Rjskj4GwJ38M7i3Wh1H4sP2rtMbRJOrMg8gRAQrmE7/f9WnnA/kZS4PmWZ
	 BgHUhokqTfuoLZBkdUbiFHRQQR/UUZ+49LHwcs1t6DofOXq2VSvt0sMFCqjVeTcDmVX04
	 y6pzPT7xTVPHBKBet4olQdADnr9Q4Tx9PS3mn5GHFj2LjpJaJe+LBmFLklfdVU7MhfM/r
	 o6lxyVbtczPWvFPCde6jLlMzRFZtG0MQ/S/70fdIHc7ztCrsgkpJjXbCVsjKkL0efKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N7ZZkp0w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E0C606A899
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N7ZZkp0w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930911F000C5
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 10:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910665;
	bh=ySuzHjmG4uRFGXyGfa/u993RjgUB2Ug0Tu3eHKgx3Xk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=N7ZZkp0wN8hEB5JpGt0E3/RJFrW/VViQ3mMGWfuBCI7hTzXUbvBcX4GBc5dhI5Ft6
	 TQ4CUXzaP+y/sjqHEeksFdL6Cj4X7o2EtGz/18Uh+1zTOeg0iBf353l+hApfy8QaD1
	 gMdm2jHTdTwJrR419IPgxV4kyPLfOnHSuZ/Tj783ARPKgYaEQiDj2aR5FKjmp0WgCg
	 FEkJxBWLBwn3TGLHW8rh374QnPBIcLjTHIIWXlWg/clizxbinPTat8LmHKT6cCeiNa
	 oo7W+yFADkhKWqwpNVj4V4+wMteXoLo6zcjeOQV38/1MfkjQBi6Hn/Z516yHxzMHR3
	 tUx6CMTTXMmLQ==
Message-ID: <sashiko-outbox-218585@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] landlock: Mediate CAP_SETPCAP for inheritable
 capabilities
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117101157.2520463-4-mic@digikod.net>
References: <20261117101157.2520463-1-mic@digikod.net>
 <20261117101157.2520463-4-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:17:45 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> A process in a domain that denies CAP_SETPCAP could still add
> capabilities outside of its permitted set to its inheritable set with
> capset(2), if it held CAP_SETPCAP.  cap_capset() checks CAP_SETPCAP with
> cap_capable() in cap_inh_is_capped(), so the check never reaches
> hook_capable().  Through file inheritable capabilities, such a set can
> grant new permitted capabilities on execve() when no_new_privs is not
> set, which is possible for a domain enforced by a task holding
> CAP_SYS_ADMIN.
>=20
> Add a Landlock capset hook that checks CAP_SETPCAP against the domain
> under the same condition as cap_capset().  As with the mmap_addr hook,
> LSMs implement their own policy in this hook: SELinux checks capset with
> its own permission.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117101157.2520=
463-1-mic@digikod.net?part=3D3

