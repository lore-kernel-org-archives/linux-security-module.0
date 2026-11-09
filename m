Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230262;
	b=sPIsLZSB3Ul1BOk8c1o9lfXZRQCpf6oZazBd0G0R5RD3NZUOXb5kGdek8otcalc3P5Vz
	 vaO1C+jLz2BmATFxko5u2hi5n4OBsVrS6NN9pIPOln6pwfPI3YFls85MjRq3FN1sUul0i
	 kP/BL7U2H16kw2mXXVeukZ8ML2YsVK3YYDE0cBl2Na0gqjjwIrZsO81Vino5g7Rj72vK2
	 Wq4m/eV9wvLn4lN1rFTJw4hcOgJ2NMKbngjOi96/bluBeX550sPYEG1EZlyXVUoFoZil4
	 BR91rnNAb6Ib0rIYIVhncrEaZZwOvJ8SWT2WlJ9QeKbq+k1EQ/8BM+pNCzGXaYIEp7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230262;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ida3Yygzy1UUVlawgmaaIzpSHIax/rpFOE3aZbkzj/o=;
	b=Wk49XrWtCd711APM7Smm2q0BoyWHU1EgrFp87luzSrEXqvXYKBCN9mrTvJ4k4PSBo265
	 KLJfO1aJUDp/0fVewTxEyH6GSWy2jY+F1iAOI0TEeRIeygs9OhCl2+dMSsmONyd6FpMXG
	 cZ9F9IDvTCfjmBVaIz4LNqLDO/7/oyCcg88RauHWodLRqURmcIW7OCpy3utBxyQ7Zbvs7
	 2TTLoq1TX24xK+ZAm2ZfVzaBpPi3o0UeQrcynYtHok21lyWMdmzArGVUEXHWx7Bw46EXh
	 CX6HxbBXdiNJ2Azm8sqDMn2YGHZSwU555Kf+NXNyAX6NZFpMUNO+v1dZUVfv/q3flJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jz4C9B05;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37BA606A31C;
	Mon,  9 Nov 2026 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jz4C9B05
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F4F1F0089F;
	Mon,  9 Nov 2026 13:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794230261;
	bh=Ida3Yygzy1UUVlawgmaaIzpSHIax/rpFOE3aZbkzj/o=;
	h=From:To:Cc:Subject:Date;
	b=jz4C9B05hpP7qBtUm2s8DuWRulge1rhaJylcjcRBxHVUHMTOoVZDGgfHQw+2Ayyi5
	 ZqttTwST+G/2dE9F3yKOLfHlwCqA4rlaL37CSpm622ouoCFpAJCgD0/csjYzcnC+pL
	 tL+ec2cFWsXXXwBYCxdOFzNwwxIa+5K8KTPLfUImmK81mG7iUJOpKZ8FO4tU8L7+0G
	 Fu3rsu6cpBRUxbBIoOwzS5dH++yAcs4Z9G26wgjMdNYWj8Iynzbxbv6CrVyM5r+DSp
	 YffBJUqA9HKcs81T5nmDPMxlcgrtU1+vm5DSsabfvaAx1UtdhfQNbCZ0t90LbpTFio
	 O5/zUo8jmpIAA==
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
Subject: [PATCH net v2 0/2] ipv4: do not write shared IP options when sending ICMP errors
Date: Mon,  9 Nov 2026 14:17:34 +0100
Message-ID: <20261109131736.3060756-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
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
place. Two callers recompile options on an skb that can be a clone
sharing its data with other skbs, and thus write into shared packet
data:

 - ipv4_send_dest_unreach(), called from ipv4_link_failure()
 - cipso_v4_error(), called from the LSM socket receive hooks

If clones are processed concurrently, an option pointer can change
after it has been checked, corrupting the next option's length, which
__ip_options_echo() then trusts when building the ICMP reply.

Patch 1 recompiles the options on a private pskb_copy(), because
callers of dst_link_failure() keep pointers into skb->head.
Patch 2 unclones the skb, as ip_rcv_options() already does.
The two patches are independent.

The issues were reported by Kyle Zeng and found by an AI code review
agent. They were not reproduced, and the fixes were only build-tested.

v2:
 - patch 1: use pskb_copy() instead of skb_unclone(), since callers of
   dst_link_failure() such as ip_tunnel_xmit() cache pointers into
   skb->head across the call (Sashiko).
 - patch 2: no change.

v1: https://lore.kernel.org/netdev/20261106234313.2537882-1-edumazet@kernel.org/

Eric Dumazet (2):
  ipv4: recompile IP options on a private copy in
    ipv4_send_dest_unreach()
  cipso: unshare headers before recompiling IP options in
    cipso_v4_error()

 net/ipv4/cipso_ipv4.c |  3 +++
 net/ipv4/route.c      | 15 ++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)


base-commit: 1d5e2c57e9ffc134e14b3f837c8d7c53b508bd22
-- 
2.53.0

