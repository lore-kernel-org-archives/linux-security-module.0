Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87172931CD
	for <linux-security-module@vger.kernel.org>; Thu,  1 Oct 2026 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790863509; cv=none; b=N+s472eDy9XOKSWetXb01J1/WTIy2K6OhBbdcRkOFavowi9KtsNCV1zqggqJ5znf7cH3VMpA1VX36VfzYFC2ByRbl0KRPbeq5x0z3JdRuxT/5R3Bin2QRBBgt+ed9ZaDZVnWr1RE09Z5gSxQvHmr7siKwjboKVQwkKjTYjB78z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790863509; c=relaxed/simple;
	bh=FWvwE4xZ3uMTticsc6hM72956QCpzQaVQ35iEteMdLM=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U62UB5pawmyKrma85wFHPY6g723gaLEfPJdDOQQMQZHy6b/CTfygH4ofhgzNVqh3gylQr5FPMXhJGqvk3dt0HnnDloIqw2FLVP92V60j5TZuHAcwdPPsESL+RGpMzJsIe7d+ltjR/SPnFMvsfPdfHBq7PaCT48CPAoahwFKecPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IN8JMMR9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IN8JMMR9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790B51F00899
	for <linux-security-module@vger.kernel.org>; Thu,  1 Oct 2026 14:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790863508;
	bh=FWvwE4xZ3uMTticsc6hM72956QCpzQaVQ35iEteMdLM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=IN8JMMR9i3o+UiGMME5peuJca3Ig03k9xN7yR4thshotBQzDv4aSNECV+A/RX8Ciu
	 LlgdcUxrt2G7VuGEvs8v+jtJ94UxmDr0+j9XYS/EDE2032nLEwVIIr+WPmxK7bQxRx
	 9KGDeh1I3kaaT1lhyEFxMM9gtbxSW+bKuFtuyKNrXtZ/2a7+m7+F8cKO4qubDf43XE
	 wWQkBTWTrxPojeLlB6JBjWxgo2Ox3lNWmMbeMGcvOB5/0FYZdX9Wi2N45o0ylCJ/tV
	 w0cI5KQ4kOdXakP6wVbswbP13YbBRdXxAd3pBEB4jG8vOZDZkc+uJmJAYZbSCKMNhF
	 VClatWNFzLfMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/16 net-next v3] netlabel: cipso: introduce
 CONFIG_CIPSO to decouple IPv4 dependency
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260930135334.4739-16-fmancera@suse.de>
References: <20260930135334.4739-1-fmancera@suse.de>
 <20260930135334.4739-16-fmancera@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 14:05:08 +0000
Message-Id: <20261001140508.790B51F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Currently, the Commercial IP Security Option (CIPSO) is unconditionally
> tied to CONFIG_NETLABEL. Because CIPSO is inherently an IPv4 protocol
> feature, this creates a transitive dependency where subsystems relying on
> NetLabel (such as Smack) are forced to depend on CONFIG_IPV4, even if
> the user only wants to utilize IPv6/CALIPSO.
>=20
> This patch introduces a new CONFIG_CIPSO boolean that is automatically
> enabled only when both NETLABEL and IPV4 are selected. It abstracts the
> CIPSO-specific Makefile targets, sysctls, and kernel APIs behind this
> new config.
>=20
> By safely stubbing out the CIPSO netlabel_kapi functions to return
> -ENOSYS when disabled, this allows NetLabel and Smack to be successfully
> built and used on IPv6-only kernels.
>=20
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930135334.4739=
-1-fmancera@suse.de?part=3D15

