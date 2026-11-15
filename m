Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794783110;
	b=Ng5LJsnEAKh3XoubjKSFn65Hmpu659tc5iUCrqGwXAXN78QSNBlCF64At4LCCqlD7adm
	 1S+2vASLJ7jVEfM+0yIcLIq4j6cvINmRe9e5AmR9BHOMHlwgJmOoi5kqjoQx1cf8IF3t5
	 5RG1UO5jBSz5oXoJJ+4EEOrxJsWmyCFuYw3R9IfKdC66ZDE0vj+LGwVVSVS75lP6bSN2c
	 GZPCtAJhobtYRjWjDUgv8HqrbsR4O85SsN6FYW2ZLmZ8sHyQKz3a7kXhIHsm075/UQf8p
	 pdlFRV50W03UuOutwbDbotK4cHcTOkDw6ynT7Uf1lMCoWBK3YXQfGM/aipjZP54pWJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794783110;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E+26MwIQtoTgXV3SSzPsmfheAUlspHnZEJtno+DCrz0=;
	b=svkihPGGUA8PklLMh9rz5zA9ad9x7RMVIqUWIQ4dkWHQAq1fbpzZawT9khHGVCTuywwL
	 xCpVSuAeW0l+ORb+jDJIS41zsOA7R18TldFVi//uzFeH6+SZCF4h+5f77kGoU5IahbQnX
	 nRvRUUf1KrfaxA0KckK2GaELV/UXYOR92SEbZhNlGZmvGcgenXUQ+5PvFzrVYs5zTvC1g
	 0NSgcVpzd4QlHddS3MtVpSj1TIKANkl5xvyx1td9eO7a8Xdw2R9Y5Nxb/GmOYr1SL8TMk
	 PjBKxUfvDE2vjphGFGLg+IhGf3QQfgX6U+8cODLvbj+QlTNeV2BHhGFdySX98HVRNHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fHBBlLRp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC19606A330
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 22:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fHBBlLRp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA1A1F000C6
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 22:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794783110;
	bh=E+26MwIQtoTgXV3SSzPsmfheAUlspHnZEJtno+DCrz0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=fHBBlLRp5uUF+KrhOsC17C8uLKTRLa0I8/6hg1yYs9t2jDOHnNkbbS+1zjjDmQQfx
	 57xJ2o2GkQA+Slzg27RkNTmEvpqpiTvK1+yLYeFrYNXOl0AH7ciIhMOr2/Q6nkM4uj
	 IDWnPK9JF0abz2VJAqO3FyeecWDi6ApLOY4nyjHHxk6JfttqQ7Fs3dsKRYVy8N9D80
	 MArdn54mCP5OoPsRxjR3LCw76IgcI9Y/m2geEzBm92buL1uhENDQFSdXEA5Kv/1pfS
	 yX67LMuEcxOMkdyU2ffugkuaQ3IksDBXADNdj/faiIWwFFgHY33r4Qvy08aPwk75fK
	 fu+tCOSqC+/9A==
Message-ID: <sashiko-outbox-215890@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] KEYS: trusted: Open code tpm2_buf_append_auth()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261115224722.1450498-3-jarkko@kernel.org>
References: <20261115224722.1450498-1-jarkko@kernel.org>
 <20261115224722.1450498-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 22:51:50 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> tpm2_buf_append_auth() has a single call site and most of its parameters
> are redundant. Open code it to the call site so that less cross-referenci=
ng
> is required while browsing the source code.
>=20
> Reviewed-by: Jonathan McDowell <noodles@earth.li>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115224722.1450=
498-1-jarkko@kernel.org?part=3D2

