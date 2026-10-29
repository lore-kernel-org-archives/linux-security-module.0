Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312311;
	b=3wBS5XSqOpa0YzDPw05dvrTxMeUl4ziG9UfmXC465k1CTke/qos0HH+VPtsM/iLXDR9t
	 WNcmnhl9Zr92K3eGPFWlJ/x9YcvHUT2xRKGRKl3gqNTP1cD7ZpUJF1Rj08fVgGczwBO/O
	 dqk+PR1JkrYpATkabqDiuRihb0Aws67lQeix41lgAMmPItwNFbpuy586oP4nT8ObenCkw
	 JgQBZ5re9I/I1m7G43Stc/zMRImkoZ5IckrDMyi8rsG4h1t2h3nlZeZCgjtOTqAceHx3M
	 yUFMKwI+D13M0c2llQxHHPz672akklJy2BR1jd+EhjkO2UYT27FbR+MF+j+dT49h26A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312311;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OZXZU+pISjzbt0s3FqAlq9IHLYtBRy1lMuHomZdW/VQ=;
	b=R9/DmPpET2UVda97Lu+7KE/VzsaFgV44t6fTKTHRLdn/lYmgf3ON5rDcs8LHxi9y3HB7
	 94QpdHvzEI7y/+QLXqGkGsp976hYUnR6rqTXVGyPWdf4POJ7E5zflJ9vs2qIl1ttJHswk
	 Gd/EA2+KEFftT6Z/iCHAIqLk6uOZNSGoD5oZnUOkHNJy3sW6VIiAoxRO5Rz5GYr1ctxs9
	 YsKuUJ20NrxvTrZ8rDML6caEFf8njwQ4Xa3t6EnHw680GQUPhuVZxfYco6ZHvvDrfufEe
	 O4HD45jfGDAKnSc2JIGpdqvNgR0nuoH9gzb7rYFzEHGRUMGunL9RA3t3uzRVJ0UC73Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BOk3jrIy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38366606A31A
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 22:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BOk3jrIy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70D81F01824
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 22:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793312310;
	bh=OZXZU+pISjzbt0s3FqAlq9IHLYtBRy1lMuHomZdW/VQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=BOk3jrIyGBCHBLhC26jsA1JuUAqWo7zVVSa9vnM/ABJg5wc70Eb874WUHpWzGCsZP
	 Ss4VHEVXkN9QHnf/qaka+5H005cLiNplyf08ctrZJS5E0r9qlKK7YxT5EnXPGVLCqt
	 oBDpZSeY14Fet+ejpyDsLmlFP74fNi7lxn4BDY8sSOZG48LNLJEyHPqI7sQgxM7q5a
	 67q9T7DKzhrzdQrJqhgdoz1Z+ovCk8+VeGvQXOiD8E0Z0VkP/i8/7x29eV2Gl3X4AO
	 ee3nASjlgUt80rpKbTNaB1gZ7BEV9zMIHj2sfLBszYcayQO5FtHwNihN9b/EmBLEWl
	 phmWqsDR05QaA==
Message-ID: <sashiko-outbox-190069@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] selftests/nsfs: add tests for NS_USER_GET_INFO
 ioctl
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261028221705.3915340-9-halg@google.com>
References: <20261028221705.3915340-1-halg@google.com>
 <20261028221705.3915340-9-halg@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 22:18:30 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Add tests for the NS_USER_GET_INFO ioctl to verify user namespace
> capability bounding set inspection and validate error paths.
>=20
> Signed-off-by: Hallgrimur H. Gunnarsson <halg@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028221705.3915=
340-1-halg@google.com?part=3D8

