Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692559;
	b=AyK6ulRoPgnDSecvdCFSABBjuvjJlRbOjgU9DaE/IfA/fp3gZnvVj0n2fK2xbIXM/VNv
	 +IdWP1Hn862PrCDob+xnjiPWNR+y59vajLq49EZs8PZ6Zs8ORN79TDKy3wrpIZdTLKsUM
	 OXaWOqBp/zuYyv9qtzoa4+K2cJofMTjjSH/9d8ViJkyQi4hkXyAk5VSJLMT7rav0v9H3G
	 O8kbGgvl5QwiOeYszbs/Mlm1IP7YQUGTpOEebcF2VxTErchZ5hOve1cHTJXZRUNWC9ns/
	 iHSSo5ooELivEfNU7B9F9dc4O2hb/2vSUjtSHn9lOGdBsfkYAnqcx6NC6rZaqDF7QMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692559;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RrbofP9e6Yx6jWryQzJTEsafd2f/G6LuqK3Makhr7BU=;
	b=oo5OR76901lkDHwTFhsZkKNh2iA3ocBUTDdzxAGP+qpJiZCM+X7CH+ONbvjeUsUBva/R
	 d6YGHM9abEjV2Dh33Mo1CMJraTyiTifanNrOW1gQRRaXKSWqFuW2Su8u2k+sOjaFCHbzr
	 Lsq8VxNnhC/DA3EbPkgfdDDsKu0wtlPxVEgl1wEUhP/e3iei2MduCytMsfBJEuY+LUnw9
	 h7Cv5rLybRwb4xBpS6ZzTZYt/iklxyfN3KXKkJKrtYRK1pissRitHR5dTefl04XESwNii
	 OZlWHxoGWjCyLDPIpnerkookEzUFqa3YtKAFPtmQGIDIcK09jRicUTFU7iMCqz4y2CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BmCj5r2/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B37606A329
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 07:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BmCj5r2/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFB51F000C1
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 07:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793692558;
	bh=RrbofP9e6Yx6jWryQzJTEsafd2f/G6LuqK3Makhr7BU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=BmCj5r2/L6pXNbXUc3e3ysagAKDh6+rQanuuYo6LLSPTqgZY7+Ozwj5s+3sz9Uzrn
	 6SDeBRrurYZ1Era8EQDsl0/kVyE+qewBIL6YVZR5pR5W8G3Yg8u6hm23LG+FSmLrBB
	 Dep2NsLkvVdYLYgtkDJRHCCgj+Tc2LSYHCLNDegn+UqT/kwwFJuOFJv67y8vK8BRWn
	 qI6Te7EDpwE1fykO5EALyp4/ZgvCyhIDhxPf9yp0o8QG9iUXnipZQ+KhX9KcnC+7y8
	 +b3iOmxbXqG8SBtwrHZNRpWm2JV02cblyXlFJWMIO8JuKBgbOaxJoEgp/PaVvafHv4
	 pmnm0NAL2yAdg==
Message-ID: <sashiko-outbox-194777@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next 7/9] lockdown: move lockdown_reasons next to its
 only user
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261103082421.3033195-8-caixinchen1@huawei.com>
References: <20261103082421.3033195-1-caixinchen1@huawei.com>
 <20261103082421.3033195-8-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 07:55:58 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> lockdown_reasons[] is only used by the lockdown LSM after the audit
> data was removed from lsm_audit. Move it into
> security/lockdown/lockdown.c, make it static, drop the now stale extern
> declaration, and point the enum comment at the new location.
>=20
> No functional change.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103082421.3033=
195-1-caixinchen1@huawei.com?part=3D7

