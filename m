Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827223;
	b=TIxzwdhRcTUj6MgRTijdZ9rSH1aGh27/BDJr78MEoE4BFlSWiqFC4XOjD4+N567jgd4j
	 oEU/SGIhHjw1E88Ki+U/6rbCBV0aTKwE8WyRarSeh3Ec5vrZbR3VO6xSxmXarFHDksUYW
	 s6FBUKSFOGf6kgaifXd28ALyBDBpbUr9b/7VABcz6CB++KHm568kJnJAsggIbIh2JiKGv
	 H4iYPy7qx5WS4XkIjhSYPsYG0FqGUuemGwS9KmHg2TgoTSTA002I2rNGt5MGjYXvuc8GD
	 XWZaVaYiYuFhWlCiYtXmBCgIwN3JEq6wivSAvg3ceqKQgWVja2aJOWohaLhCtb/h37w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827223;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mlskJRptPsPr4Q9M8TaJ4lhAYWB3/lwJ/PmJ8PEdQXI=;
	b=Gi53FvGvaDU1+CvMfQF+UgRsKY0voUYplf20y3mwpweF7I2D8wqtZX/EyA+55/kn2gvm
	 cGS4XtfB5ZMJgmF4Eu83UvqWxDYYrE6q9W1t+UoBPltN/lwPrqihPG+WaUEu7v8ShFX+4
	 Z/PDzx5x0DlZGblf4lTUcmmSgjvi6r2vvcfPceV+dC0VDXu7tFGuXELdb3hLzjBJz4Xes
	 aEmN/ZmdtVITwqIH9nzt7k9Ep6z3cxEjDFC3fh5vbQ3kiCtn5PcSYhUWFhqnOqhK20kCD
	 6yz68CsqPtzCJjHRbhWVextmR5gpY90vynWGw3sxFXZSsXw6hHQvgyOz9wL8TE+IPUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igVnEOO2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF7D608F102
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igVnEOO2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11A01F00A17
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793827223;
	bh=mlskJRptPsPr4Q9M8TaJ4lhAYWB3/lwJ/PmJ8PEdQXI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=igVnEOO2Vn4kBQHehYEOQyvwt5fYKZSog9o88nHW04TokzmIPtEXsoYY3BToWX51b
	 I1E7yXofcNRrFMOGQgkvLktw+1DcTw5JdftonZCIprEecwNXYsJpvpheilau+PdRpc
	 QnHLa5kNNTpPKHysbdubTKT5itPG66SAbLtenQbTMEDq3kilMVTn3WK2puWny5dl5F
	 hIuBP79WGG1k6M0DaDojQSBLoA1Rlta8aejdT4PjweLcXSRsHxO/Lw0ACR1n8IGZ/E
	 c9stAvyrcmCxGVjdbi3WhQSXXwGgULIDZQbxBUa8W+3ahxDTEKiURq+89amB1AltqW
	 GJlTYcuSrcj9g==
Message-ID: <sashiko-outbox-198099@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/27] selftests/landlock: Assert audit
 initialization in fixture setups
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-10-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-10-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:20:22 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The audit fixtures check the result of audit_init_with_exe_filter() and
> audit_init() with EXPECT_LE() and continue with a negative audit FD
> when the initialization fails, e.g. when auditd holds the audit socket.
> Every following audit check then fails with a less useful message.
>=20
> Use ASSERT_*() for the audit FD and for the audit_exec filter
> initialization, whose result is used by the following calls.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D10

