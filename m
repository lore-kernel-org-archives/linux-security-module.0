Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D3C41441F
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967398; cv=none; b=g/UXOqx9PdrZk/M0Gp8MF1wWfN7Dbqb0mCD4fpPaTsdAjE3OLV4CXztiIf2kUhPAFXQ64IJfyYv+tAnSLcmpxOtfKsc+d02YyzQp6BqcRkAsfRDF+a/pa22fSiDXSHrcGixDLKRtfJZX21U7X7RpEVRS8JX+1Zd0OSFboBV6+ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967398; c=relaxed/simple;
	bh=9yYTXVX1+D/r+95zivB9lfrCBq0JmoVx6NMo3HlicTI=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GvUV3ekOqxUecF+xV2YVzANUKggtMWy89S7O0Dgvzyq1Ut9JliqnOK48UbqbsshbtnHT3UiWXujTLJeAUpvtNmR0ZE1kpGpv7/xP56URC3vQB17eA0UgHQ1k2rAFmv79zqcYBbk9bTCme0AZ+vKOHUMVYF8N6+WimIIP6VzLjdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCzWAjlf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCzWAjlf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800E91F000FF
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791967397;
	bh=tephdFB4VVL41dAjUyFDThIUfnkTX+InmJGEpkBaWq0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=OCzWAjlfYwjKj+L1L3DY7KH0u/vDlUmJL+U1/x6Kbb/B0ABYESTjQf4tKos3wT9h7
	 F8OBFL2Ub8jzOEvMpKgcAtexteNkKPDuOct1nwVpXZwBPId2YptY3dLOhY6iuf0TN5
	 NiUDHIfdYwdsgU4r0EwVKOAYw0SVkuF1cDBMlLybMgVhTvhIge+HUut/NFWh4VrOjL
	 M57FGI3swtXyhMVIvEVvFdK/Hv7qO3vjZMTExsfXUgnQLL4DUQYxeP6SaOyNPtRxWN
	 SrwN5vH+1lsytN3wFLtSbNiyWie24IHtSv06C1jKVpetDn4Pc9l3DltdGVc7Gjx0wi
	 G2Q5/IBYNSY2g==
Message-ID: <sashiko-outbox-171034@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/8] selftests/landlock: Add capability restriction
 tests
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261014082718.1435842-7-mic@digikod.net>
References: <20261014082718.1435842-1-mic@digikod.net>
 <20261014082718.1435842-7-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 08:43:17 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Add tests to exercise LANDLOCK_PERMISSION_CAPABILITY_USE enforcement.  A
> sandboxed process is denied a handled capability when no rule grants it,
> and an explicit rule restores it.  Unknown capability values above
> CAP_LAST_CAP are accepted at rule-add time yet have no runtime effect,
> because deny-by-default still applies once the domain is enforced.
> Stacking tests cover the per-layer allow/deny combinations, including a
> layer that does not handle the permission, and invalid rule attributes
> return the expected errors.
>=20
> Three tests exercise non-standard capability contexts: enforcing a
> domain via CAP_SYS_ADMIN authorization without no_new_privs, restricting
> capabilities gained through the kernel's user namespace ownership bypass
> (cap_capable_helper), and checking CAP_SYS_ADMIN against a descendant
> user namespace, with an unsandboxed positive control, to confirm the
> decision is independent of the target.
>=20
> Audit tests verify denied and allowed capabilities, per-member quiet
> interactions, and CAP_OPT_NOAUDIT suppression.  Trace tests cover
> accepted, rejected, and no-op rule adds, and normal, quiet, and
> CAP_OPT_NOAUDIT denials.
>=20
> Test coverage for security/landlock is 91.8% of 2864 lines according to
> LLVM 22.
>=20
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014082718.1435=
842-1-mic@digikod.net?part=3D6

