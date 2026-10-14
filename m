Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E1F30B517
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966460; cv=none; b=WfT8wYkeNmlmsnTaBql5uFLr7miQ+FooG395vkMAe41c2PZblvg86++pE+vy3hfeaj5BwGXTApDo/8VN9aYqzGOB3IJB4Z64V2wIa7ZFSGOzBLhvCVulSF6y69Vbv3gAqqINWs+rlk4qeQhFQst4CiM+nMMyKAs1fGwo6SHFbRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966460; c=relaxed/simple;
	bh=0U/SL+PSN1rma7aUcXW98o3MR1OFX54qyYFahOHMmqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RkLi7v3A/IT12IphNIgGiYOYM64jc6MHkCZ3N+v4u9qU/PnXYW/K+2AQ5GdQXklcgpMWBidVBVpvCeTaB4Ra7DjcGHOWuIz4uzoaiaF2CAbKFGWYz4bYsQwAH1+euVPzeDsvO3zGYFw1Tf6/Lsl54XQ8fAzpJJ7i8B+0lfNRijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=M7PIUTGi; arc=none smtp.client-ip=83.166.143.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="M7PIUTGi"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j4PTD48L6znD3;
	Wed, 14 Oct 2026 10:27:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1791966448;
	bh=Fexq3LuHYaxXlssqdkEW2nbR6F3A9k7ZxkH0ECU729g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7PIUTGiqk+OcDjXZNuGjzQVa/l6bHVt/L6KOuo2BepU5swjzBEJtAXAfBoKQAv6r
	 npS//ia1n/aPPh/vOnEvdncPwSCjA80gLnOKs+UTyKFDFdVbt1pOIXvPRrfW2xu8v/
	 1Kmi8kzW/mYiraq9mmhf39ETGAjC45PQC8D4AQVQ=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4j4PTB6d1jzlTf;
	Wed, 14 Oct 2026 10:27:26 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Daniel Durning <danieldurning.work@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>,
	kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 1/8] landlock: Rename quiet_masks to quiet_access
Date: Wed, 14 Oct 2026 10:27:07 +0200
Message-ID: <20261014082718.1435842-2-mic@digikod.net>
In-Reply-To: <20261014082718.1435842-1-mic@digikod.net>
References: <20261014082718.1435842-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The base stores the fs/net/scope quiet bitmasks in a struct access_masks
field named quiet_masks.  A following commit adds the sibling struct
permission_masks field quiet_permission for capabilities and namespaces.
quiet_masks drops the access category and keeps the type half ("masks"),
while quiet_permission keeps the category and drops the type half, so
the two read as an inconsistent pair.

Rename the base field to quiet_access, giving the symmetric,
category-named pair quiet_access/quiet_permission that also matches the
UAPI handled_access_*/quiet_access_* naming.  This is a
no-functional-change rename.

Cc: Günther Noack <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>
Reviewed-by: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v3:
https://patch.msgid.link/20260726161400.3010511-5-mic@digikod.net
- Adapt the rename to the split ruleset/domain and logging code.
- Add Reviewed-by: Tingmao Wang.

