Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827145;
	b=ul5y6maK91l4rLqM/0GvL9Mg5iqB6nN2naqPiDz1xX1B6X0aGAOSGgUbX2D54RcIamyv
	 nauH/YegfQP6x6EuqVkfzWGdLMKBG6JX79Vma/SsFezQQvTKXYI1RBIsDLz22FQ08o58K
	 O8opPVo8ixBtuYWOnuxIcIoDIy/V8xu4Girr4w1m/hrKEjoOfG+D17RtbKNv/2YA0Vwy8
	 uJvnW1CyUxQJ47Fn0qH1apzzuKV6PbvLxeAaOhlwlcV/gJ54gdbjuWXNzxo7N5DM8XlMS
	 iWSSDWG+S4m4rPXqEpNOfJcyAldBc+qG0M4Lw2rJLKaFXmdgEPVWaTtiohnA/MKJELg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827145;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7ZGKKMsYVf/7NxP1gKC101PKvdbe1VD7Zsj5FIMeTJc=;
	b=kLNdIS1d9DEYf/C/hTnHPSBmN82MiGp2S3sgMWpe83EKM93TvMiC/TEHpUnNGFCtPCy+
	 6gZ49gUe+fgLHW/XXyjfAgdrDU5SYRXgtypqad7ODDllUlC0dLECrD2kSXNypS2/KkRfA
	 WMnXpgChNxiSc17NPdYtzxMLawTx+vH2s1LiQ/X1pSPeHn7Bm/UhGmpFAhmYre5DPh3H9
	 z0j1Hrzdln3dVCxu/W1xDeiaQ3WqQ2JRiVYnvFBlYYrngb4hvRSaU5C740uMvkTjPvLxC
	 jYDpnjWMJASVfNU0/kd8k61hSH0KIM8Ttn2b1WrUbRrxGhlbPuuq6cCRJ3unZurPaKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BbRZgumR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B8B606AB3C
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BbRZgumR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD681F00919
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793827144;
	bh=7ZGKKMsYVf/7NxP1gKC101PKvdbe1VD7Zsj5FIMeTJc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=BbRZgumRUSl4xx7tNaDDXBKKR6dsoN4B2QTvGc63Eg7Dg/ZVmzeamFq5fndSx+ciW
	 Fr95r9b1pr3inyTrZLg9p+XIAelNnaR8j+eyq3YSOHmD8jgMJibxUKg4N7XB0s8X3v
	 5B+Icm1xNA9FI1n7ESm4NJikKsN8HxL2bfs68iGCV0vj3nSwr7IjuJkMcYRYOh9i5X
	 buKKUwWCq4wLLM4uUjBnCssp6C7FeZRRajaJX6wjTZbRP1E2UiDgEWkZxB+pTB00DZ
	 RsRZoUliRB9d521ckG4z12AtiWC1aCiFDmaBWbFWbQAZOZC4yXRlq51xLTHnvtJF9n
	 aFTlqGR82AFFw==
Message-ID: <sashiko-outbox-198093@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 27/27] selftests/landlock: Use EXPECT for checks that
 later steps do not need
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-27-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-27-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:19:04 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> ASSERT aborts the test, so it should only be used when continuing after
> a failure is pointless.  Use EXPECT for checks whose outcome nothing
> later in the test depends on:
>=20
> * errno values after a failed syscall,
> * test_open() and test_open_rel(), which leave no state behind,
> * WEXITSTATUS() of a child that has exited,
> * matches_log_fs() and matches_log_fs_extra(),
> * the record counts returned by audit_count_records().
>=20
> Keep ASSERT for operations whose side effects later checks depend on,
> such as renames, links and file removals.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D27

