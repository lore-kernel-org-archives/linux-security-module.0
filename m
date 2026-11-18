Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.16.66.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013558;
	b=Tv35kUqNziFAOFJiUw0VARzc37UnCQh0C6FgDxMip/Wn2eTzKRgIIyCIi4xGubxOomLQ
	 KjHgSoShq0xjv4CjRVxdhT+H8kS9Oq3RuIl37YKOGu4EBpCCx00ed1CYSEkAukpfgh6y/
	 PtGCPFITQ6i8H5D9V3IOLlsEh5mSNmZBDJpcNU124DPjclAuwvPPcnDuNbd2uHRVgE6WB
	 Ank8KcNgn+hq74UOXKixKL0vJ5ue1xQChjwKE+tMoa3he/bUjOScJF8SLiCdjExoadCwP
	 F+lPbbd7Ufq2UwxxgMU6BIR+BDrOJ/w3+rhdo4NHfKVzkL7EXip+WL1kE+HdyjvQOqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013558;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=/aiNYGgyuWnsvGFztgtB90Y0bNp9E0nMWbyIXMfAW8k=;
	b=HOns4H/0rqQgI6sXUvVqqH+EA6f99KKRhUYPCmHhnCo/H7S/9daCQ+EFfiQHPwChYN9l
	 wBSfr7FAadSe6SQ7jF3HhZ+PHMCi6qAWGidPcy7o6qhrxm3E7Tg+UX4iEekrK+L7v8u1K
	 2gdwW1uyft2rSShZFpMpSOxTu/OYwMNlHBG7mCu3Ec/9hnJD5FW3rk0NHUoOwTzqa7aua
	 RaZzy2HkLwb9C0Q+iqc8EShfsGq/dN0TJU+wTE32v1gxLj6tSfi6ak6ZekVHk4qt+9Moh
	 zNwccRkeADAMPPpjKiJ8+4HiqI2Xgwl6Wb1pzT7fKWuUDnu1mpVrqCBMLDAsa6Nus4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=MdjHt7CH;
	arc=none smtp.remote-ip=84.16.66.173
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805C660A261C
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 805C660A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=MdjHt7CH
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jV4MK4fbszwqf;
	Wed, 18 Nov 2026 15:52:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1795013549;
	bh=/aiNYGgyuWnsvGFztgtB90Y0bNp9E0nMWbyIXMfAW8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MdjHt7CHaXwkK2ooAfe7ZvaEE6GZC8MmwRKrvIpKlg2YuAzNvrefHFTOGaMAiwqRy
	 F/SIdFdLKSbDW61KePxEPRt+7EHWbuLin1DoMxioC3wohEk/4M6xpbPAMYwOrJYZLy
	 ifMC2b2yXU0Y5o4v9LKBGyhdUchf19aJ4eCt8t+w=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4jV4MJ3W3rzV3w;
	Wed, 18 Nov 2026 15:52:28 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ada Smith <adasmithgt@gmail.com>,
	Hungyu Lin <dennylin0707@gmail.com>,
	James Morris <jmorris@namei.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>,
	Serge Hallyn <sergeh@kernel.org>,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 6/6] landlock: Fix capability restriction documentation
Date: Wed, 18 Nov 2026 15:52:10 +0100
Message-ID: <20261118145217.2551053-7-mic@digikod.net>
In-Reply-To: <20261118145217.2551053-1-mic@digikod.net>
References: <20261118145217.2551053-1-mic@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Some documented claims about LANDLOCK_PERMISSION_CAPABILITY_USE do not
hold for every capability check.  Remove them instead of listing their
exceptions, and stop calling this permission a hook.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>
Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
Reviewed-by: Günther Noack <gnoack@google.com>
Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
https://patch.msgid.link/20261117101157.2520463-7-mic@digikod.net
- Describe the permission as only reducing the capabilities that
  processes can use (suggested by Günther Noack).
- Add Günther Noack's Reviewed-by.

