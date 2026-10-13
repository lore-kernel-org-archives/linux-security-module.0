Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E429451E422
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910500; cv=none; b=XzLvB1fZOdxSaDQBha3NXgc3vq+tNrPFU6qjP9fj45ukjLp6CrzYrILCCtC4MTQBVsLyNlwa+0PfunFAoQErUg8HfIS0ThlOx+bgjp3NL3/SSByqjv59NIOv0qZMUJRb+v3IY7MpGxJkF1kefMlqf2V2IOO5lU16Vum6V3lQEog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910500; c=relaxed/simple;
	bh=7xP4y2NKhBmBJHS6FWeKf0tguMYDoZcl/SUA+KKz0f4=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=C1Z6Pp8yFyLIBN/gbhp7dZY5NQBx+z6Xtb4ByPGL90b6mXuOl42EQWNAVejXX+DxamZK+vXZfRIQslZcSXVKPxqqgreyncI26LIPDTlv5PanO0wLyi/K0pBUmc6qJV+O9Lf/uoUPmRvP5OnOgc8/ojm8DgJRkJ2fEWkb8MaU2jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFCxKmMk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFCxKmMk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E041F000FF
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 16:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791910498;
	bh=dIEpoDMNTK3LoB4Up7thGeXaQ5E/jAkAtf1Lna9cEwY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=LFCxKmMkxZsgxlQIqISfQVD6UO4YiZPfp4+vquxddfE3DHQM3oSLqpyvhFoCNpEmA
	 bwk3moRNL1X/RgBIwnXqr+tuWdiJM0sSdXID0kCYOzwHFNBjIQXfGom1VAE9zZrtW6
	 2KszRAoHnpPRqQ37P/5fSo16AgW3aGmhPl/8LRglX9dmYa8Io3ABbr63iWDr9M9ZhX
	 Sb3/aCh0yzthHD0p833vuecEKGSSGePshrKmF0FJPUu2Q3vZkaZyrjda8m37yMgXkK
	 4LTjjhpWe+IaprwH5cSfBWvZLuNMLzOEjoWddkpCME9+NsXj6PQQJovuNUdy5r7tIp
	 zXjwhQ5+WTcBw==
Message-ID: <sashiko-outbox-170170@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 01/11] namei: introduce __path_walk_parent()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261013164800.2906577-2-utilityemal77@gmail.com>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
 <20261013164800.2906577-2-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:54:58 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Song Liu <song@kernel.org>
>=20
> Factor the step-to-parent logic out of follow_dotdot() into
> __path_walk_parent(), which walks a plain struct path to its parent,
> crossing mount trees via choose_mountpoint().
>=20
> This will be used by a VFS ancestor walker serving landlock and BPF.
>=20
> Suggested-by: Neil Brown <neil@brown.name>
> Signed-off-by: Song Liu <song@kernel.org>
> [justin: rebased, kept the helper static to namei.c, dropped the
>  path_walk_parent() wrapper and the namei.h export]
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013164800.2906=
577-1-utilityemal77@gmail.com?part=3D1

