Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF168478E52;
	Mon, 21 Sep 2026 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987360; cv=none; b=fpAZbVQkZ61MFCssIWro2czMc2GnpLYNcm0YPFG6z3kW4oeXtZ8iDNu4/hQ9NQH9jDNVoX4jUZw39IsOunASkPmbqa9GPbMMX0tEqbINbbH56MkSkTJG6tFIc+erzwpgEMRNZnecMipq83l/7FAr7uQhzJD1OhqsSEuVsGSlA9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987360; c=relaxed/simple;
	bh=upCjAYp6IqJ8NxITHScMHX63rxhwcjFMK+DfOSIUAX0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EEDu5cnzFFhF655Rme46iRQtAJ5sxdH5aARuVvNpORI/gPkny8Uz9B7HIWaYiGtADSEYFAgLlrA+qxplTvrga+kCTpzbrsxkzJRVfREgust4leQEV+3ApYLZJ3zeVjBq4nUfrI7UyaGbhocZhIGIKaO0GhhRv2/UmGNH7dRlmBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1ZxCHo6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1ZxCHo6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87611F000FF;
	Mon, 21 Sep 2026 10:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789987358;
	bh=upCjAYp6IqJ8NxITHScMHX63rxhwcjFMK+DfOSIUAX0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h1ZxCHo6XWANER9/M3uwHUUzzhByJO/AOxBfh9dLeyvzGvYernclBEQ1/doAUi+CS
	 9FGPCUAfoHZiD9RxsjiNsKSOo7LTTt3L9u1RXorRNthgLxZ5b4QBk8iRvgeUewzOyP
	 4cEa0F37RpobYl+qm6n6YcUmYHIXFRnraThLhhLCkWdr4HNGKTxWi1lIBDqq65LmWw
	 CrbfIC7ke1F7BuPf7lG4X/doe/J53vhQVkpQlKbEw0XjocSmu7WpeAwr+BmUWUhJC+
	 CYRQ+FBP/a5DMjVsVaTEtFNkhrCb6Zt/9PvJYvX3/JBE1GvtffnFTX4VvDWpyr3kZh
	 y01/DESbjqqkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/15] lib: convert process iterator to
 for_each_process_rculock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20260921093311.104814-1-ye.liu@linux.dev>
References: <20260921092101.89285-1-ye.liu@linux.dev>
 <20260921093311.104814-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 10:42:37 +0000
Message-Id: <20260921104237.D87611F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Ye Liu <liuye@kylinos.cn>
>=20
> Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
> with for_each_process() loop in lib/ with for_each_process_rculock(),
> which scopes the RCU read lock to the loop body via scoped_guard(rcu).
>=20
> No functional change.
>=20
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921092101.8928=
5-1-ye.liu@linux.dev?part=3D14

