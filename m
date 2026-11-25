Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642697;
	b=pNaKPzpE5m8GJJixr4Vp2DmDuRD54jx8V+WBkhF7zXK8mUNCR8HVlf0F7StVWH+n9E/M
	 bdFxNYtQKGAwY4E0diVMk+gtuBqn8SUd0foVR48hugMkos9HEd8R+xkyFR1IWDoHHhJfK
	 nB50zkC1jcJOvJA+nlrzqm/qft0QCcG+46WweCofzVcUqp51GuVS+dW5ztwK+dkslwcXe
	 RLyuf4ewEKPWWjbqjOaOdn8PHuF0BnwlEBl5sOeAw7Ow9cvj7zsJgx6fAo4LZh7cDvwEQ
	 XZEpV0RKegsi+7UMa1k6CZxuv118aG32zKJ0JS2xBSbkMfKHkNP24JSp0+U22yVWeGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642697;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=UM83AueIbriLogzPnL1gmpRK12x4S9EwiEfofGFCsLc=;
	b=d79IH88R5UEfmNuADeB1nKNHKn4707WUDLe/xsSCznRQCZH0Qjo9KYLpj0E4UJOWP/RJ
	 c/LdzR8tt0FxuBXz+3LGu2t2yOm0bnYrIl9dy8X5Rf0N7PPjbEbBHT7RkpBqNhc87w7YU
	 HC8+36gQ3MGMDSzpyK3xZuYW2C2XngaBwimF2kyqk98Ke1/PMV438OFSp9cRGFOH5teW2
	 sZX6HHok5/pMww6qtvqd5I0bGtBS3EKoSZMfKzjVBGq2dq44x5sSUI25zyPaPeRwJuJB4
	 9F+ONfRUmzOqV7jVdN4MXmDveILn3f8/NlhK6zHtNE8frytxgQx63wDmO+UTFn4NLwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiLOw1bW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42719606A321;
	Wed, 25 Nov 2026 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiLOw1bW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C554C1F000C0;
	Wed, 25 Nov 2026 21:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642696;
	bh=UM83AueIbriLogzPnL1gmpRK12x4S9EwiEfofGFCsLc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JiLOw1bWEd30G9oXaQN32F+Pb9icWosyt3uKYE9QF1k9PLNJs6k+4lqPu/MWNgtOR
	 FfkQur3a0vwok67T4oRXGB1inbNNGPmOYmWf9Xm2xkmTxlgSXmvN4PO4kiaEZq9gIN
	 Chg24jcYoI1pM/FLPmfYzc9KsVkJXvQ4L1BiNLoSZ5nxwCeh9GQiFdqglA7ZG2W6rS
	 auRTp9xQZcqXsY3t5duaIHrH/9BhBmCmV0itVkr1IgQf5hqV7TyMkvcJcTq4J9DpUX
	 bv/sxzcCjqt8JaMwn5uS5uenbF/A7ALKTGMHugjMW/UcMcJzMf78ZxlA+41dpV6yyh
	 5BK4ZTylBEFLw==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 25 Nov 2026 21:37:04 +0000
Subject: [PATCH slab/for-next v2 03/14] lib/xarray: specify
 SLAB_MAY_ACCOUNT for radix_tree_node cache
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-3-7c680f02a734@kernel.org>
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
 Eric Dumazet <edumazet@kernel.org>
X-Mailer: b4 0.16.0

XArrays with XA_FLAGS_ACCOUNT (e.g. the page cache) allocate nodes with
__GFP_ACCOUNT, and xarray/IDR callers can also pass GFP_KERNEL_ACCOUNT
directly. Specify SLAB_MAY_ACCOUNT when the object may be charged to a
memcg. __GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.

Path: __filemap_add_folio() (i_pages has XA_FLAGS_ACCOUNT)
  -> xas_store() -> xas_alloc() (gfp |= __GFP_ACCOUNT)
  -> kmem_cache_alloc_lru(radix_tree_node_cachep)

Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 lib/radix-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 976b9bd02a1b..2c7531deb0df 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1600,7 +1600,7 @@ void __init radix_tree_init(void)
 	BUILD_BUG_ON(XA_CHUNK_SIZE > 255);
 	radix_tree_node_cachep = kmem_cache_create("radix_tree_node",
 			sizeof(struct radix_tree_node), 0,
-			SLAB_PANIC | SLAB_RECLAIM_ACCOUNT,
+			SLAB_PANIC | SLAB_RECLAIM_ACCOUNT | SLAB_MAY_ACCOUNT,
 			radix_tree_node_ctor);
 	ret = cpuhp_setup_state_nocalls(CPUHP_RADIX_DEAD, "lib/radix:dead",
 					NULL, radix_tree_cpu_dead);

-- 
2.54.0

