Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E30B39AD2A
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910812; cv=none; b=r5HFhtAbvOqkBnNXo8FhD+B9xRwa94O798qieXRqI66vliL0ky49+dcGqMZ5lhPQG8xeQtlA0nwqU2OXbb6tvOzHV2L0BvXIFbsxp6P05iWBIhtF7RDEfzXBJrSSwgnWb8XW1ty6lO5VaZhPYDEBpjfbcv8+T97Rxx0W60eFJ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910812; c=relaxed/simple;
	bh=iLyjIT/HLqp3iakpP9zMQDYTQ7zih1LMKInwVSuqeGg=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=S/GofT4/lhWeAc3Us+F+b2/P3fbqspFSlBPRMjrU/gw5zAwFE7qzN+JPHiLgbebDknUbWkosfAwP4LjNSYBLHpbn5WZvqFRuAGeNU0UZO8hfoUqXqIfMFecBOB7+rKN6o1S0C3x4ukMECBEGelOiGadfiNZg29E1eUyoiO0CJ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWM9f3S8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWM9f3S8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35B31F000FF
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 17:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791910810;
	bh=iSEaVSypX/5K+uEiGYjsxOXrwfIEwmGSEGdruAbZDKM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=iWM9f3S83r7RdBenAy6Ot1oj7uxvf/uchHMiyh2pdGLmMMcJr6WDI34dVf4XaDKAn
	 TtFGHTzYKFknNCd0SzbDfsWHXqZQwQWg3CdsCpVyFwx10e+CxCV4dVPa3TCZwxO0WM
	 bNVz7myo0H9pPfHXcJq+iZ1JTktWg53dOPw9PZ/GPovVUQh6csvf6TsM3MH1OKAUnA
	 zGPIboQtw0yYftrVz7UUjpM/x0TOCcJ5SCYVslosoqBW+VFHjEoI9+V9WqG2uJ3zTb
	 hRYBucIx++GwWKieu2+LLNa+Fepa0bs67PfrB9dyEOEvYuyLgD423rOWAh3a8m/jJf
	 CbTtqBejitEhw==
Message-ID: <sashiko-outbox-170181@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 02/11] namei: add vfs_walk_ancestors()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261013164800.2906577-3-utilityemal77@gmail.com>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
 <20261013164800.2906577-3-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:00:10 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Add a callback-based walk over a path and its ancestors, built on
> __path_walk_parent(): the kernel owns the loop and the callback must
> not sleep, so an rcu-walk engine can be added later without changing
> the API.
>=20
> Internally the walk is a stepwise engine - vfs_walk_start(),
> vfs_walk_next(), vfs_walk_end(), static to namei.c for now, with the
> walk state declared in fs/internal.h - and vfs_walk_ancestors() is a
> loop over it.  The position's flags live in the walk state, where the
> next step needs them anyway: stepping off a disconnected position
> resumes at the root of its mount.  A later patch exposes the engine so
> an iterating consumer can drive it, with every step and invariant
> staying in namei.c.
>=20
> Disconnected root dentries are reported to the callback instead of
> terminating the walk.  A disconnected mountpoint landed on by a mount
> crossing - the one position this walk visits that a
> dget_parent()/follow_up() loop never does - is additionally flagged
> VFS_WALK_POS_MOUNTPOINT, so security callers can reproduce their
> pre-conversion evaluation sequence exactly.
>=20
> Suggested-by: NeilBrown <neil@brown.name>
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013164800.2906=
577-1-utilityemal77@gmail.com?part=3D2

