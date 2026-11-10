Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316277;
	b=hgHDF6By3EJ9rXh70Y4eGBXIT+zdDBxxBJhj9bm1HvUV58GelY98TUEMuCvs12pc4Xea
	 9eMHxSxQnyg2w74h9lvjxoXebF8jV8whte+xGkMFj3dF56Sbfnzf92DTe5PLG3v6eDN4s
	 7ccTty0gojCXwEHdH73f5+WRu7SNaxiRb7Q6MUGjZWnYWSoHv+3uhesFGZ2OjuPLcBfZt
	 kNa7tW3vaQPtS9a9MiFXBm5iqI08n4hc1ocSZDQLp1qBtvuJ9kUEhCZ0RM/r+oRzzTogY
	 xRUSJRE6aWBeKVrj3Qvjb7FEBjOoGAgXOmcf5vCupjy1gAlfYSoqc/g0W92K+E0Bzkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316277;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AVkDW6B6yRTcNaJO6Mhf0NYzJ/YGiOOZdfjAEwmdeVU=;
	b=Oh1qkoH9HGj8Uz8G4G/opl5WqaHNieglqzoSFpGUJ6+tQFIclifNIKPlbEGlXDAmDMO7
	 021moaBzaRZYLg7JqEPZeVGBqCikKMDMhTQokBnh+NoA4az0X1MGzFAwuPYvxCIh/+b0p
	 yPFEke2GN6lrqPRkh8DzX7odUNkaspydA3Fo1Hd6kV7K9UJYuO889BtTXN9iQXz3XoNhq
	 DX7uEYcBk2q95e/0YnSmx6aBbSBykL59mzhXSA8zA4TLQGfTnG8sZFEzXlv4jS9G8e+A2
	 v0X9Ek2syoq+xtsWrp9A1R8DuwQ1qmfFEwn6nIsnn52SEg6mFdJt9Rnb/lf/91I9htQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l+yvL8tS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D1B606A77A
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l+yvL8tS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7F51F008A5
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 13:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316277;
	bh=AVkDW6B6yRTcNaJO6Mhf0NYzJ/YGiOOZdfjAEwmdeVU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=l+yvL8tS/HbvQ/BudJOYAD8PlJdJHJCyjEi90f0gdj0N4avKSqLYbfuqXyjnvQP6f
	 oCRl9AOYX+M4kl52gPbT4yawy72OBQzMofbT4xt6gNIV9j433CYmi4KW3b6igZLSIG
	 XKINqp75q1Y2O1sFbJap2vErRP3hlgkhcd7CLyymE1baWY69U7+PuqjHu475Q9vxJB
	 bnGV6JOPYx+fH5brUrzGhQ8GVEWoVyY45FsKUb0gh6J40fouZQFOHDepP3gZG0Vpwn
	 CpTSe+89DBHcT/372vHTSHk/rciQnq0vLA+djOSUv8Bh0e4mnVL5ktv6NwrHKsZooU
	 iej3+tLc3FmjQ==
Message-ID: <sashiko-outbox-207101@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v2 5/8] lockdown: drop an unused include and move
 lockdown_reasons
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110132818.2231593-6-caixinchen1@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
 <20261110132818.2231593-6-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 13:11:16 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> linux/export.h is not needed since the file has no EXPORT_SYMBOL() usage.
>=20
> lockdown_reasons[] is only used by the lockdown LSM after the audit data
> was removed from lsm_audit.  Move it into security/lockdown/lockdown.c,
> make it static, and drop the now stale extern declaration.  The existing
> enum comment in include/linux/security.h already pointed at
> security/lockdown/lockdown.c and becomes accurate now that the array has
> moved there.
>=20
> No functional change.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110132818.2231=
593-1-caixinchen1@huawei.com?part=3D5

