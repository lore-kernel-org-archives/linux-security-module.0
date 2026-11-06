Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794008603;
	b=Ngw1O0qcodzEI5sKO9NXX8QB1xgHoCAxumKPNYMUNPgWDmg5j+mhfppAU8o3VWlVPRCb
	 UuMY6KLl2UxfhJyUIq5LRReMu0VjpUd2LCzYNLfNzKQxiu9SgaWpC3YG7ItTLZT/7tD9k
	 9l+R1SqJ94/BRmWlmNkPYmC1swT7e3QTXRUi2D7dDAI0qj4AKALtG1jB5kLl7MQxJ96Ja
	 kVDROzF3nRQZUCk1q97BpqCayBRXR+FciMe3mH4JYrYv0J9QxxAcDg/Jhs2YSvn3dfl0U
	 RhZKcsduWwl/xJCFI0wEMV9bQqdyZS74mdoI4tY1lTZNv99JuFhpwUAAAW118OzcIfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794008603;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9Uc9ujiAJcEN2LTqEw0E1qXlp9Q1RJ8VZbRCmeOuBn0=;
	b=SNDCZ5ov47Hc69UqFuyV6kSr3kK+GCgrTMH2UHvJGCSGsOMnhW6XjvcXc8gION9gNajx
	 Tb802kSIJs23QkGpahorQMDX5Nnt8f/4mXm1/Jh/hj/08XIPvyTjEgJcscHfp+UPcdGnB
	 FLyk0nL9FUJY01Nh+oRBIuUlTCNRVAMD77aS7B8t4jworYhdycUIc8PTavj2vfXbV1d9g
	 YrEAB7zKO6GI2cJxaZ7pC7aTikRuODbnBoZylDmZ1BQEN2IBQIH5f5Hw+dyUvk/snD61f
	 dh2nJCryChtobbCs0nihy56JpEJoC7tjazdx9l476ZHZyeG0sMsdP67l9KT2ZW2L4vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QdAWfGxx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F119606A32E;
	Fri,  6 Nov 2026 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QdAWfGxx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9764E1F0089F;
	Fri,  6 Nov 2026 23:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794008602;
	bh=9Uc9ujiAJcEN2LTqEw0E1qXlp9Q1RJ8VZbRCmeOuBn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QdAWfGxxKAMlGtEOD8rKz64Eq8It75VoWtmqflYlsi7jbnI8bZWLwEM0LW0YbonXo
	 pjmpPTrz4eBxoa2yMRi0h16GStB8uCLp7AvmgEilvKFQLYszE0Gdl5ukKXNrsMNS2d
	 VEj6WbZhOYz7EozZqOv+1w3VUUuttxS1ouS9cwCGVhERKXf4OmzUpv54ASkZRx8M8H
	 r4nu9UfpKsrid/jwHCLkkFiFWVpnneVOrT9S8MX/55BkhI9VARuPO7tx68FES3Ugef
	 FBI6M97R3e6UIxKXQPq+9zH03yEyvur/goXzx5SDavxxbxG+MzQ1AJwRy0bg48tEp7
	 MIBE/z9fgE6CQ==
From: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	netdev@vger.kernel.org
Subject: [PATCH net 1/2] ipv4: unshare headers before recompiling IP options in ipv4_send_dest_unreach()
Date: Sat,  7 Nov 2026 00:43:12 +0100
Message-ID: <20261106234313.2537882-2-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106234313.2537882-1-edumazet@kernel.org>
References: <20261106234313.2537882-1-edumazet@kernel.org>
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
with clones (for example TC-mirred copies), and pskb_network_may_pull()
does not unshare an already linear IPv4 header.

Concurrent link-failure processing of such clones can therefore change
an option pointer after it has been checked. For example, a Record Route
pointer can advance during fib_compute_spec_dst() (called from
spec_dst_fill()), causing the following write to overwrite the next
option's length. __ip_options_echo() then trusts that length when
building the ICMP reply, which can overflow both the stack reply-option
buffer and the cork-option allocation.

Make the header private before recompiling options, as ip_rcv_options()
already does. If the copy fails, do not send the ICMP error.

Fixes: ed0de45a1008 ("ipv4: recompile ip options in ipv4_link_failure")
Reported-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
The issue was found by an AI code review agent. It was not reproduced,
and the fix was only build-tested.

 net/ipv4/route.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3a90c8d28b940bf615c165d9b30ac634943586e1..4d8fcc95c2f460585437b1f6fea4e4fd11d3a2f6 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1269,7 +1269,8 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
 
 	memset(&parm, 0, sizeof(parm));
 	if (ip_hdr(skb)->ihl > 5) {
-		if (!pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4))
+		if (!pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4) ||
+		    skb_unclone(skb, GFP_ATOMIC))
 			return;
 		parm.opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
 
-- 
2.53.0

