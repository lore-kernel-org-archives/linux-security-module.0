Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275526;
	b=FlV6AcevFjMA6pWtIFJOLtud0Cz2wYT7lbPybMqwGyr/rB6TiU1PqG+QUVkuU+yG7XVX
	 fVaQwD5PUpMe6A6mlIw0qIEEH8hUgs9XErrKq6tNX/C/Nwnq8bsMx1yLuWdhGDr0bQGZm
	 hUpO3HGxcEuFWYNf0jNdTSATSA1CV81WkVePDiycVDYH7Yn9elWamIYitmGunb9orOTqS
	 wcH8nyKAOp6ygdKXs4cI4Wd0rf3ECD5dUB0BA1JP+bv+E58DJMZi866zD5CUrbYaqPedQ
	 GRX7NLkver5nOQ5UVEsiKTWzuMz8XTo4T0pIhCML0c2s05l9HLVlKsHx0MxYNmKZn0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275526;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FJ7NOTlWT9kfz78ycD3ewXgQFLQZHKtIKqG0rrFAwPE=;
	b=VT6LIrU60IMSniMhYgNRHzUrs0S3USTwa1HNlRMTYMuSDDUuSu+hWQDy4mV1M4/TBev5
	 j6vm2yhp+2RPtS5Elv0ey96lr0NWITpr8lr23GxIAiOjMkJXkxIAUODnHw5ysMXiUNqi3
	 XDOUfyxCWdMCpWVtVnlcvuHU0LuZhHV9+BHQ0Y42+N60ZW+M4+qMw/ye2GpL6RH0SQ5gB
	 eNPagR/FhEVaAKCk/f9w+gyRSoYmKIfa7QztSIwQAkYYH/GzO4MPBsB1vEJGTMyZgnEGn
	 13SPB5cbrxcp59ujncFYz8PXzNaFeGGRLBM0Clk2eFadtisuWvGrUz3S4qEdCE6vyfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="H/5szwas";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EED4606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H/5szwas
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923121F01828
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 12:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793275525;
	bh=FJ7NOTlWT9kfz78ycD3ewXgQFLQZHKtIKqG0rrFAwPE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=H/5szwasp2y420ObUKXmnz5r/c/WRKmMYWiRNZAVt7BHm6W7FrGOqRAU7A1pLn4va
	 cwSSUAP+AjbQ+JXIDL40CVFcN/z6/xZzayPxP++hy4lYLftJd3sbbIbzV5xfFo09z7
	 bwN7vm13jZy4O1UVueupuGHE0nx4tWRB6I9+7UnOyOunHQl8x4BTDndON0WBycZFah
	 RSjyIMLZGINTwQRjm/BjuJuCZptKO3Lp+SXy5uBUJdfrVqYRH9cur87hUrE96Kbugp
	 uFVgMBoCCgZ+uyDu0Eb7xzgsutoroPG6Dz0VTOP/sgkb+0WDQekPndhs/5KEjKrPgU
	 YtOhfIlbJexKQ==
Message-ID: <sashiko-outbox-189252@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] keys: Protect the update method check against type
 removal
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <pm-keys-update-type-removal-20261029-v6-3d92b2f9693854230a02@gmail.com>
References: <pm-keys-update-type-removal-20261029-v6-3d92b2f9693854230a02@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 12:05:25 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> key_update() reads key->type->update, ->def_datalen and ->preparse
> before it takes key->sem. A reference on the key does not pin the
> module that provides its type, so KEYCTL_UPDATE can race with the
> unloading of that module, for example dns_resolver:
>=20
>   KEYCTL_UPDATE task                  Module unload and key GC
>   ------------------                  ------------------------
>   keyctl_update_key()
>     key_update()
>       key_permission()
>       load key->type
>                                       exit_dns_resolver()
>                                         unregister_key_type()
>                                           GC: down_write(&key->sem)
>                                           GC: retype to key_type_dead
> [ ... ]
> method and key_update() returns -EOPNOTSUPP.
>=20
> Assisted-by: LLM
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/pm-keys-update-type=
-removal-20261029-v6-3d92b2f9693854230a02@gmail.com?part=3D1

