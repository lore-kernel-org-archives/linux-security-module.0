Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292904;
	b=Mds8VXOnB8luEBJqscVm1TzA+m8yaSS7HmJ9XcCVvgoDmWxrBAHBR/AFV+VTQ9poZBro
	 nKjemay8vQDUk2jTlX5/lXVLgLaPVnQjIlrG3V4m1ISdcLrNXfKgU0nF/BIpFwJ6KsDeX
	 jDD9zQ17Uw6p5souC7cf+dOtgRY8+tQWipdbDGEJDpfebbNfd1FfeG9d8fPo5TzCOUDU0
	 /2oBMJRG481PwHbZa98tL4Wg3wTHitUXivfLbAo1BcBMG0vKVnb5JRbC78I6zbXbwOyIw
	 9DOYpMHFvVFtz9H1QdKUoM5qhizstT84jiz5xnHq37VpAcJ1QqTvoKRy7pxaW9CVOqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292904;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yHLa5e9OKQhgmCf9w2Utndr5LZC7/sNj7rvw/iATWcs=;
	b=phObVBSJ77+5MZhAmRYs+vnxz+0oPbD1VAYoeCi1vkrkM7zWdVMEmLOp5XeRAaU0k28s
	 0Io6If7FmaU0drcHb5R93PyXxGmvlwXt/Xhtkp8wNQbXY4Yh4OsYvLiif01WAyUFdCmPV
	 YMktvtZwvsbj3CHtVv/e3OeeXWgxUog07boBlJvu5j/DX7aXpGV4SA1OtXGVQLEzTcwKQ
	 NqGdGtKyC8mhj6GZlB1Wa0mSpAX1EZ8cDaKaEOEFPUvEUVzLKGNCfNWDi6NQe7He9QHZN
	 AX2UN6AUhj68Iq/Y05xNJyUkbsqjwHXzepuy6CiAhYThmd/+g1VeAoA6+CrIo4ecU7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BOsUUd7r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E559E606A31F
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BOsUUd7r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD03E1F031E4
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 16:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292903;
	bh=yHLa5e9OKQhgmCf9w2Utndr5LZC7/sNj7rvw/iATWcs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=BOsUUd7ro1uJk/Wz4vGJhClEobTpJg5p6ga4bekhtvQfkPiw9745Xn5O/LgV4nl5F
	 yH5r2cgxxJRjwzgSiV/xxzHKqFeGQ9VVo8FL+lBPsdoxn1dKrqJWACavxAl928oHwL
	 U/oPbeNC+g5XNgEt+4SereZsC+Ca0PQsRf1poN0Airm0Cc8MHH5sZBz49+nYdj8kaj
	 HXz16hksGOl6gLwzSeD4yHfqguoXR1E7MpUli4IGGqA9HssrD60o1YbF9Cl8498iNV
	 Ibl9dnorORNpZQhoQXywtrX7YBmDXQN8ry/UvOVG+6sPxZyKSkEVmNwmwmPYHhRIGN
	 5GXE4qMHu2XYw==
Message-ID: <sashiko-outbox-189690@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] selftests/bpf: add a lifecycle test for the
 namespace LSM hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261029-work-security-namespace_free-v2-7-65591dbba7b3@kernel.org>
References: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
 <20261029-work-security-namespace_free-v2-7-65591dbba7b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 16:55:03 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Track new uts, ipc and net namespaces from a bpf LSM by their namespace
> id and check that:
>=20
> - namespace_init already sees the id that NS_GET_ID reports
>=20
> - namespace_init, namespace_install and namespace_free fire exactly once
>   for each of them
>=20
> The test fails if the namespace_free hook isn't called or if the
> namespace id is allocated after namespace_init.
>=20
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Tested-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-work-secur=
ity-namespace_free-v2-0-65591dbba7b3@kernel.org?part=3D7

