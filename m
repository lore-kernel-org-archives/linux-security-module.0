Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187816;
	b=JRzmVZws/QX6s6QaUzrGBAFpqhbejgohVhRbP5nai+lDyAxW+QAyl6DPkUU/R4JwJ7XD
	 GuwUD8D8CKKlmJ3UrGHB3NeXs+dAAofdLwMQTutzO4HICDOvTGOUOggPeCMXDMeKvnj8l
	 0mugpLPCNSlvtSY/eR25ePDC3Jzf2yQy5o8EX/uHTq3yEytgt2ovNfyUyOC6WPQdw2yGL
	 /h9Z50dUvbNgaNkHiCTwt4t5djlhuiQP8o/nVIXAgz8+L5dBS8lWan6Q8GlRm4iUMeDeI
	 IiWPDO1+TTS6/G913OPjlbLvcWigaEP1XueYdJi77g9+CGZ3V2lKAjg7LqiUAv6daqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187816;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=diWUs24HVm8w32Wt1QKkaOELoQa+R8agKgBpUTMjBkg=;
	b=vI3dUjoR8k/qk+CYhH1eqWVID3yessY/jx9p0s8VeaDzxv0XeIUe45aX8owNBV2bkj3l
	 8LJjjXk5ZizwAeuaMPaZlJsqH4oA3sk2eA0PzYkP009t7J/p5igsB82ABveXVOFnkJB/8
	 FRUXO65i+P5ZuM2BWToOL8HIv+YqOZpVXKff9gqhrTxfzu9U0BjuprT9+ZzNPbbtu/NWh
	 P/IJDj4AC8Xt4sNwfaRs09bXt5QFsZmfvZYckc1W7i4Qy+vuTTvbmZAyU6jjlvLQa364B
	 lFSt5JnzyQ5eZF2904JeEf/MZGy/hE1IV3FDa1UTlNKxI6XOIcecZfBZqrkUW30ES9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJ8paLPm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A92606A31E
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJ8paLPm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1151F01828
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 11:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793187815;
	bh=diWUs24HVm8w32Wt1QKkaOELoQa+R8agKgBpUTMjBkg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hJ8paLPmpbURxjYpayudyZhGv6i90i22MVdORMgW2YZqLY2ON0YUSnPXqXL8nb0oI
	 ky8ze4FmqNI8CHFhPAoZE52F2OND7UT64G+1wdRFrtngjNjXjDGvl0vGr2vMmSfy3H
	 F31pG7votz0oPWHk0/1vO1HWrQLnmXAKcYoc4TyFo7CennbhYvX2IusQv90bV8PUWi
	 9ejXMSM63tdyn/9wvnWoWxr+ErjSmR9RXdu9VMQGocnUd92DuEMAN+KjqkrR1jCIYe
	 iQtha/wIcCffCV73+xZqesscutvnJcIT7rFz1h7A9/9t6hBv97DqrqyF6Y2re4oSCU
	 BTt1UKIrTrhjg==
Message-ID: <sashiko-outbox-187838@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] mseal sysmap: Allow with CHECKPOINT_RESTORE,
 default off
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <7ff59c2ab6c234ca4d799f862eb7c3f22d671f99.1793094611.git.chris@chrisdown.name>
References: <cover.1793094611.git.chris@chrisdown.name>
 <7ff59c2ab6c234ca4d799f862eb7c3f22d671f99.1793094611.git.chris@chrisdown.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 11:43:35 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> MSEAL_SYSTEM_MAPPINGS depends on !CHECKPOINT_RESTORE because CRIU moves
> system mappings when restoring a process. Now that sealing can be chosen
> at boot we should instead use this to determine defaults.
>=20
> Let's add MSEAL_SYSTEM_MAPPINGS_DEFAULT_ON and move the dependency
> there. Existing configurations retain their behaviour. Kernels built
> with CHECKPOINT_RESTORE can build sealing in, but will only seal
> mappings when explicitly requested with mseal_system_mappings=3D1.
>=20
> Hosts can also share a kernel built with MSEAL_SYSTEM_MAPPINGS=3Dy and
> MSEAL_SYSTEM_MAPPINGS_DEFAULT_ON=3Dn, enabling sealing only where needed.
> This lets hosts which need sealing share the kernel image with hosts
> which need their system mappings to remain movable, which simplifies
> deployment.
>=20
> Signed-off-by: Chris Down <chris@chrisdown.name>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793094611.gi=
t.chris@chrisdown.name?part=3D2

