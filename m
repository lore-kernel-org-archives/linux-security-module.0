Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54A93E7BB2
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344856; cv=none; b=ln5EVzTWqtqefnbxRGAnz3/qeO25/lvJMyq+SL93W7RdZ8yTu/b/C1lOZCksBsjXOVtbaFf6Qfk0iw1n7IyQEl8C1e5rTzDJmtR+5yzHrtgbSjKifIut7HOtKm7e4Q9MmKuYqZWmochqQynhonFHSInKAc9mr+awPbRF0AL0eqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344856; c=relaxed/simple;
	bh=jUnsmUH+gAGzobVk1IN/KqdJcs5zLGlHgBo4TVchK4w=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gm/9xe+ZZvSEnxZ6DqSzSLOj9uYc/L25tLsrud+iknLiJn6EFnHGUeD82H0PwWp4TZ+U07B0yGWJnYvT5X/2pn5RNZMT/AL6NXSiuq4hS4FAVhnWrIYU6jnkscoRpdy+K6JfHB7bTyk/wmz2Esqdk9p01R+xnQFI3ydnjKiGeDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gs0LPzHN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gs0LPzHN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8071F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792344855;
	bh=jUnsmUH+gAGzobVk1IN/KqdJcs5zLGlHgBo4TVchK4w=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Gs0LPzHN8QtqWKR8VZdzTnWRAoUhXaXKjaO2YAv+wN9IFELxzHweYQUrGo+ngw9lu
	 bVOKoDcZinswcpILPwBnYjzNze/dYWiF6DHeH6Fu1zvZ+nCvvynZWbc2JLDjtmYvdp
	 kaI5u5eVg3NEE3JAf/BJzr/9TYXsBSXcTqKdGwf2aoL16P4X1Dpve6Ilw0cmpjkPrL
	 225ssX/8OutvHMC7ERS4WpeyfaaCvx1Vi0J+Ex+gKQyqlVvTqVmTx99s03sx2o75qK
	 7x1Lj3+9wYpkdfqGQuo6N1ujseQ0KJ/DdBBehS3eitpSXFUmQvpuqsJVIjrabLdlp1
	 hQnppGelmLMNA==
Message-ID: <sashiko-outbox-176322@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/13] ptrace: use cred_ids_allow_control()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261018-b4-cred-ids-v1-12-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
 <20261018-b4-cred-ids-v1-12-7bdf2db4ea9f@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 17:34:15 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> __ptrace_may_access() picks the filesystem or the real uid and gid of the
> caller by its mode and wants them to be all three of the uids and gids of
> the target. Say which ids it is and use the library.
>=20
> No functional change.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018-b4-cred-id=
s-v1-0-7bdf2db4ea9f@toxicpanda.com?part=3D12

