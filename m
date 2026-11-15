Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794752123;
	b=GR/Zsrl1tpZION+6tepCljYpN/J1ZClfWhaZQFawqzKkUl5NDXuQcrq7XhDcuEUWlQeP
	 le3pUA8Hohe/jn3BCo7CJSdIVw4LEUxZhsHpyMpMcD3wJQqqHFdn2Qw+p881zZfPo4Vx2
	 rYCNWyRT0xFOXWhdKgw7xobTiTkgg4ZvOrfTPlawJ+w+KRVpTXh2u7eFrHiAbpePJC57f
	 a/ObPJ3+WsHIAYfCHIdHpoBPW+zBvS2GKcNlseTTUzkn+E/2AS9x9E9tqhLsRP7S382Dd
	 L06Dh3G84P1k4dntct0FSpldYLdNy3lRTcb8cCglXjTPF8KqsGtr6Q8w0KbqCDMu3UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794752123;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=icnKsybTx7tJaqhK3i+99mJT6Tiw6OT/qOObe5yTVtY=;
	b=BHjCIY8XT0rMkQe9Hmy3Tp7Rs2rF5fyPgY3VWm9I6E5K7qf5rU3PXyEvGqdvPp/oh5U6
	 XAdUqrEL7gTvwOavLulR7eXB7D+mDFhxHP5jojWI4PXePXbC6FhGFA+c8hgn4E6Ukn8xm
	 Z3mbhFDA3OEqqd8ORk1mqYbDFwxijCuPZV2zhN/YbdXG+JutjCcpV2dZQXlXtMZ/xZOv4
	 jvDB4SXJqrD3jF1bNlW+ndZ/JLvjBRG7Hqu2LS9VLt7kaYyxOm/wObqTVF2DxldtUKXO4
	 uANF+KBQmxYzilP2fxmUtxlcItTPsK+NfnAKRlhoZtCrx2hkSuvxzVnnxQXzuNx2ePQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lgEm2PJC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD3B606A323
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lgEm2PJC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130361F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794752123;
	bh=icnKsybTx7tJaqhK3i+99mJT6Tiw6OT/qOObe5yTVtY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=lgEm2PJCZcpNhfCFIa7PrZzQGdtyIFvd163L+Kg8qGbw/kzAdTMsibiWxJPyl3SDY
	 z7BB0rZZesNH/v0Gg2tWalpSVVVac0nQkeDhN3lNl3iGXacmkoRHAdL9y6/1IMPxSd
	 DO8PwxYPZpNGBc5PzUSEGIn0ju7zuT1a2jIW86mecrUWzRHZZ/DV9LSiT2JHOEVlYj
	 VkFwq2t2HRrfANoJDimNioEACcx9y8yR3YQww/Xvj/FDCGD7mq6R5r6GfYkkx1VFUB
	 NE+M7dRrF1FOAmeQ27t78aXvpf6tp2a8E7w0vG9ySkvm3aWYkw4XmMJZMU9a8V4vN3
	 SIASeLGBeSrMA==
Message-ID: <sashiko-outbox-215571@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/13] ovl: return the error from the lazy lowerdata
 lookup in ovl_d_real()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261115-work-ovl-d_real-v1-10-ca155efbcb2e@kernel.org>
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
 <20261115-work-ovl-d_real-v1-10-ca155efbcb2e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 14:15:22 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> All callers have been converted to d_real_data_inode() and handle an
> error now. So return the error from ovl_verify_lowerdata() just like
> ovl_open() does. The lowerdata dentry missing after a successful
> ovl_verify_lowerdata() would be an overlayfs bug, so keep warning about
> that but return -EIO like ovl_open() does when it has no real path.
> D_REAL_METADATA never looks anything up and still can't fail.
>=20
> Update the comment in ovl_d_real() and the documentation of d_real() in
> dcache.h and vfs.rst accordingly.
>=20
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-work-ovl-d=
_real-v1-0-ca155efbcb2e@kernel.org?part=3D10

