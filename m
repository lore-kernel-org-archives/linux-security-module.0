Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D15D3DAAB8
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 05:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791523344; cv=none; b=smd9Z+sBj6HNTENZ+Vb7rJqubtUCWs2eAaBJZE8P849eW8FR6fRgSrMdDxgLVyZD2jMHuKAQly9NOZf0QHoUS7JuN+ucyTZyY5WbJjC3dr1z8b53cAvECyWTgq/EjEfDn8xThuGlc9R991srug0VAqrzJ9tx0VVaoXEWvvvFL5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791523344; c=relaxed/simple;
	bh=e0M3xbP4c24qG1iV2IJWkI6h9WVbeoUvHCCU3EUecAs=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Z7Tv7AW71a2YBoPIKK54g9CmtvgkN+zkg+uQ6jTVkXzRtAwmaKLUcX0hpTm0HfLsV5v2m1Ag/mkhGxNxyvt9Hx8YrryQrbXp3VWGV0WrAGnRb14ereI7aHH8ywDghdyKNExzGmshHUrXjebTUfJ3Fm1/dBf99Eqyf7z2iREJGlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4G5O3GU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4G5O3GU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D8E1F000FF
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 05:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791523343;
	bh=1kjR1DO6HHgT1aWTh/60lDZtSvZtkbTz99Lfmm0hhC0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=F4G5O3GURWOnAcEm8svpDZ7vQ8i61Sh1lt7OZGNhkV+DP3L2A8U4/OcnwxnWxB87C
	 hHEn94wpkfj0AeqgwSRPwqU39CjUUYvdvUeitu3HcjgJtc2mxuxGS/p/dIGkGSZDhp
	 9sNa/hBwObd3LSb7ktv5D7m6qmwkdqBXGX8r5v7anrIaRSOlJZdLcKLw0N4ae3Cv8q
	 rDqcZYCXvsgupPtExHLelI2r9ODVo36GfGwqtMJ63vxEri7OOGk3t0N6losWvx+yiX
	 ag1rAajjeDiAIFUrNwyeOup0iDVzvHsq7d5AVYj6XgdgesTw4Wv5gZ4X5craTcdBRE
	 05RH8p+/W8now==
Message-ID: <sashiko-outbox-164880@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] keys: Avoid the owner account dereference in named
 keyring lookup
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <pm-key-management-objects-candidate-0002-v3-2baa8cad2bb554364e10@gmail.com>
References: <pm-key-management-objects-candidate-0002-v3-2baa8cad2bb554364e10@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 05:22:22 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Named keyring lookup must keep the storage containing the owner UID
> alive through the namespace mapping check.  find_keyring_by_name()
> reads keyring->user->uid under keyring_name_lock, but that lock protects
> the keyring's name entry and allocation, not its separate key_user.
>=20
> A named session-keyring join can overlap a privileged KEYCTL_CHOWN on
> another CPU.  If the keyring holds the last reference to its old dynamic
> key_user and the ownership transfer succeeds, the following ordering is
> possible:
>=20
>     Named join                         Chown
>     find_keyring_by_name()              keyctl_chown_key()
>       read_lock(keyring_name_lock)       down_write(key->sem)
>       load old keyring->user
>                                          replace key->user and key->uid
> [ ... ]
>     Read of size 4 at addr ffff8881128ae2ec by task keycase/500
>=20
> Fixes: 2ea190d0a006 ("keys: skip keys from another user namespace")
> Assisted-by: LLM
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/pm-key-management-o=
bjects-candidate-0002-v3-2baa8cad2bb554364e10@gmail.com?part=3D1

