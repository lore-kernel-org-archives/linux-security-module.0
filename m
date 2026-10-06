Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3168B23F40D;
	Tue,  6 Oct 2026 00:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246655; cv=none; b=TNFwBGnPzl+FKN84qWYvIeYHkqtKRpJCQ1M3J7BBR4/nbdU6mu5i6PZecPiQCA6Xdhxdgz0VTw5LKHNSyf+6CezbG1yg3SG6LS1loZcJR3Z+A1/u0obZT5xwjlBw3svBq7urqHXGDcakXtdCI63K3BKdWgYnULSi35UTDKAMx2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246655; c=relaxed/simple;
	bh=MBrJJ27/zYSbcfla4/KSuUOS4xT/5Nelo03sJEVGQvw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JuBhT8vvS27fj9Jz0uqFzYxEUpFUfXvb429oFFANn0LEG57nFTkEqhmEovPxVAnKLue88xEhfce4XXmnJrJ4/UmoAlegPnxiGGUw3Eb7Bqs3V6esOQJMuBmgHWz2RdnGjSY83nwRmZnQ8TDO9LfoKwPsqRKM0tVlaLB+Fh4gxSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VldjgDXe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VldjgDXe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17D31F00893;
	Tue,  6 Oct 2026 00:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791246653;
	bh=GWkGy5eE8eCplg7nWoqzBo+bczS+6iKheTifYVmcyrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VldjgDXe9ia6rKF7QhNjaCWNV2J4UgwdQ/3K/2bABXynYQehPfkUw8/csRJsWxlv3
	 BmAAyNlPF6fKRPHAYuWhVlKPyVvkjyhRHFv/CRT7bQIzyr+UFK72SiIppRSAMWCZBx
	 gJw2TsQ7e7kDirMh6PuFcNHKK4EW1orfO88TmRV/AXadGfFZKw8bZG4z7deyAQy+Se
	 wQQHuxdNlwLkLIbh3IDkiPexDNicF7VRnP8Jj/YvSaZ/XpaTuZuqmCyIRfKDQ1G2LH
	 BIm9VuBE2+oGleUie7l63G/a48LYiYgM9GQcCfldywvUOwTo7tnALFcAVsgX0DKcn+
	 cSrYw7eAAfLng==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 06/12] bpf: add a path ancestor iterator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261006002020.2890858-7-utilityemal77@gmail.com>
References: <20261006002020.2890858-1-utilityemal77@gmail.com>
 <20261006002020.2890858-7-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 00:30:53 +0000
Message-Id: <20261006003053.B17D31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Let BPF programs evaluate a path's ancestry with an open-coded iterator
> over the stepwise vfs_walk_ancestors() engine.  The iteration holds a
> reference on its current position, which is what lets a program sleep
> between positions - a dput() of the last reference may - so the kfuncs
> are KF_SLEEPABLE and the iterator is available to sleepable programs
> only.  That covers the LSM hooks a path-based policy attaches to:
> file_open, file_permission, the path_* hooks, mmap_file and bprm_* are
> all in the sleepable allowlist.
>=20
> bpf_iter_path_ancestors_next() hands each position to the program as an
> acquired reference of its own, to release with bpf_path_put().  The
> walk's own reference moves on with the walk and is dropped at the next
> step, so it cannot be what keeps a position alive: a program that saves
> a position's dentry, or hands one to a sleepable kfunc, needs it to
> outlive the step it came from.  struct path is a value type with nothing
> [ ... ]
> slot from it, so growing it later would reject programs built against
> the smaller one.  The walk mode is a parameter of the shared engine for
> the same reason - so that a mode added later is not an ABI change.
>=20
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006002020.2890=
858-1-utilityemal77@gmail.com?part=3D6

