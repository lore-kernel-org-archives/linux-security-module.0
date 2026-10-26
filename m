Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793050102;
	b=g9ps5c2870iOo4MGrIk6KiwQL92BurUbhOAd7eAaCoE2Q3wQPgNUoroCZ/o/TGtBZyhQ
	 eHr/+7zPs13bAhZcxkh7xcPJBIM6BB+GNR/VHoSx+TTyX4Ak8V5mgJFQNwzb1Zw7DCs+i
	 S4dMkn2IKSdisb7jaoKVOTjVgCYOQYZo3jrg5IH/yuPsd+9qnb1WgUfThV9KJOPYyqfDl
	 ZmrwffbaBmfOo50TxPb2N77IOCpwy7pOTSXLEspGmRdG/yJUSVeePqSf8IXO7bXQfvwow
	 rWANsHbF119CWWVQPYXF4ay16yhW+u4nPteR8ZVFBvc9tb0S1IgnnR/oSPVX0hwdSLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050102;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L77gFSxA3JcmOYfbu0gwsYbBFN8rY6HuyXXDXaY7l/Y=;
	b=i9qWz9QFvBUs83cWBv1lI4Q0mqxDG7JN+onPrLbcD7HHf9TrpH/S2/yYbfTel7Et4HjJ
	 Ow5DiBX/HsW79cL+TPKIoXDhsj0+S07HEZGdsg8UcMjfAHYKu6e0smK100+aiAGVJzS9W
	 vOEmPV9n4PnmCocafCjNTFxviIy5oEX9m9ZrtRB+YWUeSk2fp94Bz7eVeQe7noSIKxWaS
	 3jouNofHadeW+vf4rqU9X6dH2GZMImGWX9KflV241XIiWEU48e8Zc4qhNLg2iCKN0tFOW
	 QBYnm48NVPolcnD/vZ3DTsFctB056Hk7k9LFTLoI7AadTOSFHGjR8hH5TvcA+lGaXYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dWLR5oTT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D6A606A31A
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dWLR5oTT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087891F01825
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 21:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793050102;
	bh=L77gFSxA3JcmOYfbu0gwsYbBFN8rY6HuyXXDXaY7l/Y=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=dWLR5oTTRgiuP98cSylrmJf9XNLLw2GXwLpYdMx0M92aVymNqUUK7i4k6iDPwXKrv
	 B9jeiXyQHP9GZVOt7v5hvJI3Uv+qufr0wJi2jQ6p7lwwcL66tsYpnx9YRQi83P8tTN
	 iaU8F/6zZtVOgq2fOUoBzxJ1BNb6E8nrUV3K9cU3/mIc2KFjFpiBdJbxhw2kYK7Gqu
	 3TUyEjb5E5WWssbPn8L0mbXWrdBxZYOT/gWMzd0HB5MVhoklulhzy95vgcWdrfib+S
	 PhxzIqYLRBz/MrGTKvJ+qwyN1QjpJS0YOdkkpDSrBIzj7Yp7C8EhvPfqE0U2IssnBP
	 tNtlHBzFNjDLQ==
Message-ID: <sashiko-outbox-185751@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/6] capabilities: limit fscaps to where CAP_SETFCAP
 reaches
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261026-b4-setfcap-userns-v7-4-bf8a576f7259@toxicpanda.com>
References: <20261026-b4-setfcap-userns-v7-0-bf8a576f7259@toxicpanda.com>
 <20261026-b4-setfcap-userns-v7-4-bf8a576f7259@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 21:28:21 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> keeps a root process without CAP_SETFCAP from creating a user namespace
> that maps uid 0, in which it could attach capabilities to a file that
> are then honoured outside.  But the map doesn't have to be written by
> that process.  A privileged task can write it from the parent, and the
> file capabilities are not checked against the outside at all:
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>                                     unshare(CLONE_NEWUSER)
>                                       ns->setfcap_level =3D 1
>   write "0 0 1" to B's uid_map, gid_map
>     A has CAP_SETFCAP -> allowed
>                                     setxattr(file, "security.capability")
>                                       rootid =3D kuid 0
>   uid 1000 in the initial namespace:
> [ ... ]
> an unprivileged user does in its own namespaces.  The rest gets -EPERM.
>=20
> Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-b4-setfcap=
-userns-v7-0-bf8a576f7259@toxicpanda.com?part=3D4

