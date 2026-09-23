Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19503A75B8
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181780; cv=none; b=KBN+JFPmIHB/bkbaG1qaynclbIxfdV8hnYp3vTQGM8CEyEPQERdH0LffDKzqKuBMdvNMWlfWfS5pMOFldbZOhYkHQZGJDm+5BrP6lniMCP3KQQyka2SvZ8fJbjR7tn/1ISkBMepB8CObngeoAnMvPf8QvjPF1tJA05tkHHCMZJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181780; c=relaxed/simple;
	bh=lchjKWOXUyFSk0FctM2VDJokcQLCk0xqSFLciptsd3k=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PbQOqQXgJuWlBtWAN7SBh4Oft+FlCdnD6BjPCjlBNLoPeMXAEv6mwfou1ZYPCJYugvVBNI87I78zMw4lEp4a1KlE+sfgfY/yd29W6hcWJVcVnnxcsyMcuz8ydrJe5TaI9Pc+WbfGlxBPZXX8Tb3TXSS9lr6U0zaRLzNj4bmCK3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heEfTXfN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heEfTXfN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91E21F000FF
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 16:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790181760;
	bh=whmEkVftjH/ToeoJrxXnxpQt021UBIukKPEc1j9M19o=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=heEfTXfNVTWbpp5w/IVw9kz5InnGIE0V6vDeosPa/yQCL259MIEhDrOy7PwtwzOFI
	 5CYNcXu+Jyr+90JVUasDCew6B53h5lTKNFj9QBmYUEitd376adsUL4ZZlQybsF0t+e
	 PuTkSNDyj2W3koYCX/r7Hw1RfohUj4pLSIagEUcMV1IWYTAjnwc6aw0wmRaZZ36L70
	 4lSIP57U0o3G/o01AjyM6lNj0FVdUsya+n5M79aaugI4GzWZhK0aTo13voZLlBi9Ob
	 uWGp+yyhnCPAM0EnvxQ6B83JvsSFprR4u23m0YCaXFlEPa0RTJ7UyiTvzb0KPB9Zuf
	 OAsksxaVQILtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] selftests/landlock: cover TTY signal scoping
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260923163321.79770-3-clusk@northecho.dev>
References: <20260923163321.79770-1-clusk@northecho.dev>
 <20260923163321.79770-3-clusk@northecho.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:42:40 +0000
Message-Id: <20260923164240.B91E21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> LANDLOCK_SCOPE_SIGNAL blocks signaling an arbitrary out-of-domain process,
> but a PTY master retains signal delivery to its terminal foreground proce=
ss
> group.
>=20
> Add a test that enters a signal-scoped domain, checks that kill(SIGUSR1)
> is denied with EPERM, and checks that TIOCSIG(SIGTSTP) succeeds and reach=
es
> the target's signal handler.
>=20
> Tested the focused case in three QEMU boots and ran the complete Landlock
> selftest suite (12 programs, no failures).  Built all Landlock selftests
> with W=3D1.
>=20
> Link: https://lore.kernel.org/r/20260916152336.1589383-1-clusk@northecho.=
dev
> Suggested-by: G=C3=BCnther Noack <gnoack@google.com>
> Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Christopher Lusk <clusk@northecho.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923163321.7977=
0-1-clusk@northecho.dev?part=3D2

