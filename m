Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425276;
	b=4LV0NnZn9HGIaTVNO6HmfP6uWYfF6o8E3gTGStxdSb032mOB1H+Ot7t+xjtkh1mNdnHM
	 X7+KBWCe1skfwZu+FqgNbkmOAhkaGsiRrk8W3/29fINMrn8cmJ6x4cvMt84jrmZ89fsZb
	 KLGZLvfNiOZe7h1Jqg097SBf0aEV9DJlDWXWkR1YUM+cey2eoXarc5q9wovktA/dc6ijO
	 qTOqd74idRsGume5OgXKw4pEBZN8qY7gDKHRt+gl/0dV4VPD8jJJ4cHQUihWetjyAxqPp
	 5gbswGJGLm7rPt8vv7c19LbsPOzpmRPJUoBvb9DL0nZtXr+iAfbD6xkWy7K1Xn+Dt7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425276;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Rbyb84CRSA5pfjG8sHU6xsoE/z5wYGYTxHnvtXzB4V0=;
	b=19S1Ak2FW/yRlD4gX1cwKvFsCSLIBIkL7i/V3CoQzHNdKVi9Mg0yHUMwIqWJo3co+sTI
	 j6kbFfXCmw8EuIpA1L6/dsYroMQYNxyBr9LTP2sl60a9sAvdPG9cP4irsJsK/QYMwNNah
	 U9YXCgkELZyTieNwYWL8f7Y61nVJB2KIe+nYS+17LvQCb1l+bX6qWwHLhA1sDWE1LXTTD
	 /8Z9a799idYY+nIWC7pQBJWgDPjc/S7OrIwLU0fl+h+4hG3FQMdNgY7uVBPQTAGISKfgM
	 UvWtj44nvPHGeSZZ24uMB4j0FsBtbAWEEqoKbkS3a5ypgqBDcmwEsnSEubg1yabNT2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zfm0bmjI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED587606A326
	for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2026 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zfm0bmjI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3BE1F00A0A
	for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2026 19:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425275;
	bh=Rbyb84CRSA5pfjG8sHU6xsoE/z5wYGYTxHnvtXzB4V0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Zfm0bmjIURS+GGpWy0wcMUCjqMmqkUt2sq7+rfmFafvEMyYuZBkpwowM3nGrv4mua
	 p6HmYrUQ6wd+aWdmNoeG1CJQLq0o7Whe3lPlE/+xHPurEV9KE6tiWypPFlj+neS3k7
	 speScgx6kjhmK9Ed64BOlb1Ud22wZXzkvPLbtouEvlXtnz5zWkq7+OO3n6o+mfo9Ze
	 4VSntmEF6LflJ58HFIXSA9df/jauuj3kDzlTJ5AXucAfSG4WJKMjBz4XU0XFdNWvl0
	 U7F8rxofw941WUTEAg4ZTlyfav7GzOjEAHzZIX4o+4QpDL4hr3VNi/419voTsUlIb6
	 1DdyyqTpUmcUw==
Message-ID: <sashiko-outbox-209560@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] security: smack: fix typo in kernel-doc
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261111191548.538644-1-manuelebnerli@mailbox.org>
References: <20261111191548.538644-1-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:27:55 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Fix function name in kernel-doc, fixing:
>   $ ./scripts/kernel-doc --none security/smack/smack_access.c
>   Warning: security/smack/smack_access.c:593 expecting prototype for smk_=
import_valid_allocated_label(). Prototype was for smk_import_allocated_labe=
l() instead
>=20
> Fixes: 674e2b24791c ("smack: fix bug: setting task label silently ignores=
 input garbage")
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111191548.5386=
44-1-manuelebnerli@mailbox.org?part=3D1

