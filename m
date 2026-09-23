Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7783D363090
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790133603; cv=none; b=qqtKgPc7GBLFnV983TFTwsBVttUvDoFEwdKzNdxybUDUpsEoHHVB6UlDLFLk9KNRF9jgrwk3sjRopV6B27JPHNYHz+eP4zrg6ym5YETAYV6kT0c8uR2+ldvwJnxWJlwBtgKVyAdJXWEDS2UGWbe2RpIn3REQTg1R+0hTAXPiLQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790133603; c=relaxed/simple;
	bh=XGfhi0YaM5qZzvQay8dFa8T/MQUJQ9r7QH68z+BW/SM=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eIxiGlMdlrfsb2HmcjrO/zBvb5AflCwF+/YVYrfUh/ZEgrtY48w/w49ZdTw4hznyfld08tbNp0mpb6TFR4mK3R0nAi9QtHDGtbn+wLvmXbdBf6QU1+TSh+AHnUOA6MTb0gn/VO9Lbact4vC6WPm4RGBh/P2QeRzI6suVAScddpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsgiP939; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsgiP939"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAC51F000FF
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 03:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790133602;
	bh=XGfhi0YaM5qZzvQay8dFa8T/MQUJQ9r7QH68z+BW/SM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=TsgiP9393QrqJH/6iswjJ9D3PBR4Cgh03xhAsUvRGKvvDhvBFIxV5YHfLdhpJTjKZ
	 sWyHnd2A3bLSHkKsnfoq37uUyEIykTEAwIABY9KCDtZYHpL+6KlZHkMqP3F4jvQ5lI
	 4ZZw4y+/2MY64uQRMAcSot4N1jGQWPRgD6LP6VCNp9liEq2yRoORdBAByTbuKh8knF
	 s/xlc0Sr8/hg46dbAWwb9GWcZBPXg+6jCmJnJl00abFUrF6xLnAyb5kbWXHGNUXD8j
	 GN4caOShzYyGnr+xJ1taAABVvUwgk74LW0Xs1EJKeGJIZwOYPdVZ5CaV53e/F9sVfS
	 7a2JVFU6UXaXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] ipe: protect the dm-verity root hash with RCU
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260923031349.1216431-3-wufan@kernel.org>
References: <20260923031349.1216431-1-wufan@kernel.org>
 <20260923031349.1216431-3-wufan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 03:20:01 +0000
Message-Id: <20260923032001.EDAC51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> ipe_bdev_setintegrity() frees the old root hash when dm-verity publishes
> a new one on ->preresume, while policy evaluation can still be
> dereferencing it.
>=20
> Protect the root hash with RCU. The evaluation path already runs under
> rcu_read_lock().
>=20
> Fixes: e155858dd995 ("ipe: add support for dm-verity as a trust provider")
> Cc: stable@vger.kernel.org
> Assisted-by: claude-opus-5.5
> Signed-off-by: Fan Wu <wufan@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923031349.1216=
431-1-wufan@kernel.org?part=3D2

