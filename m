Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826884;
	b=CivvkR6B9BSorVC0+J0X6wG45cMbZzTZ3V3xmbkgERRAf5x9HlnS28IvxhrShFbH65ln
	 MGQeqga3eppjo3f0VlzceaLSvvkTlq2t1x7Xzc6UOkP/9PC/CoR8m3uiejhwbeBYiTmof
	 9PPEkDXRb3O0ve+d57Srv0N8vRGX/L1lVAxU0DEyHi2SHiWG39lDR70HscaSaPG7FIwWU
	 ZUc6KijrupST2oY9IJtEQZ7R+2dMO3+wrEDdThdsYcgZFch1kB6eUYp47zBO4dbuVsdTA
	 roxgYPohNrICplih1o34vndB2SUlY2TIoD31RzbFr5K+hSBQX+Qdzs6jaEetOkWniuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826884;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JfekNqhk53I2//dVobeJT8osniDrMXwPOZpTkEKOn+o=;
	b=cY9jAv3VmPIPY39ivZmEtAnfk6QaFJr3M9MevN2xXOeAcwqHeSyFZSSfErGyzYKqeAyM
	 SlH4IFlu63BpwcpqaetjmGo4fIf0wGJzPU5GmHDdimGsAdo/96ay6lKveoRar7QxZMh+M
	 HuxE55f48I36WepYbfGSDviIu7nTzg4Wmi9G3A/qffY2okTrcsbgVkBz/PBv5h2C/02CJ
	 d/rwfZkpYDgkZk41crpiNeHczmTgH75kluk7WaQYj03HZGsyJon3iG5LcjHl9BMUZwugk
	 8vTI48CR/kfIb/gPnjoVOlWpKMk2g0jeSm8+5G6dSIJkaABL9w1/9g6Pmgftwt+15ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MDmXw16L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06385607266E
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MDmXw16L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD5E1F0093A
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826883;
	bh=JfekNqhk53I2//dVobeJT8osniDrMXwPOZpTkEKOn+o=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=MDmXw16LWDE93xVo3MKQburPlAgKX/hyI7Hx83cR5FLUcryO1HonJRtJn9ioKySpY
	 +ljehRaivWvsBezrWfbXzS531WVCr5MPOhAxuC1npLaT8H1wHquiSuysk4EjXKv4UP
	 alpzuJjGY+NukLKO0rN3Q62+rNtz0IzXdtSK3xIuU1MxLqUmoI5iU0C+6qDUZWxvIH
	 /jirACiZxeqNmpwyQlu83bv/gm1AuoZPrG4t1MQ7Oc1AFFcbNNmcmMNmC0o0sPMWNP
	 +1D9Uz57HGPNbnWNE6VVvvOwzV6Yxsl8oSnGw9Pxq2YNJ56WX4eNUeAHD8/e/t1W2/
	 dsNKhvjHU7Zww==
Message-ID: <sashiko-outbox-198068@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/27] selftests/landlock: Check errno for combined
 VERSION and ERRATA flags
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-16-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-16-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:14:43 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The errata test checks that combining LANDLOCK_CREATE_RULESET_VERSION
> and LANDLOCK_CREATE_RULESET_ERRATA fails, but not the resulting errno,
> unlike the other checks in this test.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D16

