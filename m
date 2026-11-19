Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795120921;
	b=e0GXQ1nCpZOoyEE37z4SV1HKIFxVguIquWuj7OT/L6Abvt5/K1cUiotEQDlpAjKeLTNn
	 mUifQEE9Myl373KxvtkhMoYfVhbW4fsw9T/oQseGaApoAhO9GY74d7qSBtuQJ1tDuZBTp
	 N3ZeOCAN1cg+WYzcQtG0dFRXukc6+sG6FRW+FyAiQcz6sjpBZ/DIGjUicxxHZkaA1LNOb
	 +6Bap9M4pl1mxZiDT6vs6nGFj/kOveLrx4oqwGfJbxqUKM2YijtN8cVRhOodZwz75Xb0C
	 HM5GtU09QdYEKbHk96gEvv3T7HqvkeS29J+cPhzpsndHLzokfkh2P/tazVQIV8WawAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120921;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CITnywdmdusdb5kiqy4ua5csjLbLO7yj+VwdlZYF09A=;
	b=hitKZimcOyi4Mr8cZGJ9TfBlbLy/iI6PuS2OwryEbXymF3QQKA7D2+zFdCTCnarPQomi
	 gDPO+ELujoZnzHXtVIn8GqI4p8Sv++j/FLSzj9a0hh/tufOTXuYu1qn8kejBXhFPfW2oc
	 5kT/yC7dvbXv3979By2FTjYq/Iv+f+oPUXDmzJOUjRj6v0ndimUa624mcaYI3YBKs71to
	 lgIXVuv6nauof/BThvWZBun/oWQBYnjlD8I6kiJeg5rPb+/BrGZ//sNYv3wCWCjFO6LwU
	 LeBDaQhyr9D9fBgCoVM8Tl2m7dyUL/nSvVsK/YceHSmCS5TR70E27HtUdJ5Yq7Ilt8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZgC4awmJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3F4606B762
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZgC4awmJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80E41F000C0
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 20:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795120921;
	bh=CITnywdmdusdb5kiqy4ua5csjLbLO7yj+VwdlZYF09A=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZgC4awmJGRCWux96iuqC0TGxY6WxryBSwE5lPaTBf9dn1hQy/O+P+QE5Lt+vVR0TQ
	 MM3zJoAawt0gezE34TFX+crjhWBhgOb29tgKQvqq5GXz1pRakE7pqUXaV5SMEtkk4+
	 DtbTV/GSU69NQkjqhz3o1b+O4xMJaMU3jhpTdPoz5p21FiTkh2GbMd91d0OpGxLkcB
	 4B7gT9FtsoOwxuhUM8JERXk7sEI61VTFnbaacaSq0b4erOrKF7Snmy34ygCtpB3yxC
	 CHKHKxwCofGEBW0Nx9qmbjQY3REW6pKLsngAQLdz3digRYwFFdYhwi/qTl7X9F7m02
	 0ab78G8Hty6zw==
Message-ID: <sashiko-outbox-224039@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] apparmor: fix label replacement compiled out of
 __label_insert()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261119203650.51147-1-andrew.kroh@xata.io>
References: <20261119203650.51147-1-andrew.kroh@xata.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 20:42:00 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> __label_insert() replaces an equal label in the labelset from inside
> an assertion.
>=20
> 	AA_BUG(!__label_replace(this, label));
>=20
> AA_BUG() evaluates its argument only if
> CONFIG_SECURITY_APPARMOR_DEBUG_ASSERTS is set. That option depends on
> CONFIG_SECURITY_APPARMOR_DEBUG, which is off by default. Without it,
> the compiler discards the call to __label_replace(). The new label
> does not go into the tree and does not get FLAG_IN_TREE. The caller,
> __label_update(), then removes the old label from the tree.
>=20
> The proxy of the old label points to the new label. A task that
> holds the old label therefore moves to the new label after the first
> profile replacement. The new label is not in the labelset, so
> [ ... ]
> result.
>=20
> Fixes: f1bd904175e8 ("apparmor: add the base fns() for domain labels")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrew Kroh <andrew.kroh@xata.io>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119203650.5114=
7-1-andrew.kroh@xata.io?part=3D1

