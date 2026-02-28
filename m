Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CC62D8379;
	Sat, 28 Feb 2026 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772314662; cv=none; b=uDlisQ4XYbuJUBeMUtgYPcMUKbDWoIj4XZE4L91FDqQM0DL2rVdCeblhs1MHyn3KWJYCQ5F5WSvINuZbj+tb2TEnpl4MhjbaMO+F/Yj39aPdgVoSFJbuRwKp7X/MzVnZHRhbIDE0GmgY2IJoJwl4cF64mkagUEJVzcc9CRU24hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772314662; c=relaxed/simple;
	bh=M22ouk3EnhHtWN9GfaGOPktGAo/YBHtJPyV6t5VKC0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kiHpCPJGlc3uYXer0mFYNbOmfX2GhVCadta12Q6mEU1dECPvzg3lIDA0Qn1c04ETB0VRPMn3YQ5CwQgHc86fGyU9picxnZpTRF9u+aaiukvUHVbpWT0rCBjMnT/nE5VqrgX0fIKQ5Ut9GAsOgtSklTrtf5B8TOcxnSTI1BHS5Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=n0toose.net; spf=pass smtp.mailfrom=n0toose.net; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=n0toose.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=n0toose.net
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fNdp833w3z9vJh;
	Sat, 28 Feb 2026 22:37:36 +0100 (CET)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of git@n0toose.net designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=git@n0toose.net
From: "Panagiotis \"Ivory\" Vasilopoulos" <git@n0toose.net>
Date: Sat, 28 Feb 2026 22:36:59 +0100
Subject: [PATCH v3] landlock: Expand restrict flags example for ABI version
 8
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260228-landlock-docs-add-tsync-example-v3-1-140ab50f0524@n0toose.net>
X-B4-Tracking: v=1; b=H4sIAPpfo2kC/5XNsQ6DIBSF4VdpmHsbQCXQqe/RdEC4VlILBojRG
 N+96NatHf8zfGclCaPDRK6nlUScXHLBl6jOJ2J67Z8IzpYmnHJBOWcwaG+HYF5gg0mgrYWcFm8
 AZ/0eBwSUnW2MqHUlBCnKGLFz8/Fwf5TuXcohLsfhxPb1d3tiwKCTqpKVpArb+uZpDiHhxWMmu
 z7xP0VeREGVokqKttXNt7ht2wds0158IgEAAA==
X-Change-ID: 20260221-landlock-docs-add-tsync-example-e8fd5c64a366
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Cojocaru <dan@dcdev.ro>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772314653; l=3612;
 i=git@n0toose.net; s=20260221; h=from:subject:message-id;
 bh=M22ouk3EnhHtWN9GfaGOPktGAo/YBHtJPyV6t5VKC0M=;
 b=+RjUuZxBdcD60MwR6pN0l2QjGDS2BJMjpy0JTkZ9jT+pvjGBkTlVtQyoTnRoEhsOF8ZFqZESZ
 gymT75AzPMxAXqXv5yrva8ULAgr4WqeYW/0UD7LhQxOt/Brd8M7nXmG
X-Developer-Key: i=git@n0toose.net; a=ed25519;
 pk=Tis+3ti1x0lr71vFYBVrYAzcO2UpGQijF0kXwupcsXE=
X-Rspamd-Queue-Id: 4fNdp833w3z9vJh

Add LANDLOCK_RESTRICT_SELF_TSYNC to the backwards compatibility example
for restrict flags. This introduces completeness, similar to that of
the ruleset attributes example. However, as the new example can impact
enforcement in certain cases, an appropriate warning is also included.

Additionally, I modified the two comments of the example to make them
more consistent with the ruleset attributes example's.

Signed-off-by: Panagiotis 'Ivory' Vasilopoulos <git@n0toose.net>
Co-developed-by: Dan Cojocaru <dan@dcdev.ro>
Signed-off-by: Dan Cojocaru <dan@dcdev.ro>
---
Changes in v3:
- Add __attribute__((fallthrough)) like in earlier example.
- Improve comment for LANDLOCK_RESTRICT_SELF_TSYNC (ABI < 8) example.
- Add relevant warning for ABI < 8 example based on Günther's feedback.
- Link to v2: https://lore.kernel.org/r/20260221-landlock-docs-add-tsync-example-v2-1-60990986bba5@n0toose.net

Changes in v2:
- Fix formatting error.
- Link to v1: https://lore.kernel.org/r/20260221-landlock-docs-add-tsync-example-v1-1-f89383809eb4@n0toose.net
---
 Documentation/userspace-api/landlock.rst | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 13134bccdd39d78ddce3daf454f32dda162ce91b..b71ac7aa308260b8141e5d35248fb68cec6dcba9 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -196,13 +196,33 @@ similar backwards compatibility check is needed for the restrict flags
 (see sys_landlock_restrict_self() documentation for available flags):
 
 .. code-block:: c
-
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
+        __attribute__((fallthrough));
+    case 7:
+        /* Removes multithreaded enforcement flag unsupported for ABI < 8 */
+        /*
+         * WARNING!
+         * Don't copy-paste this just yet! This example impacts enforcement
+         * and can potentially decrease protection if misused.
+         *
+         * Below ABI v8, a Landlock policy can only be enforced for the calling
+         * thread and its children. This behavior remains a default for ABI v8,
+         * but the flag ``LANDLOCK_RESTRICT_SELF_TSYNC`` can now be used to
+         * enforce policies across all threads of the calling process. If an
+         * application's Landlock integration was designed under the assumption
+         * that the flag is used (such as when children threads are responsible
+         * for enforcing and/or overriding policies of parents and siblings),
+         * removing said flag can decrease protection for older Linux versions.
+         */
+        restrict_flags &= ~LANDLOCK_RESTRICT_SELF_TSYNC;
     }
 
 The next step is to restrict the current thread from gaining more privileges

---
base-commit: ceb977bfe9e8715e6cd3a4785c7aab8ea5cd2b77
change-id: 20260221-landlock-docs-add-tsync-example-e8fd5c64a366

Best regards,
-- 
Panagiotis "Ivory" Vasilopoulos <git@n0toose.net>

