Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642750;
	b=C9CtLyDYkvy7QUYESDAiSFV+w/dKAHmLGFSs4X63Lsf+fMCaYeVsudp0XGsXkgFFWq4y
	 KOBEdFpU6kALbqLqfwfu2yJHstPnyw8E96IHRwD+hEdyFIvpm98y5Km/TEdLz1DGROUeD
	 lBqqZVAhJym4E6Bj1gjWzUtseicQybNGPQh5JE3tSKVZgxLmQMxm89p34FqwzPKfgtV1o
	 m7c2F7HOtxV9iSsF1xUMRa20MRT73Ft89PINLJWZt6xMS+2O46eDzqq+n9CAl2zBqtK3A
	 P/stFM9WnrJVYQWU0TxlaW3utHwQOvcY0Px7HzJJNGOdi1iQiXDNkuroIbTipWDzCXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642750;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=rUM6DDgN644lwBMuVOf8hCvlUKG7RqWtFvmySpiCJP4=;
	b=Q6NcXRiSM4z8Atynk5Tl9smrm+c0X6au33o/iK+2NPeewsIhlwBiaWGBq8tKS+xzK5F3
	 11TTNzgNBQfYyya1NQ8iS4EZdEvulyTlknU0e21pvS3hAGCIBm3jFFCk6gjQo+N+zqOzK
	 4/gIh6qit+KlaA3jB9WLFHVs+m6LNjAK5ifqSPgUGPOPRnE3W2HdT0RnzDKhoK5QIqOOy
	 vvlAOwO9xcfchYo9x9zpkBnsqtvUbuLllKJeVzeAGWDZn6Hf9nvJOH93Pe8WdkuUhF5Sq
	 J6xOnA9yBiSE1pjq3/e5VPULF79Auohq0MBc9uudjm3TjQatfr54UX3oJRuyA1+ThAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csHVXRqO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3154A606A32A;
	Wed, 25 Nov 2026 21:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csHVXRqO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3346D1F000ED;
	Wed, 25 Nov 2026 21:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642749;
	bh=rUM6DDgN644lwBMuVOf8hCvlUKG7RqWtFvmySpiCJP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=csHVXRqONzw+Zf2W4mIiRNX44yIJY5CyRbFbcCR0+M/3R+GAiOMw3psRBPN1SgjKG
	 e3zbCETZaMq3pe/kSpHAtZiGstZ7Nel3amY5pdz9XV8gqjeM1AXeDT7jpyIny0bOe9
	 SuomrZaO2RHa2qG2CVi5VaWOYXyVZrW1FAihaRpWfvGCbxdLN/suOU+Wc2dERbKl8o
	 boj2OWLoGU/PW20RgzAeGTnGgWZWL7274PUZOHFuSASuVtqK5eYFytXfIwSwwoOCk0
	 g7EEMg5orzdhHYvJnZxuXFqRuBz9YUo0FhIUT/VJHPoRhMgzSPogevaDBmoXEyezPE
	 LcFWpym+IE1LQ==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 25 Nov 2026 21:37:09 +0000
Subject: [PATCH slab/for-next v2 08/14] powerpc/mm: specify
 SLAB_MAY_ACCOUNT for pgtable caches
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
Message-Id: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-8-7c680f02a734@kernel.org>
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
 Eric Dumazet <edumazet@kernel.org>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.16.0

User page tables are allocated from PGT_CACHE() with
pgtable_gfp_flags(), which adds __GFP_ACCOUNT for non-kernel mms.
Specify SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
__GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.

Path: copy_process() -> mm_init() -> pgd_alloc()
  -> kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
                      pgtable_gfp_flags(mm, GFP_KERNEL))

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 arch/powerpc/mm/init-common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 745097554bea..72dfcc559630 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -140,7 +140,8 @@ void pgtable_cache_add(unsigned int shift)
 	align = max_t(unsigned long, align, minalign);
 	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
 	if (name)
-		new = kmem_cache_create(name, table_size, align, 0, ctor(shift));
+		new = kmem_cache_create(name, table_size, align,
+					SLAB_MAY_ACCOUNT, ctor(shift));
 	if (!new)
 		panic("Could not allocate pgtable cache for order %d", shift);
 

-- 
2.54.0

