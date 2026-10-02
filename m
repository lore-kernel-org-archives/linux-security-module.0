Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEA346A5EE
	for <linux-security-module@vger.kernel.org>; Fri,  2 Oct 2026 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945946; cv=none; b=HbVw7uzJQducut4aolgV7bw/wIssWbD4lnImfWfHnA4Pgqlv/khCHN+yOUuomCtmvBC+kvs9/KFewV0UGGtgqUYvYj6hP/y8laLgkEtM6WrRBMBPNoyLQ7FPKEXp+4S4uvJVU3ouCM78c/ypEDVVsC3msLBVUz7fhWo34TpvahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945946; c=relaxed/simple;
	bh=mbJWrVs9ilJrDY6scC09hFGEtUiB81mHdFk9SWzMi7Y=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NBIKL3yC4QvtvRDrB1VbfLLp0CxHEF0CCEya5K8fhXALxALZNzNbe4o4xfHHIkD5pFjgovTFGDLRyCNk8YTmQzf5bE9A/w5/LWbxfaaF1P93NccM+WQqviVcSWbwkDv6sHeBtY2Zi1IvJSKNVvYeGzEgiwmePpbC6GRB3UmM7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgJ4a6tm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgJ4a6tm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4AC1F000FF
	for <linux-security-module@vger.kernel.org>; Fri,  2 Oct 2026 12:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790945945;
	bh=mbJWrVs9ilJrDY6scC09hFGEtUiB81mHdFk9SWzMi7Y=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=CgJ4a6tmh2HgJ4Y7GA3HdePA5tVwVCbP4BdT+k7jJAtrBF0AVbi/vypFi5FfBvmX/
	 o8fXqB3Zuxvg6PI4Qbw/dFD1yv854IhBB54MhYdZQ9ydrM/wiajyEjDS5vcHn3XFtY
	 sN3ufmqNb/GH63wX5ZBqc/tYm3C6WQO6050zHwYAS5MYOw4P1mTa3Jc2S69C4YkjPW
	 OM6mc6+Xhzz3d9iVf/hUMCQ7qRAgjQhv16F57+hMa0OSjsHjPml5VoRRGTWrO+tN0Y
	 9feandLh66RpcxewoJC2edFZkjITZw9T/FgfsublCgIV6Mi3PGJjHwHBCrtoDX6tsu
	 h/kGNGv8hzOOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/8] landlock: Add documentation for capability and
 namespace restrictions
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261002124409.1277970-9-mic@digikod.net>
References: <20261002124409.1277970-1-mic@digikod.net>
 <20261002124409.1277970-9-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 12:59:04 +0000
Message-Id: <20261002125905.7B4AC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Document the two new Landlock permission categories, introduced with ABI
> 12, in the userspace API guide, admin guide, trace-event guide, UAPI
> comments, and kernel security documentation.
>=20
> The kernel security documentation generalizes the existing per-object
> access-rights framing into three restriction models (handled_access_*,
> handled_permissions, scoped) and states criteria for choosing among
> them, so future permission or scope additions have a documented place to
> land.
>=20
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002124409.1277=
970-1-mic@digikod.net?part=3D8

