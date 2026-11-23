Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453319;
	b=m3BjPMnPo93c8BUc8tMcPEFhh0bPLN+oQx2kEn5tZiYYwrlUxGjPnq98B+2QKcABS18I
	 PnZgE9UvMmyBe758TPIpVu0jRnkAeUEtL1CDDHB6Ue7QNHZZVWPstRb55vrGnWWWuIEr2
	 3J7BnSglO1Vhqa0IPyDJZi/26r9fL0joUxJ5Bmt4+owVazDAXlBi8zDdBHkSTkvLzuPnj
	 RDePhuu4bD6JDPeXB4MRi+sE8AIIMI9PlanKw5lhlLARGJhQfOPW20WC4/69mw7y8mBRQ
	 h5XdQIfifUP8EMyB5RC4oQlwZsb0RT45D+wwRZwu5oYDYtQyMbAlgl8ENDyab0ShB9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453319;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DHyGly04C5yRrUuR9DAaRuBJyGyoCw+ZVNURQ828dpk=;
	b=ByaxjiBjjz389XYYGxrdkFSsomDc7aqLHiSlVdwynaciDxH3g+8SyJpx13YijwHXofex
	 +EsaNfIJdKAJj0EkF0iQV43mRYI92pH5HZ30+ivweQVLi9IEXy2lMhVJaBUeXCfJpTRlt
	 SCdBolKDpnwi6Qm56/H0NAkQ0MoCLdovfrWCYEAlQeisonkPGKDLQ7CjTkYd7ysDgh/ua
	 VbhpgiPm9kQJEKhX9AzBnSoN51xQSFsRN2RrQTMci+vUYo73zOb08wHq4TR4moeB9n68N
	 xh67tvom6PnpJNMpeG+ZzXLEMGLZyzTLwId6IG2ZB6p4VG9Pepun6prTL3hBGNV2kVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FjV5WlpT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50D0606A31A
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FjV5WlpT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A935D1F000ED
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 17:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795453318;
	bh=DHyGly04C5yRrUuR9DAaRuBJyGyoCw+ZVNURQ828dpk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=FjV5WlpTEh6H3ouHoa0s0Ms4QK4I8QZ1R/8JfFpG4ZUB08ttQ7cYb3gYMN2dLcgF7
	 3OfgPE1JEEAs54HhUFzgBGCGysfQy96jUQ6G/CXlXKkN9EP3IIfwadHqCLthX0Ycn4
	 dcUXJ1WpnEWq6Q7TXYcEZ4ubnjrETLpIiB8I1tVzPk89xZbPuKpACkcPitFpU+eo0R
	 1zFv8BR+WtLgjoNck6O++4DUb62HSM6gdMpaqVdpV1ElI/VReaMKAQKy3GmPIWycNc
	 6QjxfJj4khUJmT5EaFyCcoHhvKvyGLQcc0OcmMRwP2N8uBaybED1ty0hdSmXlD5Inp
	 rkooT5/xWcIDw==
Message-ID: <sashiko-outbox-229702@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] yama: fix use-after-free read of a dead PR_SET_PTRACER
 tracer
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261123165357.4092273-1-bsdhenrymartin@gmail.com>
References: <20261123165357.4092273-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 17:01:57 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> A PR_SET_PTRACER relation stores a bare pointer to the tracer's
> task_struct.  When the tracer dies, its task_struct is freed via
> call_rcu(), and the relation is only marked invalid from
> security_task_free(), i.e. from the same RCU callback that frees the
> task.  A reader that enters rcu_read_lock() after the callback was
> queued is not protected against it: ptracer_exception_found() can read
> relation->invalid while it is still false and then dereference the
> already freed tracer in task_is_descendant().
>=20
> This is a slab-use-after-free read during ptrace access checks, e.g.
> via process_vm_readv(), on mainline v7.4-rc4 (KASAN build):
>=20
> BUG: KASAN: slab-use-after-free in task_is_descendant+0x1a3/0x1b0
> Read of size 4 at addr ffff88810a46c598 by task poc/167
> CPU: 6 UID: 1000 PID: 167 Comm: poc
> [ ... ]
>=20
> This issue was discovered by Tencent CodeBuddy Security.
> Cc: stable@vger.kernel.org
> Fixes: 93b69d437eff ("Yama: add RCU to drop read locking")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123165357.4092=
273-1-bsdhenrymartin@gmail.com?part=3D1
