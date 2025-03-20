Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD4722A1F1
	for <linux-security-module@vger.kernel.org>; Thu, 20 Mar 2025 19:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497664; cv=none; b=d8Ljc565LhgLeIpv2kihIFB6V4F4qjq8ClbN7kn0IrDvdS/UdZ3ZGjNe8TkbTrNDiv+Dj48y/85tHGLV80ajQDVZiQ1zXHx4pNq3WihB+YMYD+KdcH/ii+/7Gih+ocsEDRRgbPZv9Fjf9eLANdl/8k4mW4iDTOF1wOAKxU0bNCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497664; c=relaxed/simple;
	bh=7M2HCNBBbNvtHgndpxDFlHm5ZCUn465h1cpAk4NHpog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5PyILnYtaH2k2aXXttXuk1XJQ9TQHC19Bd6jX8aalWQKJEkXOSNIgyFoUQCZX8djecPoseJHVe9C5ZUT3GKVQRVhp/lZ81MArv8ZaiAa8k5duU/fSMxsASLoraov20Amo0xFl1iT54fnWIT0yPvwgKGlbkFJJ4M1waJsZYUAlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=CySJmn9g; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="CySJmn9g"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZJZpF6l2kzLHv;
	Thu, 20 Mar 2025 20:07:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742497653;
	bh=bBvmm7L6QNI9FX5fCvyfCIGt4iiWKXVuXy7dSrsTyMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CySJmn9gsWHgo2JH4lfACWTO6DcoSEOJF2qZtw4LHB5NDjVFU7B4qDfnxvSFQUxYK
	 9bLXUh+OUh40nUOYHKn89B4d8/DimxeQ+WCBVlVjzXYbMv4v2Zb+XkQD4j5Z3b/xxD
	 thXUAsxFdUh/V+B6ISsnkx6f2supZGxyOlys/O44=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZJZpF00VGzXRp;
	Thu, 20 Mar 2025 20:07:32 +0100 (CET)
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
	Matthieu Buffet <matthieu@buffet.re>,
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
Subject: [PATCH v7 06/28] landlock: Prepare to use credential instead of domain for scope
Date: Thu, 20 Mar 2025 20:06:55 +0100
Message-ID: <20250320190717.2287696-7-mic@digikod.net>
In-Reply-To: <20250320190717.2287696-1-mic@digikod.net>
References: <20250320190717.2287696-1-mic@digikod.net>
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
---

Changes since v6:
- Rebase on the signal scoping fix.

Changes since v4:
- New patch.
---
 security/landlock/task.c | 49 +++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/security/landlock/task.c b/security/landlock/task.c
index e04646d80e78..a44b8e4a6ea6 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -7,6 +7,7 @@
  */
 
 #include <asm/current.h>
+#include <linux/cleanup.h>
 #include <linux/cred.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
@@ -214,15 +215,15 @@ static int hook_unix_stream_connect(struct sock *const sock,
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
@@ -231,11 +232,11 @@ static int hook_unix_stream_connect(struct sock *const sock,
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
@@ -245,7 +246,8 @@ static int hook_unix_may_send(struct socket *const sock,
 	if (unix_peer(sock->sk) == other->sk)
 		return 0;
 
-	if (is_abstract_socket(other->sk) && sock_is_scoped(other->sk, dom))
+	if (is_abstract_socket(other->sk) &&
+	    sock_is_scoped(other->sk, subject->domain))
 		return -EPERM;
 
 	return 0;
@@ -257,15 +259,12 @@ static const struct access_masks signal_scope = {
 
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
+	if (!cred) {
 		/*
 		 * Always allow sending signals between threads of the same process.
 		 * This is required for process credential changes by the Native POSIX
@@ -277,18 +276,22 @@ static int hook_task_kill(struct task_struct *const p,
 		if (same_thread_group(p, current))
 			return 0;
 
-		dom = landlock_get_current_domain();
+		/* Not dealing with USB IO. */
+		cred = current_cred();
 	}
-	dom = landlock_get_applicable_domain(dom, signal_scope);
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
2.49.0

