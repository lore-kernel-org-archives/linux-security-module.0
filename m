Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771670;
	b=BQlRaLm2Bx/djjYiIqJmPtW90wAqjm+1M8wQwYTDhq86iOzSw7OUSBQUTEJDIzU4hQs+
	 GrwiFxz7aKxTouEB7pw+Q4izRTp8FWs5NzD6yuOG0/0jlFfJYn1epShqAJkm0V9znPnGa
	 Zuy5sPjRKa6NcSq4JJmAfMqlizi/FFdupL2kw9XQxOc8iwe0lQ5hhawPkDHKJ+8IxTgjP
	 fxlzmGnP69QX96SauNCHSQ7uJOpvZcgcTdYTxsRTxXCUC3ezvmPI9gvXD+j2clEAp4R9T
	 MmYgTqMyG3X5vfnFNOao5ryivaSeESgQB4ZEvk0bpolIPwclGaH5kjbPUnhccIAMi6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771670;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=836nqAty9s1YxBsFCI6clpm2Z3VkP4gVy4L1FQ87a/8=;
	b=Uhcip+X80UhMQ5nqMVelv6j0l9wDWUjKESF8njUbO5DenxfrtiI/yKIGd+blDBeKiK4a
	 cFRglkUgbCBF/Iwk0IgFtHyHmsKOaBzS4jJna4pf5wAPzN6aOsJxtRzKD9qLh12m18UTl
	 z7a9UPScyxkZWTLnbrF8MzLqrK1BKznMwI3p1zpp/+54O2IzafSuFxEzOmXz18LzVMNO9
	 CH8u1fg2dBuG2g3JU52U3VWDbRFPm4I+TxsJmhla7yvoxnQkipChI54P6wVNhbTZkBi0p
	 2kfN6GlaAs0K5cpTcAyVx2sb7Q7pySLKYgUH3k29yCuaZRJeFv3Wd87fP6G5lkeY8gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HV4bFs0a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1117E606A31C
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HV4bFs0a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E7D1F00897
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 09:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795771669;
	bh=836nqAty9s1YxBsFCI6clpm2Z3VkP4gVy4L1FQ87a/8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=HV4bFs0a96Qd39Oz95TbVw9PcyqDkAYCQQLehE6mAt2S5FXMtoC3jR9nLDqKLR0Zl
	 8lp7irEwGzr6AV3g9KzL5K5flQzPdnKDsJ3uSckGs05wZnNlJYgga/DCgqRwf7L8Pv
	 689GSe0mkf//VL8XgBNUqeFFBRR/OiDsQvEfJF+cctdfd9kKlCtZ0TZsTrDePRHvCj
	 251EbS879vryzR//4bezaII9/3ZLnOufoRXgHY36GcLSAF15NzQaHqSOt8e93tDH2o
	 gLdBP0fYnvZ++3vT/6OkfwDCQHcZdCH7zbliBeyv9f3CfExhclqobPEpzBukFSZ9Sk
	 PBXAdkioBUCrA==
Message-ID: <sashiko-outbox-236976@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] netlabel: fix duplicate IPv4 entries in the
 staticlist dump
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261127092325.3563681-2-xiaolinkui@126.com>
References: <20261127092325.3563681-1-xiaolinkui@126.com>
 <20261127092325.3563681-2-xiaolinkui@126.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 09:27:48 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> netlbl_unlabel_staticlist() keeps its dump progress in cb->args[]: the
> bucket, the offset of the interface in that bucket, and the IPv4 and IPv6
> offsets in that interface.  It clears iter_addr4 once the whole IPv4 list
> of an interface has been walked, so if the skb fills up while the IPv6
> list of the same interface is being dumped, cb->args[2] is saved as zero.
> The next round resumes on that interface and dumps its IPv4 entries a
> second time, which shows up as duplicated lines in "netlbl_unlabel -l".
>=20
> This needs an interface that carries both IPv4 and IPv6 static entries and
> a configuration large enough for the dump to span more than one netlink
> message, but once it does the duplication is reproducible on every dump.
>=20
> Clear both address counters when an interface is started instead of when
> it is finished.  The skip counters still have to be cleared only after
> their own list has been walked in full, otherwise the offset saved for the
> interface where the previous dump stopped would also be applied to the
> interfaces that follow it.
>=20
> netlbl_unlabel_staticlistdef() dumps a single interface and never resets
> these counters, so it is not affected.
>=20
> Fixes: 866358ec331f ("netlabel: fix our progress tracking in netlbl_unlab=
el_staticlist()")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127092325.3563=
681-2-xiaolinkui@126.com?part=3D1
