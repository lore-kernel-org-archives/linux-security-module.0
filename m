Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230269;
	b=5ktCL/m6M19uSTox44gErVfLJwTW23LNKe+nbzLlufmZzWBUxDL9RwnV5qO1DFKDmuCl
	 1MGbEmWGWhFrUYt1ONwm15IVdbuo2SQBM4VzZqkvexH8Y46aHEbAkSYAp1uyWDSUSPN32
	 U7aZ/E4PDvn8wlfQsaugY2pP6ABjb/PvNOev/eheajT+uFNhobtY+NASrcf17BqKoeKxC
	 CvD23u6lvJvgWYzzbDswhx8x29N3xMVOTE5kepMEY50+UqpUNQMLfXa5YQLH2zyUv/soi
	 LQGU65qTvLpjrm2A8oQWPiNhv1uqKyk1GF1qaxfW0lBMx4L6cIFaqQto4Hl8/QV4gUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230269;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L30ylyi7mcSbO4q1PzcorbnCHicUdcb120q9e+UTDeA=;
	b=1RtfTd4lridFqKjpdHzyT8xjnFLJN/80b1oOJheZlWP5i4LHN0/MI4FkO9zw5krdX9El
	 +geRrSWN+SV66EhH6OtCtIdDckou0J1Bvg+8HayqXAinkJVJFVWAuG4SdTTjOLHuAwNDf
	 4Jfg/VJSHKuNEO2yZiFLkAd5rTKQMJPQrqLXnhy5PiPU1ccZZE+o4DvASzuKd834gX+V8
	 F/4s3rwqtrHt+Rolm//GAEUXCNRNrlMx3/d5ANiR33GmCvrc6DJdqGTbCqS45WXhOCRfi
	 V5ksz8T/jfxZYD8LDNILfvpCufhqGXabIyyEw8XhqlYrLcqcjsz+q9imhiuJCFU/EPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmONt9zn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013BA606A31C;
	Mon,  9 Nov 2026 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmONt9zn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDE41F0089F;
	Mon,  9 Nov 2026 13:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794230268;
	bh=L30ylyi7mcSbO4q1PzcorbnCHicUdcb120q9e+UTDeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DmONt9znjtDiZc2ocniAOT2x05E7BFrIowImhqr+WG0CHuGFUjWF+Jr4KFjsMFvMy
	 pJGErvFmtX5tl8lIJ96Gt93hdV0SAml86HAcd7nxKGXwUgCA55ovYnBq+648BPnB2p
	 bXj8m3LjtM0edmhh/GerPVfV/yXUdoECeXlptowTYSUpZjrVEYgABQ6jYAPhqktsd7
	 8yGNBrkRmHmiCHVi9B4sNL7h3qu491rqnPKpi6+2+XoAAMrX51xaOjDDyGzrjW9Qjs
	 nYOVHgj3bKRdvRHrwCD6SmP2/RlDzE4RvlG6pP6a+bjls8yrivho0spaR92RBVxyPQ
	 v8sj9wqezug6w==
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
Subject: [PATCH net v2 2/2] cipso: unshare headers before recompiling IP options in cipso_v4_error()
Date: Mon,  9 Nov 2026 14:17:36 +0100
Message-ID: <20261109131736.3060756-3-edumazet@kernel.org>
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

cipso_v4_error() recompiles the IP options of the offending packet with
__ip_options_compile() before echoing them in an ICMP error.
__ip_options_compile() updates Record Route and Timestamp options in
place.

cipso_v4_error() is called from the LSM socket receive hooks through
netlbl_skbuff_err(). ip_rcv_options() unshared the IPv4 header earlier,
but at socket delivery time the skb can again be a clone sharing its
data with other skbs, such as the per-socket clones made for raw sockets
or multicast/broadcast delivery. Writing to the options then modifies
packet data seen by the other users of the buffer, and a concurrent
recompilation would hit the same check-then-write race as the one fixed
in ipv4_send_dest_unreach().

Make the header private before recompiling options, as ip_rcv_options()
already does. If the copy fails, do not send the ICMP error.

The issue was found by an AI code review agent. It was not reproduced,
and the fix was only build-tested.

Fixes: 3da1ed7ac398 ("net: avoid use IPCB in cipso_v4_error")
Reported-by: Kyle Zeng <kylebot@openai.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
v2: no change.
v1: https://lore.kernel.org/netdev/20261106234313.2537882-1-edumazet@kernel.org/

 net/ipv4/cipso_ipv4.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index e65a3f29d2caf31c34cc5aaaf862257d7d374275..f5f6a812ab9ef05117e002779baf136e615c043d 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1725,6 +1725,9 @@ void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
 	 * so we can not use icmp_send and IPCB here.
 	 */
 
+	if (skb_unclone(skb, GFP_ATOMIC))
+		return;
+
 	memset(&parm, 0, sizeof(parm));
 	parm.opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
 	rcu_read_lock();
-- 
2.53.0

