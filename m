Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B80C3793D2;
	Mon, 21 Sep 2026 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985253; cv=none; b=U10pU534ga0jiW3BDFM2c7RGbcPfwo3LBM7oYWM/AyI2o93hQEus31e/mDzEQXnbuJQvoHku8sBtl32QWY1+MvwE609OWIRP57B7XXDFk0Yd9xrPERNOXgL2au8nvgAG2gNTVYe19j6uL7PLYh/iNgW6gsuzUsXXRGt8AIOMmRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985253; c=relaxed/simple;
	bh=t3F7UKTgOWlMOcCohyYbyjg9oeiUEggIz5ve7ziB3xo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EZIpxg1de5/FUqH0IoiIm9oYRCM80WYFWQ2jsozjzBP8WUBYpFhO8URmx0jkXC8emquKkXljb0xm4IsMkuppQQxVZ4NkNQOWNT0SoIs3/0W60Tdned6w+1MjRXLEC8zMClnObklY6QCv04hknu2QZcG7v+iQMoWqrAIjmHBXdBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oh//e5Ps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oh//e5Ps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118A11F000FF;
	Mon, 21 Sep 2026 10:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789985251;
	bh=t3F7UKTgOWlMOcCohyYbyjg9oeiUEggIz5ve7ziB3xo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oh//e5PsZlrvxPNF07z8rPP7Q4EwZBonJIFyFUsOKDNZ+joJV1VuOwnpC/sq6DJJE
	 Xe6YnyRZ/b8VWC/tHwWX9+aUiIY15j0ccXxXKX7w39jUrHebDyn8Icj6mcIgbzHaC1
	 zoYsQoqOjNrdDNuo9sZ55QEWPOUhjXi81ZhSTsbK35liZEN7a9HQayPVtByG3MuhUq
	 osn7/rS7d4hki5pK0HQ1ox2KLZqTWpKDzWZMhmYkTuxhBfQbVYNRgOazgEjw9PpAp0
	 URe+GTk7B+EukGpubvugEGgz3nWoTSBWmKU3HQYLmo+2O8IsuFChYh4u7CE06b94/n
	 Iwalu2KoHEevQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/15] freezer: convert thread iterator to
 for_each_thread_rculock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20260921092101.89285-7-ye.liu@linux.dev>
References: <20260921092101.89285-1-ye.liu@linux.dev>
 <20260921092101.89285-7-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 10:07:30 +0000
Message-Id: <20260921100731.118A11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Ye Liu <liuye@kylinos.cn>
>=20
> Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
> with for_each_thread() loop in kernel/freezer.c with
> for_each_thread_rculock(), which scopes the RCU read lock to the
> loop body via scoped_guard(rcu).
>=20
> No functional change.
>=20
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921092101.8928=
5-1-ye.liu@linux.dev?part=3D6

