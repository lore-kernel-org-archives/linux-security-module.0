Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794008606;
	b=VVAPGJRdjGnUcliGAycRx3T8dFX7sZDc82xOCrV/HtjGq0KNRbIh/8U+ZX010bgbks3D
	 GAkqvrKLJCIz55YSNf62Pe99z90lulXHqrT4VuwSKEsWoSXn4LYOaHAMLCk0y47XbAJOV
	 qMqQjrohwWhbk1zQuVk/StegIgu7NXDDeyuaSvLCnpGAI8MhnJy6N6euEgvbPSVezDBvx
	 yrCRKh3I5Jxq9gjybx06hDMq9WYVv1I0aXPaELSasmzTyzkOE8UlrOccwoKps0BYVolsZ
	 hCkMmVqkeQEElAE84W0KO8/RpIdV+zKaDFxiJRkBkXAXd2WscOlY8t0AaK4QWPQD5PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794008606;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QVYCLJ6CEJWYYPlOW6sPkRq4yF+frQ+0NRtoT4sY5ug=;
	b=I/aUL3nnI12xupeAvFBCEt5Y1VmMYJf27II92pWZdi1Q3Tk9TWh0UP8OllpJiNwlgSCL
	 ms5URpPLCOVFZCYYgnsEzh2dhDSlfFvtIEPN2nMjqbMEgONQpDF9eKaoMVlG2cw3rMp8Y
	 5LGFNOkiwlU7s9h+x9q2H7QEby1ciGQqEZhMYagWuKOYMZL66HzD7pL9JSw3RNKPMy5Zq
	 o9sPSX1XW6IjO84Dvpx3tGjJmt4q4viVtYdvBTfKGwJM2gUXFsEE3w9gql7z7idUZoEh5
	 2uw5+f1jIR02qRUmq4BOal4ChoLJixMH2BFC/qf2pYkBmN+j+TGl0FJR+N4SIravfkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSNRz9cJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937AE606A326;
	Fri,  6 Nov 2026 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSNRz9cJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCCF1F0089F;
	Fri,  6 Nov 2026 23:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794008606;
	bh=QVYCLJ6CEJWYYPlOW6sPkRq4yF+frQ+0NRtoT4sY5ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hSNRz9cJ7j+EipLujJzjC6F3dpPPhfWG4o0ncn2h5iS+umqahFXaiDXKU8fgH1hKu
	 Ptv5g2/+nww/hbtA/MkKTN/mUmDjBt3CX4cGNVIwleRKflhBjqciwtTf8xTn+3QHhu
	 r9kmIxK6zcDtMPVLSkyDSVkc7IEMRHFOilN1jblKbrPrpnGhL4B782Vhyp8Oy2iZoD
	 3xbPxUYJO9pAI51fvdez2mCeXrC+XuwPaPdrl8ay9aSHdsKGVGfC397MgKIB3HIEJ6
	 Zg4xqKv/1SaJivO6cSNiK0m1Vvm3tbahcMLaGiNGo9KG5Ss2q/VaEzCf5+zFDB/zDp
	 dCbrD8sLvw4mw==
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
Subject: [PATCH net 2/2] cipso: unshare headers before recompiling IP options in cipso_v4_error()
Date: Sat,  7 Nov 2026 00:43:13 +0100
Message-ID: <20261106234313.2537882-3-edumazet@kernel.org>
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

Fixes: 3da1ed7ac398 ("net: avoid use IPCB in cipso_v4_error")
Reported-by: Kyle Zeng <kylebot@openai.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
The issue was found by an AI code review agent. It was not reproduced,
and the fix was only build-tested.

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

