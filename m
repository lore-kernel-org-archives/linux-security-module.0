Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826729;
	b=AzE53dqZjjyi8xzlsIJSHm84WudvKZxq5Xp8uVIraFuGoaN8GGEMOUeprJlTMw1XB1u+
	 Uy+ZnF/HY39T1yTUFAfwA6PeW1b0PUA/tRdQ9rjoTRZ9Z+4gPEzZ333yMf5U4YMazy2nj
	 45JaraxZU+QaGj+zNlaQuFOBdEZr4LncqgzJntK+bWmIQ9nVwEW3FAcklkkYWm0EDmPkc
	 UUc4nkvP/wJfgMYOA6Bvyv8jvXZyzhiI/axKl7+6OugGtFmvxmmfvduEdYrFhkSbOcAf8
	 3VkLuPqA2AHtseOJGHLV1Bq96lmBfuE8tXWZOlV/j0zJMHgdCWnyyrXcLXbQdicuEWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826729;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EpW/TAsKyadedmEjmhk7NBzKbdVyTfI4A6MF+CtLjpk=;
	b=yTWl4nFNkKzmyBjcBttCPJhH+igbQQ2OYixD3HoloVIp0Y5XTl4dlIowZ807LQd6impX
	 dUfzYkbpCTEymYUVK/lK5vxmF0k8u2b4X21nX024gAqcl4bIqi4pOjTNfKmzrBuLl7VGL
	 xZwLdTjoYOsS/K3gV8lnaOExH5GDpDKXskQUOXzEinMTFZb08I++WE41CxMv1maokJ9Ml
	 v1Qdwg0xBhFVDrXyONr1yZ84mOQP1CpatQk+YZ5erjFH3qjbhOEkv3gvzjvdT/7lcfa/K
	 O4iEskP6PMVpuIQb4k1zrH/lvmtoY6uFjU95CM+GRPlbYP92y1/XUpl4DtpyZxjlHKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESZrnA2x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D5C606D81F
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESZrnA2x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B141F00919
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826729;
	bh=EpW/TAsKyadedmEjmhk7NBzKbdVyTfI4A6MF+CtLjpk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ESZrnA2xd79xXe08Xj0KYwIG+Ryh7xMVR4A0bBSmK8PP4dTVh25ultjM2ia+UsWKn
	 ZbyfDp97+gfZmivIdMvng8pUWtGnuNDeiUrUg2qnMhknfCWudcWoQxcUVd6E/NDIdh
	 595155xmXhG4XmwJExLBo9o+RqdFAhN83hNbfSOPwJQBv+PDII1ntrIinaQNVRvmm/
	 OSPLZMAKL08WYmPD6oOLAId9qarRZRfrwwlXq00lZWiC5wstV1X7DcSSdy5bOQf8Ep
	 9VHuF0wOEUZcdrjSsTP5JxYYyCSAZPdO+zUucdCEAF6VM9w4pTwxa5E1GswfB/mOoQ
	 o0uBylpk2vg8g==
Message-ID: <sashiko-outbox-198053@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/27] selftests/landlock: Check the thread result in
 audit.thread
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-3-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-3-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:12:08 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> thread_audit_test() reports failures through its return value, but
> audit.thread joins the thread with a NULL result pointer, so these
> failures go unnoticed.
>=20
> Check the returned value, as the other thread-based audit tests do.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D3

