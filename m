Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316668;
	b=5Djb+5bqb4yM5Meo21pRR9MOVgnRFaVMFmqicKSq+36s/IvlYJ6ONL3bcgLmPaUdXFZ4
	 EB1QBXptdde13rimdQFTP8eHK6Xpm2c41Hg1pkNr3cxm6hDyGI4RbLyQ1O7hqumwlVAXa
	 wR7/GxQrJHFxYR02FeV34bmcK7x6SYDaztjY9WedrBbKk1W2HcYUAp7SbEbZk7rFH1xNI
	 Gm5FBVPLD/0Ybl/ijrbbAqREd1ueq58IgXVCG7ZRSpUErMoqwawQFzo65qEDmJfKK8gr4
	 kOj2TxoeJzLbcqMZEt/t2T21UzYanOBQarIolQZjJq+/WdLPfocdTRF0vHq2lcrap+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316668;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=V3mypVxGDqlgDieMzPn6OXajx2jFnizo7jBFFhwBoQQ=;
	b=SlyWjkKWr422YQaJ1ww+4auhW13SDJM1l6HjwHnr18RFuckf1XtafidT7xa7agl7A1iJ
	 QA2XTa60ps6SGZzSsAzRO5wsCIxSSnKh8z4MlFoGzcBwpmU/iYrDNQWcp9qkqL6s+jfIx
	 yxGoHxvMnOQpwfy1wBZjTvwbNEDKY7xJk6W7HwreWR8XzmL8N1k4OC7siqn0cpBiyDwPf
	 GZbF+hP2l2spGgYs+oZmsMmpYn3++JKCHVkEO1iFD9HDjdN5iWTCbrLK7z2K7GEEjAEKX
	 bxIJ15oLwFgJNSZdw3Zeb9ubSU6zMPpotGNnXHvVHaupreMfYyAUgGxtMu/ckK+n7jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZbfeYcO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7913C606B2E6
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZbfeYcO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9E61F0089F
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 13:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316668;
	bh=V3mypVxGDqlgDieMzPn6OXajx2jFnizo7jBFFhwBoQQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=XZbfeYcO4RqvwOtMgZUg3wcmIMXYFJy+SO+WmDn9L2Aw+M7dPq7lQfFfW3W4XLwaq
	 FYF73XxeMv9pAGNGmZfouFScxsAeIHuRE39fvAFIxfOEjZVlokeVFSlw8wyvmj8MQk
	 SN3+JWLuSJO3L8Bf8XPDJXglR5EMIucLtLASe7nPwyJZKc0DY0bpgKSZwopKdtm5Q7
	 xDry9kk2Kgl57Opg2Qv8eqemhQE7PuZdvZZyTdTzMkTk9L+B9jvFKD3VUy0o0Wbj9f
	 HEB3k3bPZgMqtm0nAdEbb7HZTDTysEVj9VhzvQ2JQiZSwb+OtGeyQ/Nc6/cnUGqn9u
	 d/kNqbv/aawoA==
Message-ID: <sashiko-outbox-207109@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/2] ipv4: recompile IP options on a private copy
 in ipv4_send_dest_unreach()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261109131736.3060756-2-edumazet@kernel.org>
References: <20261109131736.3060756-1-edumazet@kernel.org>
 <20261109131736.3060756-2-edumazet@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 13:17:47 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] ipv4: skb->head reallocation and ihl TOCTOU in
  ipv4_send_dest_unreach()
- [High] ipv4: uninitialized headroom access after pskb_copy() when
  network_offset < 0
--

commit 5a814100bdfbbe07fb37410d0b393cb7deb2e38a
Author: Eric Dumazet <edumazet@kernel.org>

ipv4: recompile IP options on a private copy in ipv4_send_dest_unreach()

This commit uses pskb_copy() in ipv4_send_dest_unreach() so IP options are
recompiled and echoed on a private skb copy rather than modifying the
caller's skb.

> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 3a90c8d28b940..9af72cb892034 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -1256,6 +1256,7 @@ EXPORT_INDIRECT_CALLABLE(ipv4_dst_check);
> =20
>  static void ipv4_send_dest_unreach(struct sk_buff *skb)
>  {
> +	struct sk_buff *nskb =3D NULL;
>  	struct inet_skb_parm parm;
>  	struct net_device *dev;
>  	int res;
> @@ -1271,6 +1272,16 @@ static void ipv4_send_dest_unreach(struct sk_buff =
*skb)
>  	if (ip_hdr(skb)->ihl > 5) {
>  		if (!pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4))
>  			return;
> +
> +		/* __ip_options_compile() writes into the options, and
> +		 * callers of dst_link_failure() may cache pointers into
> +		 * skb->head: work on a private copy.
> +		 */
> +		nskb =3D pskb_copy(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return;
> +		skb =3D nskb;

[Severity: High]
Can calling pskb_network_may_pull() on the caller's skb before pskb_copy()
still reallocate skb->head and cause a use-after-free in callers of
dst_link_failure()?

Tunnel transmit paths such as ipip_tunnel_xmit() and ipgre_xmit() call
pskb_inet_may_pull(), which only pulls sizeof(struct iphdr) and leaves IPv4
options in nonlinear fragments.  When ip_tunnel_xmit() calls
dst_link_failure(skb) before skb_cow_head(), pskb_network_may_pull(skb,
ip_hdr(skb)->ihl * 4) pulls the option bytes via __pskb_pull_tail() ->
pskb_expand_head() on the caller's skb (and pskb_copy() itself can call
skb_orphan_frags() -> skb_unclone() on a cloned skb with zerocopy frags),
freeing the old skb->head that ip_tunnel_xmit()'s cached inner_iph and
tnl_params pointers still reference.

> +
>  		parm.opt.optlen =3D ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);

[Severity: High]
Does re-reading ip_hdr(skb)->ihl after pskb_copy() also allow a TOCTOU race
when skb->head is shared, or an uninitialized read when
skb_network_offset(skb) is negative?

If a concurrent clone modifies ip_hdr(skb)->ihl between the check on the
original skb and pskb_copy(), re-reading ip_hdr(nskb)->ihl without
re-validating it can underflow parm.opt.optlen or exceed the pulled length
in nskb, leading to out-of-bounds accesses in __ip_options_compile() and
__ip_options_echo().

Separately, when a packet is redirected (for example via act_mirred or
bpf_redirect) to an NBMA GRE device with header_ops set, ipgre_xmit() pulls
pull_len bytes before gre_build_header() pushes tun_hlen, entering
ip_tunnel_xmit() -> dst_link_failure() with a negative
skb_network_offset(skb).  pskb_network_may_pull() accepts negative network
offsets, but pskb_copy() only copies data starting at skb->data and leaves
the headroom [nskb->head .. nskb->data] uninitialized while preserving
nskb->network_header in that headroom.  ip_hdr(nskb) then points into
uninitialized heap memory, corrupting parm.opt.optlen and causing
out-of-bounds reads and writes in __ip_options_compile().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109131736.3060=
756-1-edumazet@kernel.org?part=3D1
