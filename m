Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF734F3930
	for <linux-security-module@vger.kernel.org>; Mon, 28 Sep 2026 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615346; cv=none; b=jTkNMsFPANliESus9iRtMnWHDvrUabQ83cd6e4nh6aqXBghtbb/2q7igEXhnm5pELyj+nvV4yH1811w9CfTjzOHeFmxdwEOYKRkKXF2DZ3ROJxrb6nE8CFXWmQG+pUXtEskYEiE3FFQugqvD8BAvhgZrdIQfS/icG5NHBdBWziI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615346; c=relaxed/simple;
	bh=LH+w4S5tSyTwTN8XDWirsXxiUMNE50eyt7m8HB2NBL0=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eZkpXRaKHktNjqeGf16ZGsCUtfmkKawvdYDa9TPv6TB14FhvkLj5ErxzACXfdZqxjm9y/Uf4/fMndJOKOPtKyx3QNj9XPjQ/rCycG+wQYUyNe3uGcXBEG/9THQTVYuUfat3u3OaJHYgMOWiyBljRGHoPypCEgD4Tll2Hogg6ovI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpvHyIcz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpvHyIcz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B681F000FF
	for <linux-security-module@vger.kernel.org>; Mon, 28 Sep 2026 17:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790615345;
	bh=LH+w4S5tSyTwTN8XDWirsXxiUMNE50eyt7m8HB2NBL0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=SpvHyIcz+cL6K7TK7Mour/zJuzTHisP1BzTep0xU1u6F16R9Cwkd38iXhtDAJmwot
	 V+xO+Efiv8kNzbgVVRMxOl13H87kiHNYeA9gBTOIztjY/9ZKsyPCBo9Za1cfwxFkZ3
	 xNp8MaBduEZLxVnJZOPBhOj+tBGScWSOVPwX0FlqSo2The68oSp5aPVnCaJ9CmeNgS
	 Kzl4h8Z1lmoCtam0zXMv1GRS/hFSte8dwntTAuxtT1jNk8NYAeXniFsAAaAtCEvuZA
	 MdCMHyiCwruOfOIfVe1NkGyqipGdeZhNa9palYL4OVpAXmX3LOLTv5vf396L8B+c1T
	 23UjwFzDMJOYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] lsm: remove redundant NULL check in security_init()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260928170639.413560-1-ekffu200098@gmail.com>
References: <20260928170639.413560-1-ekffu200098@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:09:04 +0000
Message-Id: <20260928170905.28B681F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Since commit 5137e583ba26 ("lsm: cleanup the debug and console output
> in lsm_init.c"), the NULL check for lsm_order_legacy in security_init()
> has no effect.
>=20
> So remove the check.
>=20
> No functional change.
>=20
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928170639.4135=
60-1-ekffu200098@gmail.com?part=3D1

