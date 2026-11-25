Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642741;
	b=dZWx5pma4OgBMthQuwQJ7GyeMrepWtctWFci76jAkGtkcFlO9NzE8U884meEJe/InSax
	 DIgozzd30s8D6ChHtAjtWOtqjODtzXKreb4Ij3d7Prw3wnozxhzUWI/+B4YokApRSUHpM
	 r8q4pf6RbwTEcPikSaFiMf1zU563aP1B9NGFTAMdbpwQyXYPYsDU+CifG5KMYDo/ujIK2
	 SiJ73360V2Xbym7MfKCHsaJLpjiBwa+5wO60+RFLRzgFG92JKgTIpeOnJEtfUknU1Wk0O
	 hZZ0nmlHkKHPACl5zfQnIFHJgXQJO0NBX/6aAs24VKkvOL/n4yrvXWz/qPbXDeEeHtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642741;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=g9HZ6CESqCC3IbuIZeeH60D+MFwI+V+ns81lV3Y2LAA=;
	b=JODN8UFKkGC3z/maifzSbDRz0XVWbp8aCJGIW9E8NbW5MDbrkf1nZKPwD7TjM8fX0BFU
	 bxSo44+jvPeVBcg8Yl4UQ/jS1Kk+5P+ldXHz5q3ufLKrA1LFjafUKwZA3D0vf1OmgI+uB
	 2wiZn8AaaqaggHzqJCjQ2FkMPVs5hj5xOMoLwWdkAEttGz/Rq5ifWwtjBv21OSNfq7xYi
	 rCo6yJXc45zIQrH9FKx6DkkPXru9tnGSjG4iEi/SxpQlOUAr+uX0l04u6pWDlVhwgm4WV
	 ld9mIQtHUQdB+++8ONJKZUPU2nlMpexuSKgWpXFAJS4NwcIKDey+lHo8m8SRj4eyesQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ntc1/cKL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16367606A321;
	Wed, 25 Nov 2026 21:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ntc1/cKL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04021F000F2;
	Wed, 25 Nov 2026 21:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642740;
	bh=g9HZ6CESqCC3IbuIZeeH60D+MFwI+V+ns81lV3Y2LAA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ntc1/cKLKb+8Patxe9n6wstPGCvrq26H4Tcsn38Rhk6RuSCvvN46w3x1WtKqjTuOA
	 6st+MQ4ErxaBFPr0iiLA0fbC0+q1sHT5uY9eBtF6toWf4QJOozqgr8246o9Rzfqm4g
	 RHwhhKuQMiZ8zzD4OaV26wbGQkS7DXl1kA5wJMECEtgr5olYRPAVYaMKkB2Bk3jpRS
	 Q3E3wfxkOTNHJTPnAp0ciFAqfe2zPqsJWRcSel/MMjcwW/BNLifvygBPDi7qNcmch0
	 Ed3INnmHFEy58vB79VTuatorZxZdMk1K/cLZHwSDHdgKhe9Xv+lHnWHjgGzXv/Kk0X
	 OrI6evbyW9T7w==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 25 Nov 2026 21:37:08 +0000
Subject: [PATCH slab/for-next v2 07/14] arm64/mm: specify SLAB_MAY_ACCOUNT
 for pgd_cache
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
Message-Id: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-7-7c680f02a734@kernel.org>
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
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.16.0

When PGD_SIZE != PAGE_SIZE, user PGDs are allocated from pgd_cache
with GFP_PGTABLE_USER, which includes __GFP_ACCOUNT. Specify
SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
__GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.

Path (e.g. 64K pages): copy_process() -> mm_init() -> pgd_alloc()
  -> kmem_cache_alloc(pgd_cache, GFP_PGTABLE_USER)

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 arch/arm64/mm/pgd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
index bf5110b91e2f..0fd5b90b5160 100644
--- a/arch/arm64/mm/pgd.c
+++ b/arch/arm64/mm/pgd.c
@@ -63,5 +63,5 @@ void __init pgtable_cache_init(void)
 	 * Naturally aligned pgds required by the architecture.
 	 */
 	pgd_cache = kmem_cache_create("pgd_cache", PGD_SIZE, PGD_SIZE,
-				      SLAB_PANIC, NULL);
+				      SLAB_PANIC | SLAB_MAY_ACCOUNT, NULL);
 }

-- 
2.54.0

