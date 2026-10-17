Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572503A16AE
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 07:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792223662; cv=none; b=a3/4d0wAMwcOwkQBEApuoBHpnKAe3brzeh7U0ig91H+CC68Y33Ckvi62d987ePJB1Dmnypa6VuJmPWdcd0Lqge6j3jvL6V+8oH+TXG7zR5/X3jbQHGfYbRQzxJy4Hk7Y1ljH5AlK8eyeLucCHPhjKCjbDSBvwO8vfz10mAGbNFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792223662; c=relaxed/simple;
	bh=/c0JgevYLdfjkR51sNSxlC0Dhx1I6M9s3Qi6Z5Hhhmc=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cJupu/z1AcEYxugoWvzSXHbUXNp1i9CgyNqXfxZOzOnZu3oZFe39WQlzn9NsqkTTtdhlm8OowqeiHg+WngxcB01Cc3dMe0XXoKVpLRtE2B5kNaj5rXkQJQ1zRu2mXnH2fwGDzJp/V1i4lsmEmTAU94g6XiUHuNajf8Z0CZ473UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0vk94X7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0vk94X7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA8D1F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 07:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792223661;
	bh=/c0JgevYLdfjkR51sNSxlC0Dhx1I6M9s3Qi6Z5Hhhmc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=m0vk94X7bcp9e3XMT7XSVTE+X5R+0eJI+8hxgoobe4SWB093c5gWRUuVczVGxbttj
	 SXG7AKUPEHNyQdwtXPmTUxzwdrvySL3JRYdh6MnIMJiJtbO3eSV1SLLQquhqk8FSy4
	 bPnQVEyua78514NHUdoq5jailTGQzdRoObaVLiHxwRS7U7ocwa1qHI0lxpxxIWI6LQ
	 UAGlglR6cj5GBWHUBD1RWui6VIe31jbPjXJmVyZ7FJsRuynnJESbV7MCgJpztnqQ3y
	 mTzgkPcZnOyUG6PEju6pTEedyGojExLsszhrpaV1UIVKK4bvTiRK+fvZdYRAJBXnRm
	 J0ueyUV03x4qw==
Message-ID: <sashiko-outbox-175379@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] pseries/plpks: fix length types for wrapping
 operations
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261017074850.164031-2-ssrish@linux.ibm.com>
References: <20261017074850.164031-1-ssrish@linux.ibm.com>
 <20261017074850.164031-2-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 07:54:20 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The object wrapping and unwrapping hcalls use 64-bit length values, but
> plpks_wrap_object() and plpks_unwrap_object() currently use u32 for the
> input and output length parameters. As a result, the interfaces cannot
> represent the full range of values supported by the hcalls.
>=20
> Use u64 for the length parameters to align them with the underlying hcall
> interfaces. Update the PKWM consumer accordingly.
>=20
> Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping =
Module")
> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted sour=
ce")
> Cc: stable@vger.kernel.org # 7.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017074850.1640=
31-1-ssrish@linux.ibm.com?part=3D1

