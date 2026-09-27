Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812E53B14C8
	for <linux-security-module@vger.kernel.org>; Sun, 27 Sep 2026 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790526835; cv=none; b=KHMmo2puFaxwzIIU+jAogsLui6cNvjG9UQVqAoCF0BchjnfuKMbo8ek7xGZON2Vy/Yo94Ou1goLxZTYXP7tCMAJ3b2xkwOe8jfuWTOsK4q/Zdi9bATbFgpAxCkZ7e3vFo9QBUip9jDXxPnNOJRcx1/A3L/pJ1Ngp3EddAXDyQaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790526835; c=relaxed/simple;
	bh=eq3CZ1cUvfvu1f4KfBhJXxwzp9ALYKNMZ1QTzsKXcQs=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZTPAvWwfG58LEuvPsBmTW4FiIzUOsGiIEt0Erplc+N/cf87KF6vFhv3z7lj7a0bf9AW1OOEVkC6n+MPm+PR/bYeSOOgVu7rQUKLWzo7nfZWimTFkZsso9rQZokDziKhGODZCjTMDWLHLWjLovyGy3XXoMwhG44Gs92rX38fl+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8PDg1cA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8PDg1cA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469241F000FF
	for <linux-security-module@vger.kernel.org>; Sun, 27 Sep 2026 16:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790526834;
	bh=02C4aauQt3nKBG2sJN6C3pvwQO379BC3NQNV7VsqsAM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=A8PDg1cAAPItxj2lrKV7vOPWRamSubE9RyGZlOQCMYJRbCj/DJKfO40DZAm4CCxMG
	 zFYgkL4g0JSrKn5JxUsBUViY9lu10BwD3gZjHWWFQwbS4FCiLNfwLDck4IamZxdxQy
	 xVk1jAb7sjaoCSuzUdzmSjzSlYt1iczYLDDtpJkXyKXLA0gk0VKyKRsSI+jW7/1bD0
	 kKFj0pqDAOhFnYnEOUNQmhz7oelPvZ+fsQ3q6r4/+WN18zbTqc1hrfBcDI9B/qSdU8
	 JvMu3Kk6QDvFGZafXbBOG2aXF33Kg8R0goqb4Dk/6mePFnLjMouaxIMFyPA2DuMtzx
	 7np806kpsgyEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] keys: Serialize ownership transfers with key
 accounting
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260927162528.943886-3-nicoyip.dev@gmail.com>
References: <20260927162528.943886-1-nicoyip.dev@gmail.com>
 <20260927162528.943886-3-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 16:33:53 +0000
Message-Id: <20260927163354.469241F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Protecting individual accesses to key->user does not make ownership
> transfers atomic with accounting updates. keyctl_chown_key() holds
> key->sem, but instantiation is serialized by key_construction_mutex and
> need not hold that semaphore. KEY_LOOKUP_PARTIAL also permits chown of
> an uninstantiated key.
>=20
> The instantiated-key count can therefore be charged to the wrong owner:
>=20
>   instantiate                       keyctl_chown_key()
>   lock key_user_lock
>   increment old->nikeys
>   unlock key_user_lock
>                                     observe KEY_IS_UNINSTANTIATED
>                                     skip the nikeys transfer
>                                     replace key->user
> [ ... ]
> key_user_lock, and release it on the quota-overrun path.
>=20
> Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's own=
er")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927162528.9438=
86-1-nicoyip.dev@gmail.com?part=3D2

