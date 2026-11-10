Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344159;
	b=eWV2cpVHaLTgkFBML2B0LqwJWSF9kwT2iTkouWFKgKh/xEzC1y0ApA0foXv8bZ+McL+M
	 3L8WPoY2VC4vAYg5x8P1Sc+oVGuWbuKJZoVZZLMpFUqUzOhdpLuRCQ5lC86Y0ypR+yeTo
	 E1Ba+ojITf0VzM3zmpurJLc3WJY/tmCwDwpMeXYGJeZxwS7Gv7bja0IqDx5jydU2p1c5g
	 V04dB4oPkNUDEW11HS/tdLFtWpLhHjeW0y0WEhnYQpW1BUTGQQNvOZ2WNrqjA/NniIgzH
	 S3gpepeEYp3MA4PLxdn0r1AGprDL/V4vP+sq+Yz5Ga7Qb1XmhhlfFBtIq9XHIJozo2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344159;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XWeCqKaRYAkU48efvVd5flgmu3pnw2Inqv6lNBBQLRs=;
	b=dTp3SPNmzygCe5fbSscgQVHqeCy94HG9ZPhMyqxuV25oouBiS5LN7NObY1bjuh1u9b7x
	 Yw/c5k32aPWs4fH6z0M3Cosfq7cr1e6NwwbzV5ekktIb9BQYB6g/wRpOYzH/Jql8ZyS6I
	 vMdsym1nua871DgBqp3SVGVqZLBeE+yZu+bbxDPbJF/VDMsoVbLFGLgbar8i4xJ0zaUIf
	 Rk086zZAiHlbRUHd4kj0ahy2ZgzLbN5GmY+GpqIt0Z6EZwonQEv/tnP04xno9auC0rfQK
	 KMGtzhlPmS1yndGZTCHsxDoUP9eW59QOxHvXk5k4shVMO+xWGkZ4Y87PU53L48TM8xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYEB1W4c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750A9606A320
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYEB1W4c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754BE1F008A1
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344159;
	bh=XWeCqKaRYAkU48efvVd5flgmu3pnw2Inqv6lNBBQLRs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JYEB1W4cZqtgLNdlvjvBQrEXuUd5Zl1XgVb2dUfesOKRki9W1efn8g+PFTveqanc+
	 sMGouP7A0rwBSH4cpf293XmV4XcFmnw8eBoPmNxhOM2oTmrfbKffobgF9dclhWBlxP
	 VJ1Uxb4HMXN5AZIKhY1KT3g9SXwKRDxwriQ3S1eb59bi1fTJyeRkULug0l1ZzU7Ngu
	 vFvKM+wywtXDkPM1K5etWdoDQ+vCUEj9fTpnkCHJTI2o1AQn8nbcsUMOpfkNG4uLbQ
	 A4zfCQ4N4bixypcwnEe4lkG6QlRi59PbVi/DkUnQ1Im7hM1yoh+IJ7DZACjU27Xkd+
	 goQ1p8b+RAZcA==
Message-ID: <sashiko-outbox-207737@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] landlock: Fix capability restriction documentation
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110202436.2408244-7-mic@digikod.net>
References: <20261110202436.2408244-1-mic@digikod.net>
 <20261110202436.2408244-7-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 20:55:58 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Some documented claims about LANDLOCK_PERMISSION_CAPABILITY_USE do not
> hold for every capability check.  Remove them instead of listing their
> exceptions, and call it a permission instead of a hook.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110202436.2408=
244-1-mic@digikod.net?part=3D6

