Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795766733;
	b=l8pd/XoPtn0lG6iQPSZKOnOmZXJ/Hdm7XxjaKonsZRt89WNG5F0mPhKf8r6WTZOPeE/I
	 F95/KPv7XyDJRQjFl3HN63mbS18qmWkYyohjIJahcbRTkD1XZcENoHUX4CGWHE6mfdM7/
	 2VZBNGAPFkxPmBR35umkld8sgew3bSfxM/yK3j8D3yYRvYWQJjRBcJbMxqrg0VxzwmldZ
	 p7KBjzW3bKULtZ2BrMIGuGcW1cHmd5W7JneBL5TO/Q4g3KMDtgSAOnd0Y+N09GcexkDVb
	 KIQhWeTC2c/m0Iw+TI7yrhX4SEvr21Jg7vDMYqiCf48vLF7t3/dIKkb3F8HUb3d7ryw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766733;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w8chAV23OP8ImZeB/ixVto7EvFpsOsFneavxj8XR2uI=;
	b=s6bPLVd/eZTcmXyxliti/iZZDr3BmOyDeB0R0eTClrUFg/YpSKVd3c5HmjzWq8lN+Bmg
	 jZgflx6gTUKmS/Yn7tA8gC0Iqdv24fPjFPun0vcB0m21xMmkM7cvHCrllhqNnfKkZ/ToL
	 h6Xe6EBn7cDPehwvTvwfGPmLhSfYP4v1mHaf0Z80bLICk1u8JFPYGviFbObm3KwbtKrY8
	 gQzaeAVKPW62PyI63gjfE35YZDA4+AoTpXS3D2taJ8AOB/JIIrCCYnzRsjPwI+wgK7Yip
	 7PMJ4GKcaL3GTWajnRxlaHxIpUimcgM6MBf5Eyo40ix4X87Y5l+nhIE8H3SlU5pOPrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fm42teNp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C38606A31C
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fm42teNp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497541F000C1
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 08:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795766733;
	bh=w8chAV23OP8ImZeB/ixVto7EvFpsOsFneavxj8XR2uI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Fm42teNpCm1Rj3i8o3/6vlhINNQhqm17KGgR6t/jPY0lkSImTJcWUtBcA81KhC5+P
	 uoqZs2CQS8zt/Y2kPptjvoVOIU6cPlh+gKypmtjIo6A11dppPQdx2c4QCHPC9hoO46
	 ADiIdp1qT4ftes4YJfhiI1JJQKWgieUSPbOWg0eHxGop3qkIix08sbKcZpzOYl2JV9
	 8ZCcbvXZnzQ+/8PV6j41KTYuBfzC8ldDieVAneJocRvgNBxVHoUaEpvaj6C9NkbYpk
	 kDHJVnDiG39U5ynNdM/y31p8Y0RdWZxLs7G9l7LVwPZRZxV+os4KI/6smmDlyrR8lY
	 cYLZAi1J58zWQ==
Message-ID: <sashiko-outbox-236856@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] apparmor: return 0 from unpack_tag_headers() on success
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261127080132.266236-1-congnt264@gmail.com>
References: <20261127080132.266236-1-congnt264@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 08:05:32 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> unpack_tag_headers() returns int, where 0 means success and a negative
> errno means failure, like unpack_strs_table() and unpack_tagsets() which
> unpack_tags() calls next to it. On success it returns true, which is 1.
>=20
> unpack_tags() tests the result with "if (error)", so a successfully
> unpacked "hdrs" array is treated as a failure: unpack_tags() destroys the
> tags, rewinds e->pos and returns 1. Its caller, unpack_pdb(), only checks
> for "< 0", so it continues without the tags.
>=20
> Return 0 on success.
>=20
> Fixes: 3d28e2397af7 ("apparmor: add support loading per permission taggin=
g")
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127080132.2662=
36-1-congnt264@gmail.com?part=3D1
