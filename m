Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342832;
	b=y2BR+SvzArLJVg5NZvg1fQwhbYEC9skfomkyRtITkFh+bFXjqcnpD/6/WoKFzPhcMXHN
	 +FCu2yRbcY+ToA/WlUIBNbdAfVdiP7Ybe58wTHJTZsOYZXVC/DVO8EGibEUZtjQh5oAtF
	 OJ1aN7dRZWaaLisPLJu7NLinNiEdHFDJM5ZuubIg/fsfwxucYBNneq2CsoAPeQma8gpis
	 poEyItbk19sudl1xm+8p4Xptk2GrZe1JsCvNi5UfGAV2RgprYGbwzON98TuUT5gtdeOR3
	 ymxrsVG0QCmXJ/GDxmWp00SByzFCY84ramAd2eIYHJ2ll0XfwO4bB5kNG3Wk+iB3zrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342832;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0y2bOH35GXA0WqTYKrPvsGwhkw2x8Yice4dmqS6sRZ0=;
	b=BwJc8A860OcyUlYLFZ4YjdsQIK36O8e56GVeBb2zuDQpj5j0ean2qzUTvsm6/vbXyhBc
	 FB6zDA3pTIFzVpQ/tGSHasYnwyOs5FiJZ1UgqLIiPWhndkrzQf/+YQi1olbzbfN4b4FpT
	 +71YGwHbCXNxoh13IpPMMLV96r0dTRVhWGJQ3V6LKGfIJihSwx9Hc9AE7N8JeuEjLP35p
	 pYF4uEz/xjQoLwwjlx+WMLQA+FjNFJiU4qNwjPLgwEypdK+w+iJ9QR6fke0a1esEhoS+q
	 V+HT0374d+eQdk1rjGL3w0dC18gHNaZaYBVjtYWmyFT32rOaP8I+nm6Xw2vTWMsIAxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E8PthMAh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F0E606A880
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E8PthMAh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B181F0089F
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794342831;
	bh=0y2bOH35GXA0WqTYKrPvsGwhkw2x8Yice4dmqS6sRZ0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=E8PthMAhEb8JN0bojSSQRKajo1Fh7VumB4MQ1CS93aBG2/yTryPrTiPEnPOk/dqmr
	 mTRSlqRRpVCzbj9DXvkZETebtSJlFsLAwsEdutUl+ou+QtOkgD12T+7RyTJ7seinKm
	 jcsGSsi+ocoM3YiATOZRCo9W82i3CfmO5HwQDnEFkIJRqmHFotAD7oPeIZu6D92DvZ
	 ORnWQQdhQawEGhtqqOKy1r4dYnHlzwqQ8auJzTwtV9tkyH//oOq6+h+rzeL5ZBSzOc
	 I30/FB92S4pDDbO6msmzBVvHC9Okxln0mFrPUVGl83ZY7DH2+39fVMFPNvdqckrY7d
	 FW40Lxh2iKv/w==
Message-ID: <sashiko-outbox-207713@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] landlock: Mediate CAP_SYS_RAWIO for mappings below
 mmap_min_addr
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110202436.2408244-3-mic@digikod.net>
References: <20261110202436.2408244-1-mic@digikod.net>
 <20261110202436.2408244-3-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 20:33:50 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Until now, a process in a domain that denies CAP_SYS_RAWIO could still
> map memory below the vm.mmap_min_addr limit if it held this capability.
> cap_mmap_addr() is commoncap's mmap_addr hook, and it checks
> CAP_SYS_RAWIO with cap_capable(), not security_capable(), so the check
> never reaches hook_capable().  Mapping the lowest pages is what this
> limit protects against, because it helps to exploit kernel NULL pointer
> dereferences.
>=20
> Add a Landlock mmap_addr hook that checks CAP_SYS_RAWIO against the
> domain under the same condition as cap_mmap_addr().  With the same
> vm.mmap_min_addr value, the hook only denies mappings for which
> commoncap required the capability.  security_mmap_addr() stops at
> commoncap's error, so processes without the capability get the same
> result as before.  This also covers the x86 vm86() syscalls, which use
> the same check for address 0.
>=20
> Making cap_mmap_addr() call capable() would also fix this, but it would
> send every low mapping through the capable hook of all LSMs (SELinux,
> AppArmor, SafeSetID, BPF LSM programs), adding capability checks that
> their policies never had to handle.  For instance, SELinux checks
> mmap_zero in its own mmap_addr hook and keeps it separate from the
> capability on purpose.  LSMs with their own policy for low mappings
> implement it in this hook, so Landlock does the same.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Reported-by: Ada Smith <adasmithgt@gmail.com>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110202436.2408=
244-1-mic@digikod.net?part=3D2

