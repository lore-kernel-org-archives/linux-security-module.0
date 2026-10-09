Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B57F4D7D29
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562411; cv=none; b=nHQYadl0CEaUUjpspgxI1oqrMMkNZUON1IRsmt0Qqf1soj0yB3bXrSbUnKwH++/GBpcEi61C7VxtA23S3cL8aFIWndLkhs13Ih8rJCbb8g7Pso2EM5uujU6TMwz2I5/jf2wyXjEXDY5Z07OjjrxxgJWp7olaWCG51GQY8HutQAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562411; c=relaxed/simple;
	bh=8UX2z8nw0cifzyGmKLowZznLvF5AT2ereh9rVLxNNI4=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GzOfOIluJR+MHLstdFNPPpnpnHq8D1vnGJILtXii4XF6x/3yrKHTR+yiAbVLLlqhJMHZchOpA21MYwqDGGC/mOOwPtg6wmw1yjMlba9NLf1m64V3ABNMSu57zzEH6xJSDTd8rzRtrRzvdaDrlwR5sHpq6JjwbSQ95TzyhsNctl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZoYHzwr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZoYHzwr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056201F0089B
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 16:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791562410;
	bh=tBSIoy1Q7ch+XfuOs+63Hx7Fo0nBia1mhxcs2+MQJPw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=AZoYHzwrrSY/ACBswLRez6irBZKOAn7CYNliJbKUl3nXSialJ5xC/VYnzay7rpG1s
	 4ZunRN5lN3B3mV6YgIrTK5HDwdF28PicBdoRRBaoJOgSHpjPZZy0Q0Wni8QCLAKV3s
	 Ezu0esmE+TXXiilnxh61cgzp/dr+rW+7cH5MV79s3sv+cyVqY8tTlb9L+t4Om+PKBu
	 VuHHcNEBi3AaDxwbjA+tyNOJY3pSxs2St/1o6JCTwvrKmdeKT2k09pFttR9hQ+voFY
	 CRLTpagqwdkill2DGMvLFPjVSvFjFaSgbMGKkQJFC6NDsnahAUp8MXMhPfTZ59j98s
	 ZBYXlKFgYcNbw==
Message-ID: <sashiko-outbox-165818@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] calipso: keep BIG TCP payload_len in
 calipso_skbuff_setattr()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <179156155963.36253.400481753322266658@gmail.com>
References: <179156155963.36253.400481753322266658@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 16:13:29 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> calipso_skbuff_setattr() adjusts payload_len by the length of the
> option it inserts or resizes:
>=20
> 	payload =3D ntohs(ip6_hdr->payload_len);
> 	ip6_hdr->payload_len =3D htons(payload + len_delta);
>=20
> GRO can build BIG TCP packets larger than IPV6_MAXPLEN, and stores
> payload_len =3D=3D 0 for them; ipv6_payload_len() then falls back to
> skb->len.  For such a packet forwarded to a destination mapped to
> CALIPSO, the code above writes len_delta (or 65536 + len_delta when
> shrinking) into payload_len, and ipv6_payload_len() no longer falls
> back to skb->len.  nf_tables, conntrack and sch_cake rely on it.
>=20
> The same arithmetic also wraps when a packet grows past IPV6_MAXPLEN,
> and a BIG TCP packet that shrinks below IPV6_MAXPLEN should get its
> [ ... ]
>=20
> Fixes: 81fbc812132c ("ipv6/gro: insert temporary HBH/jumbo header")
> Suggested-by: Eric Dumazet <edumazet@kernel.org>
> Suggested-by: Wang Zhan <wang.zhan@smartx.com>
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179156155963.36253.=
400481753322266658@gmail.com?part=3D1

