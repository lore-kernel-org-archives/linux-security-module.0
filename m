Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBC13921FB
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792262575; cv=none; b=LEanJIGjCmsPYBlMFiNRtpzzE27TEuSfCWJhomu2v+fUlZrOetB1qa3sUSuW4RxWWRmOYqR3DLjBzh/faxL1XP5KwETWNAx5vHcfxeK/TV8JmnGq1zjZ1SCepV9Vj5b6oN9lnECyF6QjLtzRWIu3+/gQlMvaXw4YC9D0n1DC1PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792262575; c=relaxed/simple;
	bh=2U61zovP6vD/BfqH8Ef88O97oABXC3MWwossWTgqGUA=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=kkjBFJzfVyHfZfak8LGWX6b1fuZmjV2sOrrFK5nzhAta06rX3ny+MR3DHLqlmsCc0r5egjOrHYiF0XVSz/REiaXfn673iL/P2PIWcox6oPJVtQssHJdyRRCxMN4xz7s9V8PI0Ou+V6VxQY0tNKuk+jdrXzOl9AiKXtqGtOuIEx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwuUb5im; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwuUb5im"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8691B1F000C5
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 18:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792262574;
	bh=2U61zovP6vD/BfqH8Ef88O97oABXC3MWwossWTgqGUA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hwuUb5im1McbRKslpH1Vgl4fHrgMSDTj097xDBbBc3f03eDuLWE1YA6D4CgtIxGiU
	 ZzJoCKr1WTr4VUWAbe5LBdlnwwXswCCuo/k1F2LzSnzfZCoh69FEegselOM1qqiKK4
	 9WyFxBgBq6rFsrskl78A/OCa6Ke4DpOHmFXB/Z5rT3VtlAGGb0HNeQuoib3W5efydH
	 M+KaGbrQhugojkglyJv5n5AWTxWGRo01BI+iYyxAwK5f+Tbb8nc/bya6F8yDpk5EOo
	 XcNxdrGJLU2QqPonYh+8kw3wi7Nc3nV6VNLB6eH1VSn76sU6ZYmCmSpd6E2Kob07NO
	 VAMAW5Hfu8hjw==
Message-ID: <sashiko-outbox-175744@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/9] pseries/plpks: fix double conversion of wrapping
 key flush errors
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261017183853.596052-3-ssrish@linux.ibm.com>
References: <20261017183853.596052-1-ssrish@linux.ibm.com>
 <20261017183853.596052-3-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 18:42:54 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> plpks_confirm_object_flushed() returns zero or a negative Linux errno.
> However, plpks_gen_wrapping_key() passes this return value through
> pseries_status_to_err(), which treats it as a raw hypervisor status and
> converts it again.
>=20
> Convert only errors returned by H_PKS_GEN_KEY, and propagate errors from
> plpks_confirm_object_flushed() unchanged.
>=20
> Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping =
Module")
> Cc: stable@vger.kernel.org # 7.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017183853.5960=
52-1-ssrish@linux.ibm.com?part=3D2

