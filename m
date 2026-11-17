Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794881789;
	b=q6yZ9OvwwaP/Z7+zOmMoQ2Ct2Wo+t5gHTaBOtXIiHCamdEofAnlF8wpPsA9b9LDIRUqL
	 EQ6s6v1PXWMZhdH60/hifLYSWJqsIMkFWFN5DmCUwJMLY2mBNJxEO6f+mXLMMett6RGge
	 bgNDmsPKBpD9gfAmwd8G7GVkGt+l6BcNY57dzNHQyxfNNMg37lSRE6M+vASEkfjt7n2/8
	 rrkVYO4R6InS6ej3Bcm8cVfG7elkdcmVw3B5sRWJgfDOEtb+i2AH1l9otdomzs+3+59Us
	 KeyaAuvsl/8vcjf8kRf/FxKl66YuiaUTyepHaLe6LhHOlXvtjbVwsmZw7nTu9EvUQgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881789;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i+KFx0lbmGFRu1lpwIhEjdCiCH+xUQBXopy41az5JEs=;
	b=PlwXrZom9G6G4Nbx703Hdt6OuBx9GXuR5XF85YgDL7VtHFFd9jWKdij2fNqUFG0J1csp
	 Th488oc1FhBEW+Rfpaq3mqUb4Qhn41iQlllzkORdU/SxLqOvaO71CF4q7OC2d65y/fjx5
	 a4FFqqlf5tJcWJHJGG+PjOz0R9tB/Vw+A3TXigBwUBxx+Acz9EQtoT+4Vj+0DOJzue0UO
	 rfAxJpVB86Lkqhb7OGjHMvwlWxL6hhtv8x/xtbtgDOFVahThCrlo6ou+DHq3zYP6ikqFP
	 LI8qx+xEGefXaFvzUgsC/r8D3uj9w51YAAnWzPobtv/tkhNaNb1ThXiP6x8G9bgmYQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TgP1nZjM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC53E606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 02:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TgP1nZjM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630EA1F000C9
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 02:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794881788;
	bh=i+KFx0lbmGFRu1lpwIhEjdCiCH+xUQBXopy41az5JEs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=TgP1nZjM8rgRnxGAb9x2EesQg8BXgkLw+HsOGnKJ7r2U7HVJLhG2oXD9f4fhxEydd
	 AuLYA6v89fw8rtrKsm21/qC0kd93nKrIgpVYc/1GpKUBNs8bPkQuYLmkT2wcfSnjfK
	 i7O5/EChzZviamRN0u8NxMIhUmwigFUd7hm24PJcBAn3BFwIoITtj4D4IfGzARYkB6
	 ujcuDHsp8iwMKC2ze8By3bz7Ls5PhBD+GkpV7SkR3Fb/cXp41BDUn9SEVavIdQW01V
	 xBmoHGDpHfkQaNqQ6lvZ/RrrB5RoyQOn74TEazhSTsN4iZFrYJU97au0nfufLeC8VA
	 T7e268qtF1F6w==
Message-ID: <sashiko-outbox-218073@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] smackfs: fix IPv6 netlabel prefix mask for
 non-16-aligned lengths
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <49DF0992E528A465+20261117021108.209924-1-daihongjian@kylinsec.com.cn>
References: <49DF0992E528A465+20261117021108.209924-1-daihongjian@kylinsec.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 02:16:27 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> smk_write_net6addr() builds the partial-word mask as (1 << m) - 1,
> which keeps the low m bits instead of the high m bits (e.g. /33
> yields 0x0001 instead of 0x8000), and stores it without htons()
> while the address words are in network byte order. Any prefix with
> mask % 16 !=3D 0 is truncated to the wrong network and mislabeled.
>=20
> Take the high m bits and convert to network byte order, matching
> how newname words are stored with htons().
>=20
> Fixes: 21abb1ec414c ("Smack: IPv6 host labeling")
> Signed-off-by: Hongjian Dai <daihongjian@kylinsec.com.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/49DF0992E528A465+20=
261117021108.209924-1-daihongjian@kylinsec.com.cn?part=3D1

