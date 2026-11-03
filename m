Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692488;
	b=aKHoRPUEQB7uHBGFNOnQ00MH1+xq9U8T+lMVj3NhquQuiECgXKvfPfhB8WfOxXDarLSD
	 2uXD3BrHK+KaW3y7E6JwBg9vA7AR7s3G1Lzrjpd3AGS9aC3JTav9r33rxfbU3WMNZPblj
	 bbC437hjmkZ8STZ5aU1eiwlf+Ir0Y04n7mEZUdxtGRKbJl/Rqlpp4RNsCxnKGhdAtiP0u
	 cbW9Bzr+xwrn/FtUSIZOXCeU5oIk3xA0rfylV0ZOeYQjT+L8LhKI3YhQT77DoecEYJ49o
	 nkbN4rBdyA6dWhLIBdydqa1RanQQQ7mic3lu6zRfhPdnW36rll17o9Fu9/kMTAedCtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692488;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Z8tgt+5KNxFL2dP4IxpEVDUCpGFdu3xNYL9n5stj/4s=;
	b=T+6SiGRpawKqRLfxZ7wxjDVLKoocBwgOtDZMl2/EIaJaC7f5d8BoWbArp2wsfJbaX99u
	 ysbi1Um0zTQZ80ZhjgnRJ4CXPJZ7eEgc2l0G+duYdZKGrrQvVfIBiaEijbMd1Xd87qPRt
	 33zFZCBauVWbs5KC0tC/UelA1PmUHYPjb/qfT3bHVlFwtYMtuhZvpx/CEeWgn6DCUWJiI
	 i7matRqYd3iCRYvlfk+jDpHd/zOeadAIVa8z8vDxX6uyuCzKVkIxFNu393XX7ELFbW1QZ
	 xE8P2s/xuAG8o5UCcWcbtWEOKrWJipCWkVLHscwkBZPpv04TQpow1+wFNRGMz79BUMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bf51LFc8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D042606D807
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 07:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bf51LFc8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3921F0093A
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 07:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793692488;
	bh=Z8tgt+5KNxFL2dP4IxpEVDUCpGFdu3xNYL9n5stj/4s=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=bf51LFc8rPjQWJ3CG62OZ8Akiy34HddWksswHsbxRRVt8XZlyfOVThWnLwhoQ6B+m
	 jdvhL4ODHa0J4QNfIb8XVDwe5I4xm41s/UXHGh6ypstds6mvzjE9XTVZZspd36d15L
	 OUuKc2rICxhSfuDhPQB7FP52DctvZYcwUN1XvUBaMk5dt8h67MddU+UzrCmTRnVw1P
	 /Dqj4pQ59QzIxl40sAv6TVaH06XAEodVOU3oHzUryWrQgJBAFKxSLLW/zWD1vrJYiz
	 bllNS8JQCZDGyPTPPS/Rm+bWDRsZ04s6Vfm5c+M+83SPIUrNwmfACGkz8Xz2IXQdNJ
	 UmVJkIQbYVZfQ==
Message-ID: <sashiko-outbox-194765@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next 4/9] lockdown: select SECURITYFS
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261103082421.3033195-5-caixinchen1@huawei.com>
References: <20261103082421.3033195-1-caixinchen1@huawei.com>
 <20261103082421.3033195-5-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 07:54:47 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The lockdown LSM exposes /sys/kernel/security/lockdown, but it does not
> select SECURITYFS.  If SECURITYFS is disabled, securityfs_create_file()
> returns -ENODEV, lockdown_secfs_init() fails and the LSM framework logs:
>=20
>   failed LSM lockdown core initcall with errno -19
>=20
> while the sysfs interface advertised by the Kconfig help text is missing.
>=20
> Select SECURITYFS like the other LSMs that create securityfs entries
> (AppArmor, SafeSetID, TOMOYO and IMA) already do.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103082421.3033=
195-1-caixinchen1@huawei.com?part=3D4

