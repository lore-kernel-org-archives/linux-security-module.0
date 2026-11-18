Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794978599;
	b=wGXwxVKvJCLVYHX7tfWngu90RFIV8+xQ+KAttflZl5Dn4sv6FxWtZH28//G3rOmncr+n
	 ZneJX+8dXlt63+pgVibWM07vLZweMwN8HJ+rWcY4pHhJLs8D1TjG6w5ZMjKjCBFJlcyjU
	 Lf7xE3+lgm9wiD7HvFuooDGkE97xTNrk/fe3AvEg+ihqwtMoifOUXopIbpvXI34GalvNo
	 lGcIvQpAm8pIPjPGL96Evuyjo3YTQ5pAmDi/JJCb6lJa/GF3mizuAC4AuL6Iyi56Glpb3
	 l2oRvvGlJAMAxgMsALRIUm/kCfYaKZrF+rBL1wQlbdnC3t46LUaQwv91GqVrcHiuofA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794978599;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BizPZng4xJWXi0s3XmX1D5mQbQknyLSQeFizEXnSKSw=;
	b=U5ielU61/FPfKbBWqOB6EGE40llITYvFuBZv5zFyDvgI3PiJa2Yfecb5rlaN8REs2RgZ
	 llISTK2+Ro9wk6SZcoZPpVfjD6N0gTFUWq5EFFTkMa4aczkr2iX0jKRp1m2YM3QPcB1OR
	 PBv5nQ+D4RCPq6KAoEI7kkdAIXI+ncr77powO7KcAzv/lWppl6URa+GOhhwEVC4z8r5gj
	 9C/zBWGM9WAh8a8AVYvqPlzemzJQOjB8Ox0MRDvENs66phFd7GkO7eIBk4ta9X77RDsLl
	 hgJHXuFB1ChX3jRMiWSNrm5vG97A8Y8pxqG5qJleqQJzmacFaf9VNBrWM5kHHUN6/5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YdEFcz8H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24729606A31C
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 05:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YdEFcz8H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834421F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 05:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794978598;
	bh=BizPZng4xJWXi0s3XmX1D5mQbQknyLSQeFizEXnSKSw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YdEFcz8HK2VeviUQHDeI0qDxtKOAGJQNbYYhsgoBpo5yVO2oKVwgxMinOYhF/nNgN
	 RDG+OQBGGxrBycleYtKCgZ1TeZp45S8c4rIh5JEJQqp0Z7LLgMsyK4e9oGhSJA6QQQ
	 GY0HF3EVYxZGOx3a4X1oQd1F5ULX9Dz7UxA0ac/MCQ977y4dYBd9tj/ibhK/Cr2mRQ
	 ZGL6wwpKHomrBMpC6dTXkDPV3d3UyaN3f4KtZcbfPaQMCMRSbS1RZ5hBqOr3iUQpAF
	 YM2VPfZwrke7ZMi3dpuro/F5Vf/aluo7JZF/ypMhJFtCZpPPHHPgMokZ4xJSYZY74Q
	 1u9qVwz7vXtjQ==
Message-ID: <sashiko-outbox-220146@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 11/13] docs: Document root namespace uAPI
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117050841.3289652-12-jarkko@kernel.org>
References: <20261117050841.3289652-1-jarkko@kernel.org>
 <20261117050841.3289652-12-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 05:09:58 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Userspace container managers need a clear specification of rootns state
> transitions, mount-tree construction, credential rules, and namespace
> isolation guarantees.
>=20
> Add Documentation/userspace-api/rootns.rst to include the kernel-doc
> sections and system call reference from kernel/rootns.c,
> include/uapi/linux/rootns.h, fs/fsopen.c, and fs/namespace.c.
>=20
> Co-developed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117050841.3289=
652-1-jarkko@kernel.org?part=3D11

