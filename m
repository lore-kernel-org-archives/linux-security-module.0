Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69531CF8B
	for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 05:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776059370; cv=none; b=Koot+lmMYnqCH8VYYfoceCde0TRyCfQzXcSIQZ14/U3hfT+UL0dxyEe0qOAYtt9HJthIWohhtqo/eKS1TCCeKfUv8kHsA4Wo6zKLCavz68VDoEZBj6Z1zbWzZllKuLN4pbXJbMLFVIdIpScjjrs0aE6B0kFkQfyqngq9Fq/mY20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776059370; c=relaxed/simple;
	bh=bVOgcEFca8l7LLMejE0bVSv1ySNeaKuA36hrI6O4p+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XaWppFIg6k0fJ4XHejpLUFwcp3nMW2CSEVaTA6rKS4Qzn7XSFDnfJm1vCCwEn31QdtPKFMVWxtCjpE6jrNGs1s1Z48TZf5sBbzvu/4ijQbPEbmjraZhA5FnhG2BqMsDf8NMH7WP9IgokvDnpdgzqLBxfitSMo15382FkT6bW2Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=hTGNW2lx; arc=none smtp.client-ip=120.232.169.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="hTGNW2lx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=hTGNW2lxzVW+exODemMDyEwIlfVYrpYdUpv9SKMUnRgi/1iYCTtqz82EDyyq+OuFnK0fhBNOH6ROr
	 mXWMdTzPWnvLOilAhCq6HKQ775hQ71pBgzqU49VzH9niFmWOCJvff6i1hTYR64NeCMLtmMLMwJRg1K
	 1pY06PpBXQ1+k1AQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-29-12034 (RichMail) with SMTP id 2f0269dc83e0836-00841;
	Mon, 13 Apr 2026 13:49:22 +0800 (CST)
X-RM-TRANSID:2f0269dc83e0836-00841
From: Li hongliang <1468888505@139.com>
To: massimiliano.pellizzer@canonical.com
Cc: john.johansen@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	qsa@qualys.com,
	carnil@debian.org,
	georgia.garcia@canonical.com,
	cengiz.can@canonical.com
Subject: [PATCH 5.15.y] apparmor: fix memory leak in verify_header
Date: Mon, 13 Apr 2026 13:49:21 +0800
Message-Id: <20260413054921.2244728-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>

[ Upstream commit e38c55d9f834e5b848bfed0f5c586aaf45acb825 ]

The function sets `*ns = NULL` on every call, leaking the namespace
string allocated in previous iterations when multiple profiles are
unpacked. This also breaks namespace consistency checking since *ns
is always NULL when the comparison is made.

Remove the incorrect assignment.
The caller (aa_unpack) initializes *ns to NULL once before the loop,
which is sufficient.

Fixes: dd51c8485763 ("apparmor: provide base for multiple profiles to be replaced at once")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Li hongliang <1468888505@139.com>
---
 security/apparmor/policy_unpack.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 851fd6212831..3bbd28603c8c 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -959,7 +959,6 @@ static int verify_header(struct aa_ext *e, int required, const char **ns)
 {
 	int error = -EPROTONOSUPPORT;
 	const char *name = NULL;
-	*ns = NULL;
 
 	/* get the interface version */
 	if (!unpack_u32(e, &e->version, "version")) {
-- 
2.34.1


