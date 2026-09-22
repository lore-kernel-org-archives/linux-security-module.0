Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195A5519B4;
	Tue, 22 Sep 2026 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083964; cv=none; b=MI/fXO22LqHra6pfh9SCIbuPmX0fFJHOTiUP4sSWwrlz5Qj9V/9nugZVBQbz0NfhdCgo4S1Ad7cFOHTGrjSvERj7lirgaqkIVnkCpcVHPUzY1r1YVflDm0lbTaR27LrULw0EKoUXhzTjdOyTj/dwWGHIEc8nyQwaIypEPyloBU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083964; c=relaxed/simple;
	bh=zECeUf+7aYFcSL1MTMvWT35bZSfVk3BhoABrnDR2N98=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vCl0SoHjY9ay2kFVYUhYG8taN/t+PHJJyxF4EWRY49upble7oOO1qGmNfxb80GKZZvImkKGDsaTC6YlKKzTph7c/RidOxad8z//IblKxpRNpsdbAWd2Ur9ZL8KKWMbmG9h3cCFeWudTw2Mzj6Iy4/6+tRlDwZPlJHDRlAfcAceg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWhtSVe7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWhtSVe7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2852C1F00893;
	Tue, 22 Sep 2026 13:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790083963;
	bh=l/HgF6yiQLsjKBuVjGNIOKQ0c7VQbdR7KKAP0GiBsLg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gWhtSVe7oFfJkKDAcN+Plln8oIJK9EaL2SJGJQyDMyHz7UQPHwopZq/fjdjZyRKDv
	 b+BHQLMR6MtzAz2VQzpksU3YalPJUvrNj/QoTLdwCRPTkIb7AEWsWZ7HZ9nFjohbtc
	 okRMCKxC17lskpyZkopniXt1hjQs0Q6spEIfc/rZR8bT9OfxN5HOFFgOiWwMz/FV1b
	 5iy/rxwgJbKN60Lp155zCQkevuj3I6iAudWJtr3t+aYSyYHxBDnW9UMrJGMYzoEe17
	 nSNz7FUOivNmNbkgIFIXb/2prf3LTSt7lHeIIawPO7/nDO7R44wAwOgQ3rFccMbcs8
	 Ob6CZ1VJtr1kQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] landlock: Widen ruleset versions to 64 bits
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260922132615.1025945-1-mic@digikod.net>
References: <20260922132615.1025945-1-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 13:32:42 +0000
Message-Id: <20260922133243.2852C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Tracepoint consumers use a ruleset ID and version to identify the
> successful landlock_add_rule(2) call prefix used to create a domain.
> LANDLOCK_MAX_NUM_RULES bounds distinct stored rules, not successful
> calls: re-adding already-present rights for an object or port succeeds
> without increasing num_rules.  Because every successful call increments
> the version, these calls can wrap the 32-bit counter and give different
> prefixes the same trace identity.
>=20
> Widen the counter and its trace fields to 64 bits so the counter cannot
> wrap in practice, while preserving the successful-call semantics.
> Saturating would alias all subsequent histories, while rejecting a call
> at the limit would change otherwise valid syscall behavior solely for
> trace metadata.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: 63747c94774d ("landlock: Add landlock_add_rule_fs and landlock_add=
_rule_net tracepoints")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922132615.1025=
945-1-mic@digikod.net?part=3D1

