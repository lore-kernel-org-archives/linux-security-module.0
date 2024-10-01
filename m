Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EA41C1733
	for <linux-security-module@vger.kernel.org>; Tue,  1 Oct 2024 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792976; cv=none; b=nX9WA0pU9BnDcyR/xutxOE1wn4yQ6JO5ZYcFKGyiE/UF4Meuw9fn1htoiPb3OfxiZQzE/+GFHXG7cD2aP2n30OWhw+OlAUi83Tbpxj9xMHcMAKSZz2MA4Hg18uRJi8OnhnrTjtpAXAWChGWInmHdypmpDQ/hecRToeFmUkGY6iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792976; c=relaxed/simple;
	bh=ueKXlRKbUxKgW/VYitwtQFQ3oZkGIkwxW/mJgtz7r7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHjh1DUoDNSLFvpPNzsQMy3LJXsDZyzG5hfKrpQru08J/0EOxAq2W9honw7Di9L5tRRgctJxHeSYwIy+JBceJrDorpIOqnNUACaMAVP9eJL6G19Vzp85LP7XHd6xi46rRnA3m7Rd9xabI51bsNeyZ118UOtZ0kfryMkV1wpXxVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QJi0lLhu; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QJi0lLhu"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XJ0JZ0dnZz4fm;
	Tue,  1 Oct 2024 16:12:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1727791965;
	bh=Dj0MGq2F7eT7dWux7TQJIkSeSK0bidTDsqd/S578HcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QJi0lLhu4AnjRR2h9kdlOuBQ6LsMCmMm+0cDxL8LofGgcPPVvrppWmdhskTd6WASl
	 7oygurNxglPypTxibL5oxxydqsRCd9bgfaK+KdXUKs2yPVEfYDEzEWaCP4X47k0Kdr
	 E7HAIh/kTwCA+/mc1wINsc4UxfGavJOsz1TQaLGw=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XJ0JY2RsbzYqn;
	Tue,  1 Oct 2024 16:12:45 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1 3/3] landlock: Optimize scope enforcement
Date: Tue,  1 Oct 2024 16:12:34 +0200
Message-ID: <20241001141234.397649-4-mic@digikod.net>
In-Reply-To: <20241001141234.397649-1-mic@digikod.net>
References: <20241001141234.397649-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Do not walk through the domain hierarchy when the required scope is not
supported by this domain.  This is the same approach as for filesystem
and network restrictions.

Cc: Günther Noack <gnoack@google.com>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241001141234.397649-4-mic@digikod.net
---
 security/landlock/task.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/security/landlock/task.c b/security/landlock/task.c
index 4acbd7c40eee..02e3a0330b21 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -204,12 +204,22 @@ static bool is_abstract_socket(struct sock *const sock)
 	return false;
 }
 
+static const struct landlock_ruleset *get_current_unix_scope_domain(void)
+{
+	const union access_masks unix_scope = {
+		.scope = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+	};
+
+	return landlock_filter_access_masks(landlock_get_current_domain(),
+					    unix_scope);
+}
+
 static int hook_unix_stream_connect(struct sock *const sock,
 				    struct sock *const other,
 				    struct sock *const newsk)
 {
 	const struct landlock_ruleset *const dom =
-		landlock_get_current_domain();
+		get_current_unix_scope_domain();
 
 	/* Quick return for non-landlocked tasks. */
 	if (!dom)
@@ -225,7 +235,7 @@ static int hook_unix_may_send(struct socket *const sock,
 			      struct socket *const other)
 {
 	const struct landlock_ruleset *const dom =
-		landlock_get_current_domain();
+		get_current_unix_scope_domain();
 
 	if (!dom)
 		return 0;
@@ -243,6 +253,10 @@ static int hook_unix_may_send(struct socket *const sock,
 	return 0;
 }
 
+static const union access_masks signal_scope = {
+	.scope = LANDLOCK_SCOPE_SIGNAL,
+};
+
 static int hook_task_kill(struct task_struct *const p,
 			  struct kernel_siginfo *const info, const int sig,
 			  const struct cred *const cred)
@@ -256,6 +270,7 @@ static int hook_task_kill(struct task_struct *const p,
 	} else {
 		dom = landlock_get_current_domain();
 	}
+	dom = landlock_filter_access_masks(dom, signal_scope);
 
 	/* Quick return for non-landlocked tasks. */
 	if (!dom)
@@ -279,7 +294,8 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 
 	/* Lock already held by send_sigio() and send_sigurg(). */
 	lockdep_assert_held(&fown->lock);
-	dom = landlock_file(fown->file)->fown_domain;
+	dom = landlock_filter_access_masks(
+		landlock_file(fown->file)->fown_domain, signal_scope);
 
 	/* Quick return for unowned socket. */
 	if (!dom)
-- 
2.46.1

