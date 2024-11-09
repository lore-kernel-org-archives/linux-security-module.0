Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B896154C12
	for <linux-security-module@vger.kernel.org>; Sat,  9 Nov 2024 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731151516; cv=none; b=lhuWV77aJ54QgdWew/Lmw+cN7cVn/JGvcSR7k4T1npFzX4tTIj/NQXI21NguuDcZEswOGkULci01lhUXAIaqWiBD5FuVQqSjT5sBbQ+ZEjPyP4D5UaSHgeum0Uc/UyhA5wJZMYTUkN4WHzN2suPD6XbmE+SkBqRQO/pFtIEiIMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731151516; c=relaxed/simple;
	bh=Ia5hTMOLKaax1IxZmH3a+EoHfBXcP6f9RKCxsxQBfmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVEwUbeBw5ccuCt57jM7rzNPxfJ6C10g2yRqDPo6xDV+Y8P7lU+DvmZk9YEOJJ7KnP8UT20wnbHsbC42WwcZbOvWbdpNPW7NmMbzFwR2cnJzPbCS5lrTTYkQrVlpYIUs1YvSvYd/LvcfTjPzSmZ3Wd6PTysiRBI4VDZsiTtVzAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=JC/H7GsM; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="JC/H7GsM"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XltNj07LFz7xw;
	Sat,  9 Nov 2024 12:09:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1731150548;
	bh=UvZP4U1+PJ/HP+QehB8ZwzNPYbHZqDuMCkn9yYHrC3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JC/H7GsMStKSqzeD1NZosXeyyUeQOuqhko9No2y8QPs0y7ipm/a2oxl3KMS9JrwBz
	 UIlFrTXzhTCH3eHsiNL4T+EDA+mUDvUjK/pOsrsL3ulg5CYAae6+s2eL8IaAOG35/h
	 0mHD1IQ8PqfeTgS5Q0QxHqiON1/KrnFQ2eHdNVGM=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XltNh1qDFzs4C;
	Sat,  9 Nov 2024 12:09:08 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 3/3] landlock: Optimize scope enforcement
Date: Sat,  9 Nov 2024 12:08:56 +0100
Message-ID: <20241109110856.222842-4-mic@digikod.net>
In-Reply-To: <20241109110856.222842-1-mic@digikod.net>
References: <20241109110856.222842-1-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20241109110856.222842-4-mic@digikod.net
---

Changes since v2:
* Make the unix_scope variable global to the file and remove
  previous get_current_unix_scope_domain().
---
 security/landlock/task.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/security/landlock/task.c b/security/landlock/task.c
index 4acbd7c40eee..dc7dab78392e 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -204,12 +204,17 @@ static bool is_abstract_socket(struct sock *const sock)
 	return false;
 }
 
+static const struct access_masks unix_scope = {
+	.scope = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+};
+
 static int hook_unix_stream_connect(struct sock *const sock,
 				    struct sock *const other,
 				    struct sock *const newsk)
 {
 	const struct landlock_ruleset *const dom =
-		landlock_get_current_domain();
+		landlock_get_applicable_domain(landlock_get_current_domain(),
+					       unix_scope);
 
 	/* Quick return for non-landlocked tasks. */
 	if (!dom)
@@ -225,7 +230,8 @@ static int hook_unix_may_send(struct socket *const sock,
 			      struct socket *const other)
 {
 	const struct landlock_ruleset *const dom =
-		landlock_get_current_domain();
+		landlock_get_applicable_domain(landlock_get_current_domain(),
+					       unix_scope);
 
 	if (!dom)
 		return 0;
@@ -243,6 +249,10 @@ static int hook_unix_may_send(struct socket *const sock,
 	return 0;
 }
 
+static const struct access_masks signal_scope = {
+	.scope = LANDLOCK_SCOPE_SIGNAL,
+};
+
 static int hook_task_kill(struct task_struct *const p,
 			  struct kernel_siginfo *const info, const int sig,
 			  const struct cred *const cred)
@@ -256,6 +266,7 @@ static int hook_task_kill(struct task_struct *const p,
 	} else {
 		dom = landlock_get_current_domain();
 	}
+	dom = landlock_get_applicable_domain(dom, signal_scope);
 
 	/* Quick return for non-landlocked tasks. */
 	if (!dom)
@@ -279,7 +290,8 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 
 	/* Lock already held by send_sigio() and send_sigurg(). */
 	lockdep_assert_held(&fown->lock);
-	dom = landlock_file(fown->file)->fown_domain;
+	dom = landlock_get_applicable_domain(
+		landlock_file(fown->file)->fown_domain, signal_scope);
 
 	/* Quick return for unowned socket. */
 	if (!dom)
-- 
2.47.0

