Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEBB3BE163
	for <linux-security-module@vger.kernel.org>; Sun, 26 Jul 2026 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785082484; cv=none; b=mLauTM6AYsxnGfufiwBmv036WTitfWwIQdJW5fBz2evmxJ3PeI6+5ZkTJU6DaAYM/EwiII82m1YcKp71jhQArRLocIFK463FfnIciOQk8sbJ64guvf57tn8+agcsyD3ItJ0KvdxVP2zVDXdzv7IV7Up4q+gqJT31p0UoorjBmRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785082484; c=relaxed/simple;
	bh=Mz5aQphNmqKfhny6yzD/ErKXn8OPWqKUy8ldjTm9M1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f10w3X/kBpmYOBCZQsIbh3akTdAM3vII8my/U60K/KvNIqMfq8hnCV81dWhMYNIguEduZ1B82CKewhxetmuw4zH8Ja9kaWsMcCL0LlSuwh19+uZfsgXcLT9080mGOMyhJwRV0zNgv1zUO1gslOpLeTmuJPC0/niHcEIQQhqm21o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OIZIxkPv; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OIZIxkPv"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h7Rcp558nzf34;
	Sun, 26 Jul 2026 18:14:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785082458;
	bh=xBKKPMSItr6KUPpHglvKXhcTuQD19DuTc239cCRnwWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OIZIxkPv6RN5ZgQ8vB3HZ22G4J3w0vw7OlX2vYNIjlwPQDpfC6HXRkg3FdmpPNE1n
	 3FuDI/GyHFfPlCClE1sn/vUWgREFhvLRv7XGWlNq45tRUQZDOWzUzHlvdSmMQXxzGh
	 btDY6CyciT1klFUCxbOHQ92YIg/Hr9syXkPmhMEA=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h7Rcn4BCszjgy;
	Sun, 26 Jul 2026 18:14:17 +0200 (CEST)
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
Subject: [PATCH v3 04/12] landlock: Rename quiet_masks to quiet_access
Date: Sun, 26 Jul 2026 18:13:49 +0200
Message-ID: <20260726161400.3010511-5-mic@digikod.net>
In-Reply-To: <20260726161400.3010511-1-mic@digikod.net>
References: <20260726161400.3010511-1-mic@digikod.net>
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
perm_masks field quiet_perm for capabilities and namespaces.
quiet_masks drops the access category and keeps the type half
("masks"), while quiet_perm keeps the category and drops the type half,
so the two read as an inconsistent pair.

Rename the base field to quiet_access, giving the symmetric,
category-named pair quiet_access/quiet_perm that also matches the UAPI
handled_access_*/quiet_access_* naming.  This is a no-functional-change
rename.

Cc: Günther Noack <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
- New patch.
---
 security/landlock/audit.c    |  4 ++--
 security/landlock/domain.h   |  4 ++--
 security/landlock/ruleset.c  |  2 +-
 security/landlock/ruleset.h  |  6 +++---
 security/landlock/syscalls.c | 10 +++++-----
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 50536c568526..4f357a7f8532 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -625,7 +625,7 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 		 */
 		const access_mask_t quiet_mask =
 			pick_access_mask_for_request_type(
-				request->type, youngest_denied->quiet_masks);
+				request->type, youngest_denied->quiet_access);
 
 		quiet_applicable_to_access = (quiet_mask & missing) == missing;
 	} else {
@@ -634,7 +634,7 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 		 * We check request->type to distinguish between the two cases.
 		 */
 		const access_mask_t quiet_mask =
-			youngest_denied->quiet_masks.scope;
+			youngest_denied->quiet_access.scope;
 
 		switch (request->type) {
 		case LANDLOCK_REQUEST_SCOPE_SIGNAL:
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 2a1660e3dea7..56cceed5f50c 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -112,10 +112,10 @@ struct landlock_hierarchy {
 		 */
 		log_new_exec : 1;
 	/**
-	 * @quiet_masks: Bitmasks of access that should be quieted (i.e. not
+	 * @quiet_access: Bitmasks of access that should be quieted (i.e. not
 	 * logged) if the related object is marked as quiet.
 	 */
-	struct access_masks quiet_masks;
+	struct access_masks quiet_access;
 #endif /* CONFIG_AUDIT */
 };
 
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 4dd09ea22c84..6bccba2ec1ac 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -588,7 +588,7 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
 		return ERR_PTR(err);
 
 #ifdef CONFIG_AUDIT
-	new_dom->hierarchy->quiet_masks = ruleset->quiet_masks;
+	new_dom->hierarchy->quiet_access = ruleset->quiet_access;
 #endif /* CONFIG_AUDIT */
 
 	return no_free_ptr(new_dom);
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 0437adf17428..f1fdad1d528e 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -157,7 +157,7 @@ struct landlock_ruleset {
 		 * section.  This is only used by
 		 * landlock_put_ruleset_deferred() when @usage reaches zero.
 		 * The fields @lock, @usage, @num_rules, @num_layers,
-		 * @quiet_masks and @access_masks are then unused.
+		 * @quiet_access and @access_masks are then unused.
 		 */
 		struct work_struct work_free;
 		struct {
@@ -184,11 +184,11 @@ struct landlock_ruleset {
 			 */
 			u32 num_layers;
 			/**
-			 * @quiet_masks: Stores the quiet flags for an unmerged
+			 * @quiet_access: Stores the quiet flags for an unmerged
 			 * ruleset.  For a merged domain, this is stored in each
 			 * layer's struct landlock_hierarchy instead.
 			 */
-			struct access_masks quiet_masks;
+			struct access_masks quiet_access;
 			/**
 			 * @access_masks: Contains the subset of filesystem and
 			 * network actions that are restricted by a ruleset.
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 36b02892c62f..66a852e5aaf0 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -277,9 +277,9 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	if (IS_ERR(ruleset))
 		return PTR_ERR(ruleset);
 
-	ruleset->quiet_masks.fs = ruleset_attr.quiet_access_fs;
-	ruleset->quiet_masks.net = ruleset_attr.quiet_access_net;
-	ruleset->quiet_masks.scope = ruleset_attr.quiet_scoped;
+	ruleset->quiet_access.fs = ruleset_attr.quiet_access_fs;
+	ruleset->quiet_access.net = ruleset_attr.quiet_access_net;
+	ruleset->quiet_access.scope = ruleset_attr.quiet_scoped;
 
 	/* Creates anonymous FD referring to the ruleset. */
 	ruleset_fd = anon_inode_getfd("[landlock-ruleset]", &ruleset_fops,
@@ -372,7 +372,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 		return -EINVAL;
 
 	/* Checks for useless quiet flag. */
-	if (flags & LANDLOCK_ADD_RULE_QUIET && !ruleset->quiet_masks.fs)
+	if (flags & LANDLOCK_ADD_RULE_QUIET && !ruleset->quiet_access.fs)
 		return -EINVAL;
 
 	/* Gets and checks the new rule. */
@@ -413,7 +413,7 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
 		return -EINVAL;
 
 	/* Checks for useless quiet flag. */
-	if (flags & LANDLOCK_ADD_RULE_QUIET && !ruleset->quiet_masks.net)
+	if (flags & LANDLOCK_ADD_RULE_QUIET && !ruleset->quiet_access.net)
 		return -EINVAL;
 
 	/* Denies inserting a rule with port greater than 65535. */
-- 
2.54.0

