Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3DC3E5EE7
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344890; cv=none; b=AneY9y8FW9deqqY6FhXYgwQeB9PC8PlUOUxQyKPccZSokxfiIBpxR4wNFBgTRQDyc0HYrJoWFqMwpTxVqW0OF6nnOlu6vULGeU2nTwd1kZ4E0FiFBDDHdDsnJJfWohz20V9LUS+PMen+3Z557gf4UQe2kgI2wK1nMg2dqIwINUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344890; c=relaxed/simple;
	bh=cq8DfykcAcTuJZ5Ih13Bt1QoyqV4tqcl7mTKbuPTWO8=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=j9QoLLKBsIrbUQ6te2glhBi2TUWXknrqLZ/dIcsNaa5uL3FGZca1j9eYFGaDKhUvQReXdwVjZRIv3E7tGO62/uNSPRhs6iOeybNiAJ8v8zoANFVkcaeKYm0h2pdOuPT2LbW3ZvWWQVJAyW4pZHiS2UytzWyHPPCa/CNSCfkCJ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC+bUhEn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MC+bUhEn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0051F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792344888;
	bh=cq8DfykcAcTuJZ5Ih13Bt1QoyqV4tqcl7mTKbuPTWO8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=MC+bUhEnvuGVWokL+HS42y2cBO9CSabyad+3bfeE+xJ45ShcjC5y+bJUceyqWDO/n
	 9mH8JjeeE0CvbMoErtK61UarExAycyQbxwzCDV6lV/sL78lzzzyymXzIt1wUTKlpNm
	 BfzulLQXNTWsxm5CaLIW99JhhgcSXWYeE/5jcFFfEA/DBQDh7ugWHy3n+pRxp+m5Pw
	 8QsOMvSTGZlaKTb0V8fWJTsrELVfcOIxZkkbr+iGox+jbyCfUuxsagFqPfbTAIdsV1
	 hKzE/A/HfmAWT4U3tP9QjF79y8qnbg6BB6oX9yvDJa7jMQUWpFvTO4jvQGTCkBNkLX
	 864G5jlo6NZFw==
Message-ID: <sashiko-outbox-176327@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/13] sys: use cred_ids_allow_sched() for setpriority()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261018-b4-cred-ids-v1-7-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
 <20261018-b4-cred-ids-v1-7-7bdf2db4ea9f@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 17:34:48 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> set_one_prio_perm() makes the two comparisons of check_same_owner(),
> written the other way around. Use the library.
>=20
> No functional change.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018-b4-cred-id=
s-v1-0-7bdf2db4ea9f@toxicpanda.com?part=3D7

