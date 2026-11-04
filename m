Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802488;
	b=WbKZTowJNbGz/15sNlYCbdCw3+tH0c0sVgrAao7LsVtdL77c6GjBxWoll3eFWBeKfVkX
	 sNxvprMB94VBqUNLl4zBUovx5tXAYrHoJakhRd0lMkB2DceVXOrTwtOxxXwTy0gl1dnLe
	 TlseWVNLmxEd+8uJtrxaOlXhiK8MVzHvP5uF3fn1Bi73dS8J4BsAZFHnd9x/BNzXBUFC/
	 MN5taJlpAYoiIe5t2mfLkiGSY1b9uw372jqhLnzwD6GMpkRap2rvQYe6POENPBgNP3yZV
	 cibhjvxnuYyTfamWDxFV//GfBQU4dfLps3OQu4mD3jJRCxKoB+B12PRJYgklFPXW8ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802488;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sJPpFu092lfH0xBoBg9xVSD7qIH2dK6htUWfNLYu8uo=;
	b=yY2I+MDJF/J6SAzsScRmaXlXMi+nOe4h5EHoQcqVGDd90+dOENTNYW0xXQqL19buaJRS
	 U4gxWW6j1WnbvaEEBOhfS8SepCQI3eQvyksFkuMgUr+F7drjDZnjQlnm7M7YvOhE7QAlM
	 12ms7nWTaS6vd6ZDW8ueblysxxZqXaU/Ya2trEUx5OkeMJzztMH9HUwgSlkD6RJjp1q/l
	 Y4K7vBfqSlDtCLjS8nco7ENpuoudFBLE127THCK++mH7C2gM/klEEq08L1A/f8G0hChjg
	 rX1bs0fN1E65nPm0US3K77XUL/9blIxZDkCR25Q/2Dx7JvYf+6eLF9M7V2VhGuOWq+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8NnKk+Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3807606A326
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8NnKk+Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53D51F000C1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793802487;
	bh=sJPpFu092lfH0xBoBg9xVSD7qIH2dK6htUWfNLYu8uo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=P8NnKk+QiqbZQXWnbAJU3Nhhnvsag7MT35xRfatgO9K7Uv0YQNIwjbGTIHzfEdPjv
	 gMb3q22WQJUDq5kfAHxv9hy44MjJ8F9I7fpz1dQMmyVVEP9y6tj1RJxP4siZejsoHl
	 kh8zZeK6vW9z1RlcaWvO2dklqo9HekNsrp+s53gQdiC+T1gO158fE21xN+aAYLNOvr
	 3SYk+3BsjN58eqI2lpapakAaHvcse+kDSnxFhZ4maymI9nQ8QlFMBpQpkJtZ6xo5kK
	 idKPI+PSY1jhWd52Tu+DVxbhX7nFrWWCFn+1CIw63MQQ87SgRTlBvD/MIqaORwNbly
	 wFQFoNU2fIyuw==
Message-ID: <sashiko-outbox-197433@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/13] sys: use cred_ids_allow_control() for
 prlimit()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-b4-cred-ids-v2-8-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
 <20261104-b4-cred-ids-v2-8-956213608f16@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:28:07 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> check_prlimit_permission() wants the real uid and gid of the caller to be
> all three of the uids and gids of the target. Use the library.
>=20
> No functional change.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-b4-cred-id=
s-v2-0-956213608f16@toxicpanda.com?part=3D8

