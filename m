Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312308;
	b=ALBnO0NK44IKGyElXlaPfm1oYyQh3KcJh/WC4NWHo7xg0ZmpvwqClpaXTTsvkkX2mb3/
	 RMlL4HOJTq1KsvcqmufQZ4iLcyUobqb8m27kwKivfSFqhrUxwNcS/U0AH3jPYFsWwfDHK
	 94dihK5OSGJ/Cw8W+M7RuPBvJsJ/uVQLZUmn7IxXrBaMLYoZvSr4FJq9rJTfMAq6c7S9r
	 o3IRm/SjEJIqJLGLa9Z2cazSoH6BDPcz8qRCPqXkpnhuvaJiVIkjxdfv7MExlw9mHBMxv
	 eCasuAAVL2QYX30peqO/jZj+Pa8aK2gUyFQWBsaqW/amjffhybaQbSXGQMGp5TPDzFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312308;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yp3jvUpgFwdyhnP2IC2xR5AmZ9utK2J8hlAU4LLk2JU=;
	b=UIm3BkUwb1ki1FZf0/LsBlfh2fwNKjhgmPSpEdBMJ0CBGZTx1NHolqV4+470QCg0CWep
	 1NcWIZKg7cnGRWtyE96hsqx4lsiMxS6dIGD0SVKJsBYsBO/O2cqqDOVcSZgXcHBArDnr+
	 7MuptCFlNeZJe+WYOcBEL2llxSOujx8NbYNRxsZJiI8qzQmMyKZ9MJMK3GYKcalex+rnN
	 aNuIe3ybWACsKdIDAdVLbsxm7WNffE6tgEe0A3+z+5E+0Weg+L8r4SVYf3lF7Nhh3UcQC
	 Trmhv3AN8D3z0MDPN6gO2qKMetqBqyzu0Z0jvSvp7STxqrWKT6ZJklcYxEUA2Dfy0Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpwxphjI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B04606A31A
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 22:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpwxphjI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519311F01824
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 22:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793312308;
	bh=yp3jvUpgFwdyhnP2IC2xR5AmZ9utK2J8hlAU4LLk2JU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=bpwxphjIqRPZdlb0Sxjzhyp8Oomq7lB88ls0jsn5240j1+bR91teMT3HQ29u1nVxG
	 UEvOXPS7x+24WFuubwZro+3aj//HYJsFibV+y4q9wnQYF34SD4XP3iNBhpfnKXRXhm
	 i3dJbYKE4/rCQ02uiKHBYLfTWhvyELNHDqZpCus+ILSpFc95tZAEfcN3poG1WMVAd3
	 XGpQHp2Y2ylfQ/p580VvGMPIUd5Df5xB7hyOlvPBtB/qwVo4JI4VzX6uqkdYK8QEpD
	 PXEKm0/+sWVA5Vf7kIu8fxuSosZam4Rmnphz3OD5CGMQzKoxliZgNt+YtiLHNUyoqN
	 eo/vht8lH9rgQ==
Message-ID: <sashiko-outbox-190065@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] nsfs: add NS_USER_GET_INFO ioctl to inspect user
 namespace capabilities
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261028221705.3915340-5-halg@google.com>
References: <20261028221705.3915340-1-halg@google.com>
 <20261028221705.3915340-5-halg@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 22:18:27 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> With the introduction of a capability bounding set for user namespaces,
> userspace needs a way to inspect the capability ceiling enforced on a
> given user namespace.
>=20
> Introduce the NS_USER_GET_INFO ioctl on nsfs file descriptors to query
> user namespace metadata, mirroring the extensible structure pattern
> used by NS_MNT_GET_INFO.
>=20
> Signed-off-by: Hallgrimur H. Gunnarsson <halg@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028221705.3915=
340-1-halg@google.com?part=3D4

