Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC286E7D0A2
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Sep 2023 20:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjIUUKn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 21 Sep 2023 16:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjIUUKX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 Sep 2023 16:10:23 -0400
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5931FA9FC
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 10:07:29 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RrlYB1SMrzMqhBb;
        Thu, 21 Sep 2023 06:17:02 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RrlY94vr5zMpnPm;
        Thu, 21 Sep 2023 08:17:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1695277022;
        bh=pwiClldhXZTIfu2VonXNuU9Opgc7X09SctOzocW98K0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KkZZDXG0h5eg5qf9E5uRpx65dfe7+huAplBMEQEh2rZJAX7DRa8SoWlQwaBZsd4md
         hMgYWcsBPnorxQyG6aAANU34q5RipSKJIFqxAR4pakJujsnoKb1KohJ9LUfeitYlEv
         fj+woUen9V4VTxCXcOd9rMxfs3wKs5gaJOOziVXQ=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Ben Scarlato <akhna@google.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
        Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@google.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shervin Oloumi <enlightened@google.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [RFC PATCH v1 4/7] landlock: Log domain creation and enforcement
Date:   Thu, 21 Sep 2023 08:16:38 +0200
Message-ID: <20230921061641.273654-5-mic@digikod.net>
In-Reply-To: <20230921061641.273654-1-mic@digikod.net>
References: <20230921061641.273654-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add audit support for domain creation, i.e. task self-restriction.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/audit.c    | 24 ++++++++++++++++++++++++
 security/landlock/audit.h    |  8 ++++++++
 security/landlock/syscalls.c |  4 ++++
 3 files changed, 36 insertions(+)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index f58bd529784a..d9589d07e126 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -84,6 +84,30 @@ void landlock_log_create_ruleset(struct landlock_ruleset *const ruleset)
 	audit_log_end(ab);
 }
 
+void landlock_log_restrict_self(struct landlock_ruleset *const domain,
+				struct landlock_ruleset *const ruleset)
+{
+	struct audit_buffer *ab;
+
+	WARN_ON_ONCE(domain->id);
+	WARN_ON_ONCE(!ruleset->id);
+
+	ab = audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_LANDLOCK);
+	if (!ab)
+		/* audit_log_lost() call */
+		return;
+
+	domain->hierarchy->id =
+		atomic64_inc_return(&ruleset_and_domain_counter);
+	log_task(ab);
+	audit_log_format(ab, " op=restrict-self domain=%llu ruleset=%llu",
+			 domain->hierarchy->id, ruleset->id);
+	audit_log_format(
+		ab, " parent=%llu",
+		domain->hierarchy->parent ? domain->hierarchy->parent->id : 0);
+	audit_log_end(ab);
+}
+
 /*
  * This is useful to know when a domain or a ruleset will never show again in
  * the audit log.
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 2666e9151627..bc17dc8ca6f1 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -16,6 +16,8 @@
 #ifdef CONFIG_AUDIT
 
 void landlock_log_create_ruleset(struct landlock_ruleset *const ruleset);
+void landlock_log_restrict_self(struct landlock_ruleset *const domain,
+				struct landlock_ruleset *const ruleset);
 void landlock_log_release_ruleset(const struct landlock_ruleset *const ruleset);
 
 #else /* CONFIG_AUDIT */
@@ -25,6 +27,12 @@ landlock_log_create_ruleset(struct landlock_ruleset *const ruleset)
 {
 }
 
+static inline void
+landlock_log_restrict_self(struct landlock_ruleset *const domain,
+			   struct landlock_ruleset *const ruleset)
+{
+}
+
 static inline void
 landlock_log_release_ruleset(const struct landlock_ruleset *const ruleset)
 {
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 373997a356e7..bfe5417a06c3 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -452,6 +452,10 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	landlock_put_ruleset(new_llcred->domain);
 	new_llcred->domain = new_dom;
 
+	// FIXME: Must be atomic between the ruleset merge and the audit log to
+	// be sure about the content of the domain.
+	// -> move mutex_lock() from merge_ruleset() into this function
+	landlock_log_restrict_self(new_dom, ruleset);
 	landlock_put_ruleset(ruleset);
 	return commit_creds(new_cred);
 
-- 
2.42.0

