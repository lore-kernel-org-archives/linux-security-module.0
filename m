Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E552E272E56;
	Tue,  6 Oct 2026 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246634; cv=none; b=Zlzc5zEL+LWCG7PYiQ4dg7OKYXZWxPJwVKlxCRFkI16Hr9RiG3M/W6bMN0l8yO1OoHZVTIRZsocatcUpXVD/EqcoPai82GurvvCWytPi2+SdOIQhDbXESV/FSVB8yAeVzUSWDJ580yvR92ccUTf00B8xYFheAy1nRF2ZKDKOKA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246634; c=relaxed/simple;
	bh=t1YTfDR4HapnSMPkzUfIgrUeSRJyIH9RFI6ig8QG58s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u/FGNUxOVIAi+4gWJknslPCQuiR73aGQ8foV+yu0Y4vP9j0EK3GdCcWRnLEvj0BxyoSFRQdqNpLXSf/prwbGN4X9xWxB6plR31TakQv30ki5umoxoUa5zLfyIPpJz99zNQTzDzcwhc7+N1MzN9kFTLE+ErvkNDULeqD7pSaXenw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhpdryQV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhpdryQV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE3E1F000FF;
	Tue,  6 Oct 2026 00:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791246632;
	bh=0U2jY7+80PToylgI7nNOvD5R/LYWXjf24rCHfSJp+Zk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hhpdryQViTWURZ5bsLPw7NafVFNCcb6DU8hUMcgqdjQG2NrEe7BizDSvV6a9SrhWM
	 oYRtoXw/0hQv6HNJlYyCmcBYMbS6sZ8MzlGaMHcWnPEK8tM3JPkB5ByFehM/dhBG6R
	 vO8WQEDWLiZn2T6+EIf/Yw4lMGEyERthBwwFrIzYA5yWZdNnJzPA1g9r+wDC5udk62
	 l7Ipikx16MiO/ysGMjOQt0+bO4ouXFudnVLJO/QUd2lY4nK+TOLlgRY+T9ddFnMycQ
	 lewGekspRl6EOGFJf0xYXuIu1sHpxmDZ2xvwAcXkDhlwgUnzJoWoC2XBTjVD9ZE/66
	 89FpyC0L2XT5g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 05/12] namei: make vfs_walk_ancestors()
 stepwise
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261006002020.2890858-6-utilityemal77@gmail.com>
References: <20261006002020.2890858-1-utilityemal77@gmail.com>
 <20261006002020.2890858-6-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 00:30:32 +0000
Message-Id: <20261006003032.7AE3E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Restructure the walk into a stepwise engine - vfs_walk_start(),
> vfs_walk_next(), vfs_walk_end() - private to fs/, so an iterating
> consumer (BPF) can drive it with every step and invariant staying in
> namei.c.  vfs_walk_ancestors() becomes a loop over it, preserving the
> callback contract.
>=20
> The position's flags move into the walk state, where the next step
> needs them anyway: stepping off a disconnected position resumes at the
> root of its mount.
>=20
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006002020.2890=
858-1-utilityemal77@gmail.com?part=3D5

