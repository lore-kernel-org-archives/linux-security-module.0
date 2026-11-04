Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826851;
	b=3GuApiNMZcSXDYs2cQmO0I8FzQbZVbITXWOOZxtsoEZfaDRuFOAEl26oc0IrCS/fMLhC
	 RAaI9sWmddC/typIj2sRVuVJjNcl+hWV2UFhK8ByhiM0sxfveuBZeVakVbSSgERYSIcUJ
	 OmlGXSml6MDHyBJby6JFXcMt86q9obQ+j1tvvNmR4g1Jmz3yyJNzvwnRPeow3A6chhFiN
	 hZAOTxcOp5AH4uhd9/f10ZjA1jo3TYFBm7Rrk92MkruD7OObDPWPzqRmrg6XRJgZELPn1
	 ZUL1ESPRVK9d6pLPC3fRhwpDd0oo1IQgKIfyqUJBMbirncHrn7RVGE+d8TIsRSeh6JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826851;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mnw5mfQal3w+nw9hYjM/XGvsfC5o5zNDMtuHvsSQKkw=;
	b=MazaSX1pS6HwlrJ6cP2RQ6p//my6w7xFRP6+jXSxsdCKhV5+ol7adGC4lN1aMEBFSV9Z
	 mJhz1uTfuLV+acSSKKJ2Cg8rl/nwLb/LMOa01hvmLBJ/3wa4i8GXUMfwHJ/zuhyFhfWFt
	 ACTZ16F82hNjZ8cEIH6acKuWZwLLUZ15FN+RmOiMetJnbXDOF0Oh1CNTCD53I7LgjkJ/0
	 wseHJqC8Y3DnaMMIcVURbUKrR3LWqx/IrLjeKTbLLZgCPkJ/70vqNCMM+ZytHXjiRQZEi
	 wmUrYToe6f2mpSJ6UVUO84hITfOpy1rNcXEq/R7r0PHfinZCxmNOySZ3nrh4zFUv81w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DU2QIf3v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A826070422
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DU2QIf3v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F231F00A17
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826850;
	bh=mnw5mfQal3w+nw9hYjM/XGvsfC5o5zNDMtuHvsSQKkw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=DU2QIf3vtbZiMBomhWZMNxEKI4KJE0bGDmbXgQ+GKQwmn1LEedTtfGxFNrb5dUYXx
	 OIQvC+40AsUaRhjTqRUC1lp92t9KJmK9IH987g1Quuv3GWEgr2vGJRYPGeL4Kj7po+
	 ojjlYyY1eN1qKPxRA7ZhwWkKGcEc7eQyV8EQRNqsNDl7uOD7pGKkP2R6oxpJjF5+Kg
	 ZPtHkaWioPYUi4987s/qfbc4TSIYG89d1e2MlW7y4NqZdrztYCW+yw8dHYqngrKbL4
	 IkZkjaY4qwsd37SelSBj1PEhyiWVz1FbzBOHsbd7WAIHR9uEP/GbGzJBHIVVOP/md5
	 zzyw9mAd3D5Lg==
Message-ID: <sashiko-outbox-198062@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/27] selftests/landlock: Propagate EXPECT failures
 from forked children
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-2-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-2-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:14:10 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> A failed ASSERT in a forked child calls abort(), so the parent sees
> the child die from a signal and the test fails.  A failed EXPECT only
> sets _metadata->exit_code, and a child that exits with a fixed status
> of 0 hides that failure from the parent.  The child in
> trace_fown.deny_scope_fown has this problem.
>=20
> Exit with _metadata->exit_code in that child.  Do the same in the
> audit.log_subdomains_off_fork children.  They only use ASSERT for now,
> but this keeps them correct when a check becomes an EXPECT.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D2

