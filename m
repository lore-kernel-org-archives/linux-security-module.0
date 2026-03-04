Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28B43594A;
	Wed,  4 Mar 2026 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648014; cv=none; b=rRhnUs/A+V4/bOHNRSJHYnyMNMm3BzULNjNwyIokF41xOml0AfH5G3jz7e4/dz5eXluZVQ43fhZoR8vWyPNKwkO3ga32h7AIuqI5wLew7Re+QyntFzKlcOijD1qJ5OBtVMEqp7y5SVhHZoOCSZilxeoGQln6EiBJOxTZXTWOMlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648014; c=relaxed/simple;
	bh=cVjS6siBmXlktPnQ1M9cg9OdBWf0lLql1obqeYw8Q9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kWWYVXJEVocsCYgDP2jusEZs+N4dbWhLBwGCmfDdDHapo6mDXY53KeDcNh8qMefGExWkNqVVbdIHAPtfjF0+4arUrhQTJiB53QhvI+69veP3LRx78gGS8dLcVZS9rB8E1BtLorW1WjSAjhZbz/epeudR0q1ulZWWpKAvGmLHAIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=n0toose.net; spf=pass smtp.mailfrom=n0toose.net; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=n0toose.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=n0toose.net
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fR14g2zbbz9v68;
	Wed,  4 Mar 2026 19:13:23 +0100 (CET)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of git@n0toose.net designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=git@n0toose.net
From: "Panagiotis \"Ivory\" Vasilopoulos" <git@n0toose.net>
Date: Wed, 04 Mar 2026 19:13:04 +0100
Subject: [PATCH v4] landlock: Expand restrict flags example for ABI version
 8
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260304-landlock-docs-add-tsync-example-v4-1-819a276f05c5@n0toose.net>
X-B4-Tracking: v=1; b=H4sIADB2qGkC/5XOsQ7CIBDG8VdpmD1zQEvAyfcwDhSulljBlKbRm
 L676GR0UMf/Db/vbizTGCizTXVjI80hhxRL1KuKud7GA0HwpZlAoVAIDoONfkjuCD65DNZ7mPI
 1OqCLPZ0HAtKdb5yqrVSKFeU8Uhcuz4XdvnQf8pTG63Nw5o/r7/bMgUOnjdRSo6G23kacUsq0j
 jSxhz6LP0VRRIXGoNGqbW3zKcpXUX8XZRF5jbZtsMNGvP24LMsdQpY4q3QBAAA=
X-Change-ID: 20260221-landlock-docs-add-tsync-example-e8fd5c64a366
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Cojocaru <dan@dcdev.ro>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772647999; l=3864;
 i=git@n0toose.net; s=20260221; h=from:subject:message-id;
 bh=cVjS6siBmXlktPnQ1M9cg9OdBWf0lLql1obqeYw8Q9o=;
 b=PQdpzyizuWfktM7QLX8rGyjBABdXYdPNMddVmbYYDi927c+AkiLSKgptGJMUePyCDd7MHxjbC
 Iwcm3borzxBCHbYZK7NCwS16pCjkAkH6jp+nim13WShKeESIKWYsfmW
X-Developer-Key: i=git@n0toose.net; a=ed25519;
 pk=Tis+3ti1x0lr71vFYBVrYAzcO2UpGQijF0kXwupcsXE=
X-Rspamd-Queue-Id: 4fR14g2zbbz9v68

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
Changes in v4:
- Make warning somewhat more terse, merge comments.
  - Remove some sensationalization. ("Don't copy-paste this just yet!")
  - Apply Günther's suggestion (v3 "recycled" some phrases, was long)
    - ... but also retain some of the wording on ABI differences
- Provide a brief overview that contextualizes the example further:
  - Clarify the difference behind ABI < 8 & ABI v8, to avoid
    misunderstandings on which option is the default.
  - Make "linear reading" easier.
- Based on Mickaël's feedback: Avoid cans of worms w.r.t. use cases
- Link to v3: https://lore.kernel.org/r/20260228-landlock-docs-add-tsync-example-v3-1-140ab50f0524@n0toose.net

Changes in v3:
- Add __attribute__((fallthrough)) like in earlier example.
- Improve comment for LANDLOCK_RESTRICT_SELF_TSYNC (ABI < 8) example.
- Add relevant warning for ABI < 8 example based on Günther's feedback.
- Link to v2: https://lore.kernel.org/r/20260221-landlock-docs-add-tsync-example-v2-1-60990986bba5@n0toose.net

Changes in v2:
- Fix formatting error.
- Link to v1: https://lore.kernel.org/r/20260221-landlock-docs-add-tsync-example-v1-1-f89383809eb4@n0toose.net
---
 Documentation/userspace-api/landlock.rst | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 13134bccdd39d78ddce3daf454f32dda162ce91b..64c7138a788d74f99da0a71428da392b3d873bf8 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -196,13 +196,27 @@ similar backwards compatibility check is needed for the restrict flags
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
+        /*
+         * Removes multithreaded enforcement flag unsupported for ABI < 8
+         *
+         * WARNING: Without this flag, calling landlock_restrict_self(2) is
+         * only equivalent if the calling process is single-threaded. Below
+         * ABI v8 (and as of ABI v8, when not using this flag), a Landlock
+         * policy would only be enforced for the calling thread and its
+         * children (and not for all threads, including parents and siblings).
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

