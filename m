Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795043708;
	b=L2FsOVdkJnOjdt0ZqGScSmbTuD1DoStTrMuXkYEw5TjMZZCvLHpsY3b8zrWYljOeLeZ9
	 09KYfj/mbFAh3p3AZNQNk7uv6JuXXIBdtdCx679a8Ah/en7oOHsbGnJ2U2GlIDTabSu74
	 m7zHfbP5QfzGEkqOy4OAWX2vascvcCpcnfAkTo9V42tZpgGRmWUX0rHpdqT5cXkSKFdQD
	 8k59+oRwKIvXl33lJOBpz0VkUGxeOF2vjZNhF5GBPkyTjK1yNQ/tlit9hDcCXBPpIwxQj
	 gKgoRlie+IGWrbEFHeAjFP1zov4HNcWxwKL2BHKKL3fEjYl2yVrjhCFKkzHzloo6Ceg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043708;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=24Yz7VMDUTi1Pl6WwiGQjc0EQCLiOF23TOKP9HL2u94=;
	b=U5x0mKkw5Um6pF7Ib49nHonx3zcpAPWLr+q2/YevTzh8QukctRunqvE5vaj3DaB1Ip02
	 HGKsQ4cq5m9Fw/ygWbWIR/4M+zkFPMn8eq1vuoKHlwOFY+gz/saqpSYEhUGVU+/2heOQt
	 5CK10sW8i6iD9Z+xtzjhJjQdOgbM8elsoMCE5Eq02XOH0wU3kuQZKJwaPGS0r04MoOBDz
	 jiQeAqrW2nvp1WfLLAyqEIa2eX2krvMxTyThk32zREiIaNZyXL/WgnHMCnBCJwQOAzrBC
	 xrBgpt3hir8Mga+ikvkCNjUTBoHIbh55g0jMVf43plBKJxpOURLGOpB+no5A6zE8yIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3PlZqaY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F046606A32F
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 23:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3PlZqaY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4A51F000C5
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 23:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795043707;
	bh=24Yz7VMDUTi1Pl6WwiGQjc0EQCLiOF23TOKP9HL2u94=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=V3PlZqaY3QY4yAj3NvoB4mR6bILk1bsnF2ikLKJuqPDd0K9fszdprt4XAoExXLPEh
	 OJRrfISqXaBaarZdj1sqKnFe8ajBU0s8GIDmyVcwbYOeT5Bl8uzVrxt1w/b0z3omrn
	 twXFPYdgVd3jbmZnFZerZ8FDdm6qqRwq58HuGM/H0OVvSm5L+OleFZRJ2WH0K3y9fW
	 Q/8WwHU24ZJkQd5/iyfjDQCJb2v3jKT5YVl1vL68/8om4yRMNRyBviP5k7pOH6JTaz
	 snEZJd9QAYY5EPbnEEFghsyUoAF1En5uwsc16ROJvugG/jHhkDeJ7phg6Tx4IEeOW0
	 TgIx2gp+z4HlA==
Message-ID: <sashiko-outbox-222155@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 01/13] nsproxy: Pass nsproxy to
 create_new_namespaces()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117231352.3816603-2-jarkko@kernel.org>
References: <20261117231352.3816603-1-jarkko@kernel.org>
 <20261117231352.3816603-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:15:07 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> create_new_namespaces() takes a struct task_struct pointer even though
> it only reads tsk->nsproxy, preventing callers outside kernel/nsproxy.c
> from constructing a child nsproxy without mutating a task.
>=20
> Expose create_new_namespaces() and pass the source struct nsproxy
> pointer directly so root namespace creation can allocate a detached
> namespace set from current->nsproxy.
>=20
> Co-developed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117231352.3816=
603-1-jarkko@kernel.org?part=3D1

