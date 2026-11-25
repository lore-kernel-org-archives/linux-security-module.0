Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642778;
	b=yV7Sp+RHTmY0mWyJ7RIQKYy3uqHLisnwDTErmHpe24BGNwAJxDY9+zsO4Nvs+WkIm8hQ
	 Eb6/BOQgviy1Q7+cfWvVzi1zqyBcQT1NR1tqvfQ2gTGHvA55j9XNkhozAzwKTxHG8eTYu
	 Axq5czUrHCVtSGucBVdix+XtAwOnrSLWeB6SPdUPdAYKCAyGBtiDvj4SMHJ0agx9HH5wK
	 MEQyNNiILR7hDDkOPvpvcRZeNyzHafKhXSlayDz6IlzKu47TaRqmu6ER3cDyVaAvpN+Zy
	 VNRYtmHXz3a80smQlHJIgEF+ONQJh03YOxus/cpmHixHqUDD2ns1IqGEk8fDrvyxfKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642778;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=vEcqqNm19OuH8f10/Y2MYPCdnWCdxBstah0njeHlZsU=;
	b=IBMpy5U/oKSIQWvulpDeecf3FvfE4m5r4xa080EoGZgb9zgb3fzNwWk0iMjtdbm0hZ3t
	 zPb4ZFXB5RfHm9y4FmnQQKVwOASSjlDD427V3iawxNWRZ5h7xp82AuQGGP3kM5Z0a8n5+
	 qefDSOQEHKRWHh4N9fxpjcVdhHYgXf3+T9gCYPuf/FLz599g5t84WoM3Mb22Isbgk4aQE
	 Y+xyw0VVdTpws6mFUDr7bS2dZlBLmUOQrxyktqwwC1FCLanq55oZvyr6y7d9xeEr5f9kM
	 TkWbpcJS+ll96y3OAi7KdQchWW8RkqPAKkRMlShNq7G+9AmTtCMbSN+CGLt/vangHKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJ7DXGEs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD96F606A323;
	Wed, 25 Nov 2026 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJ7DXGEs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE611F0089F;
	Wed, 25 Nov 2026 21:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642777;
	bh=vEcqqNm19OuH8f10/Y2MYPCdnWCdxBstah0njeHlZsU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JJ7DXGEs5MKX+mzY34S5pcC47lEO+Z3xW5ExnajvXeyp6B4cTkEBKBLKwRfYJ30Fz
	 lLNpO7huIkAceYpnk7nrSIDfc3PjICL3cqJQOiLMp7p5bm9TWqZxiN8Ef/M95VULzT
	 fHuKQo0NOfAybTCSxsCbnnpdX681msyNEwt4gK3mAOyU7j1c+c+DPuJH8a/Ket8aRT
	 gbr4kXFfaBWZDxC3OE8WLPrq1UI42pL+JEsiyxGoNQ/cgvNany+6roREwPJkRXgvWA
	 wEQW3ZqS1Ng6/z3Q84rN0+87qHe/dj7XUTNrb7i4h4TviMkgm/tk1TPgKT9zYetvzs
	 wkLns7a/xnjJA==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 25 Nov 2026 21:37:12 +0000
Subject: [PATCH slab/for-next v2 11/14] smack: specify SLAB_MAY_ACCOUNT for
 smack_rule cache
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
Message-Id: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-11-7c680f02a734@kernel.org>
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

smk_copy_rules() allocates rules with the gfp passed from
security_prepare_creds(), which is GFP_KERNEL_ACCOUNT. Specify
SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
__GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.

Path: fork() -> copy_creds() -> prepare_creds()
  -> security_prepare_creds(GFP_KERNEL_ACCOUNT) -> smack_cred_prepare()
  -> smk_copy_rules() -> kmem_cache_zalloc(smack_rule_cache)

Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3a4a33568297..f4454dc8e232 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5359,7 +5359,7 @@ static __init int smack_init(void)
 	struct cred *cred = (struct cred *) current->cred;
 	struct task_smack *tsp;
 
-	smack_rule_cache = KMEM_CACHE(smack_rule, 0);
+	smack_rule_cache = KMEM_CACHE(smack_rule, SLAB_MAY_ACCOUNT);
 	if (!smack_rule_cache)
 		return -ENOMEM;
 

-- 
2.54.0

