Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36721422E2E
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302038; cv=none; b=VkC0NPAhRBGbrsPpx21ny/WG4LTE9+rDA6ONhK7DjYHO4IFqfxtJrCBlzWJTuLTBL+rFkYD4KYdEH5uqxiF6hMor8T2tqiwH5tfqOsQBB1crJdWRl373q8/doYOdt1caAYBEP/iNc/TwBwTQZPc375HFl3zdGNP5DHj8jijS8+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302038; c=relaxed/simple;
	bh=0Ld2zsbFxByahgJ0GlUWQUrufAkgLHkDjlcdLCL6Q84=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X3U4NLImngGcQ9uzUU1h1LO6uf+3kJWSZeSVlJc17BK/X6e9A5cYgMQk9Hyaslomt7WEnIKQVsAbKBc75cqJqmsB3Ga9wSGUPf8jomfrrSjBzcm17/aDz7Z7B91rC65nNc+TYXz5ZDlan3lRB7adHydUyU5cK+BEc6dFbgpAQXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwZklAfn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwZklAfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3DB1F0089B
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 15:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791302036;
	bh=9Gn1MtP9xBfA+aRV/DXPXoQhAvucJZzcnuJtBVTwzJo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YwZklAfnwhbRtH0BBK2zXP5yiBNbyRQhTzwiPsvEgSyjXMOFyGfwY4jFkf5akJWG8
	 NqlMYkme1egfbA6p5zwLJw0u26P3oaIUXjkYNN4ZglN2dWF3tzkwaxJEOnlfykRtsU
	 J2LTseurWi70B7pQsn4esFUIxgYugaVj13eN4mB8lKTOMj7GF3lYnn3J9X48n501il
	 4IqUIarsLBNiUw+s3ktghCFFf6e4TvFKTTp86Cy7A76OUa4dBo+w7o7hhhjwC9zEHs
	 dWioEqlSFf9OTXBi30hK+YZDaJn/+tUd5QjVW2n6LtIgzXxJN5IOmgWaalTsn4grka
	 Kua0VNZbSKgiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] capabilities: limit fscaps to where CAP_SETFCAP
 reaches
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261006-b4-setfcap-userns-v1-4-f47e7ed66072@toxicpanda.com>
References: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
 <20261006-b4-setfcap-userns-v1-4-f47e7ed66072@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 15:53:56 +0000
Message-Id: <20261006155356.BF3DB1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> keeps a root process without CAP_SETFCAP from creating a user namespace
> that maps uid 0, in which it could attach capabilities to a file that are
> then honoured outside.  It does not have to create one, though.  Any
> namespace will do that maps uid 0 and that it may enter, and it may enter
> all those that were created by uid 0:
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>   unshare(CLONE_NEWUSER)
>   write "0 0 1" to uid_map, gid_map
>                                     setns(A's user ns)
>                                       full capability set
>                                     setxattr(file, "security.capability")
>                                       rootid =3D kuid 0
>                                     (back in the initial namespace)
> [ ... ]
> own namespaces.  The rest gets -EPERM.
>=20
> Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-b4-setfcap=
-userns-v1-0-f47e7ed66072@toxicpanda.com?part=3D4

