Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012602;
	b=wGqjfwhG8tISrMNKnl1JsjaI+l757OtW9YHt62k3MaA/AiWhkWqNMbNSkL+R2XaRZz1g
	 qlRt4u0LZ/LCGb8rgXLufbfKSqTZTFQ1W4ib/sfdMueVw2ughoz78ifCGIdN0UC1HVMxu
	 ksQdmoARCp23Ldy1Kb5XyDFMDN7cvMa8ydTittZJ3gybgfOEmScAWFKEHk5z7nBEmDrVE
	 3XNgIWT+9aCwoUr4tKIbpJiQnWAFue+hpNNHyIrxdrLHU3TiEuRZWu01tmzdE7j0HtxXg
	 juwqpwNxi/z7lrrQAeTCPVZWZHfs2mMuRaME+cxAxLTHRt47ZgXURLDd1KdbwJJomvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012602;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hKRyIDhr8ZKuipfRss9auUtntCKZz1DV6CwVMhLFjEg=;
	b=lid01Gc8UZND/t5I60OI0FuW48dxv1x/9FX2korvJ6xA0yBl5r6x70tck47//hFyu+7U
	 sIHmVtVv35hPpMmUcmV/EgWRc/oSiyksFlYhYS1z1Zq9aNoJhnprDXHwjqBxc8P3hwdKg
	 gYAVDwNcHBM0JgXRnOQiTmBULcjiR2G8aRqFi2ZoI+Koy1jTcbIDCohIrkiTQ71cvNbxy
	 0zGDkUijeniaG4UTi6o9HzN6copU3etJN5UeGBE0XCQXDtM23MvWKKe1h0lClgRHOGCLY
	 Fr7eXbUzklw5Iil9tgE5DOq4DKhrGI80MzN0twIlPW99zRr4tv7W5KSoN2x/aS2W2cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDjcKKmM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CA7606A31C
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDjcKKmM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF60E1F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795012602;
	bh=hKRyIDhr8ZKuipfRss9auUtntCKZz1DV6CwVMhLFjEg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=HDjcKKmM56Sm0hHGsJoioCK/2vxFZ9VZdaZx/kpP9qLnF9ZzmX6G+tHNQQM2tGs9F
	 LnMYS88yYXB7mq/iz6rKMTDVTuBngb4J9ut0eQniO+Pp5LsCDXoP1sTC+hXJCWrjua
	 Rb6WPuMNnqL40FRp7pdSy2a+raTrIv3jFeAuUkVDYHW/cgruTdPSWuHMoH8KVR7+uV
	 iWeDljw5JBNqn6KR4VyZmslZER1NCFGujEiniTiEEnNtO70bMNmEnYyPwqZPd70SD4
	 SHW9ESNlFzL5+BTX/+AX7Z7+ApnZen2765zgwSXKGSgB/ShBDjg+mSN5uOp3zVhYnG
	 1QgIm0Ir4UV4A==
Message-ID: <sashiko-outbox-221227@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 8/9] KEYS: keycrypt: Add the CAAM backend
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261118141153.621958-1-giometti@enneenne.com>
References: <20261118140421.584086-1-giometti@enneenne.com>
 <20261118141153.621958-1-giometti@enneenne.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:36:41 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Add "caam", a backend of the engine tier for NXP SoCs with a CAAM:
> once sealed, its keys exist outside the CAAM only as black blobs and
> black keys, used through the CAAM's internal cbc(paes); a new key is
> drawn in kernel memory and sealed at once. Each blob is encapsulated
> with a key modifier derived from the blob's header, so a blob whose
> metadata was changed does not open, and the blobs of the public
> cbc(paes) and of trusted "pk" keys, made with another key modifier, do
> not load.
>=20
> This is a proposal for owners of CAAM hardware to try, not to be
> applied as is: it has not been run on hardware, and the CAAM does not
> check what a key is used for, which is why its tier is engine. Only
> aes256-cbc is offered, with ECB-encrypted black keys, since the
> driver's cbc(paes), with Richard Weinberger's paes fixes, refuses
> CCM ones.
>=20
> With it comes its section of the documentation.
>=20
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118140421.5840=
86-1-giometti@enneenne.com?part=3D8

