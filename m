Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B561D63E4
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790996210; cv=none; b=NuGhuYXrdQMF0HroRAN7T4sEACMXQpcswfsbUv1zTZwzFthyAQjW1kkRh7cR+MKnjtiWSFVdBEcnOVfs08Kx2/tA+WpzoXPcMwenEC+VFRJgKyulvoLm42+M5K4ZT/066rG9U/azdPkCR4sWfP2ORqGpLqtHIkFY9qXq4OHzwhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790996210; c=relaxed/simple;
	bh=ee6ju9AXqDaW3u7M7LHlOj/NQgp1IFpLtQPoM2T5B64=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GiNkUnA9vN9LS7D206wJ2JMrkXpTzlFR8GlGxm0OXdyf7sWG9Av23XuntwdLSU/7ON4l3Np+esS4jzyroJMTubA3HNkvf2oBUC/b0Y2SgxFgxGeVP2+axFrLIxMToHhy3ibBQUr+6yjR4PdAB0oACusGYUpp+6wWxpElnNtynmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sfj6+fe3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sfj6+fe3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B34B1F000FF
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790996209;
	bh=ee6ju9AXqDaW3u7M7LHlOj/NQgp1IFpLtQPoM2T5B64=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Sfj6+fe3r/dMPH3TWiHKBWo3IJD5TGD9y6YstZJEm03LO+Kpxt0sals97luSOjqs6
	 Pgh+LyHh4VvIolgzRkiblAT8pkOojcRlD9Qx7PaNkoshtXmoHf/7ZaSlIizxRuNirC
	 2Ww6DdmXmZft7fDtJaifMsjimKlmvDn+Jtm5monL6Fu7zJRrn9HF8jGjRqCZDLYkSa
	 tYwkWmzBCE+9n4jXOkHZkAaVU5EBa1y7/pw/bPSzWUXgPtiFKk4QwrzkpZFFo4zvWO
	 OIFXzt68xYX67r/BMwDYw/43jj7njjeQcXr1bVHTBYbGK8miMLsOkMzvW1k5ydo5Pr
	 TvQ/aDsYL1wCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] ipe: check parser token table sizes
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261003025135.3666767-4-wufan@kernel.org>
References: <20261003025135.3666767-1-wufan@kernel.org>
 <20261003025135.3666767-4-wufan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 02:56:48 +0000
Message-Id: <20261003025649.4B34B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The parser token tables contain one entry for each enum value followed
> by a terminator. Add static assertions so adding an enum value without a
> corresponding token fails the build.
>=20
> Assisted-by: LLM
> Signed-off-by: Fan Wu <wufan@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003025135.3666=
767-1-wufan@kernel.org?part=3D3

