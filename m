Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642718;
	b=5D/4atAE4m7dmojBebdYyWth56etGuPvHlz29WqmT3Lc50A66pWlscvIxTRbOtflz7QW
	 4QQywP6IOywDqdCSXxID+I++Qy6Dslk22R9g3rvDvTmQIZ5/sXS6zbnUwRXvHR+lyQT4F
	 c62OR/kFFvqOQXnJNuW3eKS1WVi0Qh+QVxOvtI6ISm2vLHlUXI0Umvw8nz1V9Gmp+b3ae
	 GbZSXUaJoZxMBTMLLooYdqWcUh7hpApeOGiLOZSzDhsB+XFDOvLT7E1xp5Hp2AUlqE4Hv
	 mntHc93gF4m7HT2eWHg4rNdxmylXOiD9vT9UzwqZKdUzG0/ae6vZAneoSzDVXzMMFvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642718;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=edFT5hb7xjn/PmmUrKwEm0LfMfvsHMsiCYhbvf3yyqA=;
	b=f8f03jyjb+onp8xmuebQoJyDXuCnD4o+I/uSHJGut+lNN2bzVBT8LTaKYAGOcu1u/u0L
	 9K+MnKdbd/jOIefGpUA4ktXtlQ0pBdGxXxR9Emgip5HE5ulHqq6JlPGemWwn4bCDcQBVL
	 CvAvvUp5MzU0quR6hX5fp03NF9GS838MfrD68MXPVJ5GZyZ+VihCEnO6LAlvqPq7MJlGu
	 KhRyIJtkLUtQptDfyN91jKDoXz1JIOf6BmaDmF9eioUQ8uUWZsbx0C9KbxPo/GiH6Lb3c
	 mdL57oc+74hEKJDrCdLdF0VRrJ1wZjtrcVH5vYhsWxrstywTSxR4CL1143pOajdCx3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=is8O74Ej;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAAE606A323;
	Wed, 25 Nov 2026 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=is8O74Ej
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBA51F000ED;
	Wed, 25 Nov 2026 21:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642718;
	bh=edFT5hb7xjn/PmmUrKwEm0LfMfvsHMsiCYhbvf3yyqA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=is8O74Ej2wtiPv4G2N+/RGjZcUAlBFILhSIqRGQMFWzYYC/Xwn74wXBmESeED+3j6
	 Z/XGPrik8sp9GNGhqXNGMXRAmdpxSdLqZFQHzcfjAGwmCR5HAhvbOvdSGdqkGYux3C
	 sF5ndMMZhwRe+4gwybrcNgdDINeb1nSlcV5iruPlkuOyOZeCHU8d1COGO8014KpiNz
	 2P83n2rVN3KX1ouEtD2fgAUrIGZdk0tik/jY66o24MXIzAQphukJU4pbEwjkUXsqYg
	 ZyhB9VIPUvTCiFm2NGLp3pKF0HsPXF+FZYV/QrRF67Rq9pbNgtNuJEeID8iGUFbuZU
	 Z9/799ssKH+3A==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 25 Nov 2026 21:37:06 +0000
Subject: [PATCH slab/for-next v2 05/14] net: skbuff: specify
 SLAB_MAY_ACCOUNT for skbuff_head_cache
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-5-7c680f02a734@kernel.org>
References: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
In-Reply-To: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, Muchun Song <muchun.song@linux.dev>, 
 Hao Ge <hao.ge@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 "Harry Yoo (Meta)" <harry@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Alice Ryhl <aliceryhl@google.com>, 
 Andrew Ballance <andrewjballance@gmail.com>, 
 Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
 Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Amir Goldstein <amir73il@gmail.com>, 
 Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 linux-security-module@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>
X-Mailer: b4 0.16.0

AF_UNIX sets sk->sk_allocation to GFP_KERNEL_ACCOUNT, so skbs can be
allocated from skbuff_head_cache with __GFP_ACCOUNT. Specify
SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
__GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.

Path: unix_dgram_sendmsg() -> sock_alloc_send_pskb(sk->sk_allocation)
  -> alloc_skb_with_frags() -> __alloc_skb()
  -> kmem_cache_alloc_node(skbuff_head_cache)

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jason Xing <kerneljasonxing@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Mina Almasry <almasrymina@google.com>
Cc: "Björn Töpel" <bjorn@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org
Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 1ac1e327ac4c..91c076f32fcb 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5313,7 +5313,7 @@ void __init skb_init(void)
 					      sizeof(struct sk_buff),
 					      0,
 					      SLAB_HWCACHE_ALIGN|SLAB_PANIC|
-						FLAG_SKB_NO_MERGE,
+						SLAB_MAY_ACCOUNT|FLAG_SKB_NO_MERGE,
 					      offsetof(struct sk_buff, cb),
 					      sizeof_field(struct sk_buff, cb),
 					      NULL);

-- 
2.54.0

