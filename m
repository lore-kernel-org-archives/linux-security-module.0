Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267BF34D3BE
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344869; cv=none; b=tC/tQmYyNI56bQXIeVWv2pQpphIw2hk+UUASPECzqjRQEx4fXZ7HaNu4T/EscsNqyrtTzz0R/tBhLrpPVPYR3klldS0FHUl/s3LCnvl2NaQ8VPzbW9VgR60f4ZK1z1V9eAFz6v34FmsAoLe1MywaCYWaUrG6yGi2xwXRpGvXC7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344869; c=relaxed/simple;
	bh=8gpY9kcfE+0Zpv4xQYps9mI+je4NvUPNzo3Hj6e7hYc=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=R2rn9a58mev0SQWtUqNHYBqEIA2TIO1iXC01cPnas6zsMrCImrjRILCT3aI28/7Mt65M12CsFICwlJTUta8JZezR8K+TOneSOurxeTJlLoV24cdEEkbIxwy2kz9WW1olosjxI/9voGdFDrw6JplBW1Ze4bO6Cce9gzmnlq+aR64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnazhCWf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnazhCWf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EB31F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792344867;
	bh=8gpY9kcfE+0Zpv4xQYps9mI+je4NvUPNzo3Hj6e7hYc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=lnazhCWfKu2U2EeORUTjD4ABW5sRX93gL7wnbNXrcP+Xie4MtMCJx/WueJsezPURk
	 NMzOdoOLpOVAO4hCgPQ49abitvyOOPD5kczYhD90MhXoi9/96qpn5pIeIzcIPBcMIv
	 ZA7oR97kbCsn0MsYLbRiRcaeEV33YO8D38tUJ8zAO+yzN0DAoKRja2wmti1kRz/Kz+
	 u6r3n27g7eO+8ZwLCVLXe/6IAMZH3TvFebq5yLs6CktXgD1DdmV1bmuDesnDgjJDR5
	 yeEOCML+7zspAjJ40dY6FNyCDLMi48BXzxc23T33rPboKPyZg79OL7DY8iUh2JDddv
	 L/kWe25KuXEaA==
Message-ID: <sashiko-outbox-176325@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/13] fs/resctrl: use cred_ids_allow_move()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261018-b4-cred-ids-v1-11-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
 <20261018-b4-cred-ids-v1-11-7bdf2db4ea9f@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 17:34:27 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> rdtgroup_task_write_permission() makes the comparisons of the cgroup v1
> code, euid 0 included. Use the library.
>=20
> No functional change.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018-b4-cred-id=
s-v1-0-7bdf2db4ea9f@toxicpanda.com?part=3D11

