Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB76720F090
	for <linux-security-module@vger.kernel.org>; Wed, 16 Apr 2025 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744818460; cv=none; b=LCqe1Os5RQ7UKwyQSg/y2X5DWVxDn8qZzbH8ugyjbHo/LeghpssUt9dDJhfDpK5wPxDmagkkhN5MTXugcoITozFSe5WIMszAUVWsZwYcE3+tSDwKzrshkFziT4GZKVI7V2VdJ200+PohkChYMJpWMLeZ88Psgv2hakCtxCADwwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744818460; c=relaxed/simple;
	bh=SKdgVwJ3B/QAoYs/cq0+2AuMhB96fY/juGltdML2hoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mq/KD3U5BKMIguSuZVJUrDTEN6zi68eD0lNlaLlK2o+fgJBloExKxEv532tou5agWT1HjsCI1HeNbBDu8lOiEsPMO1R8Eti7ATHI8d6gF4g+EgySOYQslshAODYnHvmLKoWwn+1AJCuWQUpQ+sBNZy9BpG+oclDA1qW/2LNEU0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=kTOvehOi; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="kTOvehOi"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Zd54w5JqWzWMk;
	Wed, 16 Apr 2025 17:47:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1744818448;
	bh=Qqdle/3GA0+h4fFIpiAU9PmEUG/kG/uBYpe7KdmFvzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kTOvehOiUeCLYAk2HA0w4rA3ghX1p7wGhJ/I0yN+47PM4jwxtEc0qVwFPOmDuaU+P
	 hSMB95d4OIWBiuRqfy+c9oEkUFlqGuLTf0iYLQQAXuOnrfAmPsxbYgtQ8AfY17FS7y
	 Yxw075sbIsuGiRYg+1joyhcMRSlYLYzRe9IPHdCA=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Zd54w2K5LzG13;
	Wed, 16 Apr 2025 17:47:28 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH v1 3/3] landlock: Update log documentation
Date: Wed, 16 Apr 2025 17:47:13 +0200
Message-ID: <20250416154716.1799902-3-mic@digikod.net>
In-Reply-To: <20250416154716.1799902-1-mic@digikod.net>
References: <20250416154716.1799902-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Fix and improve documentation related to landlock_restrict_self(2)'s
flags.  Update the LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF
documentation according to the current semantic.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/uapi/linux/landlock.h | 64 +++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 8b2a1dc5c70b..f030adc462ee 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -74,37 +74,49 @@ struct landlock_ruleset_attr {
  *
  * **Flags**
  *
+ * By default, denied accesses originating from programs that sandbox themselves
+ * are logged via the audit subsystem. Such events typically indicate unexpected
+ * behavior, such as bugs or exploitation attempts. However, to avoid excessive
+ * logging, access requests denied by a domain not created by the originating
+ * program are not logged by default. The rationale is that programs should know
+ * their own behavior, but not necessarily the behavior of other programs.  This
+ * default configuration is suitable for most programs that sandbox themselves.
+ * For specific use cases, the following flags allow programs to modify this
+ * default logging behavior.
+ *
+ * The %LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF and
+ * %LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON flags apply to the newly created
+ * Landlock domain.
+ *
  * %LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF
- *     Do not create any log related to the enforced restrictions.  This should
- *     only be set by tools launching unknown or untrusted programs (e.g. a
- *     sandbox tool, container runtime, system service manager).  Because
- *     programs sandboxing themselves should fix any denied access, they should
- *     not set this flag to be aware of potential issues reported by system's
- *     logs (i.e. audit).
+ *     Disables logging of denied accesses originating from the thread creating
+ *     the Landlock domain, as well as its children, as long as they continue
+ *     running the same executable code (i.e., without an intervening
+ *     :manpage:`execve(2)` call). This is intended for programs that execute
+ *     unknown code without invoking :manpage:`execve(2)`, such as script
+ *     interpreters. Programs that only sandbox themselves should not set this
+ *     flag, so users can be notified of unauthorized access attempts via system
+ *     logs.
  *
  * %LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON
- *     Explicitly ask to continue logging denied access requests even after an
- *     :manpage:`execve(2)` call.  This flag should only be set if all the
- *     programs than can legitimately be executed will not try to request a
- *     denied access (which could spam audit logs).
+ *     Enables logging of denied accesses after an :manpage:`execve(2)` call,
+ *     providing visibility into unauthorized access attempts by newly executed
+ *     programs within the created Landlock domain. This flag is recommended
+ *     only when all potential executables in the domain are expected to comply
+ *     with the access restrictions, as excessive audit log entries could make
+ *     it more difficult to identify critical events.
  *
  * %LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF
- *     Do not create any log related to the enforced restrictions coming from
- *     future nested domains created by the caller or its descendants.  This
- *     should only be set according to a runtime configuration (i.e. not
- *     hardcoded) by programs launching other unknown or untrusted programs that
- *     may create their own Landlock domains and spam logs.  The main use case
- *     is for container runtimes to enable users to mute buggy sandboxed
- *     programs for a specific container image.  Other use cases include
- *     sandboxer tools and init systems.  Unlike
- *     ``LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF``,
- *     ``LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF`` does not impact the
- *     requested restriction (if any) but only the future nested domains.
- *
- *     It is allowed to only pass the
- *     ``LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF`` flag with a @ruleset_fd
- *     value of -1.
- *
+ *     Disables logging of denied accesses originating from nested Landlock
+ *     domains created by the caller or its descendants. This flag should be set
+ *     according to runtime configuration, not hardcoded, to avoid suppressing
+ *     important security events. It is useful for container runtimes or
+ *     sandboxing tools that may launch programs which themselves create
+ *     Landlock domains and could otherwise generate excessive logs. Unlike
+ *     ``LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF``, this flag only affects
+ *     future nested domains, not the one being created. It can also be used
+ *     with a @ruleset_fd value of -1 to mute subdomain logs without creating a
+ *     domain.
  */
 /* clang-format off */
 #define LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF		(1U << 0)
-- 
2.49.0