Changes since v1:
https://patch.msgid.link/20261110202436.2408244-7-mic@digikod.net
- Add Serge Hallyn's Acked-by.
---
 Documentation/security/landlock.rst      | 8 ++++----
 Documentation/userspace-api/landlock.rst | 8 ++++----
 include/uapi/linux/landlock.h            | 7 +++----
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
index d81f1c2cd236..98c2e7139e8d 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
@@ -8,7 +8,7 @@ Landlock LSM: kernel documentation
 ==================================
 
 :Author: Mickaël Salaün
-:Date: October 2026
+:Date: November 2026
 
 Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
 harden a whole system, this feature should be available to any process,
@@ -359,9 +359,9 @@ framework in ``log.c``, compiled under ``CONFIG_SECURITY_LANDLOCK_LOG``
 (automatically selected by ``CONFIG_AUDIT`` or ``CONFIG_TRACEPOINTS``).
 
 Audit records respect audit configuration, the domain's Landlock log
-flags, and ``LANDLOCK_LOG_DISABLED``.  Tracepoints fire unconditionally,
-independent of these settings.  The denial counter (``num_denials``) is
-always incremented regardless of logging configuration.
+flags, and ``LANDLOCK_LOG_DISABLED``.  Tracepoints fire independently of
+these settings.  The denial counter (``num_denials``) is
+incremented regardless of logging configuration.
 
 Each denial tracepoint carries a ``logged`` field reporting the
 audit-logging verdict: whether the denial would be written to the audit
diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 3d45b956b640..d00e94d8ed37 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: October 2026
+:Date: November 2026
 
 The goal of Landlock is to enable restriction of ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
@@ -532,7 +532,7 @@ acquisition via :manpage:`open_tree(2)` / :manpage:`fsmount(2)`.  Namespaces
 the process is already a member of when the domain is enforced are implicitly
 allowed (the process could not continue running otherwise); rules describe
 which new namespace types the process may acquire.
-``LANDLOCK_PERMISSION_CAPABILITY_USE`` gates every exercise of a capability
+``LANDLOCK_PERMISSION_CAPABILITY_USE`` gates the exercise of capabilities
 after the domain is enforced, regardless
 of how the capability was obtained (inherited credentials, ``CLONE_NEWUSER``
 grant, ``setuid``/file-cap-bearing :manpage:`execve(2)`, etc.).  Configuring
@@ -641,9 +641,9 @@ after a domain is enforced through user namespace entry or :manpage:`capset(2)`;
 privileged sandboxes that did not set ``PR_SET_NO_NEW_PRIVS`` may also gain
 capabilities through :manpage:`execve(2)` of binaries with file capabilities.
 In all cases, :manpage:`capget(2)` will report the credential's capability sets,
-but any denied capability will fail with ``EPERM`` when exercised.  Do not rely
+but any denied capability will fail when exercised.  Do not rely
 on :manpage:`capget(2)` to determine whether the policy permits a given
-capability; only the actual operation will return ``EPERM`` upon denial.
+capability.
 
 Truncating files
 ----------------
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 24510e5d8479..558a610baea5 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -622,10 +622,9 @@ struct landlock_capability_attr {
  * - %LANDLOCK_PERMISSION_CAPABILITY_USE: Restrict the use of specific Linux
  *   capabilities.  A process in a Landlock domain that handles this permission
  *   is denied from exercising capabilities that are not explicitly allowed by a
- *   %LANDLOCK_RULE_CAPABILITY rule.  This hook is purely restrictive: it can
- *   deny capabilities that the kernel would otherwise grant, but it can never
- *   grant capabilities that the kernel already denied.  Support added in
- *   Landlock ABI version 12.
+ *   %LANDLOCK_RULE_CAPABILITY rule.  Landlock only reduces the capabilities
+ *   that processes can use: it does not let them use capabilities that they
+ *   would not have without Landlock.  Support added in Landlock ABI version 12.
  */
 #define LANDLOCK_PERMISSION_NAMESPACE_USE			(1ULL << 0)
 #define LANDLOCK_PERMISSION_CAPABILITY_USE			(1ULL << 1)
-- 
2.56.0

