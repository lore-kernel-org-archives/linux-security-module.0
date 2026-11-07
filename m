Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794095019;
	b=qh9+EwSyx1uJg8UcDqCUQ4zSU4HWjuP9krLYo688vAduRmhtTsKcCZudSxFXIxa0ehF6
	 e1Fwucs4du4srU3vSnO0v1VMeW6z5MBtg3m3ovhUuWQ4gppH2VNEBUF+WM7kXUE0GqzJd
	 LHVFXt0UeIhG7tZRYPQliReRdT+iRH54/5NzDFFRMCNtTo17R0btCNXZ63HUNrcyMVIHw
	 zU8HryfkpPdc+FuDxGeEZHrBCAjr4ljBK089Eca+yvY3gBGJuIDNwPs7yAAcCGq8Rds06
	 ZF07jov7EOyDOKA4IfEQxKPs5jStap8SArnmEdbjEaaak3opTeJY95Oy6IxbOMASo0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794095019;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ShbdDo5reBovOAwCstZCHnAiUGS3u7Fdx9b5pHLHmlQ=;
	b=KgVLQfVt6iG04kkqH5EIjJ4+dtelzezChtBFZxME7rDN2KQEElxJydnxYDOq+LVe/KED
	 BGYGf65QHSmzMAzMomCs9R4m/9rIJvH1wFU55HWoipZyARsn/Ly6x6c7wP631FCpbxkyd
	 ABEBwQHSHBRV07XMvQwBXHTK+v3+Gw4OiwxNKNFAHH35dwVNEZEcEmFPW/MkNMPaxBm2H
	 MaSIMtoj67fEOu7AiUC/c82fdvx+OZwSExrgXtru9S/ii0O6cDGHq8z71Y1dopYhuEe26
	 Harqx60+FPenLLbzT1gcqGUDemmQs5Nfzul5eeL0BkYuf1VoKFeziLPwu9Q/R0KbwCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RHd/xxOS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A785D606A333
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 23:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHd/xxOS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003F71F0089F
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 23:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794095018;
	bh=ShbdDo5reBovOAwCstZCHnAiUGS3u7Fdx9b5pHLHmlQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=RHd/xxOS0epgRMeSB7SzGWIRGham2CoVb6Q0dBj0cepVNihzKFdwhEiffzfYlRcvJ
	 VsqAs3FbwBZVd1aHrWlFDrzQPqjew8zNF5OAzebExyQxLEdmXQuwKZe1WIc4w/nFft
	 ZY6CbMftRej3HinFZGIL6w1EghvXtaf7NUO3U/WfBnF+qUT+BrR8uC71vvsJpY+cvd
	 5NWWF+LtigSaW2ajfuV010/3jXlBFrjHRjIX+lUxWY3xTYFE6/xdrkAr3Rkw2Oeu6/
	 97soxmHuELTktrBu0CrY6mw8ayApA4Tpf85bGuTvJ4JfWrB5mdsIf5naWwtY5zUTb5
	 kiIIptKPg7TNQ==
Message-ID: <sashiko-outbox-203398@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] ipv4: unshare headers before recompiling IP
 options in ipv4_send_dest_unreach()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261106234313.2537882-2-edumazet@kernel.org>
References: <20261106234313.2537882-1-edumazet@kernel.org>
 <20261106234313.2537882-2-edumazet@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 23:43:37 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] ipv4: dangling header pointers in ip_tunnel_xmit() after
  skb_unclone()
--

commit b978ee14726a511c1195a618445671504ee53c90
Author: Eric Dumazet <edumazet@kernel.org>

ipv4: unshare headers before recompiling IP options in ipv4_send_dest_unrea=
ch()

This commit calls skb_unclone() in ipv4_send_dest_unreach() before
recompiling IPv4 options so that in-place option updates do not race on
shared packet headers.

> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 3a90c8d28b940..4d8fcc95c2f46 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -1269,7 +1269,8 @@ static void ipv4_send_dest_unreach(struct sk_buff *=
skb)
> =20
>  	memset(&parm, 0, sizeof(parm));
>  	if (ip_hdr(skb)->ihl > 5) {
> -		if (!pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4))
> +		if (!pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4) ||
> +		    skb_unclone(skb, GFP_ATOMIC))
>  			return;
>  		parm.opt.optlen =3D ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);

[Severity: High]
Can calling skb_unclone() here leave dangling header pointers in callers of
dst_link_failure()?

ip_tunnel_xmit() caches inner_iph into skb->head before calling
dst_link_failure() -> ipv4_link_failure() -> ipv4_send_dest_unreach(), and
only calls skb_cow_head() afterwards:

net/ipv4/ip_tunnel.c:ip_tunnel_xmit() {
	inner_iph =3D (const struct iphdr *)skb_inner_network_header(skb);
	...
			dst_link_failure(skb);
		} else {
			WRITE_ONCE(tunnel->err_count, 0);
		}
	}

	tos =3D ip_tunnel_ecn_encap(tos, inner_iph, skb);
	ttl =3D tnl_params->ttl;
	if (ttl =3D=3D 0) {
		if (payload_protocol =3D=3D htons(ETH_P_IP))
			ttl =3D inner_iph->ttl;
}

When a cloned linear skb with IPv4 options (such as a TCP packet or a
TC-mirred clone transmitted over IPIP, SIT, or NBMA GRE while
tunnel->err_count > 0) hits dst_link_failure(), skb_unclone() reallocates
skb->head via pskb_expand_head() and drops the reference to the old buffer.
After dst_link_failure() returns, ip_tunnel_xmit() dereferences the stale
inner_iph (and tnl_params from ipgre_xmit()), causing a use-after-free read
if the other clone was freed.  A similar pattern exists in
ipip6_tunnel_xmit() with iph6 when skb_unclone() clears skb_cloned(skb) and
causes the skb_realloc_headroom() branch to be skipped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106234313.2537=
882-1-edumazet@kernel.org?part=3D1
