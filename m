Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D319845FFAB;
	Mon, 21 Sep 2026 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985650; cv=none; b=m7vFF378fmwURz8hOiMBLWjpz+OxfqyZMExHau646OzX8GFEhCjFa14iYd18Qt9OwALnzrob3MqDKcnjBaLTlNdcpFMJNxUdTMVQhJqLO3CdIJh3E4D1zASh4IYVtaNsbldbYdTt3iuK8RNu6a/8iqTE8KaOfRGJ/6iyKLd02Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985650; c=relaxed/simple;
	bh=k9CcW4oUKclJ1tGKwNqmJ76JsoBO23kjg732HxY5vCA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iYs6FAJ/aLfsuOdpet1zCaASuCb0g4sOZAkh4L3sZUhslgagytjr6TD9/hnHqSLhgcsMR6yQms+HNgeEB5BZmX5ZuXuipOPyRa5V31BblV/wDJRD05MuydBoylQ7fzRlekqATkyQvWJrKOPKfWceh3DJB2S+2hoQqvwrXH2q/uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvj7ldFL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvj7ldFL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210C61F000FF;
	Mon, 21 Sep 2026 10:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789985649;
	bh=k9CcW4oUKclJ1tGKwNqmJ76JsoBO23kjg732HxY5vCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mvj7ldFLwq665JxxYOUHZ2tTJ2d1nabsVo9Wa4hiI40GMvGsjvmFntJ2dXLjYxSZ7
	 v/emBHlr83T+sKPYECrhOFQCu1EtZoydejXR9eqwYGORz2NQ8HSSWCGMAVawUTBn+4
	 j9Vl5SPuf/eXaSzG0L79zQEiSvESfHZaDdhQUDDut3LXQp9F2NkBTMefT3tD+KwrZD
	 zwZJPFR0z8rcVsrg90hqQln567RVdF3frppE2qOBFpxofDbFhYGdYjupvQvzAzvm/u
	 mVYERcUwqZYFxVVyHHemiHV9Tnew7b6aXTT/B/Ow1zkL/VznXaM+F0j5HgF07DcL1W
	 UMW6wuTNUSjLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/15] locking/lockdep: convert process/thread
 iterators to for_each_*_rculock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260921092101.89285-9-ye.liu@linux.dev>
References: <20260921092101.89285-1-ye.liu@linux.dev>
 <20260921092101.89285-9-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 10:14:08 +0000
Message-Id: <20260921101409.210C61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Ye Liu <liuye@kylinos.cn>
>=20
> Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
> with for_each_process_thread() loop in kernel/locking/lockdep.c with
> for_each_process_thread_rculock(), which scopes the RCU read lock
> to the loop body via scoped_guard(rcu).
>=20
> No functional change.
>=20
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921092101.8928=
5-1-ye.liu@linux.dev?part=3D8

