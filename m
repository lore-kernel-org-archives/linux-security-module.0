Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642806;
	b=1rRGWwIV77TRlrEwlThVMPBDF03GzX6oCEVXQX2TsO5L8ZD3fRXG8EwmbXr4Zr2QNVif
	 tB0qFNtTM3ioquGw+s27KNe79x9r+RIoYa/eh8e4dZc3fWEK5x8/apjnxU6j85KDpXzbB
	 twH0xjUXX7hdQ57Ke7rn9ssjvTBveQsDBnjWpfV4VWRU/5d1pRjjo9cwzzynDCswOt+z+
	 jtHqQVoLCpwSboEQG8vZYxMc/NR6XLPguAAR80YzGx3zmgkdm8UhETouc9j6T0INS6gkr
	 udRN7hmoOJHuOJAl7FsoSwj/8v4Lpah6LHUCQqu7GLO2DE3vdNAFMjHrjOQ0FX0iydQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642806;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=vTpYbw5ItroGz0DZO7PAjQShiM8iXjTmR55aJhYUH3g=;
	b=gW2nB0fNdtylwvmMXWsiqzPc/zL8+sNZ89LEWqlCbG8Ubh6dZIpqraxmXxwq16crZEwe
	 llHpWByolIDau1Tzr0G9zvo5t3y/VwGhPxf87XCZtyvsnk7p9drZW1raOeT8qXCg6eH7V
	 /E++J7EKruKWhZLlXlmE3TapC8VKpaVFyZ8BkfRt8+96sInOe4nglO2MW0Vy+eb8TD2zu
	 fxK0AdkvV61/IIG9V+UABSVe6mrnZVgHXnVRzJi1IzGzgkbu7qJ6nimhxixLrYT+JKMky
	 ZOeWo2Mprv4+Astws44viTbxqEFlS58H+klC8UVI2iWPEBRttd+0FU70OQ9dcjB726Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRSsjREO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E807D606A329;
	Wed, 25 Nov 2026 21:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRSsjREO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B041F000EE;
	Wed, 25 Nov 2026 21:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642805;
	bh=vTpYbw5ItroGz0DZO7PAjQShiM8iXjTmR55aJhYUH3g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GRSsjREOeODhI5QM3n2jnFfutP8TiC2UDlmMdp0c86+anFTcws9MuEdgcZWJgWP0c
	 5BHn5mQMtmswZRaAL2973a9k4bOpstS04RzDP3QBv4UvxC01O4sXMSXh52Ox23gxTq
	 VZybPONqkOJfx9yY92XNGRQpyENEFbDh6eE+IgK0Jn/cJaWaySXbOteZhO3hd2ts8L
	 XK6ADqs3lQJnK9wJgFqKSlSOKs0TDHR1RizgROWdlolXgbucx9A1WlxtnGSYcSb/Xu
	 5YAZ5xl6hAPVJPR3oCBUPgDbUmduQ8vG6K8fDxNIXc7HR7aR3mvU+/BH/TMQ5YGGed
	 ADuzLhxw7XKvA==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 25 Nov 2026 21:37:15 +0000
Subject: [PATCH slab/for-next v2 14/14] mm/slab: do not set
 SLAB_MAY_ACCOUNT for all caches
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
Message-Id: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-14-7c680f02a734@kernel.org>
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

Now that all caches whose objects may be allocated with __GFP_ACCOUNT
specify SLAB_MAY_ACCOUNT (or SLAB_ACCOUNT, which implies it), stop
assuming any cache may be used with __GFP_ACCOUNT. This avoids wasting
the objcg slot in slabobj_ext for caches that are never charged to a
memcg.

Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 include/linux/slab.h | 16 +++++++++++++---
 mm/slab_common.c     |  8 +++-----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index ad645967a3ee..8525e70eaa76 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -201,14 +201,24 @@ enum _slab_flag_bits {
 /**
  * define SLAB_ACCOUNT - Account allocations to memcg.
  *
- * All object allocations from this cache will be memcg accounted, regardless of
- * __GFP_ACCOUNT being or not being passed to individual allocations.
+ * All object allocations from this cache will be memcg accounted.
+ * SLAB_ACCOUNT implies SLAB_MAY_ACCOUNT.
  */
 #ifdef CONFIG_MEMCG
 # define SLAB_ACCOUNT		__SLAB_FLAG_BIT(_SLAB_ACCOUNT)
-# define SLAB_MAY_ACCOUNT	__SLAB_FLAG_BIT(_SLAB_MAY_ACCOUNT)
 #else
 # define SLAB_ACCOUNT		__SLAB_FLAG_UNUSED
+#endif
+
+/**
+ * define SLAB_MAY_ACCOUNT
+ *
+ * Objects will be memcg accounted when __GFP_ACCOUNT flag is specified.
+ * Requesting __GFP_ACCOUNT allocations without SLAB_MAY_ACCOUNT is not allowed.
+ */
+#ifdef CONFIG_MEMCG
+# define SLAB_MAY_ACCOUNT	__SLAB_FLAG_BIT(_SLAB_MAY_ACCOUNT)
+#else
 # define SLAB_MAY_ACCOUNT	__SLAB_FLAG_UNUSED
 #endif
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 193b5a03bc47..464695504248 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -367,12 +367,10 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 		goto out_unlock;
 	}
 
-	/*
-	 * For now we assume any cache can be used with __GFP_ACCOUNT and thus
-	 * may need to store objcg pointers for objects
-	 */
-	if (!mem_cgroup_kmem_disabled())
+	if (flags & SLAB_ACCOUNT)
 		flags |= SLAB_MAY_ACCOUNT;
+	if (mem_cgroup_kmem_disabled())
+		flags &= ~SLAB_MAY_ACCOUNT;
 
 	/* Fail closed on bad usersize of useroffset values. */
 	if (!IS_ENABLED(CONFIG_HARDENED_USERCOPY) ||

-- 
2.54.0

