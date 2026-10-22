Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792669720;
	b=SV+dz3PnPB2ABLpkyP5UdoapM9a6vyC7zhy7agOMnUXj+Vyjrsr62DZg/1o/TwS2Fjpp
	 ervv5huGn0+0Zkynsn785WpncqT4Rg4tpT2l61ItUgMf1QERmobXoX4l4CtzsNHfYsMLW
	 OkPfxx9tZtVpKi1hLl7/j2yvThRhnE3iUG0IQUQxVw4EU+rtBC15Vaa67r7g6HpnWtVx0
	 mrUkw9CS7n4CjXcBgqOTlEpUDov8tGqv5mqsB7/HZqL3GDqNoC61YmTcx6fHwgqbDhYzK
	 GlLJ+gyJYHqA4xRnDE0AvhK+7hC3pCPtAgBTxvdauTpHX34q8f99VBUYGnJYys3uCnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669720;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BS2G1R9TQQxoCv+R1To+8Cei0Gg4CALJYDTV0aLNk6I=;
	b=rIqlQmq6fLRYP6ZwbR3YVSi8EW+y5IuUsCVbFzcNF/ZXxLkj1DaxAMxYP29st8ztmFI4
	 AMnH120AWsqBcwznqCE/CneO62Izmf0dv8S0KxnDyQJyqJQlRD++R6OdcU+IKFuWOOYFw
	 p6c4zDXShl6QkZ3MI6bU3Nfilfcl1SIqq+6+JFGVd8aAviU9mEdoQffT4W5ySu6KJ/GTm
	 wnnPsLiS17GmaaEgn6cYgFEeQw0/Nh33mN1dlaZCRo/9sJOUsgsJYJYejvp2wrijEqkBL
	 ESNfQJ9daw1Byc5fAFB1+Xmlo6Oild5EH8gTZtm8lk9qRa59KrnnDoMolWQP5NhRy2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIcLnlFC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5377606A31B
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIcLnlFC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AE21F000C4
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 11:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792669719;
	bh=BS2G1R9TQQxoCv+R1To+8Cei0Gg4CALJYDTV0aLNk6I=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=UIcLnlFCBfgeqSZwA+TzO78hists1NIpbrGxJAR03EWYRo/5hZ8aP028KsJQlb4/G
	 Ab01uJd309jYze4RXBPxwewTcgG/Nl8kRCrAe0o+vE19/gcSe2gMNRoCgzFaYPibBb
	 LKhkN2WSTPSrNQPTaWiSMe/GqnjXlhCCLTnLJ4IeHingMO1TF9GxylkvsxFO2RS6s2
	 Hcw8kbJy0coFkGk3R1Hk6Na1Qqqc3c1wM/7FiPBLwccqlV5M2olgY9jS1Wo0LsWXf6
	 3JiLRHqOye5hjtqoMDp3TVTjazkGB5NRsotPg7MtV/8fMWFqKrVOaU2smIFlvGzJbG
	 aZqVWip9jgDPw==
Message-ID: <sashiko-outbox-181392@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH slab/for-next 11/14] smack: specify SLAB_MAY_ACCOUNT for
 smack_rule cache
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-11-096800aa3330@kernel.org>
References: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
 <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-11-096800aa3330@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 11:48:39 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> smk_copy_rules() allocates rules with the gfp passed from
> security_prepare_creds(), which is GFP_KERNEL_ACCOUNT. Specify
> SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
> __GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.
>=20
> Path: fork() -> copy_creds() -> prepare_creds()
>   -> security_prepare_creds(GFP_KERNEL_ACCOUNT) -> smack_cred_prepare()
>   -> smk_copy_rules() -> kmem_cache_zalloc(smack_rule_cache)
>=20
> Assisted-by: LLM
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-memalloc-p=
rof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org?part=3D11

