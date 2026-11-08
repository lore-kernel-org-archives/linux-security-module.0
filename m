Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096738;
	b=Hq1gzXNcyPla5Hg8ffQPRUO/ueDe20yYal2qOko6io3S+dTyNPABwCVuZrW5Lfk+lIw8
	 aI75jKAVN65qEmhKm/wFbvHuyXdd3rGvU8ji+6ZlWV9OwdPKXJSZ111aLtt77XGVBLn5h
	 0yKsqd+/O922C3zVL62oevdYJehRA3Yqe+LfKzSvhrR2cHV4o4e6oWp4NVkXW0LT4FN1/
	 aY9ZCTDKzpVy9FZ2Ojh3jMlADbdCT2xJ0HtbVtu0AR+uqz50l3ly867YHIhE0o2ZRmv2i
	 jiUmp7+8cwQ2TFKXu2MERtYe6auittNhLGQURTfQXTeegQNOT0OfgT9czEXCbc+WQtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096738;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WT8wm2a9NQoatQNQVc83RmAaqZCdnlsqxrOAjSePHHA=;
	b=eke32GgvLTocVLHEoL3UrpNR8XNzOo/Uii92kS00tWellhzYQoqWqj9tkR4He5nN+Jvf
	 09ZYzapZHzMXlfDPjG5gnaLbTW3Ot38ScZ7gYXLzlUvwymbeuwHcIQphOzWa44utNl/Az
	 hSKsWirRtSQ///R+5Bwy0x/e+w2XxCzMKahiGzI/0cRsdVv8dPWipHKqMjeB7DYTXbeb+
	 kOGIi7AzrD8ppWt5hptAr0hDkELYvcjefTLsQVXydhypd/FD12PbFFnlAoeq4YSdf7qqO
	 WdbpN1QXob0MRXCfkWV68ROMw0vxaaEaONcm+81+r9hzb0E5pdrUVvtQ6bAcxG4mdsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbrbWu6+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972A5606A326;
	Sun,  8 Nov 2026 00:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbrbWu6+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9FB1F0089F;
	Sun,  8 Nov 2026 00:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794096738;
	bh=WT8wm2a9NQoatQNQVc83RmAaqZCdnlsqxrOAjSePHHA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AbrbWu6+5V95/Fdm4zeoHFsRFKalD9iDryE2p6LFwSp5ivwYTG6mLLE849eTx+WAJ
	 Jnic/mRoRgOT6XE3lzu9DwVZhyNdHIoj8hESMEAxwkknYKVPTwy7aJ7CdF3fsMm4F3
	 SdOYxKq8w15E4ISLTM0n9hxgHlcz/wXdQmvBIS6HYwa5UPjOWpWjTIJEr+1YqLuUIH
	 +9gqVl4a/hR7nt59KFAi+kD0nGsggDBWteexko8Tn2kRpn/HSZW2NrWAG35DgBDfbH
	 SId+Ez1+rY1m2kulhy6rOyncaST7IBSQZJ0yLKsCI5qorfMEf1OyMC3JsIIg6LF3kO
	 gjlwAT0wZlZyg==
Subject: Re: [PATCH net 1/2] ipv4: unshare headers before recompiling IP
 options in ipv4_send_dest_unreach()
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, paul@paul-moore.com,
 linux-security-module@vger.kernel.org, kylebot@openai.com,
 netdev@vger.kernel.org
Date: Sun, 08 Nov 2026 00:12:17 +0000
Message-ID: <179409673700.994134.1614691544438367987@kernel.org>
In-Reply-To: <20261106234313.2537882-2-edumazet@kernel.org>
References: <20261106234313.2537882-2-edumazet@kernel.org>
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

- [High] This patch adds skb_unclone(skb, GFP_ATOMIC) to
  ipv4_send_dest_unreach() (net/ipv4/route.c:1272-1274).

--

ipv4: unshare headers before recompiling IP options in ipv4_send_dest_unreach()

The patch makes the IPv4 header private with skb_unclone() before
__ip_options_compile() rewrites Record Route and Timestamp options in
place in ipv4_send_dest_unreach(). The goal is to stop concurrent
link-failure processing of clones from changing an option pointer after
it has been checked. If the copy fails, no ICMP error is sent.

> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 3a90c8d28b940..4d8fcc95c2f46 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -1269,7 +1269,8 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
>  
>  	memset(&parm, 0, sizeof(parm));
>  	if (ip_hdr(skb)->ihl > 5) {
> -		if (!pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4))
> +		if (!pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4) ||
> +		    skb_unclone(skb, GFP_ATOMIC))

[Severity: High]
Can this skb_unclone() leave stale header pointers in callers of
dst_link_failure()?

ipv4_send_dest_unreach() runs as the ipv4 dst_ops->link_failure
callback. Before this patch, a header that was already linear was never
reallocated on this path, because pskb_network_may_pull() returns early.
Now, when the skb is cloned and has options (ihl > 5),
pskb_expand_head() swaps skb->head and calls skb_release_data() on the
old head, which drops this skb's reference.

ip_tunnel_xmit() in net/ipv4/ip_tunnel.c saves a raw pointer into the
head before calling dst_link_failure(), and does not reload it
afterwards:

ip_tunnel_xmit() {
    ...
	inner_iph = (const struct iphdr *)skb_inner_network_header(skb);
    ...
			WRITE_ONCE(tunnel->err_count, err_count - 1);

			dst_link_failure(skb);
    ...
	tos = ip_tunnel_ecn_encap(tos, inner_iph, skb);
	ttl = tnl_params->ttl;
	if (ttl == 0) {
		if (payload_protocol == htons(ETH_P_IP))
			ttl = inner_iph->ttl;
    ...
}

For header_ops GRE devices, ipgre_xmit() in net/ipv4/ip_gre.c also
points tnl_params into the head:

	tnl_params = (const struct iphdr *)skb->data;

The call chain is:

ip_tunnel_xmit()->dst_link_failure()->ipv4_link_failure()->
ipv4_send_dest_unreach()->skb_unclone()->pskb_expand_head()

Cloned skbs do get here. TCP transmits nohdr clones, so
skb_header_cloned() is false and skb_cow_head() in
ipgre_xmit()/gre_tap_xmit() does not unclone them, but skb_cloned() is
still true. An unprivileged user can add RR/TS options with
setsockopt(IP_OPTIONS). err_count goes up on ICMP errors from remote
hosts in ipgre_err().

After the expand, the old head stays alive only while the other clone
holder, such as the TCP rtx queue skb or a tc-mirred original, keeps its
reference. If the tunnel has a qdisc, the clone can be sent without the
socket lock, and an ACK on another CPU could free the original. That
could happen during __icmp_send(), or even inside pskb_expand_head()
between the skb_cloned() check and skb_release_data().

In that case, are the inner_iph->tos, tnl_params->ttl and inner_iph->ttl
reads use-after-free reads, with the stale bytes written into the outer
header's TOS/TTL?

Would it be safer to compile and echo the options from a private copy
rather than uncloning the caller's skb inside a link_failure callback?
Another option would be to reload inner_iph and tnl_params in
ip_tunnel_xmit() after dst_link_failure(). Either way, it seems worth
checking the other dst_link_failure() callers for the same pattern.

>  			return;
>  		parm.opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106234313.2537882-1-edumazet%40kernel.org
