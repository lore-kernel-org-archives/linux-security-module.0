Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6065D41D628
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791367853; cv=none; b=uucgqvF+glyMiVBbHSNP8DcverBAsBh2alQ6GkkFj7vi9mLWRXwSBUd6QmegGiVQaE7yOrgBusFbgcKkMkd36irprCmWpWz1PA+fBlWWKhvYAqIZRvDzpCpeE++dGYbU1fH9PQDp+0uJQZSyYUCi+1VGLX1u1hA8ZXKEdxqu9nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791367853; c=relaxed/simple;
	bh=5xF9uFXcTwnq1WFZqY6ve78claoggVVhMYKPyicsTLA=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GIORdSPSaMGPyXNeeaWC+6UiE8lmvyyaLb5aEfiEynLMzae9WpUBzbAhDfBOUiIFW1jiX6UCogf78EHuBvjrOVl3qpQLK7l7iBz/nSwFNINQboPovY8mDrwajACP/A4hqtT1tMMMZEJG2KbEMUcMSAvdELj9rZOM4WrOLlwX/1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHQfK4UQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHQfK4UQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846BE1F0089B
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 10:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791367842;
	bh=5xF9uFXcTwnq1WFZqY6ve78claoggVVhMYKPyicsTLA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=MHQfK4UQ9JAAeO25Ux7Be7ljPmZ135QucA0wJb23mEtnjD8lXIHJrvm7TVG8F8vw2
	 kRH4d/JyGglaomRZsPxj42FIv4a5QjBeP0l/FE0Wg+8s+C8L2WsXI09PR1O7ccRW2q
	 AZtV/CO4Ue7semltSi9no+vBEM164Nc9awmUAacUcTbrkaiTZHiJk8Rv96WRBCkosl
	 e3HtK0fZz2wexzkwr7iUovQxQfv2kmh17r1OrNySFmfkYXw8Br1hV0gjLo599spXKU
	 6tmcNYYwNQZtXHG96oFmWK1XULOIMNA9QmGTtrwY1FWmG8j+h1WPJaYe/YzizHl/Oe
	 nCn8oZfVtMFfQ==
Message-ID: <sashiko-outbox-162843@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/8] landlock: Add documentation for capability and
 namespace restrictions
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261007100255.1333386-9-mic@digikod.net>
References: <20261007100255.1333386-1-mic@digikod.net>
 <20261007100255.1333386-9-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 10:10:42 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007100255.1333=
386-1-mic@digikod.net?part=3D8

