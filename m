Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC72D3D76;
	Sat, 21 Feb 2026 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771711519; cv=none; b=KFhiI28VL3s7C5CMBMb7gxnV06E2w//u40N6VAI0PdIw8HjK7/CXtprWg2ZQAEuKpyqedpZEOPQ9yxOKLdwA0OxVyj2Lsema3M4GLecM/qWB7VgXlOpPVKCX7KBhqEOVwadxUTEEM0U/omRC2HBe9hRBAFMMLfNuRhT4P4rLOeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771711519; c=relaxed/simple;
	bh=p3udrPM5R8Ck6nPBvksu+g9CLXhrmSJHInoMvl7/xk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jG6S6gW4EC3J/zoNic16F5A3IwCnsv+zHeW4CPVUQXoh2/w27vEFvw9SfGGZh+Q+dz8/I49J1BYQtwopeqFVidf3+eBj5tsQjUWcjqjGKEgGr18F+L+vRLsTVOvQXA/O7HC3QBZlMvzeZRymG+ngUtnar0yU01urzptjdyfO46c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=n0toose.net; spf=pass smtp.mailfrom=n0toose.net; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=n0toose.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=n0toose.net
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fJLlH4WSGz9tWh;
	Sat, 21 Feb 2026 23:05:15 +0100 (CET)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of git@n0toose.net designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=git@n0toose.net
From: "Panagiotis \"Ivory\" Vasilopoulos" <git@n0toose.net>
Date: Sat, 21 Feb 2026 23:05:06 +0100
Subject: [PATCH] landlock: Expand restrict flags example for ABI version 8
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260221-landlock-docs-add-tsync-example-v1-1-f89383809eb4@n0toose.net>
X-B4-Tracking: v=1; b=H4sIABEsmmkC/x3NwQrCMAyA4VcZORvY6iziq4iHkGQarO1ohkzG3
 t2y43f5/w1cq6nDrdug6tfcSm4YTh3wi/JT0aQZQh9iH8KAibKkwm+Uwo4kgov/MqOu9JmTol4
 nuXAc6RwjtMpcdbL1ONwf+/4HOy5Pa3EAAAA=
X-Change-ID: 20260221-landlock-docs-add-tsync-example-e8fd5c64a366
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771711511; l=1919;
 i=git@n0toose.net; s=20260221; h=from:subject:message-id;
 bh=p3udrPM5R8Ck6nPBvksu+g9CLXhrmSJHInoMvl7/xk0=;
 b=S81kAbjaX2nYCmB+rfWfopKcWgKLpeSM90t9j+4t2IpbiebX7svx7+JBI1n40DfnoDVV7tbwG
 XviYHAVHnHSBrAXpfjJTLZLApiBTHh3+rTPXMISNYG+USnZq4+OauNn
X-Developer-Key: i=git@n0toose.net; a=ed25519;
 pk=Tis+3ti1x0lr71vFYBVrYAzcO2UpGQijF0kXwupcsXE=
X-Rspamd-Queue-Id: 4fJLlH4WSGz9tWh

Add LANDLOCK_RESTRICT_SELF_TSYNC to the backwards compatibility example
for restrict flags. This introduces completeness, similar to that of
the ruleset attributes example.

Additionally, I modified the two comments of the example to make them
more consistent with the ruleset attributes example's.

Signed-off-by: Panagiotis 'Ivory' Vasilopoulos <git@n0toose.net>
---
 Documentation/userspace-api/landlock.rst | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 13134bccdd39d78ddce3daf454f32dda162ce91b..d972af20791a722d4665bd2ac287b05c5e97248c 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -197,12 +197,18 @@ similar backwards compatibility check is needed for the restrict flags
 
 .. code-block:: c
 
-    __u32 restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
-    if (abi < 7) {
-        /* Clear logging flags unsupported before ABI 7. */
+    __u32 restrict_flags =
+        LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
+        LANDLOCK_RESTRICT_SELF_TSYNC;
+    switch (abi) {
+    case 1 ... 6:
+        /* Clear logging flags unsupported for ABI < 7 */
         restrict_flags &= ~(LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
                             LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
                             LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
+    case 7:
+        /* Removes multithread flag unsupported for ABI < 8 */
+    	restrict_flags &= ~LANDLOCK_RESTRICT_SELF_TSYNC;
     }
 
 The next step is to restrict the current thread from gaining more privileges

---
base-commit: ceb977bfe9e8715e6cd3a4785c7aab8ea5cd2b77
change-id: 20260221-landlock-docs-add-tsync-example-e8fd5c64a366

Best regards,
-- 
Panagiotis "Ivory" Vasilopoulos <git@n0toose.net>

