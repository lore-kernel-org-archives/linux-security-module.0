Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642731;
	b=mTJMJCtlH8VZyKtouwV/HVG0u+7fbCJSiEJxEbiQhwdOX7XT3CLC6z9/F2QId9UiFg6I
	 XxbYLLQl1LNePka4B1oSlApkUbuUNjqul9PDbj71iw9n7jJYVjDODCB8ZTBt3LYcoepzU
	 vto/5JAv355c82LY9t/RLLpsFUXBcXSCMcwCpoAX0ou3W+eZp45s6e1N4jDsbtKBDjaL1
	 +AY7HDsA2JBopMuq5N4miGZzDzNgq41iPr84RSLFAYMcYtQrC9yZfHCCn3otqZJ1Zi0r/
	 nY3cMPedzx8i8P9RC9Zi0FOKvxeR+pRi2aH0dy6XQppTChPaKxVfgRnbMHB6jv3c6NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642731;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=ByO1Pw16aQvedrcgFe2HrJirDf0exfH7Ey8rwMSwazA=;
	b=fsUfGHvJuxCUqFbH5q6PkVp1xujQVmqCFvYFBvOG1KXeMzDFaB0R51IzIW4nKsfvgwAG
	 HuYH8vlc/o+eESFs0meRuRfxhlFYryNZe787feh2r4jh1/hF7+FTUc5n4C1ctMbsz+7GJ
	 JIiNHgXb9L3IIDQmK6YJqseHr+KmEQfoK2llKjt4dWB5kO5xGhor729Cz7/fKxFRNXvVw
	 J1zGLQPfW55jZJvtpTZKkM5WbxAgWOQR6JWh99sb356vvd3MSD8RYMqJEk7yRnf8gPptz
	 acJT2z/6FuRrGuvimSHTHuVU9/aJl66viPJfVRqeVMW7KDQhs15mYc8gV6JPYGe5Rrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FlU8mmj0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6ED606A323;
	Wed, 25 Nov 2026 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FlU8mmj0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D1B1F000CF;
	Wed, 25 Nov 2026 21:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642731;
	bh=ByO1Pw16aQvedrcgFe2HrJirDf0exfH7Ey8rwMSwazA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FlU8mmj063INtxbA61Kmn9BCIjFoO2qoXtDLU02uGNjLyL7N+54YBlL8RxKhJklsT
	 BaS06QObcBGTEGrKXHSLbHlxAwxRtqpgfCQ8ih92lrA3bC4Y3zryTSCJoyPP3/1LBf
	 fR4uoV8HaWN9R+DzUryOg0VSZpL5HeP/sQ9cfHHqxnRl/DRse1iSz1p5WNs3oIdpEG
	 g14ZTdv+6oB3XCmo45jN594zRelczIARhGk8sC1n9OtRH8UrfBRQpHOBsWHvBJoK4E
	 xdG4ua9i9jsaTVyQbyLRmyr9L9S4ZWlDlCsWopErNsBDYVQizk39Jc8fRKsh5IIvNI
	 c0EmSdoTtMFgw==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 25 Nov 2026 21:37:07 +0000
Subject: [PATCH slab/for-next v2 06/14] kernel/fork: specify
 SLAB_MAY_ACCOUNT for thread_stack cache
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
Message-Id: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-6-7c680f02a734@kernel.org>
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
 Eric Dumazet <edumazet@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>
X-Mailer: b4 0.16.0

When THREAD_SIZE < PAGE_SIZE, thread stacks are allocated from a slab
cache with THREADINFO_GFP, which includes __GFP_ACCOUNT. Specify
SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
__GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.

Path (e.g. ppc64le, 64K pages, !VMAP_STACK): copy_process()
  -> dup_task_struct() -> alloc_thread_stack_node()
  -> kmem_cache_alloc_node(thread_stack_cache, THREADINFO_GFP)

Cc: Kees Cook <kees@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 kernel/fork.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 5efceb8d58a7..d0e49a81e7cf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -459,7 +459,8 @@ static void free_thread_stack(struct task_struct *tsk)
 void thread_stack_cache_init(void)
 {
 	thread_stack_cache = kmem_cache_create_usercopy("thread_stack",
-					THREAD_SIZE, THREAD_SIZE, 0, 0,
+					THREAD_SIZE, THREAD_SIZE,
+					SLAB_MAY_ACCOUNT, 0,
 					THREAD_SIZE, NULL);
 	BUG_ON(thread_stack_cache == NULL);
 }

-- 
2.54.0

