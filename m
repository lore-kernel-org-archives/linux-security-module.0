Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B760C56202
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Nov 2020 21:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7307216FD
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Nov 2020 21:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgKKVe5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 11 Nov 2020 16:34:57 -0500
Received: from smtp-bc0a.mail.infomaniak.ch ([45.157.188.10]:33085 "EHLO
        smtp-bc0a.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727282AbgKKVe5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Nov 2020 16:34:57 -0500
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CWdL733bMzlhdRK;
        Wed, 11 Nov 2020 22:34:55 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4CWdL71P1wzlh8T6;
        Wed, 11 Nov 2020 22:34:55 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 9/9] landlock: Extend documentation about limitations
Date:   Wed, 11 Nov 2020 22:34:42 +0100
Message-Id: <20201111213442.434639-10-mic@digikod.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111213442.434639-1-mic@digikod.net>
References: <20201111213442.434639-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Explain limitations for the maximum number of stacked ruleset, and the
memory usage restrictions.

Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 Documentation/userspace-api/landlock.rst | 17 +++++++++++++++++
 security/landlock/syscall.c              |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 8f727de20479..7e83e5def1bc 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -186,6 +186,23 @@ Enforcing a ruleset
 Current limitations
 ===================
 
+Ruleset layers
+--------------
+
+There is a limit of 64 layers of stacked rulesets.  This can be an issue for a
+task willing to enforce a new ruleset in complement to its 64 inherited
+rulesets.  Once this limit is reached, sys_landlock_enforce_ruleset_current()
+returns E2BIG.  It is then strongly suggested to carefully build rulesets once
+in the life of a thread, especially for applications able to launch other
+applications which may also want to sandbox themselves (e.g. shells, container
+managers, etc.).
+
+Memory usage
+------------
+
+Kernel memory allocated to create rulesets is accounted and can be restricted
+by the :doc:`/admin-guide/cgroup-v1/memory`.
+
 File renaming and linking
 -------------------------
 
diff --git a/security/landlock/syscall.c b/security/landlock/syscall.c
index 543ae36cd339..045bcac79e17 100644
--- a/security/landlock/syscall.c
+++ b/security/landlock/syscall.c
@@ -361,6 +361,8 @@ SYSCALL_DEFINE4(landlock_add_rule,
  * - EPERM: @ruleset_fd has no read access to the underlying ruleset, or the
  *   current thread is not running with no_new_privs, or it doesn't have
  *   CAP_SYS_ADMIN in its namespace.
+ * - E2BIG: The maximum number of stacked rulesets is reached for the current
+ *   task.
  */
 SYSCALL_DEFINE2(landlock_enforce_ruleset_current,
 		const int, ruleset_fd, const __u32, flags)
-- 
2.29.2

