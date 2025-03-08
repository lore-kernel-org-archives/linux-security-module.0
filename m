Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3172A1B041A
	for <linux-security-module@vger.kernel.org>; Sat,  8 Mar 2025 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459815; cv=none; b=R4Pxh/qk+ljgtzoN8fhQeUtkHlpO8LA1gHA6r3ywyjz6OglZ7Q//NcQzOPuEzDJfdcLeKtx0fw760rQTVn2j2nnmgsj+RDzaKRgIczZG7L3rUSDGfbnfMRUU5gxc1SKVMMfgbi0Q6daRtQfFcyZYz6psTklJ6VnXIXWZ8qh6upk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459815; c=relaxed/simple;
	bh=LAcwhyexj1ZfYg2BpS1Tj6Fb83PCQzM6VMckD2e+iFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHdnXpFsFoY7qfGibFQxkM0rlRYyGdFOvhdKYVwktdTL8K24gnvL/j/MRNbR77XzfgITdOw/mcrNshMl/9cgW5d5LTE/X5ZRCmHYbxLzU/uYMZ1GSdgFiwpmc45rnX9tSvpNhkvzEm6NYjQwkce8zYMkwQbcuuYPS/LPJpk9Oqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=KyIML9nA; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="KyIML9nA"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9BsQ167NzQgn;
	Sat,  8 Mar 2025 19:44:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459482;
	bh=UpfkxzrR33d21qbePQH9kdScV+WUPL3QSen9Fu3/hec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KyIML9nAWf85mKVNxRUX6+BWD8+DRwTx7/0t3jC80xJ7RkviRO6iNg9OwMUVxsjq/
	 RJPeT4ADHbnut7BWsXMyoMUKSl6x67skzDjXxtGcV1VzGk7h/yam9bXusfNW/bDQOb
	 t1op0F46pKW/6FXPFJZPLiOJGmsFbjaE/oE7dIA8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9BsP25hTzjnn;
	Sat,  8 Mar 2025 19:44:41 +0100 (CET)
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
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 06/26] landlock: Prepare to use credential instead of domain for scope
Date: Sat,  8 Mar 2025 19:44:02 +0100
Message-ID: <20250308184422.2159360-7-mic@digikod.net>
In-Reply-To: <20250308184422.2159360-1-mic@digikod.net>
References: <20250308184422.2159360-1-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20250308184422.2159360-7-mic@digikod.net
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

