Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794290196;
	b=PA6RHUDeIqT7PBOvuO+yvX0ohMW9VrWA0nP+2EanmQkEQpyjCwGJgB42LMd46dGQJCpB
	 CYU1XTsG5YceadmgOFeOq7QlpM868fsWjF+g3GR494IWUJVOU7/dajKlMf4PlvBXFsjkB
	 yw8U+Xd0jyuw+ZDkYWOmtkfO7fv0Bsex9wGGvWsYcqw4EM80/KvASfvdGJ76kLUnCi1lg
	 tU3viKEuXXMBYT6j4QglTJvN+O2PgfgDodOtfjGbOHuNVY9d8/CBVeniCsgoIRNIB/yQl
	 K9oLGhGym8aGg4Rj4Xd2Rb0mu5xsWB/eybVUnj5oTI3dsoTbLDWzCBf94IN9Q0RyJbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794290196;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MkYp3hPCzEIk6pJQTKy++zHxmW+wdU9SlA7JBvF4eR4=;
	b=Qw1emzvmxQiVHMjDRJ+61Fr8je0riklMmRK1U6tax8EOZ6U3O5EeGOHUzGGWZZfV1Qxi
	 94GZGhF0qW+v9YtWd9/osC6SoXr69+P92vE/2wrVL5x5xAC+7EaLPwBiyaVYFx42OujAS
	 9ZSNFlYYj3nsUCwZOoGBdWqC5S06TqKpnYIJLWUNwyvl5SoPbLUzaHq2+GVnRSE0FbwGg
	 HFMOdSGWSDiNMV9lMmkU0hEy5INaNqD+HwMB6sIfAvaGbJt39HJuQ+X4WiBRm5hEYp9Cf
	 BXM1iTYxKEN+Bj46F9FZKoTsPiZLoGbe4GdD5fZkAf1JIkK4sIdRidwVmeWtJWcSQEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pf+1IozF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308CB606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 05:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pf+1IozF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37971F0089F
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 05:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794290195;
	bh=MkYp3hPCzEIk6pJQTKy++zHxmW+wdU9SlA7JBvF4eR4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Pf+1IozFIxkFnwZouUlCEhv4Gf292jHhsxSZyme04aOd5y0nrnXwghCnESLwQckVW
	 Tj/qlTLTN9EnTCAK+6DTLtPgSTVwL59maVZm9S4CQSOEZLcUxBB/cbV1ZCeYJ7wK/r
	 qwVKGVo+r0Vba6qIY8BslCCnqNUeHCr0QkPm8dCUstCQtkfwB2jwJV6H5qKRqR472C
	 +ihT/KLFpWqMHTQiXeV7jglli+dBYPEA1sEGu+pdmR6/zFDhB1jshLO8A3Nn39Q1kW
	 GaWWUPh7dsp2kqJKjWE+Knsv5K9Wc2N6bUYMxEJKjES/lckbMqsBnkkDCJEwNFFDsZ
	 EGFA+NDPyz+Sw==
Message-ID: <sashiko-outbox-206357@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/3] KEYS: Replace assoc_array with rhashtable
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110053323.2936729-3-jarkko@kernel.org>
References: <20261110053323.2936729-1-jarkko@kernel.org>
 <20261110053323.2936729-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:56:35 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110053323.2936=
729-1-jarkko@kernel.org?part=3D2

