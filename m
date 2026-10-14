Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EFE3AD51C
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967393; cv=none; b=qCJIRBZ45xFuJDpB18tXH7lyGa2uXRz7vHu9eVN0HP3mCMT9Ndb8kv334CQg7l/sOQ2a+TeznEPjkzyp+vDB6ZMDz4DwOOmsP8FCIhHCrjLSvectavTHnGsFU7Bo/w+UQnY/DhsE9OU9yGy6lVd5311WEQ5MTVg2xCGbYA7GbGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967393; c=relaxed/simple;
	bh=ZqAHdDa8dyr+6c4aMWMc95GQS/rLXRYCjuxFJ+8wK94=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=jNXLlr4q6KNZuMfQZ9dOX1/KHIDonFSqN8oWHuO+cCV1rzM1+Jh+PGvYKZSWoJAEYl5zJxh051Jik8TIzYEjkEA/ysgE8g8czBatKzlgIHtA1rH0TiAZpxGnuimJDbou3R6KMnFkEB1msuc8lyUMPWj7+4U0hCapBkENhtuPlzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqddQA4M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqddQA4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03DF1F000FF
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791967392;
	bh=ZqAHdDa8dyr+6c4aMWMc95GQS/rLXRYCjuxFJ+8wK94=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=aqddQA4MqF+z3x5QYDp/FrksuGWaAWhU8Q2ZswXs+K9wXjo3mlbBU94xw9J0U+I+Z
	 uDHydpXMDTH3Qr2Y6ZlogdQXKTU0/5ufetDnpbQCG4rjT7gRABRYcl/X+9FZY+kJr5
	 ggddqSKB8YIKD0mmpZowGXqLPd2vfArWfegP3eKyuyNBQJLlLw9Y6oCXW6W2hwHYUq
	 VTzrwfSHd3Oqeu9vNOjkEyvQpRjv5BdedUR697toP0lpKdcPIoTucRygc/6FjPOYsr
	 2u3AQQ5dUCxgdjzZDmpkdIcKXrGaQuNW5SCRJDxcfRtrDJS3afQhS8ZHM59+oqZIy2
	 lBbRvlqlDLusw==
Message-ID: <sashiko-outbox-171033@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/8] landlock: Add documentation for capability and
 namespace restrictions
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261014082718.1435842-9-mic@digikod.net>
References: <20261014082718.1435842-1-mic@digikod.net>
 <20261014082718.1435842-9-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 08:43:11 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014082718.1435=
842-1-mic@digikod.net?part=3D8

