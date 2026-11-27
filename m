Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771692;
	b=3hQHasxHPwYrxFuLub9gcOv8v4yav+ELma1bmK4BLKl2hoAZNqMn2w4i0nYTBRKar+DF
	 N97c3akzzVnNcZ58eJkxSVcZ6S99YQ/PD2McJaSvH3dyRztdTJwPKiyGQQXyBTpZiy0mg
	 S7tz7qIILrfcdL8KKWkXgrTtTtNqCpl8LnUlqNYp0ONlLBth1j9+xD5/t3gDk/Ag7mo6x
	 Xk1H8vBGCPu+S5M2KVTT4aFX0R2rAQF9sC5jfuNpLF/zM+hW0Rfoo3n/ckkdEpDH6N061
	 fpJfoPAbQDQq5V2fjoritWGJeOqDO9lGCFAwAsgeuLoUaAsMtTg1BsiIMxCOV++8dcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771692;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zT+Ti9faUAueUkJcZdM9TET9MyxMB8GsaMDZ/zlt/ys=;
	b=5YA8///mwHlnxZINaIW2RUhz9iZQ8fPjMVdtpykFnrErDTNa9U+cxAY1hgrIzjxXOcHM
	 +M6BSRkiNeGn0+2fSmiWbKEoy1mO90LZvUDwm3oNuMDtp9OMBGZjy1uduKEI1GTH1jpWj
	 nqfmBxZ5lFmrMy45BvafDzAo2nVIuxiVyuc65bE74yko1iwKJcnCKlTUQtYu+pDA0j1ug
	 QXhiGyGAY+kR5OZShE2MJjSe87fRKoWVpZ5vi75spBY5NIoe+dRnyYkAEtvAqcZ0Ng/++
	 PhHjxDvngdp40vQIysWh90XvNBXK99WU0NmzLm9OsbJzgLQW547ZOSb9kXCRX6bDA3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMCMRxIM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06379606A31C
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMCMRxIM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B121F0092C
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 09:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795771691;
	bh=zT+Ti9faUAueUkJcZdM9TET9MyxMB8GsaMDZ/zlt/ys=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=dMCMRxIMoZOoMyisf8ptNhniYn7/8p4JIxphtJrjncab/w+wQ0NwAJHlP+gkXt0aV
	 BJKbTSJ9ObJK1D62gV1QKksFGq56uEnX2hd2GQ3Rxj4ImZ4l3lwNuEbYkuW2BQouNe
	 yvIe3nh6n01i6KvXtRpQPjfjcc5e+vuJQcgfkaMVBwmZA+hUFlZLCIBovXo07qiTyQ
	 TkL6BoA2C78J854HfbG+c1i7Tcn9hjClLXpKjnxcZG3ubm7eTxA7NAYKmUaHK/1l8B
	 AaNo3Yv9ssfU7AQNUzFIKP8wE+YioZ5sroAcAP/buBfXk2VCpAPlXxWOzbCa0r5pNh
	 o58hWQHM70m1A==
Message-ID: <sashiko-outbox-236979@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] netlabel: fix a race in
 netlbl_unlhsh_condremove_iface()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261127092325.3563681-1-xiaolinkui@126.com>
References: <20261127092325.3563681-1-xiaolinkui@126.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 09:28:11 +0000
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
> netlbl_unlhsh_condremove_iface() unlinks an interface entry and queues it
> for freeing without checking ->valid, so it can do both a second time for
> an entry that somebody else has already removed.
>=20
> netlbl_unlhsh_remove() looks the entry up under RCU, drops the lock,
> removes the address entry and only then calls condremove_iface().  If a
> NETDEV_DOWN notifier runs in between it takes netlbl_unlhsh_lock, clears
> ->valid and does list_del_rcu() plus call_rcu() on the same entry, and
> nothing serialises the notifier against a STATICREMOVE doit, which only
> holds genl_lock.  The second list_del_rcu() then dereferences the
> LIST_POISON2 that the first one left in ->prev, and the second call_rcu()
> queues an rcu_head that is already queued, so the entry is freed twice.
>=20
> The default entry can hit the same thing without any notifier: smackfs
> reaches netlbl_unlhsh_remove() through netlbl_cfg_unlbl_static_del() and
> is not serialised against a concurrent STATICREMOVEDEF, so two callers can
> each remove one address from the same entry and both find it empty.
>=20
> Check ->valid before unlinking, the way netlbl_unlhsh_netdev_handler() and
> netlbl_domhsh_remove_entry() already do.  Everything that invalidates an
> entry does so under netlbl_unlhsh_lock, so the check is reliable.
>=20
> Fixes: 8cc44579d1bd ("NetLabel: Introduce static network labels for unlab=
eled connections")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127092325.3563=
681-1-xiaolinkui@126.com?part=3D1
