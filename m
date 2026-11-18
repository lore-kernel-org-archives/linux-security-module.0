Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011469;
	b=2r5PMTOStsNsPY9fjBn6aY2pYuFzxlW3L9eLjb0WdaSGMR8cfdinIVkDs80nhnfKsDnz
	 p8VrEPpZnwWh8krl5biiVLYZ2J1EBswmoarMwedBfqM5slqQef6Agi3jcd+1kfTJit2Nl
	 nshy44yfDrfG462JPROfoT7IVqYghaOhEqEP4v0uIR0A4KPQQyqd/MBWzFqz1YTvG8eQV
	 csMa2dXS+gYRwcAvX52oQ6qPLqaSYLByVWuDkQIO4o3yDYrYSs0IGl9wAj1jHRISHpjvH
	 yskWvam6lrn+grqtTHxKbanMJvrYRn+9HhwyBYLBfcgGhJxGkwecF9cTlnk3QT4v4og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011469;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+ZRX1U/MCy0TNo1pqXA0Rv/Bu7jFSEyLEf+QOpj8s9E=;
	b=2ucBT/PKbBlnPLDLE6D+o4GhPLv4fasB1CU/jkpzex1QqaMr4tOsn1/tXG205yCqY/uK
	 zGCtKo4UW1TDXNAUjX079yIqHtTmyeT3HwjjqzyevxDlxXX25WwO5RsO79JPRoyUj7S4Q
	 nIorQFkSgj1PpyA99YHnFwAvzWK5PZGD52TYs2mv1V73DpuDtEeBDXudIqgYm0vw4Xe+W
	 jx3ajZmqAzrc2cDoGN8ga04+8xCsYJojwD0CuUwbq+m7OGbK1x3bZK6L18K2lIDG5mMT+
	 V77jazB9UEGQufrGaEs6MoHy4gvhPeLQHU519xGPzbohdCJCYzBrMYFGOnET8UCnNsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cyh4yABt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8580F606A338
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cyh4yABt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185831F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795011469;
	bh=+ZRX1U/MCy0TNo1pqXA0Rv/Bu7jFSEyLEf+QOpj8s9E=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Cyh4yABtcv7JxKxe6DZJVzsDIdzXSxAS4xN73zAZqA1LCBxRiis8C/M8cmuCuArOf
	 VdVT2gSSbY10K4q7ApQNZTCb96PhijNXO+QEHyxaRqFCII5VYi17E8lSEhy6eZ3DW/
	 wswx6cGOsoo6YExDfpQdV1k+UFz8WMLNj1NXiS2WzfTBQ4bOUn8p36AajUCJKCtLYS
	 cwhhP9VPoCoBJuoR1dc2mrgFJolGTvbNmoJsgIunOo6B4WR8iJ6lyVXNa8qm4hjT7I
	 pKIwZ6DeC5o3EwjtZM2kz/ppxzOCeqna58f34KECeZbCE0c4szZpwLHnt+Kkv5vECX
	 h89xOiTumCHVQ==
Message-ID: <sashiko-outbox-221180@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/9] KEYS: keycrypt: Add the engine tier
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261118140942.611715-1-giometti@enneenne.com>
References: <20261118140421.584086-1-giometti@enneenne.com>
 <20261118140942.611715-1-giometti@enneenne.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:17:48 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Some crypto engines hold a key so that the kernel never reads it once
> sealed, yet run whatever operation the kernel asks of it: the CAAM's
> black keys are of this kind. A key there is better kept than in
> kernel memory, but its use is no more checked than the kernel
> tier's.
>=20
> Add the engine tier, 15, between kernel and tee, for such backends:
> tier=3Dengine and min-tier=3Dengine choose them, accepted-min-tier=3Dengi=
ne
> and KEYCTL_CRYPT_OPEN's accepted_min_tier take them, and
> CONFIG_KEYCRYPT_SYSTEM_TIER_ENGINE makes it the system tier at boot.
> The core warns in the kernel log when a backend registers at it, since
> the protection its name may suggest stops short of the use of the key.
>=20
> No backend in the kernel declares this tier yet; the keycrypt CAAM
> backend proposed with it does.
>=20
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118140421.5840=
86-1-giometti@enneenne.com?part=3D6

