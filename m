Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6952C44331B
	for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240763; cv=none; b=fOirlUqqQYg86ExK+nio8tNrRMdUfMhmbSMfCyin6YaXUCS/yHt2Kt/p/yTK7DbXVQvB8Uj2KA1Ogr97TkN5ki2dIMhmB7C7IAkXJAQjgru3ktCH4x+yA+MeXWEMUFf+WBuDgJXP8+hjs3MHJ5/E/Ze0w/naffo8wWFyQz+2Djg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240763; c=relaxed/simple;
	bh=Te2nMm8E3VdiHY9LcsGvS4d9vaUawKbgxEPxDhxJjhM=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lxKYatp8lsC8W4XCjeqgrnhMHcBWxBuFKg2fQKc883lImuTxMXzXkfAM9bjL28Fu/9rvNVhZQ78eIPg0Wo8pHbshBjP48XE8N9CcGIsc2UBidqIEjWZyY2UQTn9fePvI9DsWLl3/Zs1ljOdc3NpWCzrPJCTSqRh6j7mdWm7R/Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVTt/rzT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVTt/rzT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B221F000FF
	for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 09:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790240759;
	bh=Te2nMm8E3VdiHY9LcsGvS4d9vaUawKbgxEPxDhxJjhM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=oVTt/rzT//MYNmdC85XaQJROzKe3Ekryt+OAOQGvHUE9SnvxGtmuk/4aQEbz5ShPm
	 XQfY8Ba3DkWtxIfyZnLYp8EU0/2CMuHXE54HyM/9kLtv1KXPTtU92gvHthjII1Utf6
	 GmIZllhgJXrtNuxK9I5hywoATkjLo3JrliZnKHigXo38WS+Vd0YQH8osBYqvr9o20q
	 CU/2e8TPrUsDDI3R4cRcSHTwUxzHbe3WqDtIhv+FJ0WEPjVo2BTBXtTeJYstz+TdkN
	 aL+R33CNi1b/ViT2TQlcwp46cdK7pJ+ykWyL4j6QGjXSON27Yt96l2nRrpxocE8MIN
	 HRFWQ1z8Zwrlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ima: discard modsig on detached-data binding failure
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260924085516.3111521-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260924085516.3111521-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 09:05:58 +0000
Message-Id: <20260924090559.12B221F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> ima_collect_modsig() supplies the file contents to the parsed PKCS#7
> message as detached data. If the message already contains embedded data,
> pkcs7_supply_detached_data() returns -EINVAL, but IMA discards the error.
> ima_modsig_verify() subsequently verifies that embedded data instead of
> the file being appraised.
>=20
> Return binding errors and discard the modsig on failure, preserving
> ordinary hashing and security.ima appraisal. Keep digest export optional:
> ML-DSA and multiple-signer messages can still verify without it. Leave
> d-modsig empty when unavailable instead of dropping the measurement.
> Audit binding errors separately so O_DIRECT does not hide their cause.
>=20
> Fixes: 15588227e086 ("ima: Collect modsig")
> Assisted-by: LLM
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924085516.3111=
521-2-Jeremy.Jean@oss.cyber.gouv.fr?part=3D1

