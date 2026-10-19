Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434107;
	b=Z0GVDYVZgmjoGpDMESOFJoJFoLR/fUTauvpU2fl6DcLqfd9m1Paq/kEjVsVKVDGP9BBN
	 NprpYppQQUnQw48K+2tb5iqdHJvDAr2YvjqCuJyAQpeeuUE9hivBvRL/qv3m2/nX3nB9T
	 BNTTalJvm6kaK5gQbn4huwcLlc2anijQBIB/4Qp0U0S+zK1xPJE5pVnxszdKRfjckdbEy
	 GgDGpv+ny9gcaDDD0dRI9FPjRbF2apjbv4BRMLXyvhkXerPRLYcokKPsEAl20/p1EfjLe
	 pb3XKC6LUqkaP2k1EnF+E+eAEcP+atZY7YQgZVVN1O5MeVwZJI0h8kk+oExH9mKO6xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434107;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+k910fVEAf8PMbciCRKLmQzBagh8eTmbe9xwUpzuHks=;
	b=fTbIRbSYcTS1dAg7p6aZ6g3AK5jrebeTnqb1C6nl4fJw8mPXWPA8soBSCpDLnXzP8Pi5
	 9+CfBmCT5+EW2wbnLnUqZn+DJVCfCUgZD8fjMVZRs2G6Emr/ionhd1GbMNQsTbIOhhRuY
	 RJtXpsxn7Z0CmkuQuL1aNuIfimmOIHoIyhbMThRtGRUDVyuEyjowSaUXWD5PRV6f9Lue/
	 H6WmgmZRWKtU4PCD1+Kr4Bxc6fWZYDhPqNtE6MVy9K4enr6dF9aL7/4sO3AWIVu8Alawm
	 aAZhipM2/N08N9wdXUvrJdEEsJ3ujReEQ1Max5KqgOuA6lwlxoi7M3mdyh/JUHQbYMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nERAfdRR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEAD606A31A
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nERAfdRR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B8A1F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 18:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792434107;
	bh=+k910fVEAf8PMbciCRKLmQzBagh8eTmbe9xwUpzuHks=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=nERAfdRRqr9mooGh4Lp4o4OVFD3maFLfR+TSJmuTWE4Vo/B3cvgpqijjkC6glzjgN
	 GDz8DScGWn1DPIfWSVvO8RyAtW1dIwQCq9SX5cv8o9z3Q5cxVBEMr6x3DGafeEmjtq
	 MvK2NfDQCQUJBPkjc6dz2UYOgEZwa9Gwht93W8FYtZb/IZDDlF+MPwCb6Z8WaGfzLp
	 lidunZ88YRSMPRfGO6m6mm7tOpPw/uHzdUEJzEAg2eir0GVsCLFvZ80zMQOMtWzniA
	 EqbZz8tylwcjau9UB7rOYRu+1PJ8Nryn71AvYUV9L0zvKQqBMExx5s92QIV4ukBX43
	 /kYTohoxHIaYw==
Message-ID: <sashiko-outbox-178069@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] KEYS: Verify the key identity in __keyctl_unlink
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261019181732.449591-7-jarkko@kernel.org>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-7-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 18:21:46 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Let's define the following preconditions:
>=20
> - Two keys: A and B.
> - R is a keyring.
> - Both have the same type/description/domain.
>=20
> Then:
>=20
> 1. KEYCTL_LINK(A, R) =3D> {A}
> 1. KEYCTL_LINK(B, R) =3D> {B}
> 2. KEYCTL_UNLINK(A, R) =3D> {}
>=20
> Instead, verify key tidentity before unlinking, and return -ENOENT on
> mismatch.
>=20
> Assisted-by: LLM
> Cc: stable@vger.kernel.org
> Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> Reviewed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019181732.4495=
91-1-jarkko@kernel.org?part=3D6

