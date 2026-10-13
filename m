Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BD651FCC2
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910776; cv=none; b=Uzet7hlJkB2eq+thmpnj5h4FGlkqgVQDc7lB/gV2rWdXHcUgimWevkcs738oKAB9GwnuR7f5zRdxcbmdXRDEzELxaD7SxtGLwcokPS1dq8CRe8eWnGKaM6tRiQde4K5ELHg+yAPdj6tVt6qeQtoERoehv2htZGr6VnR7mrVz3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910776; c=relaxed/simple;
	bh=pN+FYXFwUjlnxXVTTVkLK3693xexupcSdQTfGLPiTIk=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SjkeUQfYViPN3pLD8tRFKtsBi5bQ46MrYM3M7BmHX4rLT28hHHT7levbvRCWfcNeSGOus8MM1l8FC4vPgTBGTYh0UWyuaV6pCo3g5GfFKIqSCY0anFdjyk8mdc1g0dhu9DbW1vVilrQl7F5Bndouiwq+CAPsyBcwW7VOehbQDFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzxsDdRw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzxsDdRw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075271F000FF
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 16:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791910775;
	bh=rsF78C0pR5kidAhlbHyD+8NzMm1LbawkbN9oUbbcwgg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JzxsDdRwlVw1G58a0OX8sV/DeW65wmsTiLHzWIJQioyPS8wgx8Xqr9NCuAS8+Wj85
	 K7frv/sYhBoUNxOWZYFF9vkLwKClysCQI0nAny+V8mmCBcGC/2Kj5OzD0NSVlsc4+V
	 9YeBvF0ecaHloZaUWVXr6vjCGyOo9nvXl1+NVjo6HNO3m6urfD+XvaCqnDmrwW9VnK
	 4nQWVM66pnT1vZP8OOmIDdwPX24TAclY1Rw54jSRUvyx49L1JhrtC2ryeHIoShbUEL
	 q3kqgXaJ9jv+DQlh40QiqeOEDnUZWbXynPjmsEeksQDFsSKyYay8zOS4Hkodbjzk6Z
	 Mrn3rLG/5Dsww==
Message-ID: <sashiko-outbox-170180@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 07/11] fs: add mnt_undo_legitimize()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261013164800.2906577-8-utilityemal77@gmail.com>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
 <20261013164800.2906577-8-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:59:34 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> A failed __legitimize_mnt() can oblige its caller to mntput() the
> mount, which may be the final put and so may sleep: legitimize_mnt()
> leaves the RCU read-side critical section it ran under to do it.  A
> caller that cannot leave its critical section - a BPF program driving
> a lockless walk, which only the verifier ends - needs that put to be
> callable from inside it.
>=20
> Add mnt_undo_legitimize(), which drops the count and, when the count
> turns out to be the mount's last, keeps it and hands the mount to
> delayed_mntput() for the sleepable final put.  delayed_mntput() then
> tells the two queue populations apart by MNT_DOOMED rather than by an
> unlocked mnt_get_count() read, which a concurrent failed
> __legitimize_mnt() could transiently inflate.  legitimize_mnt()
> switches to it as well, retiring its
> rcu_read_unlock/mntput/rcu_read_lock dance.
>=20
> Unlike mntput(), mnt_expiry_mark is left alone: a walker that failed
> to legitimize a mount never used it.
>=20
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013164800.2906=
577-1-utilityemal77@gmail.com?part=3D7

