Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642688;
	b=kCnPzx0x0SdEHgkc8m1Mtg00n7ONZDx4d+P8WWSS/VkxBy8uGH0Gde6yciYk7nQjEurx
	 Xlijt+0jcBvIfAKKhg1LY1sRrhKessuDF6Rysp3y+2ZfHOEo/mp472yA5EbO+dufsdZv7
	 bFRoNl5vTOMJK7Drn0g79mgTMRmhn+lfe7oye/ZaqC0xuxBNIXxjrYw+Hlr8eZEYT+AYF
	 YXmPjUZqIW0oZ1dicxGxbnZN7WxM8elaWleQ8fs34zXlRP1sPcMdsvwyYLicBCOA0JZxw
	 BUSJJ1bnNdS58UC2/sXaMkyfok2eqK2cNEL+IdqFuZqE+2wv0+olL/5IZKFRxt8cWdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642688;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=xCsoMM2SYli9GoRF0mLPGTdzPc1rzk/bVTpp4cBDCP4=;
	b=s7Zc5r7E4ZKW3/KDIGttdOGxQ+jHbEy33FAfstxsA8CT0VuGHj9nZWFzutGsrysFTnw/
	 QtWZGPtjnnbt5ioIwGHY1wVb6vU0WWdXJ2r41/IZRCTFCsQ+ZWn5HBNTI6qM5Yz3KZmHp
	 IJtVMVAPNMxqVyjBiNNwqr7v+0PJ+/O99v/18rLiR3e+1FkV6wlj8OklarPaSMsdk9fCn
	 HeY5vrmEKVxSy9pQ+FWsNP6gqSQNdId9EIuCxwLdmRAMEi2I7Pj2sFBFjC1zjmC9GKKSx
	 7XiB8hNX30v3FYAYfy7VHj0kIyEUL5Beg1jlLY4pOPmIzGzgvrStzFvmwzfYK/v3HUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bgub/jGu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A917E606A31E;
	Wed, 25 Nov 2026 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bgub/jGu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDB31F00A01;
	Wed, 25 Nov 2026 21:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642688;
	bh=xCsoMM2SYli9GoRF0mLPGTdzPc1rzk/bVTpp4cBDCP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bgub/jGuSEEzlxOWoTN7Ri1uIOUtEnJPzRZ7jyIAu/Ja9fIAdurhc8RTtdT1s+Cu8
	 rKWwPTC3yFW1CmOupwJi1qUMhA1LnLYi94769K29JPagk7GVbdXviTD2ZD5NZyLVbu
	 hrJXLTjlWhzAH9rUFY5yKCQ7OPf5lglAy/d7JRIBKJjUXCIK9CQGFNwpXFAa4crnjE
	 P3+WDFuxzA2FpXgHO/xwdjxoY+/ViEg6k6KF/4l4z70Bt0yFXuheeXEo5KwewFCs3S
	 YzL7SGRJglCp8vhbDDPAxIVK/YBg+YuEbDqUfSU4CtgnuZ+Koj59Y3kZGjZbISaO+N
	 2cbb3QvteIhvg==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 25 Nov 2026 21:37:03 +0000
Subject: [PATCH slab/for-next v2 02/14] lib/maple_tree: specify
 SLAB_MAY_ACCOUNT for maple_node cache
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
Message-Id: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-2-7c680f02a734@kernel.org>
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
 Eric Dumazet <edumazet@kernel.org>, maple-tree@lists.infradead.org
X-Mailer: b4 0.16.0

Maple tree users can pass accounted gfp flags down to node allocations
(e.g. arm64 KVM's smccc_filter uses GFP_KERNEL_ACCOUNT). Specify
SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
__GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.

Path: mtree_insert_range(GFP_KERNEL_ACCOUNT) -> mas_nomem()
  -> mas_alloc_nodes() -> kmem_cache_alloc(maple_node_cache)

Cc: "Liam R. Howlett" <liam@infradead.org>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Ballance <andrewjballance@gmail.com>
Cc: maple-tree@lists.infradead.org
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index f7f51f1b40d9..5ff176f1a021 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5815,7 +5815,7 @@ void __init maple_tree_init(void)
 
 	maple_node_cache = kmem_cache_create("maple_node",
 			sizeof(struct maple_node), &args,
-			SLAB_PANIC);
+			SLAB_PANIC | SLAB_MAY_ACCOUNT);
 }
 
 /**

-- 
2.54.0

