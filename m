Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874664A43F6
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791559729; cv=none; b=TkcRtyI3ivbB59ZacQSe7llc3rftI1OrVaSf1PlyosjQNMZLJKrHWwAMAPr+kINzZJkaZcaijJG+DHydXqM7lvHk6O1mONmJ3z/zTK18+A19hs288oGHojgGmk12kJF/1r9AKJWRPbssouS+wVd094p8Mm99CIc/VX3bxJHKHJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791559729; c=relaxed/simple;
	bh=4byVmK+/JjopfgmUa6FCwZZb52Fneemu8rz7At1b6wI=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NHCZomPfUGn5vE8ReiTGlrbLKpj/sxsECnKA3suvtptQBxMz4yoT3HeGcgCRAthU9gU38bP8z1HkB2PmEBeGYkhSJh5GbQd+dQh5OwzZc6EqAUSDcwMzwva6K9UhUwX2flvk4FV+/v8hAavZLMdLTcqGMlwb0aKRwCD5cskZEOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/83dkBN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/83dkBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A0F1F000FF
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 15:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791559728;
	bh=OArrU4NpjNESoQgNWEbJj1s2nxAeAiup7D9EFvBZvuY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=j/83dkBNlf87bXJZpQ63sp8At4ElfnhQM6LTA/hHTd4zsySZnFyMUy20wLYgLGIzK
	 rYbXg3v6EKmVgMfSExpoMooqTb5n7sLyXGAEObfIEoBJoK12ETawIa9FYLnWZf6Ir+
	 t1EhJLtWK9z0GpD4m+PyBPm3EzomD4yHKyjFgWeqIi7xzi/O2niqM5zB88SE+a3NRp
	 sm0gmEXwXejJC5oM50AnmEeN6lP8Uy0P3kKbSJvs3AXjJGLmB/eP44668O9dlwa9iB
	 EZIm7mt5wzrz0g/1QxN2ONSswUd72Fht2xYIheS9OA2FdnSP8hycBxaNvNn7S8b9Gu
	 Gc1XEb9OTqxwQ==
Message-ID: <sashiko-outbox-165775@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] calipso: keep BIG TCP payload_len in
 calipso_skbuff_setattr()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <179147330473.58090.15760316487710432833@gmail.com>
References: <179147330473.58090.15760316487710432833@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 15:28:47 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] calipso: skips payload_len update for non-GSO empty packets
--

commit 453f949afc807f64bbb4a0d488ed6f38254f5d88
Author: Joas Antonio dos Santos <joasantonio108@gmail.com>

calipso: keep BIG TCP payload_len in calipso_skbuff_setattr()

This commit prevents calipso_skbuff_setattr() from modifying payload_len
for BIG TCP packets, which natively use a payload_len of 0. It avoids
overwriting the 0 value when adjusting the length for CALIPSO options,
ensuring that ipv6_payload_len() falls back to skb->len properly.

> diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
> index c6a34334e657e..dfea7ed65afc4 100644
> --- a/net/ipv6/calipso.c
> +++ b/net/ipv6/calipso.c
[ ... ]
> @@ -1357,8 +1357,9 @@ static int calipso_skbuff_setattr(struct sk_buff *s=
kb,
>  			sizeof(*ip6_hdr) + start);
>  		skb_reset_network_header(skb);
>  		ip6_hdr =3D ipv6_hdr(skb);
> -		payload =3D ntohs(ip6_hdr->payload_len);
> -		ip6_hdr->payload_len =3D htons(payload + len_delta);
> +		/* BIG TCP packets have payload_len =3D=3D 0 */
> +		if (ip6_hdr->payload_len)
> +			be16_add_cpu(&ip6_hdr->payload_len, len_delta);

[Severity: Medium]
Does this conditional skip updating payload_len for non-GSO empty IPv6
packets when adding CALIPSO options?

If a user application sends a 0-byte payload using an IPv6 raw socket
(e.g., IPPROTO_NONE), and a SELinux NetLabel policy applies CALIPSO to the
socket, the NF_INET_LOCAL_OUT hook triggers calipso_skbuff_setattr().

The function will insert the CALIPSO option but leave payload_len as 0.

This results in a packet being transmitted with an IPv6 payload_len of 0
but without a Jumbo Payload option, which RFC 8200 compliant receivers
will discard as malformed.

On a Linux host, this causes ip6_rcv_core() to skip trimming the SKB,
mistakenly passing L2 padding up to the receiving application as payload
data.

>  	}
> =20
>  	hop =3D (struct ipv6_opt_hdr *)(ip6_hdr + 1);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179147330473.58090.=
15760316487710432833@gmail.com?part=3D1
