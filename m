Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C611E1A0BFE
	for <linux-security-module@vger.kernel.org>; Tue, 22 Oct 2024 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729609927; cv=none; b=aV+c7lyHausmr6MyxbUCowXW3Ch6IdcC11r/sE4Q2Tm5RnqAKBsOVCQ1h+06/1xpPgH2IlnI17BJifhyv8+7KkeDvpJO7H/YzFRpdwpCMmmgRi0eDjXUsukktWRvAzAxvMmG1RR+7bvU5AvoLGQxzYCBP2I4tzWEiHFbUd8q15s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729609927; c=relaxed/simple;
	bh=ttehDRu/BQ2EsW3iyyOpqOC3g89gxXwwmrIXLAuBUls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rGPyo/CBcn6C7Qa4YcRUUuJir59+dd4OcasAqNBR/HaROL8/42ionIUgl9vkdXfe/TgDHC2UCFjitW1h7cSF7tVD9j0YNV7BZnQCMU2Ke4z5DX9IQINwOFMRepoQUEBFQC+iHC7qFtsuW1t5Pjcav/+tMjYBcKe867dtfGwUDBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=reSb7drY; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="reSb7drY"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XXwd62r4Gz15M7;
	Tue, 22 Oct 2024 17:11:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1729609914;
	bh=F3JTnNBrR61BG9SkzQdBs2fguuO/JxFeJX4GZIdKhPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=reSb7drYEUJ4lsm5y/5SDeZuRZCVeMklmzhMXdBS885TLGLeB4rRsrb+gvMnP+txN
	 dOXyIbOitzzkQ37ud6QF1xuEQOHfTqEng5DQbHAUNLIRJfWay0ovy7lUSOvXhMWkPO
	 c5HOTNEeiEhxU1BtkYcyLaRsg+j1+7bzgA3eWunM=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XXwd56Hb2zYnT;
	Tue, 22 Oct 2024 17:11:53 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 3/3] landlock: Optimize scope enforcement
Date: Tue, 22 Oct 2024 17:11:44 +0200
Message-ID: <20241022151144.872797-4-mic@digikod.net>
In-Reply-To: <20241022151144.872797-1-mic@digikod.net>
References: <20241022151144.872797-1-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20241022151144.872797-4-mic@digikod.net
---

Changes since v2:
* Make the unix_scope variable global to the file and remove
  previous get_current_unix_scope_domain().
---
 security/landlock/task.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/security/landlock/task.c b/security/landlock/task.c
index 4acbd7c40eee..e7f45af87ff5 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -204,12 +204,16 @@ static bool is_abstract_socket(struct sock *const sock)
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
-	const struct landlock_ruleset *const dom =
-		landlock_get_current_domain();
+	const struct landlock_ruleset *const dom = landlock_match_ruleset(
+		landlock_get_current_domain(), unix_scope);
 
 	/* Quick return for non-landlocked tasks. */
 	if (!dom)
@@ -224,8 +228,8 @@ static int hook_unix_stream_connect(struct sock *const sock,
 static int hook_unix_may_send(struct socket *const sock,
 			      struct socket *const other)
 {
-	const struct landlock_ruleset *const dom =
-		landlock_get_current_domain();
+	const struct landlock_ruleset *const dom = landlock_match_ruleset(
+		landlock_get_current_domain(), unix_scope);
 
 	if (!dom)
 		return 0;
@@ -243,6 +247,10 @@ static int hook_unix_may_send(struct socket *const sock,
 	return 0;
 }
 
+static const struct access_masks signal_scope = {
+	.scope = LANDLOCK_SCOPE_SIGNAL,
+};
+
 static int hook_task_kill(struct task_struct *const p,
 			  struct kernel_siginfo *const info, const int sig,
 			  const struct cred *const cred)
@@ -256,6 +264,7 @@ static int hook_task_kill(struct task_struct *const p,
 	} else {
 		dom = landlock_get_current_domain();
 	}
+	dom = landlock_match_ruleset(dom, signal_scope);
 
 	/* Quick return for non-landlocked tasks. */
 	if (!dom)
@@ -279,7 +288,8 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 
 	/* Lock already held by send_sigio() and send_sigurg(). */
 	lockdep_assert_held(&fown->lock);
-	dom = landlock_file(fown->file)->fown_domain;
+	dom = landlock_match_ruleset(landlock_file(fown->file)->fown_domain,
+				     signal_scope);
 
 	/* Quick return for unowned socket. */
 	if (!dom)
-- 
2.47.0

