Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910487;
	b=TAflkTYuVfY3j2+tZDF6Wm18JjWBapyR0ehmcgwdNk9uEmjiCgikoqHI5+7+/YZTlMRJ
	 1rDiqt3wzpYAtS8zTdbkVhMcJ7AnH4Y3j0AnTU023tPaoba+2UihUk7bI/u6Ks/gRdy4+
	 FOzkJNQq/SGMSgm5vHlWj2wxtT0Qf2gwswUKzJJk86sYulVj7F+lnva0xIR9OE6oc8NpZ
	 b1u+zw1c5Zrj9ZoMCq+diuANyUFqpWjqWKI6KNSFQoA1Ei29x/lBMPWRHqwWruveMOXr2
	 Q/tB6NAjydPsTBL5ekduynSYyhtPwsk7wgWqt3tzCCqVYJXjhE22gUVgaKgbyki0gwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910487;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2NW+szgwl/haThPVwI8fmZXp7EAXCmurSucktlpm5V8=;
	b=e/xpMO6i+7gfvYN2b6YGx/+NsTfw1NdrCN3ck3d+wjmz/+2OME1thyUnLlDpqnvH/K/J
	 TnS2COHGv2BQNAf5Pxqsqk4ibv6b0IbojTtBd6ZKRBiF0X3o/ikplLDEGhN9eca4ueZq9
	 LZZZ3ADIOwB5RLf+YqgGD4llkrVaZ/TiEyUxwFVnLQvlGeU5dCLzn2Kj3OgpU5jWAneKZ
	 71boL4wn/ojjg8wdGCx91oS1QmUCaBFT+eaF6RWy3LmC9Vlf4WFHPqYsOEGyJ92S5b0RA
	 WVZ1Xyjcn+OoFdFc5rHd2wCteNM9C1AKGhAOZ44rdF2R/c6iLNp5PV77SDOQUGIp3gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZqERAO5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E94A606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZqERAO5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2681F000C4
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 10:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910487;
	bh=2NW+szgwl/haThPVwI8fmZXp7EAXCmurSucktlpm5V8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=iZqERAO5SalmPwax5JFwaRzcx/BDGyaqAKh+W+xQyXmlsOhsXjLAbTdgJx32+w/BR
	 LrkBBC7Hwd1wSk9+Z7Is3s6upAJEJPu3G7N+ntlPnptblINFlSlOW3yRqk06kqRdiC
	 SPVd2JxF0WVsj9BcdV0Takf2qSMvQshxcig3xagz9B73F1BvdKhrxVrWSsQwE4xF/j
	 O8jTZCbXQMqWrLYmy18BKF8G5k8bHVw5P+siyeLzmkRLkMTO56OeRBTqG0Bl1T29lx
	 dp9Co5GvY/Td0O6giDkXD7+VwdoMAsdVxSsiOLmBKZA51f0oalp7WKD3M9u2i6MnXO
	 q+dZHVgc8itSA==
Message-ID: <sashiko-outbox-218580@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] landlock: Factor out capability denial checks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117101157.2520463-2-mic@digikod.net>
References: <20261117101157.2520463-1-mic@digikod.net>
 <20261117101157.2520463-2-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:14:46 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> hook_capable() is the only place that checks a capability against a
> Landlock domain.  commoncap also makes capability decisions from other
> LSM hooks, and the following commits add Landlock counterparts for them.
> Move the check and its denial logging into check_cap() so that these
> hooks share it.
>=20
> No functional change.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117101157.2520=
463-1-mic@digikod.net?part=3D1

