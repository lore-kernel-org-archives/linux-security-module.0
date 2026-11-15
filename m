Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794783065;
	b=sXz6R3UIMZ1AGOLH4QUurYy0v2GLDnQkpbwqkgoU3UTdm3ZUAEKI3YpmpZo8Ndc3zwSB
	 7O4OFf5hSiwfqYITkMttplcX+LFW3K586VtvjryUtrj1HhifMKEVYOsxuIxCA8Vta6c0X
	 svRJRNm7M8UaSnX+p6fJvYaniKo/rZ2VZmFn961oWl/IJHaBfgwO7OYzzfmWD4M4r5T65
	 tH7LA2tiaEE4c1bZisFTK2jOworNwLu198RMFCH2Z+lfiGDQzgeegkIMXkNX1rg1R8IlZ
	 p6ahrwlfIbRUBty7BOKzZRpHp8GOLccAnbpNufJZ3Nvb94GGBBhhqCsLVfzJmUNEZCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794783065;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8pTJ0qsZsxhMV94mBiYMWzA2Bh3Yn/ueCQnqIxG+Z8k=;
	b=enY8jr7R9et41eRcNXmC+Ow7LwPFP1Zz3EnlRPoky5w9C6mZIbyEZ49T31P4bbGU1gnp
	 ia9xtNH+v6JyP/UQZR2fLhCxFuVcwqUcT/ilpZkz+M+eAj0ZU1/I6x7ZRLIRtoPyhVTA4
	 k9DmdKLV8SFZlH8ewtKpJ5xaxy1F3IWRBMnm6Ox4xaLwNob1LQT9YYqnX7/5dtGFExQnM
	 2JwTXiv30d90Ihsbf+YNPDaUzoJCmQ4acl8cxTuD4KdwYvAm3DvZmIsw1wcIquUkrt2PV
	 euDgC5Ye1CKVUkVuXXnqXmZLTV0N5hgcAy7jqMYmuVwKA8TiLrb4QrMrgQyPatBk/GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0jtZLVI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4FD606A31F
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 22:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0jtZLVI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6301F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 22:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794783064;
	bh=8pTJ0qsZsxhMV94mBiYMWzA2Bh3Yn/ueCQnqIxG+Z8k=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=B0jtZLVI5GOJVltNidNlG6t1an7ohB3hInzI/Pz0pdDe4DsARN3QIVc9ELNFtv2WL
	 Fw8RCcyTaLg9Poz1rMg1oPSYVtwmZxD2sU/iTaZPbbvTgKsvXzXN2OgS48x9vhh/Bw
	 YBBrjxKfHJMsyWDFYueykp5ietuHKo8abPH7JHthV+mjKNqA4Zc3kA9cdYNpcFXudB
	 v2PHnkeSfLOhdIMcpakvljfy4Ds6MsdIi33hDCLCXkYzXMzXxFgC0jzgieXRhxr6C5
	 RuzVtJ1KJ+4E+f0eTi0m81kZR7bnCovJt8ZiB73M+H3IxxcGF3PMmAvd8aPJhp5lOF
	 o8OwCVtuE56tw==
Message-ID: <sashiko-outbox-215889@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] tpm2-sessions: Drop TPM2_NAME_SIZE
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261115224722.1450498-2-jarkko@kernel.org>
References: <20261115224722.1450498-1-jarkko@kernel.org>
 <20261115224722.1450498-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 22:51:04 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> TPM2_NAME_SIZE was left to include/linux/tpm.h when the base definitions
> were consolidated. Switch struct tpm2_auth to TPM2_MAX_NAME_SIZE and
> convert TPM2_NAME_SIZE users to TPM2_NULL_NAME_SIZE, removing the
> redundant TPM2_NAME_SIZE definition.
>=20
> Cc: stable@vger.kernel.org # v7.3+
> Fixes: 88c5a62c3af7 ("tpm: Move TPM common base definitions to the comman=
d header")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115224722.1450=
498-1-jarkko@kernel.org?part=3D1

