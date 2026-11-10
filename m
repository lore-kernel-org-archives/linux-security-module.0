Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319498;
	b=QCbe780i19kX33TSntXDEuNnLR+C/uPNcVy805hTyxZOK1WwNamObvVJ3Z9YvEKJArOA
	 MzzsVsNpyEbclI4kCj2BBi4HUU9+okBmDyrt06ryC9vIpsyog4nV2MyrayB6fCClaLNUH
	 xZonaWf6F6O45u4JErZxDGfeiKJv657nqdmMtV8Kn+RNiBKfLPW4fg4F0N1/TUVI/2BiY
	 nPooAFwptmleXtUf8lAc9qd6mWfmEunTW5sFdP1wbSg1xgR299un/hQJDbmIlSEKuGPop
	 xj1pfHiCS9j753rHig6O8ed6tToMcm7NGy7B1iGPnwm6G0A8ZnKHZP3SddYHYr5rFXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319498;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=NevmellycncZFpNqSdh/Sp54vKBHYeC16JYSEBiLB0Q=;
	b=4wn2whTXi0YavMO99yWZZUmEiIhli4p5IA1cc0oBfT3+QoylxG9K81FtxNYGQs6q8h4A
	 CxfIhHClLvhojO3Co4HhndKrHPQEaW1bK/W0YA3glaElmIctyp9z5yZyL+G4OYTSBnpqB
	 SHi9ergPwxkHaa3iwfV/XwNvBQbgKeFGWB08AG2i4Dgi+drOnH6VjOxQWmYXJejIDY4gn
	 ZcS2qH6v5t7F/HUrCj6MX6cI7EUYz8pB1ip1oSKAfd7ChdViI2ZpOF9OSfz97BoiqbhzY
	 1KUgRRKqvRPR2XKYfwCi8Ctlu3BofMKkqvd+hiBu0XY3pYXaKmPszqwzqQMGspj8FMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNF6+vsk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D90606A321;
	Tue, 10 Nov 2026 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNF6+vsk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6471F0089F;
	Tue, 10 Nov 2026 14:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319497;
	bh=NevmellycncZFpNqSdh/Sp54vKBHYeC16JYSEBiLB0Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SNF6+vskI3iIBNOgKtei62xkqPzjollaqRSPcZktvfN/LVQeSW8KBB2UKJ4vmagb+
	 MKk45uhvm0CeMnuIpAb3mepyjYdqm6Ndm2p9TZgN11bGeMgHqSEn/G9q5ewav29tM6
	 fX345Tj+xRuJGwBRcL6m8CpPj0zd4pH28z9PW//7BmyMc8zkRBKorQ6uDvIC/mStiJ
	 0+EZ0mshOLuodNZVhnOJIRXfUXAd0fBoYAny8AkFkdde1uxxrtibA8cGafEXTRSTu0
	 HiGlOxBJYFM4RkyxSDmRuz2CADRePlXJKbKoFPNrMnj3cKD+gV2SRKrx+k+UeeGnSf
	 IRnYQ7LuTwAjQ==
Subject: Re: [PATCH net v2 1/2] ipv4: recompile IP options on a private copy
 in ipv4_send_dest_unreach()
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 paul@paul-moore.com, linux-security-module@vger.kernel.org,
 kylebot@openai.com
Date: Tue, 10 Nov 2026 14:04:56 +0000
Message-ID: <179431949623.994134.10376655995833239221@kernel.org>
In-Reply-To: <20261109131736.3060756-2-edumazet@kernel.org>
References: <20261109131736.3060756-2-edumazet@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ipv4_send_dest_unreach() (net/ipv4/route.c) now re-reads the
  IPv4 header from the private copy (nskb = pskb_copy(skb, GFP_ATOMIC))…

--

ipv4: recompile IP options on a private copy in ipv4_send_dest_unreach()

This patch changes ipv4_send_dest_unreach() so that it recompiles and
echoes the IP options on a private pskb_copy() instead of the caller's
skb. __ip_options_compile() rewrites RR/TS options in place, and the skb
may share data with clones. If the copy fails, no ICMP error is sent.

> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 3a90c8d28b940..9af72cb892034 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c

[ ... ]

> @@ -1271,6 +1272,16 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
>  	if (ip_hdr(skb)->ihl > 5) {
>  		if (!pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4))
>  			return;
> +
> +		/* __ip_options_compile() writes into the options, and
> +		 * callers of dst_link_failure() may cache pointers into
> +		 * skb->head: work on a private copy.
> +		 */
> +		nskb = pskb_copy(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return;
> +		skb = nskb;
> +
>  		parm.opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);

[Severity: High]
What happens here if skb_network_offset(skb) is negative when we get
here?

__pskb_copy_fclone() reserves the headroom but copies only the linear
data that starts at skb->data:

net/core/skbuff.c:__pskb_copy_fclone() {
    ...
	skb_reserve(n, headroom);
	skb_put(n, skb_headlen(skb));
	skb_copy_from_linear_data(skb, n->data, n->len);
    ...
	skb_copy_header(n, skb);
}

skb_copy_header() keeps network_header at the same offset from head. If
the network header sits before skb->data, ip_hdr(nskb) points into
headroom that was never initialized.

The earlier checks don't catch this. pskb_network_may_pull() is
pskb_may_pull(skb, skb_network_offset(skb) + len), and that passes with
an offset of -20. The version and ihl checks ran on the original skb and
are not repeated on the copy.

One way to get a negative offset looks like this. A tc mirred (or
bpf_redirect) egress redirect of a routed IPv4 packet goes to an
NBMA/multicast ipgre device that has header_ops. That device is
ARPHRD_IPGRE, so tcf_mirred_to_dev() hands it over with data at the
network header and keeps the IPv4 dst:

tcf_mirred_to_dev()
  ipgre_xmit()             /* header_ops branch: skb_pull(hlen + 20) */
    __gre_xmit()           /* gre_build_header() pushes tun_hlen */
      ip_tunnel_xmit()     /* err_count > 0 */
        dst_link_failure()
          ipv4_link_failure()
            ipv4_send_dest_unreach()   /* skb_network_offset() == -20 */

Before this patch, the function read real header bytes from the original
skb's headroom. Now parm.opt.optlen is computed from uninitialized
memory. optlen is an unsigned char, so ihl < 5 wraps to 236..252.

Can __ip_options_compile(..., nskb, NULL) then parse and write past
nskb's tail? The writes include the IPOPT_END zero fill and the RR/TS
pointer and address writes. They could reach skb_shared_info (nr_frags,
frags[], frag_list), which pskb_copy() filled with references to the
original skb's frags.

__icmp_send() would also use the garbage saddr/daddr/tos/frag_off/
protocol. icmp_glue_bits() copies from skb_network_offset(nskb), so
uninitialized headroom bytes could go out in the ICMP payload.

Would it make sense to bail out when skb_network_offset(skb) < 0, use a
copy that includes the headroom, or copy only the IP header and options
into a private buffer?

>  
>  		rcu_read_lock();

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109131736.3060756-1-edumazet%40kernel.org
