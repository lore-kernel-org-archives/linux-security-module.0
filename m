Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012597;
	b=TIvXeNM8k2DRf0jxZCJsiluNRIAutyV+n1zuIaXu0FNQ7O7HKCsE5EbICUkVfqaPMquK
	 YVuzqhBeGGO5q+d/i43L0YE0NRsboeFidg92DDXRygXfKRXC4JbZzC7Eo923eW8qX7okC
	 UnTgZpA8v1CN420RfbSJjcoukdkXw7uOmj+CBTYe/t5qpBsOPOTpDvU70MDUMqyZ3Xzd0
	 ZfN+YVHVCuIcOsdAz6zyXnc9ZGxYV4ZwZiu73/WQIIqu7116/EIPMva31IUa2MnirTGdn
	 xpKZSDuavnVflOkn2WOSxi4QLGpubf073bTx4bqJtzy/66QcxUswBdXRnjLSUBAbBvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012597;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2yFA0cRCAkqOXRbrvnLvIBOgdhI/t3evbD6GqCify2o=;
	b=HR7Wan8DMvjMv3p74RnhSDUnLxgAp9zq3JxC/8eQzoycd0vWRdQaU5XTLbmbDBlbzJl8
	 GutzeoLO5v6G8bhXYjrDKACYV803Kf9l8mik9/WtMsC9RL2XJPrC1YR3nFiavFLj9VJRp
	 wC9DLlIHA2OXY03BBWn8cLGGiaQAqh2BGMaU+FYneZqRGDi/xIHsZEWTJvxBuyBxUnm9u
	 Ef+eMheu1Tk1aLDb6dQbgNntroTtcfl+K3w8IX0fJxiOuvwKAWGWB7IHfqxDXCO/sDS6d
	 h/vZG1TyoLKtI1ZwEmNWyl3hX/8CHJR/RJYC+sB0MNdLy2Iw0BWig2CDBhqWI/2yyEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVeenCmC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B1A606A31B
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVeenCmC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6611F01825
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 11:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012596;
	bh=2yFA0cRCAkqOXRbrvnLvIBOgdhI/t3evbD6GqCify2o=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=GVeenCmCOWZtGDXZ4dfMRlTMGWl/h2sQ6CgqLt2w91ayso/CO9Geb/9DK043jFtE+
	 OAc8z5BhMBRLtzgCP16PzLf7U7fK0OjBs0gYqaXubn/4cFmV6TTkRRfKzfWsZp/Xsk
	 /2e9XuBWyu6hZhjbf12jHXHeTCeMDM/AWD8cT0/jbG1HWTgVUDdVra9gygLPKJwTNK
	 5hfJ8eWdHuuquuOYRKYbvuTCZC2GPG0TxvnQtLIpBLz6KCgXTxINljHeeONcN2VvMi
	 XMrZ7eI1F+eKGqfjs1lkKi9jsYYDsRTfRlUofV/3ACzk1XcznsHTs2oG48ht1TwC32
	 h1LwZhZ6iRvjg==
Message-ID: <sashiko-outbox-185045@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] selftests/bpf: add a lifecycle test for the
 namespace LSM hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261026-work-security-namespace_free-v1-8-ffa3ebbf71bd@kernel.org>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
 <20261026-work-security-namespace_free-v1-8-ffa3ebbf71bd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:03:15 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Track new uts, ipc and net namespaces from a bpf LSM by their namespace
> id and check that:
>=20
> - namespace_init already sees the id that NS_GET_ID reports
>=20
> - namespace_init, namespace_install and namespace_free fire exactly once
>   for each of them
>=20
> The test fails if the namespace_free hook isn't called or if the
> namespace id is allocated after namespace_init.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-work-secur=
ity-namespace_free-v1-0-ffa3ebbf71bd@kernel.org?part=3D8

