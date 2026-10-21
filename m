Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583286;
	b=41monKZcaiqiGNZ7hesSw1v3WINBnhWVde/qsofDFBmf9lvp59f1O42Rqcq/6kFkXobI
	 ybu/2KGS2Pf9DeignU9XNUmnLLlW8UaauX9L8f/b9Y0LPJQ8tdmlEZbLBjl24f7P8tduV
	 uSWauNLaH3DZQV3BGdC7CHKHAWzpV3uLWxrUpoLfp+o1fz1obz9ZCBbVguLwVMIFiOcag
	 8UsYTLi5EsP4NI6TKiJPSOdtrd4PtN0ItxpDxZfj6dNIS2dxUOQYROYhKOIy6SsGH5a2F
	 NCYKeI3ElNnZpJHxB1lsug79BcgiY7RmdaQHWUHCZjIKqDMjbPyd4dfNpMnXbM/CUAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583286;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=a5DIL4uZz39TVq6ZW2xMCikSAQz9J2d8P4Q3iHPEMlU=;
	b=L3C5m2ERuVxlkwkSGwvIW/BMg7hRfDCSz3yyszKPRtVMNBTzYQTyNmQ1OrCwahTniSqu
	 A9uDcmSf5KbUxtbcKV5HU5RRwt2m2zwdJl+70vETpaClE6/4GSsVv7M9NhlPqw9LfTL28
	 O3aZa1I8K9sCwNUSeCajSEvUEP9lnloNE6HfzhK3nI+1Q+NZ5kDNW5/dWaWHFozPP2I5g
	 clyPd47QcfbuBb+37nIIneEODkMO0GYZUGi6mR6KRKe3+xbqhE12YrP1olszuZtiGQG5v
	 y6wyD9ahkC5EUz1gzIms53rMPrSrFX5ddxEbH6j//nwVs3nMlFuGtLcZ0Pw/TsfEjPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1s+5KSD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242AF60A2633;
	Wed, 21 Oct 2026 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1s+5KSD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43461F000C4;
	Wed, 21 Oct 2026 11:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583286;
	bh=a5DIL4uZz39TVq6ZW2xMCikSAQz9J2d8P4Q3iHPEMlU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=h1s+5KSD/LYCP7ujuSgohzesMNYwc10Y5bulYUJ3+UGxRRMiXU8KIh/FMzTSkkOgg
	 Ufb1lNPdWnAwJkPD+5pPsMl00dCLEJtYEcZ5dgk7xvWvNFSf9NF8tAw9fLrL92Udtq
	 rkCwSaHww/7ShJR8WNBFhX3BEmczD6eiIqmEqfE4h3ZQBj5hEBCMdieZXz6KXZnfnY
	 vL0H90KeuQ3mq8ysW2MgvMESaxPP6RG8H6YO3dQrER98Wb/RMRvOKwoYW9WDddVBrr
	 8Au2xU06dRcOWEMBVFD5KjcFr8UPYLCSePft0eZSLwI+ytPIPqJxEKwulLs/dyKvz8
	 nqlTDpL98W6NA==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 21 Oct 2026 12:46:52 +0100
Subject: [PATCH slab/for-next 11/14] smack: specify SLAB_MAY_ACCOUNT for
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
Message-Id: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-11-096800aa3330@kernel.org>
References: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
In-Reply-To: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
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
 Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 linux-security-module@vger.kernel.org
X-Mailer: b4 0.16.0

smk_copy_rules() allocates rules with the gfp passed from
security_prepare_creds(), which is GFP_KERNEL_ACCOUNT. Specify
SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
__GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.

Path: fork() -> copy_creds() -> prepare_creds()
  -> security_prepare_creds(GFP_KERNEL_ACCOUNT) -> smack_cred_prepare()
  -> smk_copy_rules() -> kmem_cache_zalloc(smack_rule_cache)

Assisted-by: LLM
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 8e88ac65fd7f..8a802578ac29 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5352,7 +5352,7 @@ static __init int smack_init(void)
 	struct cred *cred = (struct cred *) current->cred;
 	struct task_smack *tsp;
 
-	smack_rule_cache = KMEM_CACHE(smack_rule, 0);
+	smack_rule_cache = KMEM_CACHE(smack_rule, SLAB_MAY_ACCOUNT);
 	if (!smack_rule_cache)
 		return -ENOMEM;
 

-- 
2.54.0

