Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0992A2C032E
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784723415; cv=none; b=gFrL0uGpS47Q+FT5wEsKecl5gm76uYiBMRKT9vfBtxjiTdePfc0f7Af52HTH6EdxhOyekFj3PtE4dFvUgSpLJzzNvQTPFrT/h5FUDaNI/ACZMdNpkBoFyqZYcdFS3nl06gpyLhdbL/E2givBc+/CIc1M+7FGMrpsePci3PPgIYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784723415; c=relaxed/simple;
	bh=XXP6So6EytIRNbavWUyVFlypJEjg8u4P/XJmPMsD3mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHyS03eJgEHr2HilL7NqVNrUqCJ6J4Kl8foJkUJQoxih1UyO69ieaoFLu3RjObGx3DH2s9Og05hmt6G+VOpTELkFD0p5iA/W5p7sE0lr4X5jLUoMD5fe6arnKelXVvsSQrnCqmzJlUs7O5GikpY5ld0Uau7USmo474hIAAEF2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OvNL3QxQ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OvNL3QxQ"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69c5fda04a8so20550076a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 05:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784723411; x=1785328211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P42HCFpkq11qC2COB01ikocfGvftDj76wdm0yvbU3UM=;
        b=OvNL3QxQTxJ4/10TiccCe/IxeCcHtK6AT+Z+TrFFD7NYOk1VTYL9HrAYj0pG4KXWpa
         ndu8vHarLB5XaXIxwlT8geiWSr2XR5jE7GV/EwF15dq9RhJzSbVlwr6XxGmShMBwIfv9
         ehthctNHUnxiJHES0GHpal0AaOOsMGSXD+LwQjJX7F+u5PRsD/Z6WIn3xNEthEhdbufF
         SQJxbtRM7CitP2JtOMjYT6806tlGaVjTLP57w/LjayU41YLa95mwPI6CmnLaQsNZTDGU
         xz8ZlEAlHdmIp26Yk9h3hbTcZDfUZLp/jSEUIxlfl/Ii/0SWLfT5YC2DiRWVN0wB6Dhm
         gDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784723411; x=1785328211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P42HCFpkq11qC2COB01ikocfGvftDj76wdm0yvbU3UM=;
        b=XRcR7tjTZqz1Qo04E9KcNm6TDS4WcQy6DWAqfQ2P1G4pBD9wTRk84V3WlnEXLd8Xu3
         kGtXCsxvix5p6sF7YkqRZSUhkUc0mWZctvyOBmrYmo1Zk5EfD3Y4cC3SIgVcqlTDdPML
         nzyXwQTenPBObRu+WtFjCCspkgwsm6fk0OQFFSJ12zNBscM5iyPS7cDpJbxuz9YmD92u
         GVjCcpDw/Fyz67wMD+YpT9eRx/fK/Bq8/+UMTyLMyCugL29wBPm8PqhJTrHN/owW0m7g
         /PlaS+tXv/lU9jqD3p7M9kFdJtuPNIeOCzwJoQg6PlFS8zTfNGghgyJDwvKaxvO+DWyj
         4qiA==
X-Forwarded-Encrypted: i=1; AHgh+Rr4khT18NDxM2CAW+a9oEYCwVURO+pcBI0GwHI7iBSNWlCaK2Yjre7noqALpto8fyiChpfhKBRdoUMfy82PaXEjLJm9/Go=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNsj48Z4eJ1y23l+Iifgd4IxiU1RV5IfbEd1JYjNn6cHg/RNS+
	GQPdJvaSkvmai4Y5oiJDltCYSrZK/3E9fy8z7tlbV/FHHPO4RT5FN+LpzXFt4t+bmVY=
X-Gm-Gg: AR+sD11q1RMLNnglCvzdcOP/qQaSI4YyZKNtlN0M4JKRPNbqR7Sf7TNYpeCEWK3bmka
	G3mUH7wmSeER2/J7mFolEVjjS3OybX1mIDaxcSGN8mHHZtUVxdJdC1p5ESWujL4cVhtDxeDcSwh
	wijs0FORFd11PcxE7HuXx1x1Q+SIrTNjTc36XbtpMku+DWFqn0j7Mvr+82cAkgGqZ/LQnonucm2
	NI7+bi7rKX/MfB99yQNDnAEnyiSjX7Pvcp53LTZeHaEm1W/p8+yXFjL++NvVe217t++EJjGfFWz
	RsYyLjDC68wFtzxps5EUFo9SlodYCXGNabKeY1EYCwwdoUPoacseSRe0SyC3KslN+CU+rsdO3l1
	BEZasvDylT9uyf8o78s/ABRzxeHsfmB5L154OjI6dIzlX6ca5d2K+7TGN/lMOhRldRJwwZaTK3g
	==
X-Received: by 2002:a05:6402:4402:b0:69c:9197:4413 with SMTP id 4fb4d7f45d1cf-69e652dfccemr9233139a12.36.1784723410993;
        Wed, 22 Jul 2026 05:30:10 -0700 (PDT)
