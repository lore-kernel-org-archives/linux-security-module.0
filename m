Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911279;
	b=fUr8PxIJosCOzlZFgt+UYA1CiXC8gWo1jc4FpeOUh72sIbgcPL7TBla3Zj7bG4s8kzCi
	 lbCjUnMbPUsHVb63P5UeV0yW2PsPLRjB2bu0q7+hNb1lCpAkwl9AsL9b0OT/g1DXwuAez
	 wyz8u/bFFftt4OAT4fI62Jvz6noERfJIenmu7cmyoXhVacVPX/LQJtlW7gbZpHzZ1K31F
	 SbC0py2N/p/udcPuCP6m4Ww4DqTchULPWywhPDQ4h7XhQm43ml7uNKWEzrNQXPui1SD3W
	 EOK2bp5MGWcz2zAbEmCvfxGHqdnjockmKPDqtfVi6BU0pERBOHnFVuF503DJ3EBTYUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911279;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aIk+5XJnmyj1qXukMjNkA+RU1ljG1J/Spq0vwM056DE=;
	b=cVKKBGCc99+zYChyE45X2xqsULxXiV6zMNBnUDBVpLvfbpU0izO2yIsbMWLv+p7IYUPC
	 d+Ojw9b+JkeOhjSgFQF8H5bkcDCQ2BuLUM45ggyElzQw4fwVb+xEE8kaftSHoMwAEFMmq
	 pbr5kGs/uAO/EbVvmSFJNutlrbmx2kcufoq42ULJtTiYtlcY86NlpjCt4PZ7R7ofhS6OP
	 L5aw8LjG0H3aCKjFyr0oehi4DbuK3i4mNBFxtjAYicVabPd6/p2LRuRNL249Q+k4FjCZR
	 uYees+MDK3RGh7HVyfs1tUpXmD83hCCmmWhNXcstHhOpqkGJO9OBkbzJ6/tn5ljNMpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFbD7jM8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6A5606A890;
	Tue, 17 Nov 2026 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFbD7jM8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7611F000C4;
	Tue, 17 Nov 2026 10:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794911279;
	bh=aIk+5XJnmyj1qXukMjNkA+RU1ljG1J/Spq0vwM056DE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=VFbD7jM8Wf6zu2xL3XDy027GXFKSyFT+PElwteJpxAvQ9XQOMWSoE+J//RgD45afX
	 Jvrqb1qDp0Xg9oLeLSMlzOOnrDdY8w6gu0mA1qY5ZWOyPQ4cx+Ch6APtmoyNVyyD6K
	 f150aOFBhvjnYxqht9yZAqW1I/Qt+Fk1tykEbqe1aCQRG0Hmcpg6QPx1nVl/7S1uRv
	 AE6WZA+gIgoAUqjq7r0lMm5+CZWMvcU6pRf0HTTYuroguC42VSH2/+Jl9+lHJNZRWd
	 SZ1Xwvhj2SF60VtNfN07gEn1lp9a3yKFdfDUwHfKYSyYxv01cmn6O6CGJTLNL4DKLH
	 kMLQn4v6nP/2g==
Message-ID: <sashiko-outbox-218621@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] landlock: Add capability objects to denial tracing
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261117102110.2524197-3-mic@digikod.net>
References: <20261117102110.2524197-1-mic@digikod.net>
 <20261117102110.2524197-3-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:27:58 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The capability denial tracepoint identifies the capability number but
> not the credentials or user namespace against which it was checked.
> Typed BPF consumers therefore cannot reconstruct the authoritative hook
> context, especially when a check targets a user namespace other than the
> caller's current namespace.
>=20
> Carry the exact cred and user_ns arguments from capable() through the
> synchronous Landlock logging request and add them to the tracepoint's
> BTF prototype.  Keep them out of TP_STRUCT__entry and TP_printk so the
> raw ring-buffer layout and textual format remain unchanged.  They
> provide context only and do not participate in Landlock's verdict.
>=20
> Do not carry the capability options.  CAP_OPT_NOAUDIT already suppresses
> the complete denial record, and the remaining option bits do not explain
> the checked security relationship.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117102110.2524=
197-1-mic@digikod.net?part=3D2

