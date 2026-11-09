Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230265;
	b=5FpBCp2RUukwFIAgd/0jLNYbz0/XKos3IAWSmhahG/LcmGmNOlRVgaj57C1TYqapEX1c
	 7baAI2chkWC6T5RP3UTHWR6Q5DYIrfY4EZfiLmg20XoD1CAtwWs93v5p0pcWcbhqnNNyU
	 a6k+PPVt5C74jjkZCkYe7o3HK9MI0o09yQB8dP0TmzUsk5eGL7MVjpBz6ERCEouNH8yCo
	 7Ej+tvbD1cv09XuOPHzrtqlpch7kHXdirS0n+k47vYLHVSucxIa4IMgF0vd+LPADJ1JeZ
	 x02y5ykaJ1ISgIjeE3Clnh4rlCeRKsv8k+b/rEO26KVm3kiH61J9T3p5XcEDr+zlsbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230265;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wmSKA0NVMNFLjGl+O7ashCzG730qVs4KBuS1dZB2o1Y=;
	b=InSPbZ8y/Sn0F062bA65XfaDS3tcxD9rvY+b4KQNa/3NEf3RgY04jCVOia0+cP8+LImd
	 BQdhcI7miwKd9Z9gVyfw/YAbgWpOrqyZ3Q35tONxsjA5vA3jsh+VRb0vyLiU1m4okd33D
	 cTfoFpF/DZoBmb3ZWDQzt2mPz44q+YWk4PJgxcL4dKktVON8Q1AU+z04ympJmu8SoMkSX
	 sXTWZ0t79rLfkQCqjRQvMFiTNv4lPKJ5GeR1s7vjTD1qhSKewRKiI6xBs5KlwvDl209W9
	 yKfWBtFyh1fiXyXYs8LU7bBfGihHPTJ+yrMH5E0QHcY1LlYpwhXHroAKqPQGLQKjrtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a2Ulgqs7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA1F606A325;
	Mon,  9 Nov 2026 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a2Ulgqs7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83C21F0089F;
	Mon,  9 Nov 2026 13:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794230265;
	bh=wmSKA0NVMNFLjGl+O7ashCzG730qVs4KBuS1dZB2o1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a2Ulgqs7zf06D8PuIMyDCuX6l8nysWf52xbXNoKuuFvT5b2fYeMv8QzQTZ8ME21XK
	 iNc6obiBk+XN71Snf16EIzJfIhOTT+qhwvQevNhEMl6L1cJIiOhknrmKIYqla5UwIp
	 hHBKj8sj+OUqZlhZ/b+4M0td2Eu7Szr5oQnQ3806z1wXzfLL802V+VxzQQk31auZYD
	 NnGtnJPmwqSYEE8/tLODbmrQ9Rb8leloURbQprsfp3eSSvhLKmQiWGLp+ncW4N90F8
	 1bLshwF1gjJRLY6YfJOYb7EnR6pXr4oQcbBbTenBURJ5LKBs975LxG0ECtj6Wswobo
	 Al7Ay0EnnmRSQ==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH net v2 1/2] ipv4: recompile IP options on a private copy in ipv4_send_dest_unreach()
Date: Mon,  9 Nov 2026 14:17:35 +0100
Message-ID: <20261109131736.3060756-2-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109131736.3060756-1-edumazet@kernel.org>
References: <20261109131736.3060756-1-edumazet@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__ip_options_compile() updates Record Route and Timestamp options in
place. ipv4_send_dest_unreach() can receive skbs whose data is shared
with clones (for example TC-mirred copies or TCP transmit clones), and
pskb_network_may_pull() does not unshare an already linear IPv4 header.

Concurrent link-failure processing of such clones can therefore change
an option pointer after it has been checked. For example, a Record Route
pointer can advance during fib_compute_spec_dst() (called from
spec_dst_fill()), causing the following write to overwrite the next
option's length. __ip_options_echo() then trusts that length when
building the ICMP reply, which can overflow both the stack reply-option
buffer and the cork-option allocation.

Uncloning the skb is not an option: ipv4_send_dest_unreach() runs as
the dst_link_failure() callback, and callers such as ip_tunnel_xmit()
keep pointers into skb->head (inner_iph, and tnl_params for GRE devices
with header_ops) across the call.

Instead, recompile and echo the options on a private pskb_copy(),
leaving the caller's skb untouched. This also stops rewriting the
options of a packet the caller may still transmit. If the copy fails,
do not send the ICMP error.

The issue was found by an AI code review agent. It was not reproduced,
and the fix was only build-tested.

Fixes: ed0de45a1008 ("ipv4: recompile ip options in ipv4_link_failure")
Reported-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
v2: use a private pskb_copy() instead of skb_unclone(), callers of
    dst_link_failure() cache pointers into skb->head (Sashiko).
v1: https://lore.kernel.org/netdev/20261106234313.2537882-1-edumazet@kernel.org/

 net/ipv4/route.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3a90c8d28b940bf615c165d9b30ac634943586e1..9af72cb892034deff2bb3169911c02c025d73cf2 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1256,6 +1256,7 @@ EXPORT_INDIRECT_CALLABLE(ipv4_dst_check);
 
 static void ipv4_send_dest_unreach(struct sk_buff *skb)
 {
+	struct sk_buff *nskb = NULL;
 	struct inet_skb_parm parm;
 	struct net_device *dev;
 	int res;
@@ -1271,6 +1272,16 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
 	if (ip_hdr(skb)->ihl > 5) {
 		if (!pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4))
 			return;
+
+		/* __ip_options_compile() writes into the options, and
+		 * callers of dst_link_failure() may cache pointers into
+		 * skb->head: work on a private copy.
+		 */
+		nskb = pskb_copy(skb, GFP_ATOMIC);
+		if (!nskb)
+			return;
+		skb = nskb;
+
 		parm.opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
 
 		rcu_read_lock();
@@ -1279,9 +1290,11 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
 		rcu_read_unlock();
 
 		if (res)
-			return;
+			goto out;
 	}
 	__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0, &parm);
+out:
+	consume_skb(nskb);
 }
 
 static void ipv4_link_failure(struct sk_buff *skb)
-- 
2.53.0

