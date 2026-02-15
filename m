Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DCB405F7
	for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771182986; cv=none; b=YgCblQWcqPztAQ1J3rAWdITQADqBLlAfIfd5Uqm+uLPMVPpAuSNOVi8f+fNA8bM5o2ox+3P+wv3vrh063GIgmMS/6vS7x+RTt5dvsUcTl0NnUV7/ghMVhivC31BqxUCPdzOCWq0P1rbpQSottV3H16spa8eZS2B+87hsXn5OeBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771182986; c=relaxed/simple;
	bh=3MhCrzzYCEnBYR2cTgGTems3TLS2Wx9RW05pDkrmbko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A47TgKz/dXdbIy68HqzIKsy5RC+xAgj20prabDjGox7K9lypWqtRn4eipT0uJIReBikkcHpVqzFFfDk8KmbsthSDOeeIJ/QXANuEzIHLMqg7ZKwgSHxgD4HZIVsMQgINh9nenc1gEehH7qEnt45aaY9y782edTqH/OBYhQHZcBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=wWooxoE7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V7AT9u8h; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="wWooxoE7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V7AT9u8h"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 114E41D0011C;
	Sun, 15 Feb 2026 14:16:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sun, 15 Feb 2026 14:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771182981; x=1771269381; bh=m2eovXNmov
	pd5Zpzc3B0BbywYzC/tLSWj9v3EYXZe1A=; b=wWooxoE76Cf7/FdsBK1j9dTV00
	z+zWHJiQjdrq8hRkPG8Ahvz1bG3uh8yLmqLaRedixNW+7PzlANcSDlMq5VV75PAL
	1ZXNXJF40nyTpPEvMtO0nTWTQ27xacGSKiZlwOH+U5cJB89WZ59P8MEHUwbmUzby
	oIWb5T6mr5LfYMuTpZFBVif12EhVW5Yjb6/JLHDgvM44h5RU4qL91PGPeUqsUff8
	VR+qAaRq30s7r6QHmYFlUBB/5gqBjgrw/cDzspR6OpRermfBquyzBjM2hmPfzual
	X8dF3QOj/+8fk1X3dkti2I79gztIPv1jTS7DsCoYZXA5mzhZlLQxZi/qxGZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771182981; x=1771269381; bh=m2eovXNmovpd5Zpzc3B0BbywYzC/tLSWj9v
	3EYXZe1A=; b=V7AT9u8hh6Agr13kRqEVLn9Eivnz6EnkSp0vyUawm8kRtbjWh6m
	jIB5B5VR7lbeGT/4QXVIh9y44KyJ86oXi8vyBZAhGDM1gNYAuHPBrFtPbYuLijdq
	qqgsBq0si8hIxZnxRXvEINHRi/AT9tHpbWstyjrqVwhYQmeQ8Dq88Oi9EjJmTUfW
	8t5TkxSB9Ac9IvmZm8aLwDt18XullvL3+EtNzHeI/N9LQom393UZKbWX9fgA/e3+
	bX7SzGjjDrppnfZZ+p2BjDZNGILhknLto1HfjfCP+63aMHBfTxW1na7TpfTxE0AW
	y2Wxf46gG5dLuTrZbFSHq5Yx/vRcxZ2ICkg==
X-ME-Sender: <xms:hBuSaaciSIqnfU5KIhwTAjfuh6SLuJ2KGMufqAFIpRDOFIP-yeIq7g>
    <xme:hBuSaalJN8Zl6tZ1VKX23ExfTu1kUC8AT5pv7YgjgbXJoxqVeoTiPhgSYKXV601M5
    nQ72qd57UkbW2hymTosiOcfzBF5qf-ytkYEiLaDVPdv8JPbBNg7dQ>
X-ME-Received: <xmr:hBuSaXxUdASz3OQ2-CBffHWtp6EY3DL1BL6MlIszX_NnRTScGuQV2rdMX7IhRHOcrP2Ne7Fkh5pl-nU7k-dCnM2yNsT0S9-Sif8-Fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudegkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkgggtsehgtderredttdejnecuhfhrohhmpeetlhihshhsrgcu
    tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpedtkedvfe
    dvvdetheehueeifeelieeggeefgedtvefgvdfhvdethedvkedtheevvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhephhhisegrlhihshhsrgdrihhspdhnsggprhgtphhtthhopedufedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrthhthhhivghusegsuhhffhgvth
    drrhgvpdhrtghpthhtohepjhhohhhnrdhjohhhrghnshgvnhestggrnhhonhhitggrlhdr
    tghomhdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepug
    gvmhhiohgsvghnohhurhesghhmrghilhdrtghomhdprhgtphhtthhopehfrghhihhmihht
    rghhvghrrgesghhmrghilhdrtghomhdprhgtphhtthhopehgnhhorggtkheftddttdesgh
    hmrghilhdrtghomhdprhgtphhtthhopehuthhilhhithihvghmrghljeejsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epihhvrghnohhvrdhmihhkhhgrihhludeshhhurgifvghiqdhprghrthhnvghrshdrtgho
    mh
X-ME-Proxy: <xmx:hBuSaVwALTlc-KqQfpRAMubIjYy_tlkE3-ASQMK07btFqxLqcJz1Xg>
    <xmx:hBuSafXZNXw-kc4i61X_n8z_sdvyLfLngpV2RU92k9XahOQ6ZlQDaw>
    <xmx:hBuSaUQ3RraBTgSF8k3ZhCqeHD1VFDjWkMarPe0BL9-Jg-UILdu9sw>
    <xmx:hBuSafSCKhb44lJlUz2M-vidbDDoPZEsj633OhHr0U7PvckGNZd-CA>
    <xmx:hRuSaawWv_Za60SZf4sdBzFl_naXJnz6xYXcurrfgj7jDsgcHwW7q1_r>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Feb 2026 14:16:20 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id C849F744F27E; Sun, 15 Feb 2026 19:09:29 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, =?utf-8?Q?Micka?=
 =?utf-8?Q?=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 John Johansen <john.johansen@canonical.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
 linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, Justin
 Suess <utilityemal77@gmail.com>, Samasth Norway Ananda
 <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com, Demi Marie Obenour
 <demiobenour@gmail.com>, Jann Horn <jannh@google.com>, Tahera Fahimi
 <fahimitahera@gmail.com>
Subject: Re: [PATCH v5 9/9] landlock: Document design rationale for scoped
 access rights
In-Reply-To: <20260215105158.28132-10-gnoack3000@gmail.com>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
 <20260215105158.28132-10-gnoack3000@gmail.com>
Date: Sun, 15 Feb 2026 19:09:27 +0100
Message-ID: <87fr71ube0.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

G=C3=BCnther Noack <gnoack3000@gmail.com> writes:

> Document the (possible future) interaction between scoped flags and
> other access rights in struct landlock_ruleset_attr, and summarize the
> rationale, as discussed in code review leading up to [1].
>
> Link[1]: https://lore.kernel.org/all/20260205.8531e4005118@gnoack.org/
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>
> ---
>  Documentation/security/landlock.rst | 38 +++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)

Reviewed-by: Alyssa Ross <hi@alyssa.is>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaZIL1wAKCRBbRZGEIw/w
oi9+AQCEzNJt8XQxQNizw7f5XpmybCwFapBwgFjwYdA5nmbw6wD/Y5qKyYdNQeoN
hgShkepQ1zhLDi/+wnq2nc4kxrjCOQk=
=cBCd
-----END PGP SIGNATURE-----
--=-=-=--
