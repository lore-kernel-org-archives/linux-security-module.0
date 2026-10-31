Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793439274;
	b=vAiQiW0iFGyvu8fOR/Gqm9NadNhKs/YcjDxtELFu3CKga2V5AAoqFOg0RGaYkotdj8gb
	 5XcZ3G3Hj8qpFdYu0p9GI+xjn82AXTXmg37Im9VGmUVi1MM9HESan0g/S7Gto1m9HOrPq
	 Le2Wnbp7uNbNdF1VhQcpR3Pw6BUWRTnHGlyZ+LtCVZxY8227QpmQ/feJDwKYwcZi3m7jR
	 qeJqoISlqFaSvBnrQazgVYMxNAgLh7t6pnupkQp3v3CXvF36FIC/03X/s7IdkN6aovz8/
	 tNuhOLoLLDisimTyJ7GHo+VD/hr7IPwCLWQbTivK4xUSQeLttEaGFuDsa8PpjbB54Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793439274;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xIw4cd6k8/mh9TVhauXXg6O2QvoZPuSTo/tIRTwG0is=;
	b=ZmToLMNUNUOQLkhzTxPZAAVorzt0mKqn81QOlo4kY2JGDKJRGZMBudNHcGSeN1OUZMtV
	 swjqO9nL9+K0wdxuezkQnryHvvbUsG5vyK1MZp23GZp+VfmJmmeBCL57YnrwWWR+efxp2
	 ebhL5zkpiMVYAGvZGHN/1iAkJG2sNTAIuc3efvOzENbY+Om07rWzYlRxUGrYIfcErx7CU
	 wdQ/5lsdD1Hg6JPvav63VlK6HrKNSyrMZSqTSNvJymoUtEtqKDMzRrW959khKJur0/Ub3
	 p60CssqiuOgElWdiZmiEqqcwYkZG00dTIqIwk5RQO4lNtM9Ogcp55yilNSPbLskiJWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WG1Q/D7n";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF7606A31A
	for <linux-security-module@vger.kernel.org>; Sat, 31 Oct 2026 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WG1Q/D7n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32781F000C1
	for <linux-security-module@vger.kernel.org>; Sat, 31 Oct 2026 09:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793439273;
	bh=xIw4cd6k8/mh9TVhauXXg6O2QvoZPuSTo/tIRTwG0is=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=WG1Q/D7n5Pn5AiGrT7hekKULdUny6U3TPqhR2yEDnMLqRlMt7UcbDzYvXpY2KQNpo
	 Jh6e297EluFlwIwooviN9kbaPx4YDUqzToKVNU9lm/w/puYId2ImWPWMWyuv84/+nj
	 HB4vt2Rpl+3cmV7/eVNR6IyyVinx7VxTd5FIwczIzbK74Cf8uzVet2wb7mS9fOucUK
	 4j5EEkMkpq3yW8gi25EnS+A2AbOOo02vTL+OMajpOUi1pWGiAOFY9GKDKQyErZiFa1
	 jJ65HAKVlcB0L4fJ0zUxVS6CSGjHEAPCxNT71wpkuO6eQIT/z66wQ+fgViwy3/xHVH
	 tureFUMwqP02g==
Message-ID: <sashiko-outbox-191874@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KEYS: Reject restricted dest_keyring in
 construct_alloc_key()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261031092820.497238-1-jarkko@kernel.org>
References: <20261031092820.497238-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 09:34:33 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> construct_alloc_key() links keys into dest_keyring without checking
> restrict_link, allowing keys whose key->state reaches KEY_IS_POSITIVE to
> remain in a restricted keyring when instantiated without relinking into
> dest_keyring. Reject restricted destination keyrings with -EPERM after
> __key_link_lock() unless KEY_ALLOC_BYPASS_RESTRICTION is set.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 5ac7eace2d00 ("KEYS: Add a facility to restrict new links into a k=
eyring")
> Reported-by: Anvik Loitongbam <permissiontogallop@gmail.com>
> Closes: https://lore.kernel.org/keyrings/20261030173930.40948-1-permissio=
ntogallop@gmail.com/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031092820.4972=
38-1-jarkko@kernel.org?part=3D1

