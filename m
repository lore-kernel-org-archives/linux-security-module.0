Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195A046D0AF;
	Mon, 21 Sep 2026 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985071; cv=none; b=Yaypk/8ZzwHCG58WNKm2lDIxga9JXn/2La4HqMAilAh8fhEZXt0evVkL2bvdd9PMSvUaB3vL9BlH7LO2qav/dai91iPRM4ZBXMnWTghXGkrIvyRa+RoC6b462ftgo4Gd5zmwZGKqMTIlKlYJ2S4Ym7YjMq6G/Nsrls2PJC12vMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985071; c=relaxed/simple;
	bh=krAY3na+xujc7xTFv7Ath0uIaclF8Z0wF4tkbtg/dxM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kbz3qxJQFu5AJVwzRtbjYH+FxyYi4WHvZSO4VU7/RxUDcUwbo27RgY25skg9wnadqR4R1Vxp3AouJNif/eUKmOftUBxHaoJlvZGIGfnUY56EB9O0Fb2vhbCXKt676M1C8QEyZVZsmTldf4Ycy4p3ArYrRw43f1zDe/Raonc+M7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkSknLPC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkSknLPC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676DC1F000FF;
	Mon, 21 Sep 2026 10:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789985069;
	bh=krAY3na+xujc7xTFv7Ath0uIaclF8Z0wF4tkbtg/dxM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QkSknLPCEel5nIqZQELk6zjKDym4rLJFWkhqVlPMkkL0mjVDoKJqly0iFLxNHbwfe
	 jwcag+HMF59KI/Hf9lM+culVzCmJMNpE/xaGsoTNGm0qdjJMIX1gKTDhQPnezYWs+K
	 s6YMm2rLAEXKeTZLox/QX5u1FixoKZJK8jbrHWTKfskJFK32kBUIiWpowpSk7n2Qje
	 UfY0vtaRylAkOWkplkfloGrBumTV2ibIaCklICHK3Pu8Ck1cuQ/g8MUbimA7+0xbKL
	 4Ty8mEit7S2BPRe8kWIJE3/2c6fOXVYDDnm8+Y5qTplRu6kiJ6Jdl8pgRcp3lmIHa3
	 IZqXH0zfE55+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/15] cpu/hotplug: convert process iterator to
 for_each_process_rculock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260921092101.89285-6-ye.liu@linux.dev>
References: <20260921092101.89285-1-ye.liu@linux.dev>
 <20260921092101.89285-6-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 10:04:28 +0000
Message-Id: <20260921100429.676DC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Ye Liu <liuye@kylinos.cn>
>=20
> Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
> with for_each_process() loop in kernel/cpu.c with for_each_process_rculoc=
k(),
> which scopes the RCU read lock to the loop body via scoped_guard(rcu).
>=20
> No functional change.
>=20
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921092101.8928=
5-1-ye.liu@linux.dev?part=3D5

