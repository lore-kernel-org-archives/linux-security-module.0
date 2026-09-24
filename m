Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2016E4A3847
	for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790282418; cv=none; b=Akgb9WMGNd7eXoK3WHGR3rv3ci5mX5QVxqiJCUw09VwOvlqFuuvHDSiR94G3KIPZ9k0XBIFHFUHFbrBBAU4jMXf7j5z6gDXPQxlZxFc3YCEOnvbk2wQwqY+6owQltUONya8x9SlfU0BE6Pyz3QlY0r1uVfdQ8FabA2alOW/jkLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790282418; c=relaxed/simple;
	bh=zKifT/BoFUpsMDBK8+2Cxx4rgix70VsfYTwnVZfRL5Y=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PbUAwwb3YCM9UiuhcLInLFYxejUVStReFGyebpWZg2pJXtUjFri85ULGI/+uVVGG1g5hjPkNmumS98FHXgr1ouiwsalpKX6JWO2/dAb0PwWB2Swfxml3z5CowNdnegATvYPfGgA6GqG1h8SpLRGZ04AbiGyZw4yt12kpostWsP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6lIoP/Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6lIoP/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42D01F000FF
	for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 20:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790282416;
	bh=zKifT/BoFUpsMDBK8+2Cxx4rgix70VsfYTwnVZfRL5Y=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=m6lIoP/Y8TjQFlV+AwoKd2FN3Rm3av3bsUFvTGA5ReyrbPEPZkUUHwoPvwaneJuh9
	 RJryuMbUUb3UbvFqtbWS7afPDcQ0xVGrHwfLMV+n+Qh3QhuNuRxN8Am6nfumWR6PQM
	 Uhm8uOhVEh8xz120VLcQMGO0w2YfAqyQ4I9wwx6fj4D5R86sDWKR8EevWE64OcblfS
	 wBGndNvuE6xOZu+4cmJ6TKpa1bRVU5YroQscrGUenVXfgzwve03X1jizxDY0uBt00/
	 7sKWTDZmfqRnWrDaI22Jh98SrXSyR4FtjC06bweZiTzraaLeg+H1V3n0UqmprdhL4S
	 n2KwYGNBvBNug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] integrity: Report error code in
 integrity_audit_msg() call sites
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260924-report-hash-error-v4-1-196ca6350619@cloudflare.com>
References: <20260924-report-hash-error-v4-0-196ca6350619@cloudflare.com>
 <20260924-report-hash-error-v4-1-196ca6350619@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 20:40:16 +0000
Message-Id: <20260924204016.B42D01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> integrity_audit_msg() hides error codes by wrapping
> integrity_audit_message() which obfuscates the underlying reason for the
> failure.
>=20
> Update integrity_audit_msg() to take a errno argument, and pass that
> through to integrity_audit_message(). Then update call sites to
> take caller's respective error codes.
>=20
> ima_appraise_measurement() stores xattr_len as the return code, but
> can replace it with a error code later. Therefore conditionally use
> a code if rc < 0, otherwise report zero. Lastly, conditionally use
> -EINVAL for ima_release_policy().
>=20
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-report-has=
h-error-v4-0-196ca6350619@cloudflare.com?part=3D1

