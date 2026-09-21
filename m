Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA9146EF77;
	Mon, 21 Sep 2026 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985453; cv=none; b=C8AkfVHqC5boydhf4MnlQU8tJuVZF9tu2VKnS4tDUtuZdHj6MEUuEMsozer1vy11AvQ7mZ0QrUIMeY74+9RnIIKREc1ZZJvWh3w6N6o1aaB0BatM/GjWoWDbL4X57yO4dpY8N8antA+rs+BMOFP4dL0MJ4j/TvwrXdYBLGvrCPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985453; c=relaxed/simple;
	bh=s7T1CJPw2jSRRDAAsj8PdT4JGy6vqdfUsJxj5lplARE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p1cx6p0BN9NngDPXAd3+9AoUMS9kTfC3p0PjL7UaG3ZV+2RUC1o/KpJ1yEcZNIvYhXXzzqx3Tws7OKzlZUICtQgHUaklECL6LDuhXumTm+OOpeJit5PLLeDpFfCLoZLxpvmVT42PiWYp3xJp9rmHsnlXGmZBUJ2IZ9NrMOsJLlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bb8VIpXJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bb8VIpXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4881D1F000FF;
	Mon, 21 Sep 2026 10:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789985451;
	bh=s7T1CJPw2jSRRDAAsj8PdT4JGy6vqdfUsJxj5lplARE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bb8VIpXJPfm/J/U/Uj5l0veDtTLIawi10ENDy/lbVKoU98pxa5n3fpDaS6mXEkemx
	 94vlJJD16Tc+4ryLjIU/zrmdv3PxmHfpwMlj3K//YFGMnVa6Zg16pKc2EU90OHsVO1
	 7WcB9pHnnBymjGXjH/CLPX7rUBkby/5/tOhCMz4ND+jGFMqhyu016iHp8geWPJQBCK
	 nh/BNsatUAZsLPmkArgy61YT8qfT1wnoQmG2DzWC+zlK7MrEUYw8wUNNgmk8RbEvle
	 7kn4Ja3ZdsIEXHh1z6NfhQEOQqaVp9j2j5cXEu/qX94FsSPmGn+QG2kF6fSojjCFvx
	 29MVAvdxL/OUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/15] hung_task: convert process/thread iterators to
 for_each_*_rculock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260921092101.89285-8-ye.liu@linux.dev>
References: <20260921092101.89285-1-ye.liu@linux.dev>
 <20260921092101.89285-8-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 10:10:50 +0000
Message-Id: <20260921101051.4881D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Ye Liu <liuye@kylinos.cn>
>=20
> Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
> with for_each_process_thread() loop in kernel/hung_task.c with
> for_each_process_thread_rculock(), which scopes the RCU read lock
> to the loop body via scoped_guard(rcu).
>=20
> No functional change.
>=20
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921092101.8928=
5-1-ye.liu@linux.dev?part=3D7

