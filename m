Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352836;
	b=eVPbgVkg1vfZFtoKmSCQeFyS2HaE5j+IEHq8nO1jUjBcRWrKwQVcjLjvRbf7shaP18C0
	 pXmNXeO8Xx4ghqifbnMJ4O0d+a0F8F19JNDnxL1arjH9VV264P3+uJYIBB1VE9dw94unS
	 lnZkkXG6yamcifvmy0ngIbz2Vqg8P50LcHuNnvEF6Ii0PsGs4BieV/OfOx8/+HBr1vSgU
	 oQwqNQUANn2kh95WMqcJ8GERa8qwxmsTxShKWu6sUwX2ug9qudI/hhRN4bHKfHmHV5Bpi
	 mfkVxjXwwxp/F5fPWcIvwQpt2VUF/FO6YYJixRLZkueq4/qq59A3FeV7OCOg9lX/2mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352836;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bF0DkXcMB6F8IdpPPd8ORvOZTqeOlu0DVnNFuE+sF3Y=;
	b=IfE7+OQIb6wgNRS52gE5TvT+IkDrJzgoJZxtL7NTTw9Su0JKquma3ofXKiOxkyWiRTrD
	 +ckPKRh6EHsRIISDiu3ACnG+7t5j2yk6ziNzaRtQS+cvhMEYEEKUhqPgSzcGZ8gSr0a4P
	 DeX5bmw4YbECpC8EqZfNRiCEMUKsLnYbBo7zUB7rqkPsCMCosguq3zfTudamhVk6ErdyB
	 GjbrBrXqb2AGd9haM9fpqxJiS1U3J9UjBRvhCHwHsXNKHhj4oOFYJ0c7fyzYqTo30Gz5Y
	 CR/lSVCnk2889GGKTGvUUSlXXJLIRtbk1qQacU+hzECOnNrzCZwJsdRaI3L9dJsv8gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPHK2s42;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6046606A321
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPHK2s42
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E83D1F0093C
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 23:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352836;
	bh=bF0DkXcMB6F8IdpPPd8ORvOZTqeOlu0DVnNFuE+sF3Y=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=lPHK2s42QmJkIN1xoJ2SFMo7QWnxKnBWY3fXcQqipBqdeYUOE2BWO9j7jAA5RVqiK
	 2gnTi9jX18HxzmwnTwpTppJO/jkoAyHIMaZORqRYxssLC2bn+Jdt6ijSK1/2VvfDzL
	 A+mHrgxbQhVssM+zyvmhQ1L4+8W42zhJ2YurEV6I2P2yUABHOMRSEp+EYqTWMz94e1
	 fYRe0hN6Xev0h3aweBvwHS49hwxzD3Ake5SDePQTYYoIfQrSXOlB4Pz7I+mUCzN14y
	 4b56OYWSjIbjBMZCRldXAAB6t4zQE5gXYQGe1Z3s08xSknrcKEXlWfNu14aYKS+vlN
	 b6LKHGV1Q7WFQ==
Message-ID: <sashiko-outbox-207883@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/3] userns: don't let setns() lend CAP_SETFCAP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261109-b4-setfcap-userns-v9-1-0d3f00976ce2@toxicpanda.com>
References: <20261109-b4-setfcap-userns-v9-0-0d3f00976ce2@toxicpanda.com>
 <20261109-b4-setfcap-userns-v9-1-0d3f00976ce2@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 23:20:36 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> A uid 0 task that gave up CAP_SETFCAP can get it back by joining a user
> namespace that another root task created.  Commit db2e718a4798
> ("capabilities: require CAP_SETFCAP to map uid 0") keeps such a task
> from mapping uid 0 into a namespace it creates itself, because tasks in
> that namespace could then write file capabilities for its root user.
> setns() gives a joiner a full capability set in the namespace too, so
> it can do the same there:
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>   unshare(CLONE_NEWUSER)
>                                     setns(A's user ns)
>                                       allowed, euid =3D=3D ns->owner
>                                     write "0 0 1" to /proc/self/uid_map
>                                       A had CAP_SETFCAP -> allowed
>=20
> [ ... ]
>=20
> Suggested-by: Serge Hallyn <serge@hallyn.com>
> Link: https://lore.kernel.org/all/fd159e68-c613-4c7d-bfba-8af0a3f3a96e@ha=
llyn.com/
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-b4-setfcap=
-userns-v9-0-0d3f00976ce2@toxicpanda.com?part=3D1

