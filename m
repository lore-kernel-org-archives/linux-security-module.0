Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112114;
	b=qYUDdB0xpFGJNw8k7LI4tgsk3SWs37aZaFCZHqlTTfsAbJ6hvC5dLg39/13tuXjvmhqb
	 g19Jrav4EtvCAGhbkA+yPeUEoMUR4YcPiZZgFeQ+nO5CACh6fxR+8gJr/3oc4TPH61DvQ
	 FGUA5PqMAkoHqBqaFBYSxx3eKyV5b6B27zyBpBd7h2ziuXuiaQ35SQWNR1VjVCRCLT/aL
	 w1CKAbOESKbyRplR+jK7v0SpEPCfbAoomnpOF0gLSq5aW/8oRyDIdYHwkMpa0YYJCBS/A
	 v0rXKMevLJnJaw4NcO+09tyHdRSbpmIpZ4vkISnSMU6zjVasqb+5d/9As3OhDhPRajg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112114;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+LVZ5JJxUHyppZbPjdsifnnQ4L+MMhZstuqmIiy3/Pg=;
	b=xuqmKsoMU/pJiJcsgxKAa9h5NEZ9poiMjokDQWdFa7L1U0KjsJWS+deZhwaMWJWJpzUS
	 9RhqS2Rxd1WTO+6NLWi7mqgjs2d62+lHvxh2f7RBXPyFWJHkWR+S5WI55DcilY68eQ5G6
	 GyYDLRxaqmuzYYlRqVSU6Qocsd219uoitvO2ub8T/GiS6J7xKm3GxZvFK4hVxgVyBahot
	 AC8AzhOFS8EflCknw0Qvjc6s1yDpE5xocmgxQMg2w9ohKBWzzTwCvUhpXBkuguKqSU1QT
	 OWYhbcAIAN3i7Q7W3j17wyH5sYm7z47jcT7gCuAKJhJ+OOlIakBwKFfoiWnSWjoFwkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lUnrsL9L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4782606BA5A
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lUnrsL9L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8F61F031F4
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793112113;
	bh=+LVZ5JJxUHyppZbPjdsifnnQ4L+MMhZstuqmIiy3/Pg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=lUnrsL9LLQFUkUd5UaBLhdGv2aNhxoSPO8C/UI1Lp+RaMJtKpKa2cVGAjW9W7NNSc
	 8bqdADSumOh3JTvSpQXe73WUqbCIiWgYNIJ5PbHUlWtELi5D5nTsDxlzNIdGGzy5cl
	 eez5C/nCFxslFKKjY35tghMcKvdLncAR/Y9KdK7qfK2PsmWWpTunIObk/57VFWiMKe
	 WdL/i1fKxjH1/wHmfDM6BInh3/MPt/OEtZ1+5j8UVwddaYqQjApoz833Ufs6WAaCPk
	 VW1jQZ4Df68QL7CJbHQGNIGIYuDd5pHJLerVbsIeMB/K3UuSS/yU7qTGhR+EM8HZqT
	 f11I6g5fmQ1oA==
Message-ID: <sashiko-outbox-186748@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/6] userns: don't let setns() lend CAP_SETFCAP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261027-b4-setfcap-userns-v8-2-2674adc63f3c@toxicpanda.com>
References: <20261027-b4-setfcap-userns-v8-0-2674adc63f3c@toxicpanda.com>
 <20261027-b4-setfcap-userns-v8-2-2674adc63f3c@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:41:53 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Mapping uid 0 of the parent into a user namespace requires CAP_SETFCAP,
> because a task in such a namespace can write file capabilities that are
> honoured in the parent.  A task that is already in the namespace has a
> full capability set there and can't be asked any more, so
> verify_root_map() goes by what the creator had, now ns->setfcap_level.
>=20
> But setns() lets other tasks in, and they get the full set as well:
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>   unshare(CLONE_NEWUSER)
>                                     setns(A's user ns)
>                                       allowed, euid =3D=3D ns->owner
>                                     write "0 0 1" to /proc/self/uid_map
>                                       ns->setfcap_level is A's -> allowed
>=20
> [ ... ]
>=20
> Link: https://lore.kernel.org/all/20261021-bioenergie-allheilmittel-undur=
chdringlichen-35666eb62cff@brauner/
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-b4-setfcap=
-userns-v8-0-2674adc63f3c@toxicpanda.com?part=3D2

