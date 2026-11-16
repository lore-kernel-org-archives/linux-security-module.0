Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822643;
	b=nnfZjTwwolPGmVU5Poer74i23MJFb6WLRScnIjCfCZrxX/1gV7k5W8vZHQQ2i/Owa059
	 NQTgnBnYbqbfPrbIF3M0dNNSaadUs7Q3H0xn2KbWQWqBLlgefBTxiJRajPQXg18ujzAKJ
	 Ar3JJHGVoyVvNK7EBCrHhkw8GQInLxEwOjsFmGpfUeZVbYN+BiGiw4719Xx21E8ofV1kJ
	 EcSg4S+j5Qs+B5m+AMccHiRRlBF5Fc1QxxgHIYqhdcmFai/NvV/37fxzQyDYB8yR2YKF/
	 Ttf44mRCU9E3iwBu3it0GWQs/g2iGQdhw6dVnfgznFDa3Ei3znkz70O2y4ENt4VZdfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822643;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MTtsXbnKFN4zO8iCau3AjRHwFgYH9/iS1YGrvIXli6c=;
	b=GJr+fuyzW0ljXCzEaBxTwOpVOrlC4v5Yd3id4MLXzVYrnCNWFEOSqlRUnCnSt1ex2vFU
	 ju1+K/Hky/AHS7L9KR9M2Odtlh/G2LI9RHI/EqUOj9qIDnC6dJZ7qvCnlnjR4Ar40Z7TO
	 /yQt+f2og7vXSdySlPnw1ljS35/1gEWxGarDF2jFm22du8LJ0w6h7G7EE2scTSLGXHH3k
	 4FuD4VpSkslHMHq9Oqls+EqaukFMmgINgUFRVLoLp60CrjBLcY34IeBgdmAXHPC03e5Sd
	 BWBECxdP6t8NpuIZLy33Jygvts+zDbcRyyNoe84qtL8GfiMwBQOnpY6bDhKGnfR/6Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FtkTx6MM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC03606A31C
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FtkTx6MM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4F81F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822642;
	bh=MTtsXbnKFN4zO8iCau3AjRHwFgYH9/iS1YGrvIXli6c=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=FtkTx6MM2yErHgV1WfsVBEFyh3IfFerYIETo7ZkPKOH4gdiTkYc1ErmCoZWGAp1LD
	 TCVbqS4NdRw+EjmTm+MEccswOEt9TrokmUKzf07JIRmWfILqFXqtaNXiElYtPU10aV
	 ndpr0Zhh+Ron/Zd96yKNWVxrwWMmfSrN65/XTUxqnp8Ji7lsZysa6URqvXgKrYLN6H
	 TQu1sXXXu3SIPahP3OSPyYuN+AzxYreToHxDzwyLVH170NjZ07IbPX0HHGM7FvSXlM
	 Ez7q7u8AonEXcGonnygE0g0z/74MrdHPYROvwWSMOVxq5CoE8tc5PsRJTkGdxGpO+V
	 gqxKjmD7OX2Rw==
Message-ID: <sashiko-outbox-216648@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/13] fs: remove d_real_inode()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261116-work-ovl-d_real-v2-11-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
 <20261116-work-ovl-d_real-v2-11-90564c4ae347@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:50:42 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> All callers have been converted to d_real_data_inode() or
> d_real_metadata_inode(). Remove d_real_inode() so that any user we
> missed, or one that gets added in another tree, fails to build instead
> of passing an ERR_PTR() from d_real() to d_inode().
>=20
> Add a porting.rst entry.
>=20
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-ovl-d=
_real-v2-0-90564c4ae347@kernel.org?part=3D11

