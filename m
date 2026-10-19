Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7714DCB07
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419996; cv=none; b=SPY2OTxSsrxW0J0wZVd3pAaDVSJcxw0eL/H5KS6GsFFxPlK4WvPJSG5vP5lOcWbmW7PfAfi3mQ/1L8YC9RRadoFyoLOzfEzcs/eil5KytP8nyjp0c5Bv+XxsV/vpUkeiCRjQrngSgBX8EAhX9chdzNOakXqcpE2rOEUYaSKuwAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419996; c=relaxed/simple;
	bh=wDdY0S9if0PDNq1BQtAPOZpFJ5WB0485YTNUvOqvlOI=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QTKLjkwUivnTLEVHvS+9FF07KPOSI8MsEZOUTakW+EBK656SexknNY2dNMfFujmIjNM8pWi880mazQtBsXNufLT5UJPM+vDPPiRTstNj+o7fwOjLpgNcB1n5VVvVTG4Q/a+jtwWFcqhHQh+SM2twyFC9IOCgE20qNcrFb3jZgzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbUgqbjI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbUgqbjI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBE51F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 14:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792419995;
	bh=wDdY0S9if0PDNq1BQtAPOZpFJ5WB0485YTNUvOqvlOI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=RbUgqbjIUQN1qe8yAMTpmTROHfPNk5/193Pxa3FNDr7C7lkJ6QKbm+26MKwuIVq6q
	 5UrBrD4FMZDvFdjofuLQFOUCCSuIXH4LV6ZW/N89SBkuuSE5xexxWyI19sZ5iCXAM7
	 avOHp1CFl0kdJDC3ITBkobNlELsTGv8pqyJ4dlmt7bk40dAmvWceL4u68ahtjOj7g4
	 /DwrtMCOCrJDEJO5m6MhDqqKdAFiuBXDRmE6qFAwAnoHUpMasNJgLDJyDZuo0uVqnk
	 GpaZrk1rJylqNyELyA6t13oiM6LzeFTOtlhJdRyFvfKwaS3lDA9aRSVapopuccuzK2
	 2o3+uJZ+cA4hw==
Message-ID: <sashiko-outbox-177380@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.6] apparmor: fix auditing of mount binary
 data
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261019135441.1420968-147-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-147-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:26:34 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: John Johansen <john.johansen@canonical.com>
>=20
> [ Upstream commit b9f2181b90ec047488dcb4fb1c631d417aff07e0 ]
>=20
> AppArmor only mediates non-binary mount data, and should only
> audit the mount data if it is non-binary.
>=20
> Signed-off-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-147-sashal@kernel.org?part=3D1

