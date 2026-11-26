Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795721686;
	b=Onbf3gqeKVEvzGIAllhZJzppjULe0FmJJs1krTo3r2vYP5ptsFb5cwwxn7xhVx1KPg9h
	 f0+x5ASzg19K8UxHFZj9E2vtLkJMeKTmW7SM2qk9bQS1RJxdtF/+37s2JgWgAG7u754uz
	 on8Ga80NzYtqopFnU7tEXPHRhXGAGHSOxLZ9P6dmBM5iByr3p4Snr9CbnVmAwnELacFec
	 GxiuB2MyvyACe89dtEeOpWhhqfog6RaiJcCuc/lhM9QlvwdyLQ8BKKkNtz7qRPzf/f3JW
	 uM2vmVejNqDroNpzL1JLHG8dkeSo+0Kv5knx/erPBunR3jJNcyeUxjPDYYpU3u19DdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795721686;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=CcH6oOCLJBBWhqHrt9WVxq1zAIk+ultz0SBaXp1cDE4=;
	b=fdS3l8x6oGd0pkXtQSxyn3DhT9gkguDscdGGuMMqrplJMB8ugocx8JpS85WZtHwdsDlP
	 ER+NBRadP4vgG76NgF15byTfldaV9XaS0ezM3p9Dmm4WtTGc4yJMRs8vlhsAnsmkVMRlQ
	 d7YrfpqsTF2/20HcWG4tT7CXGQmHDQPq33k7LSDcBwucK7f7bk5ZV3VPVDyi+ev7Mej7v
	 DETUezq+JVuGFcvjR/ezhCzCfYbiUwWVEuZ5EfhRSjSn3Qq5ogVqJIQD+LlxUFPZCp5T7
	 dvrnL1LMqwQHB9ne4tAtBZttihqMRJeLVRTuzsbAEOGbkudN4MCwLrL1yf59mGpxIxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qWvyQKeQ;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E525606A31C;
	Thu, 26 Nov 2026 19:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E525606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qWvyQKeQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CcH6oOCLJBBWhqHrt9WVxq1zAIk+ultz0SBaXp1cDE4=; b=qWvyQKeQwbC/z1BY2GkLz0UzOD
	XegLn6T94yjcn2nVjUdWRaaleQjLq1RjmxthJWdvlonwNaGWtM/NlFaCfIf3PshccI/ejRHJ+5K7Q
	zgp/wX2KR/OGQpPRIZPoj0A2rCRY04RxqlCzcWekLcUSyGLdu2etxwu5ZtT/TWshE9UvBu4D6c4Q9
	+uAI0Th7ZElX6+eO9BNVIl9Lp14WC/FOnZ9aILkUAOaZ0ajIysojz2zDaD6tQEXBv7hLLLb4gTlRJ
	LWjiQjH1F5FX5RJUAt4QSIqMy+u3pby41I0dX7mWeqPmf3x9fZ9YeJpPC19Ts1zmD7pq7pTyVnFC5
	GydaSJzQ==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWfEr-0000000ELfa-2nqt;
	Thu, 26 Nov 2026 19:34:37 +0000
Date: Thu, 26 Nov 2026 14:34:30 -0500
From: "Liam R. Howlett" <liam@infradead.org>
To: "Harry Yoo (Meta)" <harry@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Muchun Song <muchun.song@linux.dev>, Hao Ge <hao.ge@linux.dev>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Ballance <andrewjballance@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Amir Goldstein <amir73il@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Eric Dumazet <edumazet@kernel.org>, 
	maple-tree@lists.infradead.org
Subject: Re: [PATCH slab/for-next v2 02/14] lib/maple_tree: specify
 SLAB_MAY_ACCOUNT for maple_node cache
Message-ID: <baf4kjajb6c6xndnmizgp7uujbleuiuzcv77z3nvn7mpgidls4@rruuv76wtgdq>
References: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
 <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-2-7c680f02a734@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-2-7c680f02a734@kernel.org>

On 26/11/25 09:37PM, Harry Yoo (Meta) wrote:
> Maple tree users can pass accounted gfp flags down to node allocations
> (e.g. arm64 KVM's smccc_filter uses GFP_KERNEL_ACCOUNT). Specify
> SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
> __GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.
> 
> Path: mtree_insert_range(GFP_KERNEL_ACCOUNT) -> mas_nomem()
>   -> mas_alloc_nodes() -> kmem_cache_alloc(maple_node_cache)
> 
> Cc: "Liam R. Howlett" <liam@infradead.org>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Andrew Ballance <andrewjballance@gmail.com>
> Cc: maple-tree@lists.infradead.org
> Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>

Reviewed-by: Liam R. Howlett (Google) <liam@infradead.org>

> ---
>  lib/maple_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index f7f51f1b40d9..5ff176f1a021 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5815,7 +5815,7 @@ void __init maple_tree_init(void)
>  
>  	maple_node_cache = kmem_cache_create("maple_node",
>  			sizeof(struct maple_node), &args,
> -			SLAB_PANIC);
> +			SLAB_PANIC | SLAB_MAY_ACCOUNT);
>  }
>  
>  /**
> 
> -- 
> 2.54.0
> 
