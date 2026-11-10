Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280416;
	b=L4di0OqewD1KGRTzSBXVx6KvfPoh4QbXGtoHNAN4YAtEV2EKWCETmP8fE68SwdKX7HFl
	 9HODV6nPoDPD3MMrHk9V4x77mTmiX4uEqgvMrKbPzhBXJ/0KfSIW1oQH5qvE9BP8o5KdT
	 T0xFnOHklUxgpFpciwBpZytnaoZkqc7kc9DiKTEZ5zj9VfxIB6dfQJH6ILfUxhn5+ZGhV
	 9bbxe2lmwukhOz8qVzuMNCFxQr1DLolwEUld/YGjI9PwcYFlfOro1sa9jbBpkeErd45Mb
	 03253oHt5CyX3PM1UF/Sx/dl8blaR9jdo1+tWKwUGUiAB35ubbC3gLlelZjO6YLvmjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280416;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hghRR0o6eSXGtta75QKnUkysQygkNLiJEnODqWWmUBM=;
	b=HpnMujlhb356R11Wp3QoA5wwFY8wXawRKzYtNMn431yhr6gl15R1k63Yjyk0lIjgAXBO
	 Cs7w8otlA+RJaEH/78YiUi+yCKTTJ/37cUHsjyFxb+jXTeXkER3dfwufglcCRAcjPz5CG
	 iiGbRF+FIuytCIFndGFJhCKiqhnIbh9ENQ1oo09sL1HuDkGh+ZQCSTxX0x6MkEkpt1pv3
	 JeyXnUOpmYI3LlBdkiArpg99zgx+382P/4VDt2KvT5gVMKJDODKLRERAWJZoeQpRQ1Pyv
	 UDC5ZZa7GboSA/Xpa+A9946bMCJyBB7yG60qQKZ/1P/t79rmSaTIQj7qbnWTjCUc0Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=icqXEXRf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AE260A3816
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 03:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=icqXEXRf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0317A1F008A1
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 03:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280416;
	bh=hghRR0o6eSXGtta75QKnUkysQygkNLiJEnODqWWmUBM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=icqXEXRfUb4BNapjipXwnjkNAALTUkK6mxMELDqtGi1+6KTQO4YibWY6FDTL4Gy6V
	 G+2R9/dB56rgVkOXJtjTJObItiRO1TEd908Cyk23lekTwR+vPifeelsIvqUFq9kuxl
	 0hHvk7YyJB3RjyWNHfTOb1reopz1qBEY+4B4DVmTDGtG1vqw+WasmyYJ3YpX6jQgEu
	 kbO6gNmLSipcHhqXJmcJNCOGor6gEX2umE5rujhOruVuc4p6IguqZyg7W+x6lUl6Lj
	 RlOxZt3upNW9XWpt8BlWjHkC1z+iSDWujp5b++Xtxn/J2TAw0Vf3DhjpK8jZBnHmr/
	 G1pDrgNmmgg+g==
Message-ID: <sashiko-outbox-206096@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] KEYS: Protect pkey method checks against type
 removal
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110030252.9979-1-0xbeac@gmail.com>
References: <avJ4KM-Erci0FkgZ@kernel.org>
 <20261110030252.9979-1-0xbeac@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 03:13:35 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> keyctl_pkey_query(), keyctl_pkey_e_d_s() and keyctl_pkey_verify() check
> that key->type has the ->asym_*() method they need and call it later,
> without holding key->sem.  A reference keeps the key alive, but does not
> pin the module that provides its type.
>=20
> When that module is unloaded, unregister_key_type() waits for the key GC
> to process every remaining key of the type.  For each such key, the GC
> takes key->sem for writing, switches key->type to key_type_dead, whose
> ->asym_*() methods are NULL, and destroys the payload.  If that happens
> between the check and the call, the keyctl calls a NULL method; if it
> happens while the method runs, the method returns into freed module text.
> In-tree, turris-signing-key provides ->asym_query() and ->asym_eds_op()
> and can be built as a module.
>=20
> Take key->sem for reading around each method call, and check the method
> [ ... ]
> against type removal").
>=20
> Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops=
 for asymmetric keys [ver #2]")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuansheng Yang <0xbeac@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110030252.9979=
-1-0xbeac@gmail.com?part=3D1

