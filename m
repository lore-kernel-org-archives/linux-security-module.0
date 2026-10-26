Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011443;
	b=fxI3NeT5QkMlCZKr5iXRtWjvqwWtk90l+nwFG8jp4YyiG12UP+TspkICmXlrTJ6Hw8j6
	 /Lx3lHAedOLmeVRvUuqRSBTG8rQ08yYBR8NFU3Cawg3diD1LOYxChwB4V5cOiHjiOkXFo
	 jKKr+Ffwbk9NxFFJj38nwrXwG/i2NBK86+SgJiDv3rrYaf14eyixp615xrV+2UWG47kmD
	 GTwSeK4cP8Oi6+1Ny1PKfz8350f0wcFeUV1Q3XjS9d8Kvi+m8m8RyHe2SGaKV/DFwFdkK
	 pPL3TY5OZqwTe9S1zDRdI7NCoE+oMbwdV1Vk5Fshs0/8P7IYtI3XvFGKeHvlNqmJNkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011443;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iXoFal3ZhbDc19tYy99snNffzCuYVRhViGh0Cv2UqL0=;
	b=v3GvlUtIi2bcQQHsVIvSFd0ZCti0qONK+IF8LusHYCjv7VymsexsSZYnFSaNRznelgOe
	 p4Adg25cRPx1/fkPVDvJqFWOrFBZdKD+pjG83CtGP3tevYcDCoSJhlMALNkWlT0Uaj4Ae
	 Q9KBVclYtQzGraG8r+sQOCDcBLfbq8dnFOiy50jm1hJJawRQ3m/hJuig3wTQHRaR995Oi
	 ECpU7v4ZYIICDeESumcNAQP3jGYZSp7yBe0JxVk/lBenqRMbYfX3tYPnKh59m6Jl/7qCg
	 tn0+Ng3Ep6tBgbHkxD2ZZQVaC/v4qVAD6q2Ip/sI2c6DoV6wNeH7H09PFLmB3k00ulg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4RGZdQB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13472606A31E
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4RGZdQB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993031F01825
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 10:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793011442;
	bh=iXoFal3ZhbDc19tYy99snNffzCuYVRhViGh0Cv2UqL0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=a4RGZdQB0B6967ILtHQZiU45Pukn3EaL3OVKkzi5Id/M9TITqJOIzfS7iFqt55SIH
	 yvXA27mQ149xdLjYcmqvIH9FdDecHodBEePciBBxUiTnMXKzGA7SSyIoQngQyNXtKs
	 WoxQp8RiZ+uVE8zQ/xlee0MQA4NBT6N+GXeF5pquC3zotFcJzphELKDzMHec7L6q5d
	 fIYAOpckKkk+H9U/NFrRvfqmTbiS/eBh2IRb0yunFyILORqrSInzd/vJ3tF3CEBqO3
	 ETFve4Wb1APTPgbvlWaUk/CmUJNz4e8YESTJWceefA3L+4ovHVASTh44C2/2+qWZbq
	 kvHhlt3YZSjDQ==
Message-ID: <sashiko-outbox-185000@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] selftests/bpf: add verifier tests for the namespace
 LSM hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261026-work-security-namespace_free-v1-3-ffa3ebbf71bd@kernel.org>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
 <20261026-work-security-namespace_free-v1-3-ffa3ebbf71bd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:44:02 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Add a test kfunc that takes a trusted struct ns_common and check that:
>=20
> - namespace_init and namespace_free arguments can't be passed to it
>=20
> - namespace_install arguments can
>=20
> The test fails if namespace_init and namespace_free are treated as
> trusted.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-work-secur=
ity-namespace_free-v1-0-ffa3ebbf71bd@kernel.org?part=3D3