Received: from DW927H4LGF ([2a09:bac6:37e6:1e5a::306:2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69f34f1b867sm835007a12.14.2026.07.22.05.30.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jul 2026 05:30:10 -0700 (PDT)
From: Oxana Kharitonova <oxana@cloudflare.com>
To: mic@digikod.net,
	gnoack@google.com
Cc: paul@paul-moore.com,
	jmorris@namei.or,
	serge@hallyn.com,
	wangyan01@kylinos.cn,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	landlock@lists.linux.dev,
	oxana@cloudflare.com,
	webprosto@gmail.com
Subject: [PATCH 6/6] landlock: Document POSIX message queue scoping
Date: Wed, 22 Jul 2026 13:29:42 +0100
Message-ID: <20260722122952.42149-7-oxana@cloudflare.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260722122952.42149-1-oxana@cloudflare.com>
References: <20260722122952.42149-1-oxana@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document LANDLOCK_SCOPE_POSIX_MSG_QUEUE in the userspace API and UAPI
kernel-doc.

Signed-off-by: Oxana Kharitonova <oxana@cloudflare.com>
---
 Documentation/admin-guide/LSM/landlock.rst |  6 ++++--
 Documentation/userspace-api/landlock.rst   | 11 ++++++++++-
 include/uapi/linux/landlock.h              |  6 +++++-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/LSM/landlock.rst b/Documentation/admin-guide/LSM/landlock.rst
index 8eb85c9381ff..1ecb2017271b 100644
--- a/Documentation/admin-guide/LSM/landlock.rst
+++ b/Documentation/admin-guide/LSM/landlock.rst
@@ -60,9 +60,11 @@ AUDIT_LANDLOCK_ACCESS
         - net.bind_udp - UDP port binding was denied
         - net.connect_send_udp - UDP connection and send was denied
 
-    **scope.*** - IPC scoping restrictions (ABI 6+):
+    **scope.*** - IPC scoping restrictions:
         - scope.abstract_unix_socket - Abstract UNIX socket connection denied
-        - scope.signal - Signal sending denied
+          (ABI 6+)
+        - scope.signal - Signal sending denied (ABI 6+)
+        - scope.posix_msg_queue - POSIX message queue opening denied (ABI 11+)
 
     Multiple blockers can appear in a single event (comma-separated) when
     multiple access rights are missing. For example, creating a regular file
diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 5a63d4476c1c..c4fa84e6d281 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -86,7 +86,8 @@ to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
         .scoped =
             LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
-            LANDLOCK_SCOPE_SIGNAL,
+            LANDLOCK_SCOPE_SIGNAL |
+            LANDLOCK_SCOPE_POSIX_MSG_QUEUE,
     };
 
 Because we may not know which kernel version an application will be executed
@@ -140,6 +141,10 @@ version, and only use the available subset of access rights:
         ruleset_attr.handled_access_net &=
             ~(LANDLOCK_ACCESS_NET_BIND_UDP |
               LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
+        __attribute__((fallthrough));
+    case 10:
+        /* Removes LANDLOCK_SCOPE_POSIX_MSG_QUEUE for ABI < 11 */
+        ruleset_attr.scoped &= ~LANDLOCK_SCOPE_POSIX_MSG_QUEUE;
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -420,6 +425,10 @@ The operations which can be scoped are:
     A :manpage:`sendto(2)` on a socket which was previously connected will not
     be restricted.  This works for both datagram and stream sockets.
 
+``LANDLOCK_SCOPE_POSIX_MSG_QUEUE``
+    This limits opening POSIX message queues to queues created by a process in
+    the same or a nested Landlock domain.
+
 IPC scoping does not support exceptions via :manpage:`landlock_add_rule(2)`.
 If an operation is scoped within a domain, no rules can be added to allow access
 to resources or processes outside of the scope.
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 96d0c3b423ac..21ba31ad4d4b 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -478,7 +478,9 @@ struct landlock_net_port_attr {
  * Setting a flag for a ruleset will isolate the Landlock domain to forbid
  * connections to resources outside the domain.
  *
- * This is supported since Landlock ABI version 6.
+ * This is supported since Landlock ABI version 6.  The
+ * %LANDLOCK_SCOPE_POSIX_MSG_QUEUE scope is supported since Landlock ABI version
+ * 11.
  *
  * Scopes:
  *
@@ -487,6 +489,8 @@ struct landlock_net_port_attr {
  *   related Landlock domain (e.g., a parent domain or a non-sandboxed process).
  * - %LANDLOCK_SCOPE_SIGNAL: Restrict a sandboxed process from sending a signal
  *   to another process outside the domain.
+ * - %LANDLOCK_SCOPE_POSIX_MSG_QUEUE: Restrict a sandboxed process from opening
+ *   a POSIX message queue created outside the domain.
  */
 /* clang-format off */
 #define LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
-- 
2.50.1 (Apple Git-155)

