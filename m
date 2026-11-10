Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.16.66.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342302;
	b=zkjThf54Ih5IJpEtWcqjZ4pgHHxYKfwBCrz9yxPxWayW7op3fzwyIc2BkopCMiYd9nI0
	 rgRUB/tPBzgqYcu0iqzrHxZ+9+JXd7vmhvKNXkJPiFagUlFlBrDfujggZNFGYURKsc+FO
	 FMnYBkI62Gov+13EnhyW9/QpdijVRVgZcRKefeKJMALqZe7EFfIHKBQcUQqTPxBHRebjS
	 InVgasMFUESdju4tQO08Um0rr8lUR58zHX2dbRoygzchNIYa2WG0Vk39XNpuKWGrTe28E
	 cGQEujOS3ePADac96ngmorjBmBrJGnMxnLQPX8Ina0r/AbwSdJ60s4gJhIS7OjMrT2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342302;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=cF0dc9SB7H3n8clV0PrCFTwVXEjjZ7lGtzPqgU8lQR8=;
	b=iIXzEH23uzWVHZGuyO+bIesM+Bs2R9pAaLV2ZevHZoY4PkzmTdKuzXdSo56wjaJi5ULk
	 vRGnHaT6y9/MeiFxygefKnCo9utDuot8hlrFnv5/YI+RoRceQUdhjju4tv+eA9RLmZOnJ
	 hdG5L0jkYnBd/0xHB2HziVJC6hRgNHJ9neMaXmzoJvWLalwZbIFSQfQxyBjrAQgnq370N
	 wDXMIdzWyApan2QVqVBt2LiuG6Gomo2DAhsAHOOC6rcCPdXoYb9JCvPxc6gtpp9f7oP3x
	 RyutHsu+kTZvh0ytL0xkmlbuV+j6FqoGxXtlWQqNLNcJCkLECqkl06Ty/JKNy9hnOlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=chUSnFW+;
	arc=none smtp.remote-ip=84.16.66.169
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBB160A3828
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FBB160A3828
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=chUSnFW+
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPJ6Y5w7MzDt3;
	Tue, 10 Nov 2026 21:24:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794342293;
	bh=cF0dc9SB7H3n8clV0PrCFTwVXEjjZ7lGtzPqgU8lQR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=chUSnFW+jDa0jsbASZFfDf/DhdsC/XgdBT5uaGDXuwFGFA+Qup8K43aYkQKWDnNkR
	 gcRP+fyutaHNVjHylxPvo4CgbxkyLTVExLo9429StLXqbXfx1TLDBmbjk1jFDhC/Wp
	 t+gp5CuS0y/XBCGdfuCPEaRavnjIHJ/3zyJwAcgI=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4jPJ6X48NBzr9F;
	Tue, 10 Nov 2026 21:24:52 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ada Smith <adasmithgt@gmail.com>,
	Hungyu Lin <dennylin0707@gmail.com>,
	James Morris <jmorris@namei.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 6/6] landlock: Fix capability restriction documentation
Date: Tue, 10 Nov 2026 21:24:34 +0100
Message-ID: <20261110202436.2408244-7-mic@digikod.net>
In-Reply-To: <20261110202436.2408244-1-mic@digikod.net>
References: <20261110202436.2408244-1-mic@digikod.net>
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
exceptions, and call it a permission instead of a hook.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>
Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 Documentation/security/landlock.rst      | 8 ++++----
 Documentation/userspace-api/landlock.rst | 8 ++++----
 include/uapi/linux/landlock.h            | 6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

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
index 24510e5d8479..c9e4ce23778b 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -622,9 +622,9 @@ struct landlock_capability_attr {
  * - %LANDLOCK_PERMISSION_CAPABILITY_USE: Restrict the use of specific Linux
  *   capabilities.  A process in a Landlock domain that handles this permission
  *   is denied from exercising capabilities that are not explicitly allowed by a
- *   %LANDLOCK_RULE_CAPABILITY rule.  This hook is purely restrictive: it can
- *   deny capabilities that the kernel would otherwise grant, but it can never
- *   grant capabilities that the kernel already denied.  Support added in
+ *   %LANDLOCK_RULE_CAPABILITY rule.  This permission is purely restrictive: it
+ *   can deny capabilities that the kernel would otherwise grant, but it can
+ *   never grant capabilities that the kernel already denied.  Support added in
  *   Landlock ABI version 12.
  */
 #define LANDLOCK_PERMISSION_NAMESPACE_USE			(1ULL << 0)
-- 
2.56.0

