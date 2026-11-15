Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794751549;
	b=RcR2OwtTtwt4Tik76rKv0YfnJl+pGlXlTMtdIyEP+PAwDLka0rOJ6OxvQS3kgciiiAgJ
	 vBleMHnbhQqR9Uo3J65GPW5KfCBv3bX0Mav1DTylSidI73q6FH0ew83OcNuVd58xfJL4J
	 N81PuvD3ZEypH/+lE6KXGaCbk6/gwuHElqYdDnSOY3ukoDScS1vlfESyZ3R72VurdTlNE
	 9BVUMZuTP0EgYcK8zPscmKnNRZohsOgGK+7hraIt+9ZUo6foL4+aBFTSxOoUMJxnd6IU0
	 fPDggIgFI4iujjGYlFmIj90kdXGJcAUvHhh1tOQDeFnmBe5DYUGQWueQzbpcX4grmuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794751549;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WPi44+DVWm3Ox82WEuRMB6k3Uda0ubLR7hxSPhzxaOo=;
	b=MFUyUZRAUH+eGCFcyNRiQiCxZyEeeBQ4g2O5snEG3IQWTEUUrlI2q5oRmdfHCCNB9Y0V
	 nFlu+Rp/5jAua1fZRB2b7bNAJlmcJEfR5PmKgp7G28wqe9HPayDBFhUjsRt3No42HcD4/
	 GreZUj2xclGPEealqW006qobeEIvFs5EKKxaqQzF3aojVrwqXfa5ejn6Xxlqy1esmDV+T
	 6iZhZB5ctiExiknK3FgWpk7XW+z7xXTvqGQB1tomPjTm90olvQcdhK+JmXu2Uqwre2rXf
	 zbwo/CrZ2upPtSNHhqK2+7ccL0SEf3hk+xBv3ZG1kSCfCe+dnP8tx4Dh/GSe9oOumcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SufBCCEO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260DB606A31A
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SufBCCEO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A38B1F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794751548;
	bh=WPi44+DVWm3Ox82WEuRMB6k3Uda0ubLR7hxSPhzxaOo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=SufBCCEOcwKF/qd3zHjV0cY518G5iCfrHvhA4WWzLaAvcajZF+ZcXzcEuj5AYmNt9
	 0ZftQgymenAl2gwlFd/UP/CMQrlTpR6XQBtOGMhVFuiq2hZUYfp4EdBfFL8VEwrAzp
	 0y80KmMjzreJ+truPiapci5J4SswZ1mFAo5MWd37SrY/3KGzygHdU2oMKxEGMRPKOR
	 ISx/Z1nRImr4dCgAr4NtwdABtIaCjPdalJj23urXwSjcYIzivaahpQFU/ZaJAppDsb
	 855l2eijqHv2X311Cz118BDRFlaxh/QHiZ2po15ZgL8Hq+WJTRy5pmU+kRJpeywyhj
	 LMXQ2xnoSbs/g==
Message-ID: <sashiko-outbox-215554@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/13] ima,evm: use d_real_metadata_inode()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261115-work-ovl-d_real-v1-7-ca155efbcb2e@kernel.org>
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
 <20261115-work-ovl-d_real-v1-7-ca155efbcb2e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 14:05:48 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> d_real() is about to be able to fail for D_REAL_DATA. D_REAL_METADATA
> never has to look anything up and can't fail. Make that explicit and
> switch the open-coded d_inode(d_real(..., D_REAL_METADATA)) in
> process_measurement() and evm_calc_hmac_or_hash() over to
> d_real_metadata_inode().
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-work-ovl-d=
_real-v1-0-ca155efbcb2e@kernel.org?part=3D7

