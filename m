Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE6C4A2A76
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966973; cv=none; b=FFRqNkxsSFERBlv7Z9SOWNZav6ALrTCcF3L56G2wuxbEBZ/BjbCKJ0LGfggF6i/yfntsj7Gaz1BJ7//BbtvM1K8Jgc1PmMyjh6GAUjEnrhDYDxGdDIzaoEbrwFwutxNzLsZjZabsXyOWQj/BYkQgldUV3YPEw7Wt4A15GRdPk88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966973; c=relaxed/simple;
	bh=J25DxRNx2LKaSGGFhprDslY2E7ghUcgEQhHqcxebp7o=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OQZvjEo0VAfbypO27kR7ylwnWqTcAnXBI0istMmpJwrUAwrK9/jPFB6pQW02qeSTkM1Ud/H+rZiYc9vtHJAGhWZSKQ4rWHEdq9ae9UDgNgkgze50JocP9Z9U1IdF3w9QEksPlMMwnAq7LpNCuoDnnDuWa7ZNtca7zPAv3DNiC5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/kcbtMN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/kcbtMN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BB31F000FF
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791966971;
	bh=D0RQXzMNE4z2G3lYjv6gvB90ArzjXmQkoz9QUqWPAY0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Q/kcbtMNrfHLl0AxHxp+VcZAZnrVnbf6OCWETOup1S2DgMJ0rGEB1WblzEr20zMWG
	 FNaJxYf0atpXK3/lnJ9O64y5i8kGcYBQdZS83ScGsNetSCScgWmnC/KqYjnsf8vwSo
	 DJBFlYB+a+f51k3lE+5LQ6ZMZggV+c/LDR+KJLEBzhTLbVHIW5VliaKQaJb+bQvALx
	 xALXmsjV+SOKKNCLj1lapGcX0K4m31wscsQ4rCToYOoELPGtUzWZ0Kh8BWU3e/SIPe
	 fpwBsnK4A5s+shgMqNakHEjBlXLGuZinE+itdxq5GA0CRxLWZ8XNQj1BVyweb3SZtl
	 RgssxMl8fe88g==
Message-ID: <sashiko-outbox-171022@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/8] landlock: Enforce capability restrictions
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261014082718.1435842-5-mic@digikod.net>
References: <20261014082718.1435842-1-mic@digikod.net>
 <20261014082718.1435842-5-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 08:36:11 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Add Landlock enforcement for capability use via the LSM capable hook.
> This lets a sandboxed process restrict which Linux capabilities it can
> exercise, using LANDLOCK_PERMISSION_CAPABILITY_USE and per-capability
> rules.
>=20
> The check is a flat per-layer allowed-capabilities test, with no
> domain-ancestry bypass, no cross-namespace discriminant, and no
> dependency on the target user namespace.  These categorical denials
> return -EPERM, like the namespace permission introduced by the previous
> commit, and they mirror its per-capability allowed and quiet masks, so
> LANDLOCK_ADD_RULE_QUIET stays rejected for this rule type.  Successful
> capability rules and denials are traced as the previous commit
> describes.
>=20
> Enforce only at capability exercise time rather than modifying the
> [ ... ]
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014082718.1435=
842-1-mic@digikod.net?part=3D4

