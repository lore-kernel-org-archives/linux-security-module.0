Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722AD4BE456
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470011; cv=none; b=YdqaVAlnKVNXnNjMA/A4P1+GSuD56naUeSscmTaQUu7KuOGP4LbJIUrKBkaIO6zXv20U/uvWI+89xzI8icAznCrgM6E90Xfz9p20SVltcpoKE/tiMu2B7QTCiOgbS2MkFNVOqzaGb9Qqs3jDyzzbcnkctBVoqv2/ZbrdWlParak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470011; c=relaxed/simple;
	bh=uid8VYBW6P2tHzci7+zUCGLqW7tGud//G7H9DcQal1c=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hmMSsJL7kY43KviPtDen61dFLF0f8rELChU5CsNCSsGSv+ucWeDX6BYWzaKpdEAtVy6gB8fy5qCq/b3j2M3jxdzThq7lGcV8jN1MLrSJSSu5+o2n6w/9pNQYur3Z6pj0HsTuDPguODI9AfNR0Fcx+oLlGxz7jFq4YaXulen04I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuZ4KRYm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuZ4KRYm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C101F00893
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470009;
	bh=ZrMAQ+cjVxTE1iIOA7GNdfWkIGe96+tMyiCN7lYl9Mo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YuZ4KRYmjjGGziDEZeRndCXJtnwv3Ka9FUayi0maUjVGDfoIuz4DZ5hWV/MKeoQnG
	 Tj/g18XYoJayA/NwaqHjDpthyOT9cJvKcZeoPfPrD1HDs1E/Cxwrcr+FcJQORtHo2h
	 uee46NekHT1mm3jxTbhLOE0BhTz+oFemWuDJ2Xz0hIVwxus0eC+w4OLEhi1SH2Nxwe
	 9/wOMGvfc7aQb896pLy/k6W/nRCqvvwicuolfgP31hHYsmvUEZK3zVidRFukJ3fCsc
	 uaDcUr5Mwx5GGm/cigl+dQaUFqZPg+SBIcJ92q0NHJ98MZlTWcGtIZP9YdaAeIeKYU
	 DDyewPkTc/U7w==
Message-ID: <sashiko-outbox-164293@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/27] selftests/landlock: Assert
 tracefs_extract_field() results that are used
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-11-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-11-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:33:28 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Several trace tests check tracefs_extract_field() with EXPECT_EQ() and
> then compare the extracted field.  If the extraction fails, the field
> buffer is left uninitialized and the following comparison reads it.
>=20
> Use ASSERT_EQ() for these calls, as the other trace tests already do.
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D9

