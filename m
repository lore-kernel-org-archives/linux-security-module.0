Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048025;
	b=imOgw20xHFuSKKsJfnb+yzFKt5RH1lXJK7xPm3lsRkYgOPd20jc60QzKF41rlf60jOJz
	 9Z8UGqLw/tllEcP1LsheRbaz4QrA2jQnDHqk1BdNSrLnNxy7rPzyQofCUH1l6PdudO4jS
	 ZI1Z51A6Dpvq9ZUo8yDCZ8hq/QZqzzzZTnewl6Gb8YMRoU7FHuK3Eoo6VxnnbhNFyGF9E
	 wrZH+FXSSqKimFU4eEoki3M3OmCAGU7qlC8tNV7zd2hW/ARSIoZts+zWUxEwXmRATM/xV
	 /fkhnvddL/0Ja7171sx6WJu0lFCsW7C52yJJ7U+XmItaFF/3/MsMyhN9ZDkWWBqBHcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048025;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=b5HIEyWvULNv/7yRQwM45FhV2qIaek23MRqH1gtqhMM=;
	b=3hUmeDcy9n+Hi9JSorOir/Na0CcnUdOGnotx3Az7WX9UFJ1g3l0whVWqmbBlZGyXz2n+
	 uYkeu/ql55vIMC5pAL6usMGrQgwuTKU/BH64GgFBC1xuob5l1V/E0C6QpBG+8Me3xFuyl
	 XZ/ovei46Gd3yIOgRtmfLjkd4XxFuTDhJfGd5KjXJ0hLHhGfnluMDs0Km3pcAsyedge/G
	 xb3P2MPlpGCvfOFSlhQdXWahH73ytaUWWvu0YZd8oP0IkiD3l5/X2uexBNl6oBjga3hEv
	 +pwwS9WTWb4b7gRVVNlRDoyLd31nqQoGg+c9SbyNIIjcqAehmxjtd0FWKM1UPZ6RYXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P9UY8yEg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B064D606A32C
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P9UY8yEg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7241F008A1
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048024;
	bh=b5HIEyWvULNv/7yRQwM45FhV2qIaek23MRqH1gtqhMM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=P9UY8yEgizcSBW4+l13s3ZAeAZLS5TrbUDydr9tI+cN7SRHb5D947v1MitX8Q/btq
	 jgCb0A0D8GYrbQMNSEgg0ZFnTtuNNSSy0SOa51sQ8uUUGXpCwQRn9X9AoeZs2kKUps
	 kojTH6N/aOp1zQho88QCYNEFwDM2pCyqevwe4tuio7L9LVWNHSRK0IpIKh/9yc7QvS
	 dEnspHJHsFu+vbj7cmp0s0kcfSvM7YZ9O3c7v0GupCzIvIa+DHg8BepmrsJN+C5y24
	 Udq2xovdeBh2k8t84NSATROrSN5p6NC96CQBpk23bU0JRqpnosjaR2uFF1tRT9KEU6
	 OKljZVcJqc62g==
Message-ID: <sashiko-outbox-202819@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] apparmor: safely acquire the cached label in
 aa_file_perm()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261107102534.816756-2-bestswngs@gmail.com>
References: <20261107102534.816756-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 10:40:23 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> aa_file_perm() passes an unreferenced RCU snapshot of fctx->label to
> aa_get_newest_label(). Its non-stale branch uses a plain kref_get(). Poli=
cy
> replacement can drop the proxy reference after the stale test while
> update_file_ctx() drops the cached reference, so pread64() can increment
> the label's refcount from zero.
>=20
> Acquire the RCU-published label with kref_get_unless_zero before testing =
it
> for staleness, keeping the label alive while resolving its replacement.
>=20
> refcount_t: addition on 0; use-after-free.
> WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x111/0x130, CPU#1: =
AAVICTIM/5091
> RIP: refcount_warn_saturate (lib/refcount.c:25)
> Call Trace:
>  aa_file_perm (security/apparmor/file.c:657)
>  common_file_perm (security/apparmor/lsm.c:529)
>  security_file_permission (security/security.c:2392)
>  rw_verify_area (fs/read_write.c:476)
>  vfs_read (fs/read_write.c:566)
>  __x64_sys_pread64 (fs/read_write.c:770)
>  do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>=20
> Fixes: bce4e7e9c45e ("apparmor: reduce rcu_read_lock scope for aa_file_pe=
rm mediation")
> Cc: stable@vger.kernel.org
> Reported-by: <co+c85e76ce40a43b9b@bugs.sh>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107102534.8167=
56-2-bestswngs@gmail.com?part=3D1

