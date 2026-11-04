Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826901;
	b=uzdT5igJS3/WBH/b0XEeVMpEOjlDwnMftwrcowHsQOs9/CQ6rYSycbRem69LdPWzvqz+
	 omkYDOlYkJl3KNQmprwVnBQ62Z7TtDd/2/LMFznP+9xgkU6tHh3Le8WX+YVnVzxpH/Dn9
	 eQtuM0aTSTRaIHtDESTXnkS+eieL6Y7qSQpy/dCFLLPx7mGBsk5kRhXsiLrWq8fG6iyfW
	 jUL+yIwAn0ttHMfR+wdtqeUQYTMOvDZlYGUizQUhlytzt9wBHXo4giFy5Sn4B1jF6wZLj
	 Ou8FwccG91EYxRobkFUTXE+ndu/pfFN52czv0Ydu28Q4OfWMOAJD5+G9CMntP+/btPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826901;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gmDKUyTnarigoJ/YrwVkoD+vUNInwPHPHVAbJkxflRA=;
	b=GlU2xWdb1ON4r1TqBxlQZ706Ivm+P1UuDgIt5DG0C4OG8fa+YBJB3aR+i9J102dRD5x2
	 3M/nMjaNSYLfBkznDoiw72w8thSjL6e9pPNl+B42EnAD/xzIMXH6iw7LnGa9X4MUs/u3p
	 m6BnKLHU6Kx6rNCgFpfnAojIljFA3tjFaPKLb2dbNaDEhoR8Kq2iuWW+2Yss0ax3AMm6c
	 WdVSQz3QBs3UczvrQELPPzbyDfK/1qxlShschQGASmK2/rpooa+cl7uh/DqpRpDv38yi2
	 YH83BaTG8+WP8rF6KdPw+wQbE1dIfXwKk/KOEYCQd6KzSEkgaOmFhWy6NaEJV8N9Y8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkCiH6xE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705CB6084B43
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkCiH6xE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4451F0093A
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826901;
	bh=gmDKUyTnarigoJ/YrwVkoD+vUNInwPHPHVAbJkxflRA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=SkCiH6xEJt4UnI1RogKAcKwK6rOfPmzkJ4WIzUOCs4918giwEQmyQ/4MFCsSsuFr5
	 OWqHnxkxcMelGicKSBoouRbylv4alMAOhgeiI8zqfmUr9GckMiDhycEiLRtfKV1SWD
	 zYrwFkUmoeQfGTcTr+I8YBNRa0KNt8r/4srqjDrpAdEuWCVWSUVND+caY7IHLe505L
	 ur+97sqKHgf9zy68yc5Y+zghr9mR7wwoJJinBFP3pyGqBN5MwN8nsz7ACAyvImdG5P
	 FknzofcOdW8VY0NCMUmic5dkv6DWR/hZhm6soZL2+tMwG2Iewyn0ItAv4YJhgZXtIG
	 aTbTTk4xaf5Pg==
Message-ID: <sashiko-outbox-198076@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/27] selftests/landlock: Fix SIGURG handler setup
 in scoped_signal_test
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-17-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-17-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:15:00 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Drop SA_SIGINFO, and rename the function to setup_sigurg_handler()
> without the parameter.
>=20
> * Drop the SA_SIGINFO flag: This flag implies that we use the
>   three-argument sa_sigaction signal handlers, which is not the case
>   here. (c.f. sigaction(2))
> * Remove the "int signal" argument and rename the function:
>   The function was already specific to SIGURG and this is better
>   communicated through a different name.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D17

