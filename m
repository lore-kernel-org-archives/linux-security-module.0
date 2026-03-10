Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDB0314D08
	for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163213; cv=none; b=VARcp+yPh1SsKB2EcZDTqCqbaV3cJzci31rjlSRnb3X5l6UbmmtIRpPCrOcyY7yy5DOoMK3crCFqGnU7z3X3zKneNFkpvxBMRPdXvSW2xUqo/1KANbA9oEHLKTBBNmZmS1ndrU1TeiPi5AZe93msx2r6xiYl5rGTQva2uUejlKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163213; c=relaxed/simple;
	bh=LMzBGrJ31b518fnKMXCoVfX4zZ4s5g3rcEg1HKSu6S8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MK0MwzPIIqu61992cAOuV3R+gvuNPNzj0HHu/SaRc7xwio9RWp7oImQldLVEz3gMsxyAEAVvaJsOZSwUCaG2wnkjYO8nMQXoDwo16b13yoRitSA6acSSKvpw9+dWHzwmCBay2V9kiPaI14XLHMOBucmUuIyQ2o4vawWzJs60yC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=PznY1t/y; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="PznY1t/y"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fVgcS0nV0zDH6;
	Tue, 10 Mar 2026 18:20:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773163208;
	bh=plWE1/7HdzZub3zhJSXeNeJfAhm8zRtwOmCBs+8eAys=;
	h=From:To:Cc:Subject:Date:From;
	b=PznY1t/y57+QR386RmtOjEhqxztYc64R1UeKmm1t2JguyY3crHs/zU1uOJORIAEiI
	 AC9zSSq8BsCj8OR7sNklAw0WziscxoAFd3hVrhIMmxXTl/NLizupG+SVEwIzMHaXN1
	 08+Lf76JzYGW1+jBiluWQxDcCsRODdC2dVTCURrQ=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fVgcR4StCz1lS;
	Tue, 10 Mar 2026 18:20:07 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2] landlock: Fix kernel-doc warning for pointer-to-array parameters
Date: Tue, 10 Mar 2026 18:20:03 +0100
Message-ID: <20260310172004.1839864-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The insert_rule() and create_rule() functions take a
pointer-to-flexible-array parameter declared as:

  const struct landlock_layer (*const layers)[]

The kernel-doc parser cannot handle a qualifier between * and the
parameter name in this syntax, producing spurious "Invalid param" and
"not described" warnings.

Remove the const qualifier of the "layers" argument to avoid this
parsing issue.

Cc: Günther Noack <gnoack@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://lore.kernel.org/r/20260304193134.250495-1-mic@digikod.net
- Remove const instead of using a typedef (suggested by Günther).
---
 security/landlock/ruleset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 3234a5bc11ff..181df7736bb9 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -107,7 +107,7 @@ static bool is_object_pointer(const enum landlock_key_type key_type)
 
 static struct landlock_rule *
 create_rule(const struct landlock_id id,
-	    const struct landlock_layer (*const layers)[], const u32 num_layers,
+	    const struct landlock_layer (*layers)[], const u32 num_layers,
 	    const struct landlock_layer *const new_layer)
 {
 	struct landlock_rule *new_rule;
@@ -206,7 +206,7 @@ static void build_check_ruleset(void)
  */
 static int insert_rule(struct landlock_ruleset *const ruleset,
 		       const struct landlock_id id,
-		       const struct landlock_layer (*const layers)[],
+		       const struct landlock_layer (*layers)[],
 		       const size_t num_layers)
 {
 	struct rb_node **walker_node;
-- 
2.53.0

