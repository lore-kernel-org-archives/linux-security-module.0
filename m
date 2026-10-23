Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759548;
	b=cicbhnLcXA8i0H+ZhphJ7jZbqezp0yMh2r4XI7zLyUsNRoOutihKysTWW14Ygjk6vwWf
	 rwzrv104sUTTbFNNUw9mNv++Q2W2GHetJD49d8D7jPEjIc8C+2wMAsVTYXxueyCwcZgBY
	 FILXB2g2N/k/lphrt8UK0GvXQ7PdEHbbx1d+ZQKLlMpdMOc8Aw1l2DBPgzs7SkQYOo09C
	 k5zYpmKK3pzLKMvmT9qLaBopArI9/F7xNXc77Gamv6+OmRN4MsR1hcPT35ndt1Q+M2Ou3
	 fv8gqc6odmDsTnGJI9yepSR5/ek+10VgPtZSMRJVLl4ZJ2w167Y33YdZGXlZu+h2HRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759548;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kRhzSnpDiuB3kyYik9/Zeqni1vOK8nnI5/rYQS391kQ=;
	b=20oIYAxTvIHfPlqqqd4Pj61UJFB5n9WITEvZuuIVh1Hwe+1Xx9p9TudhDF6vUlVPR/qO
	 J+JwmbhJuu0PPSM4M3hUUIp5pwFkcH7b7KXZNJ9im4LMyCU5bTCYefJoOQ/aIjKJ2C6A/
	 8saF0Bdbne2Z1vkqqP26664j+IpB3TSq8lsQ403kK4NYAFNWOiNK47rC8FqQqvgg/On6w
	 KHliVBQX4xeAixZ+TPPATu/Df96FfCgzrZUq2JcYp2SxSudFN2k6p/eg2iYGtbEcq7mQU
	 +RPXK6qGQTl68NxyXe/sURpmblsO/8hdoDsNVo5/f7fBPTCbUbvle2/j9UeLf41DuJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SMvp9Ve6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F29606A31E
	for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SMvp9Ve6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBDF1F01828
	for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 12:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792759547;
	bh=kRhzSnpDiuB3kyYik9/Zeqni1vOK8nnI5/rYQS391kQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=SMvp9Ve6MmzLj8enMqq2c6R71cbDVJ4+1lReue3+1LTxSxCP6/NfBJ6uUX2BVQLL7
	 1dN+WNhcHrY9RKt6MKH2BuivAXv8rben3JOrK1ox2LIKOcZgiMmN7yAg7GnS/qqIgk
	 PFLqdy7cg174pEMODvpCBwO2ynmenfH36Y/C4NnazMBCzE1gHxJFcSn1FcF5PU45DS
	 UP4iP5vlTK6vV0/CTC2jK9A0eQBay/U4UHpQeUgogkTOWbCJBuYqdipsYZ4vEI84xd
	 NcuhBQudDB6eRAm1yr+8m1q256+kC6PWikbXEEBj79gXQ+fJ6CQyGA//H7SiLKX58v
	 i/IGDIvSO7oWQ==
Message-ID: <sashiko-outbox-182793@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] KEYS: Replace assoc_array with rhashtable
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261023120953.1206778-6-jarkko@kernel.org>
References: <20261023120953.1206778-1-jarkko@kernel.org>
 <20261023120953.1206778-6-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 12:45:47 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The keyring subsystem depends on assoc_array for searching keys by their
> description, type and domain. It is the sole user of this data structure,
> which has during the age of LLMs transformed into a maintenance nightmare.
>=20
> assoc_array needs to be replaced with a data structure meeting the
> following criteria:
>=20
> 1. Must be suitable for a sparse key-value store.
> 2. Must have multiple in-kernel users.
> 3. Would be nice if it had dedicated maintainers.
>=20
> rhashtable is likely the best pick from the available options as it is
> designed for a sparse key space, has dedicated maintainers, and multiple
> in-kernel users.
>=20
> [ ... ]
> Assisted-by: LLM
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023120953.1206=
778-1-jarkko@kernel.org?part=3D5

