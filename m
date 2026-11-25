Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642679;
	b=GLdkQ9ZlVpGH0lo/j8p9TBVFWxZPbpGDvt68uN+CsTB4NswCSjyawIMSFuuHWnE+doiy
	 H91EPfxPoSIFEsQeP9x7POundEZxmTsyVKaeMaUF44FND4X9vpJRHTE7RqEdmrhZdDxSI
	 9WqDOUv65/BM9caZmFoqzSvoRJ12FEHyZM0eI2w72u3JI/SeXuStEJAtXTv78UNanszJ9
	 ReQKdlDgQL8BFt5E5XKCRcj9pLKd7/00hBOZ0KsIJSXh+FFGDyLGms0fyIAmCf3AWJ6r8
	 RlMF8NImV4gde+FRjRkpVll3rRD/lD4+X5ohBrkNy/qTjfjdLQFJFvT35zQ2mAxSmLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642679;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=34DVGqhbCWdbTco/ch/K2QbRyhURvTkp3w0GHRFcugU=;
	b=MqGWH6SD8KueJ2a3tJdlCwxEt4sfqUmRM0BehA8kS0oTBT052lIQ5GC+3TG28ph7xkFV
	 VXqFaFiHE0j7euzjOKUwgnOfMT0+ElnpZiIAnVDDujJ2p8YgoYo69Z/L7cpcyfAWLJDYF
	 zd/VYsMOzOWOKd3MJb3/fIHTjNCHAdb7XS+aBG8IxVYOGEHm6JQbPXR6n3yYKxOgjaORW
	 8j7RVl4wAZ9N+7JxCGado8vOaeVh2aiovkZwTbcxqQduSoDswAjDLMJGR4ScdIQTbtL4P
	 iWrZ1cElTUGX3CALPMhM6Rm/OTarawGRAlavvFK+CMCkgEYq6s06b/dO2ialCi6/00w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GPHwmzop;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D848F606A329;
	Wed, 25 Nov 2026 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GPHwmzop
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4891F000E0;
	Wed, 25 Nov 2026 21:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642679;
	bh=34DVGqhbCWdbTco/ch/K2QbRyhURvTkp3w0GHRFcugU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GPHwmzoptOfHcsfOBCzWYlA+dXQ4FzP+DifsTdZNNeM9tO37bfo7DwJ4MrO70pC/b
	 ScxQEUwXhpTiVsTw7fDU7uq6wYjNloSj/2MgD8KG4bOHoLmpRAP5nFMtK8EJ+fSTlE
	 qFThrk26Q3EOvDwlRVat/d3MK+GdX7wHKiVOnUOExm7Gly9NHkUXz+XPiVIJ80nSIZ
	 +kUhu+yrLROZM3iXB8VWk1xWARjFk/ifzDEU+hSndCJnA3zCGjLl8H30isTqdXqwOL
	 G9pDbJ0qVNoCklp2hZ6kynKhgsF5CaXvBOVqtjn/rsh0gkEi4f+a0vtmKvUWcrAl3S
	 6gMZeK9xSU9cg==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 25 Nov 2026 21:37:02 +0000
Subject: [PATCH slab/for-next v2 01/14] mm/slab: allow passing
 SLAB_MAY_ACCOUNT to kmem_cache_create()
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
Message-Id: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-1-7c680f02a734@kernel.org>
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

Callers will specify SLAB_MAY_ACCOUNT for caches whose objects may be
allocated with __GFP_ACCOUNT. Accept the flag in SLAB_CORE_FLAGS.

SLAB_MAY_ACCOUNT prevents merging but is not part of the sysfs ID. This
was fine while all mergeable caches had the flag. Now that callers may
specify it, encode it in create_unique_id() to keep the ID unique.

Define the flag in tools/ as well to avoid breaking the userspace tests.

Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 mm/slab.h                  | 2 +-
 mm/slub.c                  | 2 ++
 tools/include/linux/slab.h | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/slab.h b/mm/slab.h
index 47a6cc8b22ff..168c394ac73f 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -484,7 +484,7 @@ void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
 			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
 			 SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS | \
 			 SLAB_NOLEAKTRACE | SLAB_RECLAIM_ACCOUNT | \
-			 SLAB_TEMPORARY | SLAB_ACCOUNT | \
+			 SLAB_TEMPORARY | SLAB_ACCOUNT | SLAB_MAY_ACCOUNT | \
 			 SLAB_NO_USER_FLAGS | SLAB_KMALLOC | SLAB_NO_MERGE)
 
 #define SLAB_DEBUG_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
diff --git a/mm/slub.c b/mm/slub.c
index 47a664427c50..3187e78e2e09 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -9833,6 +9833,8 @@ static char *create_unique_id(struct kmem_cache *s)
 		*p++ = 'a';
 	if (s->flags & SLAB_ACCOUNT)
 		*p++ = 'A';
+	if (s->flags & SLAB_MAY_ACCOUNT)
+		*p++ = 'M';
 	if (s->flags & SLAB_DEBUG_NOOP)
 		*p++ = 'N';
 	if (p != name + 1)
diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
index 2e63c2e726aa..104f962ae6f2 100644
--- a/tools/include/linux/slab.h
+++ b/tools/include/linux/slab.h
@@ -15,6 +15,7 @@ enum _slab_flag_bits {
 	_SLAB_PANIC,
 	_SLAB_TYPESAFE_BY_RCU,
 	_SLAB_ACCOUNT,
+	_SLAB_MAY_ACCOUNT,
 	_SLAB_FLAGS_LAST_BIT
 };
 
@@ -26,8 +27,10 @@ enum _slab_flag_bits {
 #define SLAB_TYPESAFE_BY_RCU	__SLAB_FLAG_BIT(_SLAB_TYPESAFE_BY_RCU)
 #ifdef CONFIG_MEMCG
 # define SLAB_ACCOUNT		__SLAB_FLAG_BIT(_SLAB_ACCOUNT)
+# define SLAB_MAY_ACCOUNT	__SLAB_FLAG_BIT(_SLAB_MAY_ACCOUNT)
 #else
 # define SLAB_ACCOUNT		__SLAB_FLAG_UNUSED
+# define SLAB_MAY_ACCOUNT	__SLAB_FLAG_UNUSED
 #endif
 
 void *kmalloc(size_t size, gfp_t gfp);

-- 
2.54.0

