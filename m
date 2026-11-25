Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642705;
	b=X9LlK5e2hgp1u8xQA0jhNS/nDichO9mrOi4YIlin3Obfipv6kI3PwsXuUjMgtcPBxR4+
	 hM01cY6LsyjgMBtgS6QvC1RRBFapBYLpXChT6hz7WQU4xLLSYl62tQ65+UUNN2rNkJn6u
	 QPg9KYr1TxN+7i5fALSRRBTVMnMnjs9HciSROLMWwd3ImnxAgT1bvgfj9mtpmysI5wwv8
	 5JbmCEA3Hy+tZMgpu7BYO2Vy9Iri8g4whLArufN2lRPXO/u+Knvcoybo3QkdgLdhouCh7
	 S/NWXwS4U4eJ6cdG3z9VNWxfkCPTX1Z6zJSqOYxSpevMxdJ+jJw7sH/DwPwiJdtx7Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642705;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=VtvhyDNbnaCNct3RDhNs8SkFhauT52QXx/BClCdBvMA=;
	b=i7mHVutZNQMVdAanaCFkYc7FRdQzoulCcoJoyEeJNJfnZKahJT34jfeJtAu8UDRFD0w8
	 QMz+EMesUOdiBP1URRQhrAPnr7YHXHu6HpsxZOhRxHs6Y0cF01RkfNnNSPg9bJmzPQ286
	 dgPBqGfEYmPuETPQyHrHOrB/Fs/ekNHXsqPN9NeRj0F026GBHCd0I5Q63SwBKRWWUDMjO
	 e+y6+o706u4+dBTlp2vzuGVxMH9o8aZBY3p4M3pjlOEi6MEmK88Z1tb0TMMeEF7y7FD8z
	 cshJ361+GqpHOAXpxl9Ea/6twuWXRxGCT1QLqoXJPShsdOfx2edR6VGoBDBr/ljb4Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6q2xfHr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8243606A32C;
	Wed, 25 Nov 2026 21:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6q2xfHr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494501F000EB;
	Wed, 25 Nov 2026 21:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642705;
	bh=VtvhyDNbnaCNct3RDhNs8SkFhauT52QXx/BClCdBvMA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=n6q2xfHrGBuWnpZqpTh6pf2C0390tzgmRh7DKN1gnFHk0AQmX84qzkWsTtMlQMrLc
	 svRe4uDwGMbaCc0ORb/4eYjHPaJEXt9+0CG6S2sgrj5zO56NZLESt0E0WsTBLPZgHg
	 4szD6xpfXlB7VdAqk4n58y0Mn+XQGISbxcsm0peXnjcedc1s6oscnD5cELpIM2+Bas
	 GV6nHvljwiC3FXB6b7KnWmnzSlZJrtH9ICY4rkDePq6A3dru3yjm3Ps7sz3UPn5Eae
	 qqotYuMecl6pP17UXUrJsGdR+LchYf2VnQkKlBD029/iN7zPzhq2DOWgAKvKRY2xN7
	 WahdfDmjlIiSA==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 25 Nov 2026 21:37:05 +0000
Subject: [PATCH slab/for-next v2 04/14] fs/buffer: specify SLAB_MAY_ACCOUNT
 for buffer_head cache
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
Message-Id: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-4-7c680f02a734@kernel.org>
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

Buffer heads are allocated with __GFP_ACCOUNT to charge them to the
memcg of the folio they are attached to. Specify SLAB_MAY_ACCOUNT when
the object may be charged to a memcg. __GFP_ACCOUNT without
SLAB_MAY_ACCOUNT will not be allowed.

Path: ext4_getblk() -> folio_alloc_buffers(GFP_NOFS | __GFP_ACCOUNT)
  -> alloc_buffer_head() -> kmem_cache_zalloc(bh_cachep)

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index f951559e7d32..4c24f4546106 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3006,7 +3006,7 @@ void __init buffer_init(void)
 	int ret;
 
 	bh_cachep = KMEM_CACHE(buffer_head,
-				SLAB_RECLAIM_ACCOUNT|SLAB_PANIC);
+				SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_MAY_ACCOUNT);
 	/*
 	 * Limit the bh occupancy to 10% of ZONE_NORMAL
 	 */

-- 
2.54.0

