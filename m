Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117009;
	b=Fg3ke6NxraKj5qmwpS1heWR/s/UFWYbeeTiixYLpJcnmsKJKpmEiENdXWpkMfKnIQfjI
	 A01RYXlvOY4oRk4kZpcUukN5aO/72nqkyjZfbdjylLZAFszLs4B7FI/veGxaHaU+MxA75
	 JwB3EjRExXiYmCkHHBMRaVnYjLkBJcnri10vJD+5gK/lUkw6cq7xKKSu7MrTmWSwov5O2
	 V/qyPhfgbaYOm84ya6n9GIKhRFpAlL0flCzXgxAiCMDyPxNRAkUN86P2Mj7QaPfrL0o8P
	 RLjDo/wgUh/MnkOC2LCASL8612Uugzl9S1noK5jyrYZfzfMaL2D1mn70lsx7ARxG9ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117009;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K7WbNgJ+WWuatYkB8tLHAKewrGS5mDEzvMwxmjhCOMQ=;
	b=KyARU6VCgBNIIuGKcYXxGKXA55lYnXhfItBWbkd0qB9GaFjw9C1uhII1qce+CQ8t4NnU
	 KqGlHCqpAc1sf0U8mEuGzF9BK6AoD7VwgUFgh9JtFBGDcknXqW5F5QScttY6afLD/Xurz
	 fCcZun/rFFvJ2LN5INarlODvm6wXnVFZUwHkhZNlsG6CLk68FIfcssTR6nelGFWrNg3Ra
	 nrGvTRZ8llNuFXI4epCHoHhWKCrcmf/4lJlnfaeyEr5F5JN2pI27GiCTTWk/8cx7LmK4G
	 iqbcoMDurHOs/LU4J0gWLQiLNGLNSa1OL2kT3WE8fZrHWHIvvPxNOUr1wN0Vc5g7hKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tkb+tPqa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE94606A33D
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tkb+tPqa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA421F000C5
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 19:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117008;
	bh=K7WbNgJ+WWuatYkB8tLHAKewrGS5mDEzvMwxmjhCOMQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Tkb+tPqaP6pd9rXkLAIDRY1udBuLulg3RYWRk+wSnJMTQu46Wkxi+LM5ccWUdxFzT
	 7HB8nnviGQxoxVswG+05jonySkvtax/AbvsbV0BP4yDCMtFG6S7W6KyYBdvq9nHvCB
	 AqOYZf7oEybhPqjlZoqm9ERmA+Iyv+MTM6mPZdMnmHsFwbgRLXDX9VSVoV/tEaOmRr
	 /3CyoTdPqH6JlrS8DzGSSTb/XAN7RmGYblncqbEoZqoZKlsYKCLkju8ZqoTkvmHXkS
	 b3AVnsDakijxZLqHEeL1DIUWXsBFQEzcFbgzFys8IqwOUMCSsw6eBFIeuNdlVyPVuB
	 GpT+ZCOhKnARw==
Message-ID: <sashiko-outbox-223943@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 01/13] nsproxy: Pass nsproxy to
 create_new_namespaces()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261118193539.240065-2-jarkko@kernel.org>
References: <20261118193539.240065-1-jarkko@kernel.org>
 <20261118193539.240065-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:36:48 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> create_new_namespaces() takes a struct task_struct pointer even though
> it only reads tsk->nsproxy, preventing callers outside kernel/nsproxy.c
> from constructing a child nsproxy without mutating a task.
>=20
> Expose create_new_namespaces() and pass the source struct nsproxy
> pointer directly so root namespace creation can allocate a detached
> namespace set from current->nsproxy.
>=20
> Co-developed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118193539.2400=
65-1-jarkko@kernel.org?part=3D1

