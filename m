Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794675719;
	b=tRIkYhOp74SGOzqwHp7O7RxsLw4adXyVxXt4FDZ/lOKvLJFFMz6nyP/ILQ6i7/w0G/Mk
	 oN4raFCKmFUbr9/HROmDWRzvyEeY6qbLKKwGVXxJh4Wp2fnLhmRxkTQD1gbnHK6NhJ52U
	 YzfaXb+eM+/alXaJVehMBA2/QCmvlN9sWLmycwlhASftUooQBOrDdhH3UOGTJI+osU/Cs
	 l3e9iBQXomtqWwuTGhDVk+fjTJaR4qf5pgfwVB1kLiGKuy8MzbmPCzvWLrqAns04Eltbg
	 NSEq/cQyTSsF+EVL4oj9eGHiTYEL1t7VvdUYbo/K7t4PJtdQjhJ6653n5NoDe5v020w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794675719;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AN4R2fEe8iN7l24j5lfrSTU54BvxacRixVZm+/ukHn8=;
	b=18i/i2A92kbYYRpPcvK0gAWR8aFQM9DM7DeEh4aeUhgkyWDvIDpdaYZBhWUwmbPwohRT
	 PvA9t+3A/G7uQgBWDNQPZakHF+QkNGWCZD5BFPv0v1bVpJHSqP81RF+kzxkeyO3j/MC90
	 gZpYWc02nxTKfMllxdnl2t1UmiyzyXxiEvnEesOdFCD4eQMh+qGgVUH20VSuPB7Z0p7d0
	 kAGVz7Ed2IPZAoZSptZVroQqf+2CK3679MGxTaivTu3k5DLRysC42ky2SpnkyvqwKDIR5
	 yvJLkZEaALoJZ7d93SSIwH2T7AcdeU+fCjQQhdG+ZE/xEXI5VmA6yOBV5lJzL09y5hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVnnL85k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5CD606A330
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVnnL85k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3C81F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 17:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794675719;
	bh=AN4R2fEe8iN7l24j5lfrSTU54BvxacRixVZm+/ukHn8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=MVnnL85knWfRfKDMDvYdTqFcZdRjrYQBHAd9hQx6MMgOh2zdTQwXeKNAlUUygbv4w
	 bAEFUH/70Gr5Swt2Kdet5ICl9DdiafwV8NDRafiWbu/OFaDKITi7DO/AiCud/sRTeh
	 vI6Q6Bhhtjo0COgZGrMCuEVDK8Z4bqC5UQu6K/kD35PJhDfVXofoYzDHKyU0BxtT9H
	 WbzHcmyVIVKk/7KgdE+x7K5JWn4NkdQKgLwWwPJYkeqsxViaAMVXDl/bYhe0hwkuwP
	 oLMzLHxd4pRLSFIGQrwcffVW3dJTdziQ8CNA3zdcRkzkoYmuOIZOFPUv4tYL8fKwQv
	 PUxh/aDn4sLfg==
Message-ID: <sashiko-outbox-214810@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 5/6] KEYS: Replace assoc_array with rhashtable
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261114164139.429814-6-jarkko@kernel.org>
References: <20261114164139.429814-1-jarkko@kernel.org>
 <20261114164139.429814-6-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 17:01:58 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The keyrings subsystem is the sole user of assoc_array. It has over 1700
> lines of code, no test suite, and a long history of bugs, with LLMs now
> finding more.
>=20
> This unfortunate outcome has evolved over time by large from the shortage
> of in-kernel callers, time bandwidth and 3rd party contributors.
>=20
> What the keyrings needs is just a generic key-value store, which performs
> well with sparse key sets.
>=20
> Replace struct assoc_array in struct key with struct keyring_index:
>=20
> - keyring_index: holds an rhashtable for direct lookups, an RCU-protected
>   list of keyring_link entries for stable walks, the active link count, a=
nd
>   an rcu_work item for deferred teardown.
> [ ... ]
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114164139.4298=
14-1-jarkko@kernel.org?part=3D5

