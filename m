Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012107;
	b=0yU2F5QzcB53azcofdkzrpkCl6IpVDzTbt8zzuzBa+mssBIcvrsvflLSip4zxO+7TO2m
	 roKut4NdtwVkNuhkfPvmN4vAMtNj9FQE6yF3UKSeEuQdDtE+i17WcfC2B2KTnPQtWMvSO
	 e0opWqfFuk3NYeocNEJ4a+tdMV/VBsPqgcUekp6Wp9SgLZnZfVeFDbVwnw/0Ddy5qDdIg
	 ILQkmMomOVaCXIkNaL4m5AeEDS/yGP5K219q6nhMp1fJGupgK19K7V9/ePO3bDnO8TEw0
	 HiDxYK1ZO+9d1tWjQHhWmYWtGyTLMGWdfrktEsqGr9dQ9CBRr1gZftYxz5XdoY44Fbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012107;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ORw+zwi7duwnpWEvzSEJgZZ2M4woe05sKMVPl6AtzJM=;
	b=Feg1quJhm1sVzqW6HcPlmVObOYudNaG88NirIyjuY83OjAZXlLyY/V9+n63Gnqf4jav0
	 GUbz7CP3fvwatK33hQ9KagCIKxfipzCp19LUrk/ZVrFCkvHe77mv3ZzY57uQH/6y/YzQJ
	 ZJz+RiGaOmHuE7f+QBYLZd9pq5kPsLfMPL3P3oDPOWLCPv/geXB2bVnpvrpuZ3v+UcL3V
	 ybs9NPTlrdHcRyFNd8c3LdN8yMSnIRO+Pp3IWWzBQpfMXL+6HNAKg0rHRWuvJQzurCQnM
	 U3oSgsi2gJ5hqn2I9vWk2OBSbSZbrE8DPqSdJjxcDo+AtZQ+OBCk74+UQ2rvOQG3T9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LQfgy/2a";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94183606A31A
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LQfgy/2a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1429B1F031E6
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 10:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012107;
	bh=ORw+zwi7duwnpWEvzSEJgZZ2M4woe05sKMVPl6AtzJM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=LQfgy/2azT3CySRJOdA3Joz5+qEqZeSE6Si+gsFjAuEl2XbTeZt16INMa/eJRUh3y
	 qWL+4/Mby7szNmp7nlQJKiIiBvtMRp8fe5fxHWLWThRPeZdTTMUIxkVJIayap2Vy3i
	 hS69VsDWncipUpxB3c/X93JdesMqXY3p1MPLMVDkXJSkHe2IU2qVr3ckBhhVcJY7Ee
	 b4YoiF+ZuxYht6zrH0e8VtBz50dsP1Um7sb+YUI7HJ34Fp2vyKZ0fhkiJmXR70Hb/B
	 4BTooBjBwq44j3BGtPqyUcnS21ZkSSrAnFqSB1XlBOjtCtBHmQ63KdRD/qmLwSg0PL
	 7REXB2R+3jeqQ==
Message-ID: <sashiko-outbox-185024@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] nstree: drop ns_tree_add_raw()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261026-work-security-namespace_free-v1-6-ffa3ebbf71bd@kernel.org>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
 <20261026-work-security-namespace_free-v1-6-ffa3ebbf71bd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:55:06 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Now that ns_tree_add() doesn't allocate an id anymore it does the same
> thing as ns_tree_add_raw(). Switch the remaining ns_tree_add_raw() users
> over to ns_tree_add() and drop it. Rename __ns_tree_add_raw() to
> __ns_tree_add() while at it.
>=20
> No functional changes.
>=20
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Cc: <stable@kernel.org> # mainline only
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-work-secur=
ity-namespace_free-v1-0-ffa3ebbf71bd@kernel.org?part=3D6

