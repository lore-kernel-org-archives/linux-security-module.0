Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061613C3F4B
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791441869; cv=none; b=ZgoDawRmgypUAyvHtgno/vhFKzODdjJuuUW6CG/5j5cZlFNZSdz1P1djd09XmCbR3O04uMckds9krc+xLD/wDAdNPFtHeGAOVaVEGbM9mrNwUptNRL/iUlc7x9fxlUbIreVfntcaomfstu2OC5LSc7U6dt/F3U9tqwRo4uT35Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791441869; c=relaxed/simple;
	bh=puNdJMLf8Px3IymagolxhUqnjAOciWCJ4TlJ3chGhvk=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ps05EKZrCt/v9bF/cfLjXcchp1XIPepKWfFVqAPjOSw9z2IVTEbv8uSaGSkWxppx7Hi/Z7EuECHUaStK8ycb91WYXbeGbYX4EaV0xZGym6G1AamXc+Ulzyska/pHcZRZxB9hT4a9/mGLHIFXUuBMmUFmnU66t6MoVU+FLsLRNmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nc33KsJo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nc33KsJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F301F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 06:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791441867;
	bh=G//nGS1msz6iTPI+RI0bXyJDZRErAz2aY6adbzcQwvk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Nc33KsJo8MsL4jPYmN7oc0VFDU1IVaHqJYYZl4GAaer8EDQyXsn97ebH2aSH1gqZF
	 R17x3k29AEnKdRl7YZhynJmEeDWCxS68+C0zabpsHeHiaRAY7/poXeUxJACz3Ed8rk
	 Ld0pCkDYVNJOsUrJSRZYpuxsF41ku6lUqw43Nk0eKAp1fbwHUyUf1Fvo91/8ZTfP7F
	 TtE8hG72oCFhqdVP2z+b0hMfu8aGHP+uR6Mrti/nSaoFCLuUbVRVbCI8+DqyTZIZm4
	 Y+n+NvhVEJ1daQdWcAbQxCaD3cjrXAD/TSFW9/PKU8rO8jAKwXJ5qVu6z9ENQ0TutG
	 pIxhQ4deV3mRw==
Message-ID: <sashiko-outbox-163711@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] keys: Avoid the owner account dereference in named
 keyring lookup
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <pm-key-management-objects-candidate-0002-v2-dd6c20a1d92928b33ab7@gmail.com>
References: <pm-key-management-objects-candidate-0002-v2-dd6c20a1d92928b33ab7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:44:27 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Named keyring lookup must keep the storage containing the owner UID
> alive through the namespace mapping check.  find_keyring_by_name()
> reads keyring->user->uid under keyring_name_lock, but that lock protects
> the keyring's name entry and allocation, not its separate key_user.
>=20
> A named session-keyring join can overlap a privileged KEYCTL_CHOWN on
> another CPU.  If the keyring holds the last reference to its old dynamic
> key_user and the ownership transfer succeeds, the following ordering is
> possible:
>=20
>     Named join                         Chown
>     find_keyring_by_name()              keyctl_chown_key()
>       read_lock(keyring_name_lock)       down_write(key->sem)
>       load old keyring->user
>                                          replace key->user and key->uid
> [ ... ]
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Fixes: 2ea190d0a006 ("keys: skip keys from another user namespace")
> Assisted-by: LLM
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/pm-key-management-o=
bjects-candidate-0002-v2-dd6c20a1d92928b33ab7@gmail.com?part=3D1

