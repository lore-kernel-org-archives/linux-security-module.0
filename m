Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642787;
	b=ItNRqS1iiGyoAK1gXzTBpDUJrsJzC/IVyLpgAFqc1v7HVTPrnjgxt766bB6ufM7kRt4m
	 bfAVIyr/ZVyRhmSRZqxvjdmh4kqJR/XysK1740HqOnqzdP3EF4KA3fhpNE/ph5L7f2tH6
	 uL8LJQKhIaEG5OakNlitlQnr1lR0PnyqKCmPT/XEjyUcDs/rhUmXubd/IHg85yaqfde9p
	 dNSHMBoPwdAbkFpL88R+T8XQiDPeQTgoI0AfwkWjyVhl0gXBtzTb81PoH9YdS2D97FUZJ
	 ZBp6oPwAehqh75FyUaXVwUSMVwtHE5iKQNsUC5CXTxXkqFuI8b2f4ayl5iHKqMdbVVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642787;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=EmbHvxSdAW/q1vOhxvKGf/qq9lAABR8oLeslWOTBY9M=;
	b=SvrWT0xwh2dGanLsu0uHW5bMWbTSmcq8iDI/RSctvaP1zF6b6BiWddqUVBqn1AXxuN6/
	 7Qri1z1bpkY7XmyX3OmycJ8zQv43OpmHFZcjkIWvNKqxQheWrMrAggOQ7Y7SLXMBOKhjk
	 S3M0kDhulnUejaV01Cbc85ns7lSqwn9jdKzwszb5fuxx+bCzkIJLT1O1qLkGdLmamZbfE
	 WcawtDkFYEMWq1Q+bCfSg1QACI+nD27OGf3TuwQvTqBAw+eEaqKCwUDT3dol2VNk+BNtL
	 HXMVB1zLFgkIyjSSSN/QphpEOrEVae+Zi57lhIgRXDQh15RLRSUTF34k9h6VrD9HSeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PuifylfB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73860606A31E;
	Wed, 25 Nov 2026 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PuifylfB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F741F000C4;
	Wed, 25 Nov 2026 21:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642787;
	bh=EmbHvxSdAW/q1vOhxvKGf/qq9lAABR8oLeslWOTBY9M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PuifylfBLGxCFHUkMhv/Mi8wFziI0lMC4HyaLotkpoyRMiK/TrqZX1AG36tnHuzoq
	 1WDRGhx+pHP7Nh965qPGtyLktzTqHZnDX+4Gh6hbSSD1omJfsf6XgD4SsJGobQnmI3
	 1feZaKZDJZvZVS7LexZ5PqMQicYfd5h8t+kiTsAk+fqrXTEZwdyxXYwnoq9TKkYv9Y
	 6UoVFGwIcQjP0rlrQartx7T9JCZdrZOPwM1GlbC3TJPbh16Dk3C0rtWzKA0VySGrC0
	 ld/K3k6FWZZbjgdKZNNrbnwCNGJ2AOltLaYpYBFbkIbdiXNq+qiPT3Hv4zKdppHG6x
	 vYPnf/H0PmEVA==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 25 Nov 2026 21:37:13 +0000
Subject: [PATCH slab/for-next v2 12/14] hostfs: specify SLAB_MAY_ACCOUNT
 for inode cache
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
Message-Id: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-12-7c680f02a734@kernel.org>
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
 Eric Dumazet <edumazet@kernel.org>, linux-um@lists.infradead.org
X-Mailer: b4 0.16.0

hostfs inodes are allocated with GFP_KERNEL_ACCOUNT. Specify
SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
__GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.

Path: lookup -> hostfs_iget() -> hostfs_alloc_inode()
  -> alloc_inode_sb(sb, hostfs_inode_cache, GFP_KERNEL_ACCOUNT)

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 fs/hostfs/hostfs_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 613146e76dec..8d748ff838f3 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -1078,7 +1078,7 @@ MODULE_ALIAS_FS("hostfs");
 
 static int __init init_hostfs(void)
 {
-	hostfs_inode_cache = KMEM_CACHE(hostfs_inode_info, 0);
+	hostfs_inode_cache = KMEM_CACHE(hostfs_inode_info, SLAB_MAY_ACCOUNT);
 	if (!hostfs_inode_cache)
 		return -ENOMEM;
 	return register_filesystem(&hostfs_type);

-- 
2.54.0

