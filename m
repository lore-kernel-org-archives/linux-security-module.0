Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795469564;
	b=HGtzjoQGvDyVZsFiRxwgUZ7qk3BJYKNTr6jE2spKnzW8XXitUZJxHLqgftJb/9shRGJ1
	 dV5x+5mq6aOBDWKuBH1dXX+S/XrjpCKLNdDgFMIfp2bqwQAIDTVH5ZZmHPZ74mk3/xja5
	 9rmlucjv8k16oJYRHNY9O94yPwORyl4etVRg7oUHFXdoOsnX3AqLPPdm0j0RCaT4GxwGf
	 hSZ65bPmOC5G7bPejJiiZWHWSI3EALE5SHfctgnfbaUNTnPLOXJNgFIpVpdN7aONxcWuF
	 cC7LXp3hYznXssDAYx2kK83m+m1jiER7zluGX7sEaB77vJKyexvwe3doLF7foP1mGJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795469564;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z2PYBFdHi3WSwHZs/zfpDVAh7bPBKbuAgUwQA5EKMVo=;
	b=ii5bi1COJMMOfFrKwUaA5hxGGaGypl1trAIXMW0NLCw4MUn6SDaSu2MIPjh6mUgHhkjY
	 Gvn5ea1ocOYvzhm7FJDAMW73N1em/+nxqcKiskPR1Qa95a90GSjS51BdpgvszfpwgBlBn
	 sP5GMDnb736oGNMnH/1ILjdkIDyrfjyhbSXTS9l6uI3Sg1TClidOMaeEbyMPEVN8sUHLP
	 GboXIIk1pET5QzuiShZu3O+veh6x+N/4k9S6VL6r313JTPtIhvijssDcKqGamQ/TKqjmm
	 lWygYDEsbJkd0NUHr52n6catbE00+HYzPrgpve50LcWCppWg5XznVdOaqINcVoaNZng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StqwE+UF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DD1606A31E
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 21:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StqwE+UF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00261F000CA
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 21:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795469563;
	bh=z2PYBFdHi3WSwHZs/zfpDVAh7bPBKbuAgUwQA5EKMVo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=StqwE+UFz+MQoI3OAjvxN9OVru4rMRGxDi5A4GKw4j47pJRt8XJs+HlmcrTy1avho
	 3+Q/JkI10vCL4ZxVayMUQf+M2ZUZT3xUGKPSjHwnZjyXElnzVMUL2dSoCLHw31O2v9
	 QeW+Dz5591sl70d6OrexY0Ar3bE2XRjN/We1LJ4C2iZ96ItVri5Ea4yYsA1Puoc1oU
	 nYVq9vIIP/MAa95INOG37tdkLdd7TzWrBEQgYHnLwKwWLICBykODgJD5k++Aw+mtdt
	 UJGppCd8aUlIIKg794XKUO4U8kYodvXDFQD3w9WXPB+rWzCFyegKX8LVi+54P4iOG4
	 QaVyeXjJH0kgQ==
Message-ID: <sashiko-outbox-230086@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 0/2] KEYS: keyctl overflow fixes
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261123211959.4102708-1-jarkko@kernel.org>
References: <20261123211959.4102708-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 21:32:43 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 2-patch series:

- Patch 2: no issues found.
- Patch 1 ("KEYS: Fix userspace buffer overflow in keyctl_pkey_e..."): 1
  related pre-existing bug noted

A detailed review has been sent as a separate reply to patch 1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123211959.4102=
708-1-jarkko@kernel.org
