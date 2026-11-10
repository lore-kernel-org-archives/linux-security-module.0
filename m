Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322098;
	b=5N8ZvwgVTMV18pzNLw9iAAoBj6w/WJRE9grESnOGzj5ZvkIIXHWneVmAn6FP5VXDmt7x
	 uBvOl58O3U43a8dS+baJxrxJxj+UTe3ODBl2BKEs5RzTUD8rG/xkvIKliy0QTmm7ExYHX
	 TKUNzllhgWcRg6bR7+3CJGl2/EJoo4BPisZHWj/L+6BUd4+7YdGpQYkzDn0a63SsC2lR3
	 eMP76ResrCzzqCynWXzwCugOqQjh9x53aRNC4e86EDudGWCy9jadGiTt3Ep1Nz7mAbtaa
	 P50LGFWjyXK5QPdfYrEdV3ePn0jnT0cwRExQe/8sK3tGTbV//faHCti+48zdq88Sy1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322098;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ySKrAdBULBVJsvWFpTHn2XHQD8aDL0bk9KGgjq6Z024=;
	b=CQ8VFZlv4a5ZtxEQJ+NPImvgYBrSsQzBnPt9AiH9tsZ9AfuQZ7l+Kt7S1KqagJfkq2ek
	 dPsFXuk/7TWu5mz4+44Ntjut5V6BrE9w/EvyRDZujukGD+KzFFaOocClobGS0cugPMyXM
	 3c/yHyt407idrjsQmrTlfti8BEXo02NVxX95zjnNmvYGG/UCN4Yn9lNsPEgzyn/7QYY3g
	 XYOohhwh7tW3Kyv4XbORHhgzrxE5O5dnIcGrGeVllqZRReZrVSITrv83l4DJkcEnc2ZyS
	 xN1NzAxDyfYqS7JNpvDFLdrP9h8E3FTG1y6itMoBTAtIIiamZ0W25oYp5lVYZpvmymg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZURuidW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D34B60A2602
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZURuidW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB68E1F008A1
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 14:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322097;
	bh=ySKrAdBULBVJsvWFpTHn2XHQD8aDL0bk9KGgjq6Z024=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=GZURuidWKv+v7AUclKPhXc5wkDOSef7Rm16HLJBo/8AJgbkDU5A0ie77FHMOxdHh7
	 avHmp1Ib2Y9zTUR4noAKLbc/aUfakchgcE8zARqMfOKWy13MOFpuyPmNdlkBzG/ikO
	 t5vijPbC1yg2z/inO4E4/bkjEMPWsJ1pZJQbyB5mmmOjYXHFiK2KyJlkvpp+wL3sDk
	 EnaxPCv9f7ftGFUUSIy/s04kLvTssI8mi4uQKKL1WDu56pXFkYYIGy4KvumLoXRed6
	 mEjbfJLwl2j/Px48ErRIteCeGZ7TkIwxlsnvYxrEQhxqAk+BhEQc9HTxkvulOV/x/k
	 WL0VOMVyaix0A==
Message-ID: <sashiko-outbox-207213@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] userns: Let LSMs deny the CAP_SETFCAP snapshot for
 mapping uid 0
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110144205.2404088-1-mic@digikod.net>
References: <20261110144205.2404088-1-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 14:48:17 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> records in parent_could_setfcap whether the creator of a user namespace
> had CAP_SETFCAP, because a creator writing its own uid_map only has
> capabilities in the new namespace.  The snapshot uses cap_raised(), so a
> task whose LSM policy denies CAP_SETFCAP can still map uid 0 in a
> namespace it creates.
>=20
> Use security_capable() against the parent namespace instead: the
> creator's credentials still belong to it at this point, so commoncap
> returns the same result, and only LSM denials are added.
>=20
> Do not audit this check: creating a user namespace does not use
> CAP_SETFCAP, and most namespaces never map uid 0.  The uid_map write
> that later fails has no LSM audit record.
>=20
> Checking CAP_SETFCAP when the map is written would not work: the
> writer's credentials then belong to the new namespace, where commoncap
> grants the creator all capabilities.
>=20
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: stable@vger.kernel.org
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110144205.2404=
088-1-mic@digikod.net?part=3D1

