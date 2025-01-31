Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D079B1F1313
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738341092; cv=none; b=Yo/a2ece2c1oXhgbflbbQysz90qeo4jRooiHl57uZS4OjA9Cb4DwB8d6912x1bT9upY0lo6vUpU3+jy+Dx2IB+5YigWPfiiK4YoazlxwhJwDJADYPDcS2BHb3DbE+g+gIF61zSRhIiWE4jh2ir+OXBYZaA0USJDKgj2chRN4wwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738341092; c=relaxed/simple;
	bh=oqub3yqXzb/VKihkceAvb8EKCMqm90Tlf8WycLxs3Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4qbY5wlgPeFEGiFZRy33RSZpy5IN09Xp8dTHMl1SQrWLJRkksmWcBzDiCdNPEqF+Q9/xIJI/FmCzMHhiltfygkP/QHxs0cfYmDfM7Z0hdm1sRw0Zkuh5hFSH1H0VlESrQYXp3uVPw5vXhH4HQFvacHlIws0ftG1uLqxaboTn24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vO31qoa6; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vO31qoa6"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yl1cB3HrCzSYy;
	Fri, 31 Jan 2025 17:31:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738341082;
	bh=FzVsYVAwdM95pvCRwAKz5t+Bv0kjzH255qCpGQBbsJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vO31qoa6cNMQSPEadLdfgDAAIFm30gZr9mb9Cg0eUwkKu6bqAddYAjjIjy3nkeHrQ
	 rQ917dREERrsYwWjwAX6/P7eP52qAjjqfGbEZgdg3ntRFkg7bkG0Dlyq/0xBjxfD++
	 j3Lfx72PB1kSmvOaqo9YdCS6eSwBYUPZK9yrkQ2c=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yl1c94LxBzdTM;
	Fri, 31 Jan 2025 17:31:21 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 06/24] landlock: Prepare to use credential instead of domain for scope
Date: Fri, 31 Jan 2025 17:30:41 +0100
Message-ID: <20250131163059.1139617-7-mic@digikod.net>
In-Reply-To: <20250131163059.1139617-1-mic@digikod.net>
References: <20250131163059.1139617-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

This cosmetic change that is needed for audit support, specifically to
be able to filter according to cross-execution boundaries.

Replace hardcoded LANDLOCK_SCOPE_SIGNAL with the signal_scope.scope
variable.

Use scoped guards for RCU read-side critical sections.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250131163059.1139617-7-mic@digikod.net
---

Changes since v4:
- New patch.
---
 security/landlock/task.c | 50 +++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/security/landlock/task.c b/security/landlock/task.c
index 98894ad1abc7..dbdfac11e015 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -7,6 +7,7 @@
  */
 
 #include <asm/current.h>
+#include <linux/cleanup.h>
 #include <linux/cred.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
@@ -213,15 +214,15 @@ static int hook_unix_stream_connect(struct sock *const sock,
 				    struct sock *const other,
 				    struct sock *const newsk)
 {
-	const struct landlock_ruleset *const dom =
-		landlock_get_applicable_domain(landlock_get_current_domain(),
-					       unix_scope);
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(current_cred(), unix_scope,
+						NULL);
 
 	/* Quick return for non-landlocked tasks. */
-	if (!dom)
+	if (!subject)
 		return 0;
 
-	if (is_abstract_socket(other) && sock_is_scoped(other, dom))
+	if (is_abstract_socket(other) && sock_is_scoped(other, subject->domain))
 		return -EPERM;
 
 	return 0;
@@ -230,11 +231,11 @@ static int hook_unix_stream_connect(struct sock *const sock,
 static int hook_unix_may_send(struct socket *const sock,
 			      struct socket *const other)
 {
-	const struct landlock_ruleset *const dom =
-		landlock_get_applicable_domain(landlock_get_current_domain(),
-					       unix_scope);
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(current_cred(), unix_scope,
+						NULL);
 
-	if (!dom)
+	if (!subject)
 		return 0;
 
 	/*
@@ -244,7 +245,8 @@ static int hook_unix_may_send(struct socket *const sock,
 	if (unix_peer(sock->sk) == other->sk)
 		return 0;
 
-	if (is_abstract_socket(other->sk) && sock_is_scoped(other->sk, dom))
+	if (is_abstract_socket(other->sk) &&
+	    sock_is_scoped(other->sk, subject->domain))
 		return -EPERM;
 
 	return 0;
@@ -256,27 +258,27 @@ static const struct access_masks signal_scope = {
 
 static int hook_task_kill(struct task_struct *const p,
 			  struct kernel_siginfo *const info, const int sig,
-			  const struct cred *const cred)
+			  const struct cred *cred)
 {
 	bool is_scoped;
-	const struct landlock_ruleset *dom;
+	const struct landlock_cred_security *subject;
 
-	if (cred) {
-		/* Dealing with USB IO. */
-		dom = landlock_cred(cred)->domain;
-	} else {
-		dom = landlock_get_current_domain();
-	}
-	dom = landlock_get_applicable_domain(dom, signal_scope);
+	if (!cred)
+		/* Not dealing with USB IO. */
+		cred = current_cred();
+
+	subject = landlock_get_applicable_subject(cred, signal_scope, NULL);
 
 	/* Quick return for non-landlocked tasks. */
-	if (!dom)
+	if (!subject)
 		return 0;
 
-	rcu_read_lock();
-	is_scoped = domain_is_scoped(dom, landlock_get_task_domain(p),
-				     LANDLOCK_SCOPE_SIGNAL);
-	rcu_read_unlock();
+	scoped_guard(rcu)
+	{
+		is_scoped = domain_is_scoped(subject->domain,
+					     landlock_get_task_domain(p),
+					     signal_scope.scope);
+	}
 	if (is_scoped)
 		return -EPERM;
 
-- 
2.48.1

