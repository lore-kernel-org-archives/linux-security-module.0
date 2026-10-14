Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BA03AD51C
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967179; cv=none; b=uZaiImDoDISoxCWAAxm18Y17H1t/5Zd4bI5OtVwUCtEIg8cBKpgcK490LeiVxNOnil0jIzE8m3cKgZ4NibFSrJn5rsE8hsW+Yp87yJTosBPqUzLVYedFuh5rOYV/JPF4/RUe3sDlCIJ8u6h1TOPzdnai/mnpTsdG5tPChuDfJjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967179; c=relaxed/simple;
	bh=PXXCNgj5eCQ4FpqVoAdW4Y8KC2+jwpuVFKAs7CVeK68=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=JKDLkHEUGQ4O6TlxiFJMM2kVUmJbsj86XWezMCzc8Wu5tTVjYW5MK4/eiVMOsxzHQ2O4gOtsXvVYHBrkG8Wzc6w2CY9v7IKeYj2YR742GIIIeka5hesdEPLn2pLfo1R8ynXk0zjNEwhj+uqtudWEldodzi8WpTmJsEkRAlUNryA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lp7yXam2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lp7yXam2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BC61F00893
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791967177;
	bh=9tMF0+0wV2B9M8RKsi/1CnzJ9FJL5XpTA4eT3GMC2m4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Lp7yXam2tcR/7qbVFfRaK4Eks7nWxfjfR9by5rdr+nUsIQsetx57b2iF1bjugl9C9
	 0DO0A9oFopxkdaJ3+DIuIHeIXefdAoRVt/R1HZLWlbvXU2RAqcAKjGZXmLxqGI/bSz
	 inSuVuDxeN1HvvlW6DTB6PsspPd6khM3dO20sFw0bmDX/JDxUJU1PtuJt5CeZVtd+p
	 VUqbw9rfz3m+Ew7IdbMwQkS9NqwnFxc42K1QCUfBW6E/YTylhVzqWTaPlWEh8Tscgh
	 lq7SEExzfjA51SPmSHDlNTNFQFFUBAJR6EBX4F1UmIN511Q/lzpEje/SDdLGtI1M50
	 kSoR78ay2MPLQ==
Message-ID: <sashiko-outbox-171029@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/8] landlock: Enforce namespace use restrictions
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261014082718.1435842-4-mic@digikod.net>
References: <20261014082718.1435842-1-mic@digikod.net>
 <20261014082718.1435842-4-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 08:39:37 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Add Landlock enforcement for namespace use through the LSM
> namespace_init and namespace_install hooks.  This lets a sandboxed
> process restrict which namespace types it can create, join, or acquire a
> file descriptor for, using LANDLOCK_PERMISSION_NAMESPACE_USE and
> per-type rules.
>=20
> Introduce the handled_permissions field in struct landlock_ruleset_attr:
> each permission gates every use of a kernel-defined category (CLONE_NEW*
> namespace types, CAP_* capabilities) with complete deny-by-default
> coverage, so unknown member values need no validation, being denied
> until a rule allows them.  This UAPI extension advances the Landlock ABI
> from 11 to 12.
>=20
> There is no domain-ancestry bypass and no namespace-creator tracking,
> only a flat per-layer allowed-types bitmask: hook_namespace_init()
> [ ... ]
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014082718.1435=
842-1-mic@digikod.net?part=3D3

