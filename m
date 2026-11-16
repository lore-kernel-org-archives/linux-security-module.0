Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794872060;
	b=kmJ3i7U8Axz9bz1pjoFLczflEKNC6Px84w4Y9DJWiQyR3/OLecKddzfb3c9oFFO0l11g
	 3SWyq23v+a1U22JE5cJ3JfqAk1cPdqwVdgE8qiPoebxTkDnaDXmjsqKm7IhWqOIj4D8ef
	 DVoSVsnYXaxg8AhM/BBlEcIIgEViuP+ndglFTGvBTfWGzH0hKQ4uKO2IulOwNBwVWXrkC
	 iP98D5PMRntk53c35guDeAaw7alzO23pmkb6dQusK2H0m66XjVs+3hdiDZuC4XGtBvfbG
	 gfAKK7tfmkYfqRNMQBZJ/HSZWglczK8Gna1S5/gVJhAnBXZRaHDlMjFIMm1Ajk90wvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794872060;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GwvR45k8zPfj3VTiaJFvI3ldl23A4KkDbuYMS4+sMDo=;
	b=ZPwODjXt1PXgJxBfJasmVyiSmocq3Df3C8zglDXOLm720h0OeaXLLykkdyJxxHdmdUmk
	 VKu8j1GEx4vTAYNFXSpcdg4dhebcKocGG10osqEgQeeQQDifhsQKnEw1474i3oezUET/b
	 KRzOC35Nx2bH/58aV6zzjzu6Dm8ralLZF3qXgf/aKCYcaVQkSegNUNaVcPgSv/ta3Q4+R
	 j3eMRk2uYlftWaZ0biH4Tj5coWAxDW7Azd7vzz1YsLd7wAX3b3r7Jfa3tbdwAqF/kR56R
	 hIY49258s/jNcIMywnllYupD8BIaSqdMeJGFejS0sjHzz3aHNKFIS4/1ZRM6gOu0+8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I61G43U2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3240606A31C
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 23:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I61G43U2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A811F000C5
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 23:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794872060;
	bh=GwvR45k8zPfj3VTiaJFvI3ldl23A4KkDbuYMS4+sMDo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=I61G43U2FKULKCSzg+sUjnfKZKxsWaG4d2E5UI9T65K4YzP4kz52Pk6Hr5Mf9K+n1
	 16x2uubY7DqfY4bjXSpYPu87JGaogOKYKU/mcywfzfixOob+lj+6xUE6jb34N4/ZHd
	 6RzgpohHfc8ej1OTONKJ91r5e7v8DlOMhnkWy4MNH/gtPr5HCSqlozdTGYGjHvdpC1
	 TyzBXXYPUixxyeT+b+78O+QAHttwLZqC+ogKyaB6GjZJ3UowQlyf57JDLrWzEsDEb4
	 TulJ0DW2D6FeLFMmyBmA2I/talhri61FdWS4FhCeMLn8/vJ+et9Gf/K/+nF6YiPY9v
	 QuajDoLymiwiQ==
Message-ID: <sashiko-outbox-217897@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] landlock: Add missing EINVAL case in the doc for
 landlock_add_rule
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261116233139.206924-1-m@maowtm.org>
References: <20261116233139.206924-1-m@maowtm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 23:34:17 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> This is another way it can return EINVAL but is not documented.  Document=
ing
> it is useful to help rule out errors.
>=20
> Signed-off-by: Tingmao Wang <m@maowtm.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116233139.2069=
24-1-m@maowtm.org?part=3D1

