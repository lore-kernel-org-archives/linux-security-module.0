Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAB523A564
	for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789852531; cv=none; b=COO2w9+cCsyElme5d3IdWBpXU/OOc6b4ajcQ01ggHTVV3MBnyK6mWbbYo8rWOin7WT5NlFi4/cij1BNqzowNBIiwQ2x6OZPWVwcpHE2BSQ+CoF7TnAntpbllRlTxmVmUn9HmVl42/e6iIR8DdPDTFHp3Or5xjS3o0ddUsDJk5l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789852531; c=relaxed/simple;
	bh=ZR8N5tjILjcWnekAU95+huCLEEnX0sJlKVEOLiA9HuA=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MZ6yEtA1ZuGGbhQ/IRh3yEkAIIqgSZjMPb4KFtt4womVyHkSNWhEUQwB84v0zU0BNPWXh9q559K6M0en76u+XycpTY7p+kzluClU3ZSc3GZ15qdeb9EOQ4Y+dBlXa1FH3Yxl8c+VSMfHKjvqNkGyOXGux5+L6uIhyghAJwuu8yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EP0GNv8k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EP0GNv8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08251F000FF
	for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 21:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789852529;
	bh=+LXZWmjGYO6rpGSUzt+K+kAprRBx7qxFckA7yUmYKj0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=EP0GNv8kcDN65FpxNx6ccbbYKEIIzC/jc360+yPuWgZYFlUbMNHr5HWYJAZdEu2P9
	 k65MVvgnoE48cLnFHKC1DqNO1cAc4xzRA7hueLd272QymozAvhLF4JqzIzpWdBSpyl
	 dRkV/8WWZIQfjYd0HExcckPQuW4PaNfZGtD6N3/Liq9rHhgPSIyJ03TNMbkyxM9s3n
	 Hrtn2OA2eE1odL2blV7vZEt7hBbMx/3N+3ez1tyOC0U6zvtbB/+n81Fd+Xiqy0NDav
	 BqZ3k/pb2jAz69XEAJ0XKFFDkAvCUNvdMjfTq2C6f5qSLXXUIeQZUc7wMczvXVby0j
	 WBGPUgYwy415A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ipv6: calipso: fix 8-bit hdrlen overflow and missing
 pskb_may_pull() in hop-by-hop options
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260919210621.3029744-1-benquike@gmail.com>
References: <20260919210621.3029744-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 21:15:29 +0000
Message-Id: <20260919211529.B08251F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Two bugs exist in the CALIPSO hop-by-hop option handling in
> net/ipv6/calipso.c:
>=20
> 1. When inserting a CALIPSO option into an existing Hop-by-Hop extension
>    header in calipso_opt_insert() or calipso_skbuff_setattr(), the
>    resulting header length `buf_len` (or `ipv6_optlen(hop) + len_delta`)
>    can exceed the maximum size representable by the 8-bit `hdrlen` field
>    (256 * 8 =3D 2048 bytes). When `buf_len > 2048`, `new->hdrlen =3D buf_=
len
>    / 8 - 1` (or `hop->hdrlen =3D ...`) truncates modulo 256, causing
>    `ipv6_optlen()` to under-report the allocated header size and
>    mismatch `opt->opt_nflen` or `skb->len`.
> 2. In calipso_skbuff_setattr(), when `ip6_hdr->nexthdr =3D=3D NEXTHDR_HOP=
`,
>    `hop` is dereferenced at `(struct ipv6_opt_hdr *)(ip6_hdr + 1)` and
>    scanned by `calipso_opt_find(hop, &start, &end)` without ensuring
>    that the Hop-by-Hop header resides in the linear data area of `skb`
>    via `pskb_may_pull()`, risking an out-of-bounds read past `skb->tail`
>    on non-linear skbs.
>=20
> Reject Hop-by-Hop headers that would exceed `8 * 256` bytes with
> `-ENOSPC`, and ensure `pskb_may_pull()` linearizes `hop` before
> inspecting it in calipso_skbuff_setattr().
>=20
> Fixes: ceba1832b1b2 ("calipso: Set the calipso socket label to match the =
secattr.")
> Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff directly=
.")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919210621.3029=
744-1-benquike@gmail.com?part=3D1