Changes since v2:
- New patch.
---
 security/landlock/domain.c   |  2 +-
 security/landlock/domain.h   |  4 ++--
 security/landlock/log.c      |  6 +++---
 security/landlock/ruleset.h  |  4 ++--
 security/landlock/syscalls.c | 10 +++++-----
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 4031b581be07..c66663f8cd8b 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -479,7 +479,7 @@ landlock_merge_ruleset(struct landlock_domain *const parent,
 		return ERR_PTR(err);
 
 #ifdef CONFIG_SECURITY_LANDLOCK_LOG
-	new_dom->hierarchy->quiet_masks = ruleset->quiet_masks;
+	new_dom->hierarchy->quiet_access = ruleset->quiet_access;
 #endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 	return no_free_ptr(new_dom);
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 428c1d9890db..61d89261e280 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -130,10 +130,10 @@ struct landlock_hierarchy {
 		 */
 		log_new_exec : 1;
 	/**
-	 * @quiet_masks: Bitmasks of access that should be quieted (i.e. not
+	 * @quiet_access: Bitmasks of access that should be quieted (i.e. not
 	 * logged) if the related object is marked as quiet.
 	 */
-	struct access_masks quiet_masks;
+	struct access_masks quiet_access;
 #endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 };
 
diff --git a/security/landlock/log.c b/security/landlock/log.c
index a8578a6f2ce9..3f9ae1bacb23 100644
--- a/security/landlock/log.c
+++ b/security/landlock/log.c
@@ -436,7 +436,7 @@ is_denial_quieted(const struct landlock_request *const request,
 	if (object_quiet_flag) {
 		const access_mask_t quiet_mask =
 			pick_access_mask_for_request_type(
-				request->type, youngest_denied->quiet_masks);
+				request->type, youngest_denied->quiet_access);
 
 		return (quiet_mask & missing) == missing;
 	}
@@ -447,10 +447,10 @@ is_denial_quieted(const struct landlock_request *const request,
 	 */
 	switch (request->type) {
 	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
-		return !!(youngest_denied->quiet_masks.scope &
+		return !!(youngest_denied->quiet_access.scope &
 			  LANDLOCK_SCOPE_SIGNAL);
 	case LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET:
-		return !!(youngest_denied->quiet_masks.scope &
+		return !!(youngest_denied->quiet_access.scope &
 			  LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
 	/*
 	 * Leave LANDLOCK_REQUEST_PTRACE and LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index cf77f1806a95..8ebdd4fa098f 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -182,11 +182,11 @@ struct landlock_ruleset {
 #endif /* CONFIG_TRACEPOINTS */
 
 	/**
-	 * @quiet_masks: Stores the quiet flags for an unmerged ruleset.  For a
+	 * @quiet_access: Stores the quiet flags for an unmerged ruleset.  For a
 	 * merged domain, this is stored in each layer's struct
 	 * landlock_hierarchy instead.
 	 */
-	struct access_masks quiet_masks;
+	struct access_masks quiet_access;
 	/**
 	 * @handled_masks: Contains the subset of filesystem and network actions
 	 * that are handled by this ruleset.
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 1d02d57f4c48..17d8e9b7b0c6 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -280,9 +280,9 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	if (IS_ERR(ruleset))
 		return PTR_ERR(ruleset);
 
-	ruleset->quiet_masks.fs = ruleset_attr.quiet_access_fs;
-	ruleset->quiet_masks.net = ruleset_attr.quiet_access_net;
-	ruleset->quiet_masks.scope = ruleset_attr.quiet_scoped;
+	ruleset->quiet_access.fs = ruleset_attr.quiet_access_fs;
+	ruleset->quiet_access.net = ruleset_attr.quiet_access_net;
+	ruleset->quiet_access.scope = ruleset_attr.quiet_scoped;
 
 	/*
 	 * Emits before anon_inode_getfd() installs the file descriptor, while
@@ -382,7 +382,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 		return -EINVAL;
 
 	/* Checks for useless quiet flag. */
-	if (flags & LANDLOCK_ADD_RULE_QUIET && !ruleset->quiet_masks.fs)
+	if (flags & LANDLOCK_ADD_RULE_QUIET && !ruleset->quiet_access.fs)
 		return -EINVAL;
 
 	/* Gets and checks the new rule. */
@@ -423,7 +423,7 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
 		return -EINVAL;
 
 	/* Checks for useless quiet flag. */
-	if (flags & LANDLOCK_ADD_RULE_QUIET && !ruleset->quiet_masks.net)
+	if (flags & LANDLOCK_ADD_RULE_QUIET && !ruleset->quiet_access.net)
 		return -EINVAL;
 
 	/* Denies inserting a rule with port greater than 65535. */
-- 
2.55.0

