Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795043708;
	b=nShTeOBATOIi3dcErEl9NavTj6wZl+IFIwsYSpgYerQ7u5/rJp5MqHp87glx31ZbOV3D
	 C2/8/Xtc6mrkHtkLXztZpThykocFq2ywD6P3vXTHelnsXT9wAtTtnACZwovwoPRFiJOe8
	 isXFRjMAH/SdnWxvty1t/NJk9c/xG7xX3L4yro6ZD8C3iC53lD1pggC/SWoLx2n29imvJ
	 Ybwm37j3fFgPcTOT/zyxXXTtZTOx16Flv9bZKKBehUNFzRvANOzTtKGU/yQd1UeuocP+w
	 u2OdECrA9SBUagY1kdPIkz1nQuc+9s8YKTdcSyhoHZ8eKiNoL8J80+Ky/+glF6IbzQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043708;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qRh2BPGtIC0Gj20LARnxfdD3agvRSZO8/QbOOXk72FM=;
	b=N0M18FeifzgGYE7D4roXu9mD49dJlZALS5zHNVPAkyL5goOoR6MdqvQ8vtRoUW4TbEI2
	 e4NBg24yqLrNt7cHlKDlwgrG7RotrvURNfkMw6XeijB/EcPXozmr4DeksP6mCmyPpuyK0
	 gB4RcdlDIjTPxzmc1vjBsFMpxAUgjtuqJBtGxs8q84mDIPF1caSCRd4HGHfC3gGkPRH6t
	 7yWYBll2VMXYVs8fxMCG61Edr/LK4TzHF3P3zVRRVKzEjmVRBfpISGLvAFIpwhQWDR3Vs
	 Vh+vBV3T4RRGs8Dc8w3YrnmewJT5Vv4x6Yxr+OmZbHK7POMC9kkeJVyd4mO9Jul8KjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xt21vr7u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEED606A333
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 23:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xt21vr7u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611F11F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 23:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795043708;
	bh=qRh2BPGtIC0Gj20LARnxfdD3agvRSZO8/QbOOXk72FM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Xt21vr7ufxYhuj+R8H9mPXQy7FHN9ZUiRQ4H8xEnzg5j0Ju1KY2CDwTWVeZ2vQ2t4
	 gI8QPrqp6NS37IZ6J6RhGRl4IrwkvRL9A7fEwzA72rbBok/uVtt60r5uWXsBcqUuaB
	 0Tc2LLW281nNu8+xgpwPwkNm4KjGPt4wMa+6d2CipK4Dy+0SrrO7lPW5pVnMICqvCh
	 LJjdbG6FIitHZ3256Y60hNI+/LLeb4ICjU91c2LhSxzrl7kAjL7F9OwCiuMHCCIQ3q
	 Xa0DbHOEd460n1eo0HeBqf+o7vLWA7AuZ21HW0VkSx//8ZXUSV4k6qFIv4jkz/QGR/
	 nlxG+pIEDNLrw==
Message-ID: <sashiko-outbox-222156@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 02/13] rootns: Add core infrastructure for root
 namespaces
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117231352.3816603-3-jarkko@kernel.org>
References: <20261117231352.3816603-1-jarkko@kernel.org>
 <20261117231352.3816603-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:15:08 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Linux namespaces can be created and entered individually, but userspace
> orchestrators lack a single kernel object that binds a namespace set, a
> root mount, and an init process behind a pollable file descriptor.
>=20
> Add struct rootns, its lifecycle states, reference counting, uAPI
> creation flags, and anonymous inode file operations under CONFIG_ROOTNS.
> Drop active and passive namespace references on final release, send
> SIGKILL to the rootns init thread group on close when
> ROOTNS_KILL_ON_CLOSE is set, and report EPOLLHUP from poll() once the
> rootns reaches ROOTNS_DEAD.
>=20
> Co-developed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117231352.3816=
603-1-jarkko@kernel.org?part=3D2

