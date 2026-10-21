Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792615460;
	b=QYzaAf+rzhgw011wqaWBBvcZMHocXi4eWrqx6JH9PwRkiE8e3VxUb9bxXNF9pnBGXqgb
	 TPAtDs/yo1eueN8jOyqCSBQKH9OJWk7UWFFYrQuz66opKAdJEUQJwWym9ymK63sQETQdu
	 tXgKizC0sFjZX56fw8J6yiutg6arC8/jBPx5NWR18Xk3rWxXFeZKHVJkVouWjGqLKLTJQ
	 YGJKYPMLaKz6XdOqZNY8mibHKbaW8TH+8umBD+MDvwyUocnzq5hXG9UoA7AQJMfzs7Z0L
	 myx8RGGU+OfYnndTBMtF9DNPSawoipoY9aCcEA1R2vD+jwTbpEGsMNOEMOWPWP73czQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792615460;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wTeweUMhPR0TJY2YMbNMMXQds8SH2KieYYR9e025KVE=;
	b=nXbK9qk6CawRorDXXLKDt+0EEMGEE39ifznmVUDgMgVv7tNVN4zCWb55Hb7mY5eNaZ85
	 3jOb7YWOlsHqiMU48QK1LeeVjvwvav7V1wmMPPc+dkgQPnuKgo30g4cokZesgBnpR6hoY
	 tymot6k9spBGtP2QRrwRlLQlkHiHX3JhT8F6XwBnPRr5EeF629Sph7shAizUXaIX3GdBP
	 mlFkvYCigXCf6SxUnB8ngbvsY1DrlsU30i6SEEB/LYIAsGXMdYYL8aa68L1U2u6Qo5SLA
	 Z+W71Zgd7e48CBBriSRys4qsO3jU8/OEvNON50QhE25qcCi797gvLMSDGRVAJA6AzeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvML0zsF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D1B606A31A
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 20:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvML0zsF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6CF1F000C1
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 20:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792615459;
	bh=wTeweUMhPR0TJY2YMbNMMXQds8SH2KieYYR9e025KVE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=CvML0zsFwz7UHEp8TWLAY81TuIMLcYU/b/QdUoyDmtsKi/irkdwocuKXSvmbUjTkn
	 NTKQvs82bFug/wtBm7S59KEF2ZSiAnDtXdeE/7qIdzeqfAHHP3QJAo2ozSyr1hsUut
	 RHkFB4zNNLwoB53dllesfBtgsWloxq+US+Z2LoDmIP7Bjnf4z0psPoWZWVJBwycOKJ
	 4SX8Rs4693O7zBRpOBhG+WcKNQhM7ZthB20GvfeSl7OuEfsOCcGvqNRnN+PuhJ5k3A
	 HdBVi74shU0DbbutIvhUkUmf6OrO1pqyZ721WjSG2Ygl7gN1jHl+4RT9QIkDWxJ98i
	 wdYlq2w1l3Nog==
Message-ID: <sashiko-outbox-180646@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] userns: record how far up CAP_SETFCAP reaches
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261021-b4-setfcap-userns-v3-1-97c7ed4e43e1@toxicpanda.com>
References: <20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com>
 <20261021-b4-setfcap-userns-v3-1-97c7ed4e43e1@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 20:44:18 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> create_user_ns() records in ns->parent_could_setfcap whether the creator
> had CAP_SETFCAP in its effective set, and verify_root_map() trusts that
> when a task in the new namespace maps the parent's uid 0.  A bool only
> describes the parent, though.  File capabilities belong to the kuid of a
> root user, and a namespace that maps the parent's uid 0 shares that kuid
> with the parent and possibly with ancestors further up, so what matters
> is how far up the creator's CAP_SETFCAP counted.
>=20
> Replace the bool with ns->setfcap_level: CAP_SETFCAP held in the
> namespace counts there and in its ancestors up to the one at that
> ->level.  cap_setfcap_level() computes it from the creator's cred.  A
> creator that holds CAP_SETFCAP passes on the setfcap_level of its own
> namespace, one that doesn't gets the new namespace's own level, and the
> initial namespace has 0.
>=20
> verify_root_map() keeps checking the same condition: the bool was false
> exactly when the level is the namespace's own.
>=20
> No functional change.
>=20
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-b4-setfcap=
-userns-v3-0-97c7ed4e43e1@toxicpanda.com?part=3D1

