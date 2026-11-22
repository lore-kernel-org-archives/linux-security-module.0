Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795377758;
	b=QOgXxo5Yd6pt3Zv0rj1qlITRJ7xqpEd3oozXiHWxrSGO4jtk+VDZrci0ztWUyvCKlt9G
	 TiyZYWtuP73LZF66NkYZd8Pn9wJwe6h+sS7njT00vNRCeQmhrGbnYDQ4swcSSbAE5vkN3
	 e+Vxb8IWEWW2tygq/2sv0FaxYSnzsvhdhAeiHTe7Sb3xCCQjtMCZLnlGe8W2WT5VhrGp6
	 A74d9LVjl+/VcK8E455ajclLeH9vcw7luh7EiLG36irPY3RuPLA/V0xmCzz303sAHkipG
	 42O5F2FVfxz/V+yc6GGw3FvFXn3PUpvuSs4HHUQy4bA6h5s9fwQiymHzbWG4aAJkefA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795377758;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WqVMyUhucocuwVQNKawGs3kp4NzTTOejZYbwC5SFemA=;
	b=wvBbZpKa4ykvbfE8/BVpbCCgJNQ2pl2tmOmB3N0+WBvIdW7IfC96qmzx7o1hr5T24rOJ
	 SrtoQMsXP83ZpZasL/7z37wM/O4DEgxC75hMJj9tiX42B+pCbKmC3m3bFeZYbUsWY0N9O
	 aoXAR2d2Y2rwz4pG9+xxFRkfuWp3H0fU4ChsWD0bLR5Lg/G3hlMhkResLsY48rv8t3ZL2
	 jrXs4hS146Ua1lXRfQD3FFByO/ahUhN4Lt73giGVWJfUhU3mshxnxSY2wFJ+kI9qEBlVf
	 ODMJB2T9f+YjhTx7YLa+LZlXdlG/HCTCO8FsH+vsHoT7e9Yfrkv9bPKE9eQ1vUpeg5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QYv6E044;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627EB606A32E
	for <linux-security-module@vger.kernel.org>; Sun, 22 Nov 2026 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QYv6E044
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6561F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 22 Nov 2026 20:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795377758;
	bh=WqVMyUhucocuwVQNKawGs3kp4NzTTOejZYbwC5SFemA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=QYv6E044MCRcYlIYiVfVHOxxo8z09dhey8U1g7yMcdLMASoSMaqVCnNvsp0BBRwqc
	 apEVVTvv6CIYLXHotSJWhGO7rf7F8Q0O539Hr1faDqdlKYDH7RAmqEg0nX6LlXGsCc
	 w31gZcj2l+4VE3l9dKwggVZJKnhaAI6e21h5Aywfsmpy+4mr/ih0lCAUFo4y07VmQt
	 el75diS078ECJvuBV1gTA3TNBJa/MrnMprOwWEfSYZYtn3i/yhPeLNie8Buc2i2tJs
	 Bw2GWYx01Ob3odjc6pz60JMKkZUM/Jj5HuRhrOaLZ7wXSB/fqcqtTABqTJUFSA2gVK
	 1D/gQlea2Qh4g==
Message-ID: <sashiko-outbox-228307@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v7 00/26] userland: Userland containers
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261122193539.3334213-1-jarkko@kernel.org>
References: <20261122193539.3334213-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 20:02:37 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 26-patch series:

- Patches 1-5, 7-16, and 19-24: no issues found.
- Patch 6 ("mount: Support MOVE_MOUNT_T_MNTNS in move_mount()"): 1
  potential issue (1 High)
- Patch 17 ("fork: Support CLONE_INTO_USERLAND in clone3()"): 3
  potential issues (1 High, 2 Medium)
- Patch 18 ("fs: Support FSCONFIG_SET_USERLAND in fsconfig()"): 1
  potential issue (1 High)
- Patch 25 ("selftests/userland: Add userland test suite"): 3 potential
  issues (2 Medium, 1 Low)
- Patch 26: skipped (not reviewed).

Detailed reviews have been sent as separate replies to patches 6, 17,
18, and 25.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122193539.3334=
213-1-jarkko@kernel.org
