Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C19D46AA6C;
	Mon, 21 Sep 2026 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984296; cv=none; b=OPmIGqwC+1nOYBLpre/G6NXMdD24RfTdfB3WSlMYZRYlsrBS2jKEyB/XWQmz4j6lm32HOcfemdMt/zno8F10jhnVI7J412xAeSf2FSgm+/ArM3HMMsB96upZcCYnT1KA/x06FxbRjS5aCYjJRmLL24rKAAw2XwIS1JGiuDo8yHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984296; c=relaxed/simple;
	bh=U4mQAhpv+zc0mahfN6jGlgBWXeGK2xt9jXdcJ0hT0T8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aa0VZPUwfbPDnUYl725ogyc9vudEy+7KqvB+X1JesA9K8fMw6/6q+3VsVoGmmlx/9CrmQByW1rrdh780XFHbaJkL9oHwMit25cPVl/I/xg8MvKpYwMAqbcgJEfnK3Pcb5u6vOQUrX6BV28W7s2yH4FYbcGZeP4L7baC0F8XM/Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5dTFKt1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5dTFKt1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79AC1F000FF;
	Mon, 21 Sep 2026 09:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789984294;
	bh=U4mQAhpv+zc0mahfN6jGlgBWXeGK2xt9jXdcJ0hT0T8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D5dTFKt1NKLkxwwAn+SMF0fBgaJ/4G9BRcUyAPP+xmTq+fL3JKpfNcVOLqR8U3Rwy
	 WhAJ3C+tOzP59wfHUJEX2eF8llGZoA11jkXQJp2w6dUH7XDRaMbvQ8wawdIVxyAjBc
	 z9/mJSVzM1d60oiu5xxbARnOJJwma97PUBrFKiWe2XpI5SRDrj2isyZiBE43n0+FUL
	 bUGra6caAK1JCC4SAjs5PMAqMax9btpZb9RvttZyAJP9xi2X0/BBKuRG3bZdDRl+Ty
	 c7AiLlSnwNUHALA1M1ET9kzdhbuNJIbrDSWBj8FYEXCO54xUaEus8qdBKdzfiWyzYB
	 MIFRo77JQhhNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/15] mm/ksm: convert process iterator to
 for_each_process_rculock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20260921092101.89285-4-ye.liu@linux.dev>
References: <20260921092101.89285-1-ye.liu@linux.dev>
 <20260921092101.89285-4-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:51:34 +0000
Message-Id: <20260921095134.A79AC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Ye Liu <liuye@kylinos.cn>
>=20
> Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
> with for_each_process() loop in mm/ksm.c with for_each_process_rculock(),
> which scopes the RCU read lock to the loop body via scoped_guard(rcu).
>=20
> No functional change.
>=20
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921092101.8928=
5-1-ye.liu@linux.dev?part=3D3

