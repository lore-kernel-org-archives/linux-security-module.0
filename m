Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66D72D0C8F
	for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766173170; cv=none; b=VkbiYdWZirQgYtNW0/N2vrtlm9rzyb1+EAuLwRSYyNyq8Lodys4PF2F1wIZancGaKzrbMEgJeQUIVyGZ6UGF6dX/xzrK5g8V/mAQ1p/u4Goh70s1JwM2XBkufeD9vFlGs5tXUcQwo3et/Y7lJa1dabhmXw1zWkRMOWMk/CJ/hEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766173170; c=relaxed/simple;
	bh=QvMrQpoj8Ma3LNC3XD9SpHIgWCTqX9jrILjT+aH5G60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lT7JDzRDMGphGpbBANAOe3S07fpeY0JR0p2UeSdQsSQWSW3ryJty3095Ku+3KCtn9RM4AgRss8+4TXvZIs052+yO9Gof+IPXnS0r6fqFuKjL9+yHuBLdeYoaCkUrEQDsnNVQ3Os8vl1agzmh5UXH6rLs9Eg7f80s7SIyYrLh81s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=SfSlOrTe; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="SfSlOrTe"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dXyXQ29yDzGyh;
	Fri, 19 Dec 2025 20:39:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1766173158;
	bh=q4SUGfcZo6r4tUng62uP7cU+hvlkWgzzsIgceQ3rh+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SfSlOrTevXc12k+l8FmcGxiIc/FpZ3a/DXPzH7Bhrc2zcdIWBB2gi3Uc/GUfx30ML
	 c7AIqrX+lrCFi1W0+bVuyPEh78yzgHxHmaaPW7M9mZiZk+4ZY80N0mKvlA2abi0w1C
	 +3SQlQqG/TGF+plyrnBvIgToMA5mHr6mS3e5QsRo=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dXyXP5t4Xzf8V;
	Fri, 19 Dec 2025 20:39:17 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: 
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v1 3/5] landlock: Clean up hook_ptrace_access_check()
Date: Fri, 19 Dec 2025 20:38:49 +0100
Message-ID: <20251219193855.825889-3-mic@digikod.net>
In-Reply-To: <20251219193855.825889-1-mic@digikod.net>
References: <20251219193855.825889-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Make variable's scope minimal in hook_ptrace_access_check().

Cc: Günther Noack <gnoack3000@gmail.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/task.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/landlock/task.c b/security/landlock/task.c
index 2385017418ca..bf4ed15a7f01 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -86,7 +86,6 @@ static int hook_ptrace_access_check(struct task_struct *const child,
 				    const unsigned int mode)
 {
 	const struct landlock_cred_security *parent_subject;
-	const struct landlock_ruleset *child_dom;
 	int err;
 
 	/* Quick return for non-landlocked tasks. */
@@ -96,7 +95,8 @@ static int hook_ptrace_access_check(struct task_struct *const child,
 
 	scoped_guard(rcu)
 	{
-		child_dom = landlock_get_task_domain(child);
+		const struct landlock_ruleset *const child_dom =
+			landlock_get_task_domain(child);
 		err = domain_ptrace(parent_subject->domain, child_dom);
 	}
 
-- 
2.52.0

