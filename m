Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.25.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910345;
	b=PQ8keSGDm+/GSwJkqdKey9MjlHXbP6DjsJpfUBgDwFNfCyztYv+fGJXxs7LuxFh2hAsf
	 /BI+NioPa7su/oC8cCpatEzatsdnOmudBPW1wdHVqAdRFH/ohX7o1BwaXvZoerNonsQHV
	 UPkF4MwZCnqZTREhdAmqoYuObxVmfNp9rB2Wys3xGK3X6zdAlJASnGIKPINZpTB4g2YYk
	 DcC/htAT2R9F13EFzN2RyyCqdrmhAqVmgYZfnwMQ5+0btPvkeZvy9eDLxpaI1vgJYGLWo
	 c8mqNAl2Cf+OQj2jVSIbhLxdwzWyPGPQUOm59goITueA7VpiXVvBzhUvznXugW+prTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910345;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=xggr5r67mgtsncjai9+raBgXLmmgGHLeb0qXzYc0Ynk=;
	b=dxP6V3pmqcII3HXHQwe4AdenwxfkfOiWrABJaxjapxjqfkDZivrfTIjIKgqLNyS399Yp
	 nWRSZFD5/a6HetWwqazOLLTsO25KjhXloCGA/RoBZ9o2bA9j3KFXCebtbXxClPq24eOCd
	 YVR5TX/VWKY0Z3i21g5o7jVcWK09G9m3On5qu5EwC4tMTVQFm8aMVCKAOPI6C250XJHRF
	 IcNITm14zXBNbCMf6kcC9PZ11BeUwEGXTRsX3s4PIsKDJmP/TRggu4MCjugbxsRkW4mn1
	 O89hVK4xN6eXaleVBeiAiVrR572BcxvOdTKbXl3ORSnMQRq6iayP7hBZTcMbQmda1OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=nHRs58PR;
	arc=none smtp.remote-ip=185.125.25.15
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4C9606A8AD
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 10:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F4C9606A8AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=nHRs58PR
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTLBS5926zNyb;
	Tue, 17 Nov 2026 11:12:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794910336;
	bh=xggr5r67mgtsncjai9+raBgXLmmgGHLeb0qXzYc0Ynk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHRs58PRUXkKXpxLgQ7MhuWZ1pu+keA7N7qz/xrG54B3snEC2A3W0td0oc86WXtmQ
	 MzwU3Cap8WEhEv6RwRJN/zCyJ+IcFjy7ymVROnSzqk3VpRYLe1iqnfIs+NfQHMo9L/
	 Cjfhulyd9j+G/HJqnOlLyfUL/8Tsgp+B8/cEpNWQ=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jTLBR30GXzH9X;
	Tue, 17 Nov 2026 11:12:15 +0100 (CET)
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
Subject: [PATCH v2 6/6] landlock: Fix capability restriction documentation
Date: Tue, 17 Nov 2026 11:11:56 +0100
Message-ID: <20261117101157.2520463-7-mic@digikod.net>
In-Reply-To: <20261117101157.2520463-1-mic@digikod.net>
References: <20261117101157.2520463-1-mic@digikod.net>
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
Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://patch.msgid.link/20261110202436.2408244-7-mic@digikod.net
- Add Serge Hallyn's Acked-by.
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

