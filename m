Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C097420F092
	for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784694; cv=none; b=BOfzgd/pcYZlA2ScboZ7iD47/YMh31NPrXH/SOk7qdXNJGjPuDbbhdrgHA3+PrgTpGMPYLdGcRMBd+GlHW8jBe0fYvX5TqfUSmpqLagICMOVvkwQCWGdbTUXy+NjPgBXE33jSzL8ozSBxpBJxFioD6mGB8+/m9Hld8cq6YYCRpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784694; c=relaxed/simple;
	bh=8TLaqHxOAqnpOnK0y/4l9elkW6+voC28qWJNnf/smEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u80+ZNc3CvooPJ+h69fUgrAVVe92KE0IJwZ6sLokr5S7hy1v1hcMo9XPlrZFYo6+RjtteRquyZs1WTRoN1lfxARxS3kyQ0Gad5dWpQP29mBhvseNR91bG01V+8+3KNXgZ13Y0wwjGMJu1JtoP9XO7KfcVPczzI4sFzTJdq1bRRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Kn/tRBTy; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Kn/tRBTy"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YWy1S22bQz169r;
	Mon, 13 Jan 2025 17:11:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736784684;
	bh=/rhNS+Hm78vBKNItT+NMBCUhZo36eNGFBlgsINUtEN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kn/tRBTyC1Cp0cgsNvqz311E+cNcBWvQVqax5eJHGlq+Yy5DjDg1BumPfAK0S1JuK
	 oDoSd/K/VL0pGxFksD7JR+Q3jfAfDRvX/0KViwyTwhcXmcUzyOAf8JG4TiToxrp0yo
	 Gm/noGlOaH4OaB8HnbWX3v2UAFtdtkT4WB/cuSI4=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YWy1R58vYzRbL;
	Mon, 13 Jan 2025 17:11:23 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Shervin Oloumi <enlightened@chromium.org>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1 4/4] landlock: Use scoped guards for mutex
Date: Mon, 13 Jan 2025 17:11:12 +0100
Message-ID: <20250113161112.452505-5-mic@digikod.net>
In-Reply-To: <20250113161112.452505-1-mic@digikod.net>
References: <20250113161112.452505-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Simplify error handling by replacing goto statements with automatic
calls to mutex_unlock() when going out of scope.

Do not initialize the err variable for compiler/linter to warn us about
inconsistent use, if any.

Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Günther Noack <gnoack@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250113161112.452505-5-mic@digikod.net
---
 security/landlock/ruleset.c | 52 +++++++++++++++----------------------
 1 file changed, 21 insertions(+), 31 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index f27b7bdb19b9..f1c3104aea6c 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -367,7 +367,7 @@ static int merge_tree(struct landlock_ruleset *const dst,
 static int merge_ruleset(struct landlock_ruleset *const dst,
 			 struct landlock_ruleset *const src)
 {
-	int err = 0;
+	int err;
 
 	might_sleep();
 	/* Should already be checked by landlock_merge_ruleset() */
@@ -378,32 +378,28 @@ static int merge_ruleset(struct landlock_ruleset *const dst,
 		return -EINVAL;
 
 	/* Locks @dst first because we are its only owner. */
-	mutex_lock(&dst->lock);
-	mutex_lock_nested(&src->lock, SINGLE_DEPTH_NESTING);
+	guard(mutex)(&dst->lock);
+	guard(mutex_nest_1)(&src->lock);
 
 	/* Stacks the new layer. */
-	if (WARN_ON_ONCE(src->num_layers != 1 || dst->num_layers < 1)) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
+	if (WARN_ON_ONCE(src->num_layers != 1 || dst->num_layers < 1))
+		return -EINVAL;
+
 	dst->access_masks[dst->num_layers - 1] = src->access_masks[0];
 
 	/* Merges the @src inode tree. */
 	err = merge_tree(dst, src, LANDLOCK_KEY_INODE);
 	if (err)
-		goto out_unlock;
+		return err;
 
 #if IS_ENABLED(CONFIG_INET)
 	/* Merges the @src network port tree. */
 	err = merge_tree(dst, src, LANDLOCK_KEY_NET_PORT);
 	if (err)
-		goto out_unlock;
+		return err;
 #endif /* IS_ENABLED(CONFIG_INET) */
 
-out_unlock:
-	mutex_unlock(&src->lock);
-	mutex_unlock(&dst->lock);
-	return err;
+	return 0;
 }
 
 static int inherit_tree(struct landlock_ruleset *const parent,
@@ -441,47 +437,41 @@ static int inherit_tree(struct landlock_ruleset *const parent,
 static int inherit_ruleset(struct landlock_ruleset *const parent,
 			   struct landlock_ruleset *const child)
 {
-	int err = 0;
+	int err;
 
 	might_sleep();
 	if (!parent)
 		return 0;
 
 	/* Locks @child first because we are its only owner. */
-	mutex_lock(&child->lock);
-	mutex_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
+	guard(mutex)(&child->lock);
+	guard(mutex_nest_1)(&parent->lock);
 
 	/* Copies the @parent inode tree. */
 	err = inherit_tree(parent, child, LANDLOCK_KEY_INODE);
 	if (err)
-		goto out_unlock;
+		return err;
 
 #if IS_ENABLED(CONFIG_INET)
 	/* Copies the @parent network port tree. */
 	err = inherit_tree(parent, child, LANDLOCK_KEY_NET_PORT);
 	if (err)
-		goto out_unlock;
+		return err;
 #endif /* IS_ENABLED(CONFIG_INET) */
 
-	if (WARN_ON_ONCE(child->num_layers <= parent->num_layers)) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
+	if (WARN_ON_ONCE(child->num_layers <= parent->num_layers))
+		return -EINVAL;
+
 	/* Copies the parent layer stack and leaves a space for the new layer. */
 	memcpy(child->access_masks, parent->access_masks,
 	       flex_array_size(parent, access_masks, parent->num_layers));
 
-	if (WARN_ON_ONCE(!parent->hierarchy)) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
+	if (WARN_ON_ONCE(!parent->hierarchy))
+		return -EINVAL;
+
 	get_hierarchy(parent->hierarchy);
 	child->hierarchy->parent = parent->hierarchy;
-
-out_unlock:
-	mutex_unlock(&parent->lock);
-	mutex_unlock(&child->lock);
-	return err;
+	return 0;
 }
 
 static void free_ruleset(struct landlock_ruleset *const ruleset)
-- 
2.47.1

