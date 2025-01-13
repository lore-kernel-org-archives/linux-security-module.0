Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B9D20AF71
	for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784692; cv=none; b=MP+XvKWAzgQ3IJw4O0cdywse1Ier9masLyMYls/mn/U1yGuEkKWeJ6NFKPwIOyv9DZBxEeSkoeuqwUcdsuPkWBo9AhvHLA4v0lS3Pvr+mjkUEv8tScWc4k/fvhgnYkuyfBwLXB4JotaCzsVIQFc2zSMKEHgAyCgZ9neN0icDabM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784692; c=relaxed/simple;
	bh=e7EajQHBGxTlpsWtbyDOw7pIsgGDBwUT7WTk0sLggUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J16iYYwYmHKFm9BLYd9R7ms4PfmsYagfxkybsZSUV3BbiHnUuBqqP1K+0/3wYUkwscfe266Vo7EhbWD2qSxHYKhgpMjHQ2wnLcvXVBLl+0zD5VJoXjCU7hdqWe8qokQvjrMgjBsVNoJkyF90pBnmS8nKyc1yWZUEYzkfcWhQiOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=LkwwU1dF; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="LkwwU1dF"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YWy1P6695z12kn;
	Mon, 13 Jan 2025 17:11:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736784681;
	bh=aejfFX/wCqISAf4ObXFXZmBBY776r83KhR6yOC8AcQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LkwwU1dFSVWTwo7QkKZpXioqyA0KUIWjz811gnY0mGTogVnVKyUmpBb217vQvb3xn
	 xOAmal7mbxYjjokwMB+oVGPSBYdIOUX5vi/uq0bQg6vXyx8D06bMh/6Qc7T1BmVd8T
	 hEHMm0t6df7Ob/KZt/fvyv8N2KcQSyY6pgeeSJzo=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YWy1P2bL4zSVx;
	Mon, 13 Jan 2025 17:11:21 +0100 (CET)
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
Subject: [PATCH v1 2/4] landlock: Use scoped guards for ruleset in landlock_add_rule()
Date: Mon, 13 Jan 2025 17:11:10 +0100
Message-ID: <20250113161112.452505-3-mic@digikod.net>
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
calls to landlock_put_ruleset() when going out of scope.

This change depends on the TCP support.

Cc: Günther Noack <gnoack@google.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250113161112.452505-3-mic@digikod.net
---
 security/landlock/syscalls.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 5a7f1f77292e..a9760d252fc2 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -399,8 +399,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 		const enum landlock_rule_type, rule_type,
 		const void __user *const, rule_attr, const __u32, flags)
 {
-	struct landlock_ruleset *ruleset;
-	int err;
+	struct landlock_ruleset *ruleset __free(landlock_put_ruleset) = NULL;
 
 	if (!is_initialized())
 		return -EOPNOTSUPP;
@@ -416,17 +415,12 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 
 	switch (rule_type) {
 	case LANDLOCK_RULE_PATH_BENEATH:
-		err = add_rule_path_beneath(ruleset, rule_attr);
-		break;
+		return add_rule_path_beneath(ruleset, rule_attr);
 	case LANDLOCK_RULE_NET_PORT:
-		err = add_rule_net_port(ruleset, rule_attr);
-		break;
+		return add_rule_net_port(ruleset, rule_attr);
 	default:
-		err = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-	landlock_put_ruleset(ruleset);
-	return err;
 }
 
 /* Enforcement */
-- 
2.47.1

