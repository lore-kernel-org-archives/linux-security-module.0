Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1847543C7D0;
	Mon, 21 Sep 2026 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984011; cv=none; b=tFBwi+zxvmsMQsTWF36WEup8+GMbnYMjIqVI2cweoHNkmPFDEAEDAT9cp/WnFUn6LJKi6JayST7UieqiboprdF53UHJpMV0Wb6aKGF9BBjwhWIMSWOpWlL/BHN0sZ5n9UdjSeSQdNOc3DwSDClxjxQ9l4EUhnh6OFkbS8Sqzygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984011; c=relaxed/simple;
	bh=03IgJeLfJ/CxuMUnC4riuAI6fKkmx0ZHjK+V+hViDk0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D3tdGkwcsAKx6GadXq2Hv7u2UiJKRKs+L9q5d/H/PYthn1oiojPIFZ+/sToIGsPkGVD6Oq3jLpN3wS23peLKF5MELN3WepEqAcSObYYan8zA2SoLONZZ980rL6iqUWXwh+Y8WsgtjnhIPk9sAcXUg8HmA5+T79JuewPb46bwSAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/wgf4Hn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/wgf4Hn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AAF1F000FF;
	Mon, 21 Sep 2026 09:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789984008;
	bh=03IgJeLfJ/CxuMUnC4riuAI6fKkmx0ZHjK+V+hViDk0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m/wgf4Hn6albcuhLJnZJCgSYeiOhgzSep0VoCY8RqXn7K1oTBfiV6DAsbfbu698EE
	 VlvKBsyFMzBh3Z/ycM95KGuFw8oOOQWgdVFAXaDxbWtQDQv1VFAxl01kRyQHSHRIqL
	 DQ2/Mp/czxZ2wdZAjaabI8EEEHbthGRxRl4NamFsaRQJbn5KkaM06DtEeFicORe9mc
	 0pQeMj1cMdG9pwOoMOs6waQRg6C8cIrOhscDx0KKwZh0fuNf4bk24/hheSGUwv5Stv
	 vAzEOAVps0UL+s6ijxHckAC50d43BRPh3ys9sIt/SlETOwvcdp43x4wYLdQzpZ5XXz
	 +xwXI3Rvz8sIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/15] mm/oom_kill: convert process/thread iterators
 to for_each_*_rculock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20260921092101.89285-3-ye.liu@linux.dev>
References: <20260921092101.89285-1-ye.liu@linux.dev>
 <20260921092101.89285-3-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:46:47 +0000
Message-Id: <20260921094648.60AAF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Ye Liu <liuye@kylinos.cn>
>=20
> Replace the manual rcu_read_lock()/rcu_read_unlock() pairs wrapping
> for_each_process()/for_each_thread() loops with for_each_process_rculock()
> and for_each_thread_rculock(), which scope the RCU read lock to the
> loop body via scoped_guard(rcu).
>=20
> No functional change.
>=20
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921092101.8928=
5-1-ye.liu@linux.dev?part=3D2

