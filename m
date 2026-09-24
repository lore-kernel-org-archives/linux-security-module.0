Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310F71FB1
	for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 06:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229705; cv=none; b=FQ1eLMfTOD9/8cLdUCkJHZ93vn6Yio7fN/ZDFf74+jP6fRgEJ4YUk0NfouyEjiaXuIVvt9gLYuTG985oSNgM8YsoW5rWhfxCSJGGW5wBs8qVVdaft4Nx4fWNYqheFT04sSI2jHmpjWJrR501Kx82+f4jgnvlf3XDf8lrbr1M+xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229705; c=relaxed/simple;
	bh=7Tei6Tt98Oh+I1OhtZXVEej6GEUexSGz9OyE1pPQJx0=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AhJeBMxJdOX/UsWX4qmLPiICsSmqyAB4MkW+TNnFBDuJTBGvwVk+m5ADNYjWbXkDOILQ1Ga7KiEnIeJqVaFZXLA73cqQXikhy/ekIA2wNaIxhUlxaA7K3YeFRbmmT7q97F/jN98M7ChnxZRXUJJqxmsmMv4dU7ap5zLR5Dm4988=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKEHOeKp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKEHOeKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73091F000FF
	for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 06:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790229703;
	bh=7Tei6Tt98Oh+I1OhtZXVEej6GEUexSGz9OyE1pPQJx0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=cKEHOeKpF8d65i/UI7m56jA/tr756h08J2LfJ58TPEt0OVp+6sZ0LYFsPCAyvVsFw
	 tzv0gc34O0VF5nUOo6NQ4CvcPZVhV/DsJMkdWEp18ZT1xWY9HO2NT2/vandCrCFj2o
	 uKZJRpCEj0XXPEMkzoWtDbhE5XkU3NXjY6OExq2pLpjSkCIvXJXHzlfP8Ch5soRZNZ
	 ZZCM1yGZ9Zq0S626T2Qyayxog1Bra2LAqwTDfJgoK80igo4nyxmfJnivW51i+KKpxz
	 0PswUck0/acpBupFNCxWnhwQHaETLcbSkDef2moCI6Kz5IeT6zrI5MaSus112QXtmd
	 9FzGxjtKXL5pw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] keys: Return user session keyring on lookup
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260924055521.1981957-2-jarkko@kernel.org>
References: <20260924055521.1981957-1-jarkko@kernel.org>
 <20260924055521.1981957-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:01:43 +0000
Message-Id: <20260924060143.A73091F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> A process without a session keyring looking up KEY_SPEC_SESSION_KEYRING
> without KEY_LOOKUP_CREATE mutates the credentials. This causes struct cre=
ds
> instances shared with other subsystems to become stale.
>=20
> Address this by returning the resolved user session keyring directly
> without installing it into credentials.
>=20
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924055521.1981=
957-1-jarkko@kernel.org?part=3D1

