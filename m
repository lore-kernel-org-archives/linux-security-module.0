Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B51D265629
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790995914; cv=none; b=rULVhyHPgxnNkhweE+uwGLSpR1K7IrPoHqWDSxUQwZe7FmdN1apqYG2HNO9GVp3TXHxkbdGwlCdG6zjwooXcuMHG7+8t9seHT3VCfnUfM+NeMpUZAboEUZEo0qMsrszJhoRDqSS5Za2Bwjwm+dhg/LaqWT2ulMQtYmN8OTLA/tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790995914; c=relaxed/simple;
	bh=Q6rnio+E9BV4+AyCKi3TdkOsclljrcJo+MbDEfk/W4U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCPcPlnvuVlxGiPYyhu/NClZLW+a+8mPxjiopGKkiZflSRKmBvz/WFmhN+g3J13d4oDHDWNHGnMaKcYQ59YHuPYl1Ff653kv22rSq9CjS3RS8Hu3J003DGh+K+WHCycq5Ud9i0W9AmTDJn62savxNGMC3F3fR9ZZjuVSWQWL86s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJnrPDJa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJnrPDJa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2658D1F0089A
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790995913;
	bh=eMDWM54jWv9MmFltfrjpv7RiesSuiC0c4vk7O6y6PP8=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=dJnrPDJa93vq8niw1fFvoJEI/7/Jqw0jt4lWdCouYRjpIQdCh5In17RHE94R7K7+2
	 LPyBHNBIPllowGivP0kSQFAR0FHe7c7yug97KgE+e0uk/ZAhtQhWRqd7MwJD1g/gZy
	 8j7s74HXfjbCG9MYpLEPdnbwk2+Xu5EsZUspeKttFDNajSbEJr+0UU/B70FTp4u2Ec
	 R11/3s4Lf16ftdbjd8rbRYJH9sE4fZt9bJU4Pw9Spgv1eUwR1OVhNQyAc056iftweU
	 nnVUun9jDMmRWkJOwJ9JiKLVbCtfmWpEdjUs2HQIKh9aQsuGyYnoV6SGaGeFL1gqgb
	 JPQObqSFmef0w==
From: Fan Wu <wufan@kernel.org>
To: linux-security-module@vger.kernel.org
Subject: [PATCH 4/6] ipe: correct policy text ownership comment
Date: Fri,  2 Oct 2026 19:51:33 -0700
Message-ID: <20261003025135.3666767-5-wufan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261003025135.3666767-1-wufan@kernel.org>
References: <20261003025135.3666767-1-wufan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Policy text is separately allocated only when p->pkcs7 is NULL.
Correct the comment to match the existing free logic.

No functional changes.

Assisted-by: LLM
Signed-off-by: Fan Wu <wufan@kernel.org>
---
 security/ipe/policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/ipe/policy.c b/security/ipe/policy.c
index 827867be4fac..e542329726bc 100644
--- a/security/ipe/policy.c
+++ b/security/ipe/policy.c
@@ -52,7 +52,7 @@ void ipe_free_policy(struct ipe_policy *p)
 	ipe_del_policyfs_node(p);
 	ipe_free_parsed_policy(p->parsed);
 	/*
-	 * p->text is allocated only when p->pkcs7 is not NULL
+	 * p->text is allocated only when p->pkcs7 is NULL
 	 * otherwise it points to the plaintext data inside the pkcs7
 	 */
 	if (!p->pkcs7)
-- 
2.55.0

