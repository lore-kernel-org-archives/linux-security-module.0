Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0DF3C872B
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405934; cv=none; b=tcYjGP9hKS7WOU+KAskABDfJMvDux6KMw79dz2sUpBvJHShD3qMhdptEcf28bgQHL3Thl+Uv5Y0G8R6hnuSZasblZO3k/gmsKT80jgTrGjOYkwenJh5aV8ZhbnGg1ZuWeWstKAw/3CcB1B+kNI/1SpNH8Qo7TiW9yLBwIEVDXh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405934; c=relaxed/simple;
	bh=XklnFHmbHQS7VZkDuG150iHCHuym7kKaiF9qMmPfxWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijjtJN9BfWnDjnbdXsQ3IIuPujox3cjWwu8d/If9UOrV1hdJY/UN4DF8mfGdIKXSxTFYZs8uHKvHqWu88+atuqGIdSHe4xdjh69DZMqROQnoiPV4GXwvZrY1ytta6Gb15ezeM1Rjwukc6yJNhA8eziEQs7ocZgou2MCiqHzHqaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGDn3ug8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGDn3ug8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AB21F00899
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791405933;
	bh=vH1JfG3bndKx8TMAH3C7J9XtsPB7MG47a4kraAsYAVA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SGDn3ug8Ut0TqoATGFX6VVPqLPozQOAOEtm1SFimcttB2+db5sxEUbAo2zQmFXREW
	 U+ArjwD5yt7tVJdeTFk8haRWsPZh4CDfRwnYlFm4jQ/NPEzizFK1ylZppRcO02k1zt
	 GgdboDvL+mXpNQksyJNkVu1hUtPJyGiNJFGUyfODolz/zIhpawuTOpkjANksLESxPX
	 pwAP9+B/6gi5LlHxeU9dXGQ/IUOfoofBBqfz5t4wmj0EzPlleebel/NTebsuKkA+TH
	 dyHER3vJFzom+r6OpfOV/2Jyj79L85KNi8LvPWSktViRY/yN5MMDmSrkOYu0TLIuTk
	 zOZcu8jBlaCTQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-48e94879f02so897398fac.0
        for <linux-security-module@vger.kernel.org>; Wed, 07 Oct 2026 13:45:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw3XDvvZqHApK3gN3vD7ExKQgFva3S+frtIb19G1aoRLLmRgewof/Hcs5IhtfqnWBzr3rPzkQXYPBFT3j/8s9fbHfgPors=@vger.kernel.org
X-Gm-Message-State: AFuF++mi92uXmjCn6ygYiB9KD2qmbO51GSIa5GziK8Tnsgw2T+5kE2Zw
	sx1uhd+KyTr3Jpf7JMeHPQfEo50HbAbjZ3+QCjSNOdZ9zQeVuJ1gcNWAAPXFKwt9ePWjnizbqDW
	jjc3nBtjb1zHnZG78aWT3bFjUFvplKTE=
X-Received: by 2002:a05:6870:891d:b0:48f:e0f6:c45e with SMTP id
 586e51a60fabf-4a2596a2130mr3260410fac.44.1791405932610; Wed, 07 Oct 2026
 13:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179138670045.80227.16292613517250896744@gmail.com>
In-Reply-To: <179138670045.80227.16292613517250896744@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 7 Oct 2026 22:45:21 +0200
X-Gmail-Original-Message-ID: <CAL4WiirbJrQThGS4BUo=a=AV9ckJk2AyedO8AgJgozjHOwu5Vw@mail.gmail.com>
X-Gm-Features: AclHuK_2K5aXaZQQbDLyAem3QMNCwXVR5Lav3TazV6a0LVSPtYk80Kv8XKrwBkg
Message-ID: <CAL4WiirbJrQThGS4BUo=a=AV9ckJk2AyedO8AgJgozjHOwu5Vw@mail.gmail.com>
Subject: Re: [PATCH net] calipso: update payload_len when removing the CALIPSO option
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Alice Mikityanska <alice.kernel@fastmail.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 7 oct. 2026 =C3=A0 17:26, Joas Antonio dos Santos
<joasantonio108@gmail.com> a =C3=A9crit :
>
> calipso_skbuff_delattr() removes the CALIPSO option from the hop-by-hop
> extension header, or the whole extension header if CALIPSO is its only
> option, and pulls the skb by the removed length.  It never updates
> ipv6hdr->payload_len, so after a successful removal the header still
> claims the original length.
>
> calipso_skbuff_setattr() already adjusts payload_len by the length it
> adds; the delete path was missed.
>
> This is reached on the forward path when a packet carrying CALIPSO is
> sent to a destination mapped to an unlabeled NetLabel domain.  The
> forwarded packet then has a payload_len larger than its real payload
> by the removed length (8 to 264 bytes), and the receiver drops it as
> truncated.
>
> Adjust payload_len after the header is moved.
>
> Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff directly=
.")
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> Assisted-by: Claude:claude-opus-5-5
> ---
> Found by code review.  Compile-tested only (arm64, W=3D1); not runtime-te=
sted.

The analysis looks right to me, but this means removing the label on
the forward path has been broken since 2016 for every packet that is
not resegmented later (SYN, UDP, ICMPv6...).

For a patch targeting net and stable, we would really like to see it
exercised at least once. Please run a forwarding setup with an
unlabeled destination (the NetLabel tests in selinux-testsuite could
be a starting point) and describe what you tested in the changelog.

>
>  net/ipv6/calipso.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
> index c6a34334e..c072eca50 100644
> --- a/net/ipv6/calipso.c
> +++ b/net/ipv6/calipso.c
> @@ -1428,6 +1428,9 @@ static int calipso_skbuff_delattr(struct sk_buff *s=
kb)
>                 skb_pull(skb, delta);
>                 memmove((char *)ip6_hdr + delta, ip6_hdr, size);
>                 skb_reset_network_header(skb);
> +               ip6_hdr =3D ipv6_hdr(skb);
> +               ip6_hdr->payload_len =3D
> +                       htons(ntohs(ip6_hdr->payload_len) - delta);

This is not correct for BIG TCP.

GRO can aggregate TCP packets carrying identical extension headers,
and ipv6_gro_complete() uses ipv6_set_payload_len(), which stores 0
when the packet is bigger than IPV6_MAXPLEN.

For such a forwarded packet, the above would write
htons(65536 - delta), and ipv6_payload_len() would no longer fall
back to skb->len. nf_tables, conntrack and sch_cake rely on it.

Something like this instead:

ip6_hdr =3D ipv6_hdr(skb);
/* BIG TCP packets have payload_len =3D=3D 0 */
if (ip6_hdr->payload_len)
be16_add_cpu(&ip6_hdr->payload_len, -delta);

calipso_skbuff_setattr() has the same issue with its
htons(payload + len_delta), this can be addressed in a separate patch.

Thanks.
