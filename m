Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA811A0712;
	Sat, 21 Feb 2026 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771711992; cv=none; b=n4JrpaapJOPJ8EGo2vWUnlmfjKy5cud1yBgGKv8Gsu/3ptb36704KQYWkFhGNTLXHnBLXpFabXq+O2BGKSPb/PpL99t4dRtcTpe7WrYNHqnyCxT2gTnO4a2GlYOxR/v+pPBXXlonj13bgP9vJecHQrsHy8Y8ae4nceRjU3pVEd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771711992; c=relaxed/simple;
	bh=cMmXvpFAhHfIemH7wcF//uPahP2enBmohiXvmiFzJAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ay74wggnsMQWGP+MVY00LyjGwRKeEl/SaQzMb8J4Z5/n7+MCPmIUrjvGTL9WfSFXtmZL0dt+iEypvqATZoKOQ7/iMBrWjfPT+hK2i8MyftNqwds7FW3ECBR60C0zpDW7PXAE4gJ4IeThurr3MipCGw65PJkg/AMkk8oZHAXTd5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=n0toose.net; spf=pass smtp.mailfrom=n0toose.net; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=n0toose.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=n0toose.net
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fJLwD18XHz9v9n;
	Sat, 21 Feb 2026 23:13:00 +0100 (CET)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of git@n0toose.net designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=git@n0toose.net
From: "Panagiotis \"Ivory\" Vasilopoulos" <git@n0toose.net>
Date: Sat, 21 Feb 2026 23:12:25 +0100
Subject: [PATCH v2] landlock: Expand restrict flags example for ABI version
 8
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260221-landlock-docs-add-tsync-example-v2-1-60990986bba5@n0toose.net>
X-B4-Tracking: v=1; b=H4sIAMgtmmkC/42NQQ6DIBAAv2L23G0ALcGe/EfjgcJaSS0YIEZj/
 HupL+hx5jCzQ6LoKMG92iHS4pILvoC4VGBG7V+EzhYGwYRkQnCctLdTMG+0wSTU1mJOmzdIq/7
 MEyGpwd6MbHQtJZTKHGlw63l49IVHl3KI2zlc+M/+3144chxUW6tasZaeTedZDiHR1VOG/jiOL
 37/g5zQAAAA
X-Change-ID: 20260221-landlock-docs-add-tsync-example-e8fd5c64a366
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771711977; l=2080;
 i=git@n0toose.net; s=20260221; h=from:subject:message-id;
 bh=cMmXvpFAhHfIemH7wcF//uPahP2enBmohiXvmiFzJAk=;
 b=D91MSFoajzqsXbAOGkPV9V3lI/AlfDUxwLKicUVeJgEpGJD4goySheQKhi/kAY4hLRVr5D3Ua
 M8he65MnsHkAhr18g9/p3w9JuzPm9Hb+w35MuqC8OULH9V51N0aRA26
X-Developer-Key: i=git@n0toose.net; a=ed25519;
 pk=Tis+3ti1x0lr71vFYBVrYAzcO2UpGQijF0kXwupcsXE=
X-Rspamd-Queue-Id: 4fJLwD18XHz9v9n

Add LANDLOCK_RESTRICT_SELF_TSYNC to the backwards compatibility example
for restrict flags. This introduces completeness, similar to that of
the ruleset attributes example.

Additionally, I modified the two comments of the example to make them
more consistent with the ruleset attributes example's.

Signed-off-by: Panagiotis 'Ivory' Vasilopoulos <git@n0toose.net>
---
Changes in v2:
- Fix formatting error.
- Link to v1: https://lore.kernel.org/r/20260221-landlock-docs-add-tsync-example-v1-1-f89383809eb4@n0toose.net
---
 Documentation/userspace-api/landlock.rst | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 13134bccdd39d78ddce3daf454f32dda162ce91b..0affe1c953d61a4b32aca700cd262c49cee6304a 100644
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
+        restrict_flags &= ~LANDLOCK_RESTRICT_SELF_TSYNC;
     }
 
 The next step is to restrict the current thread from gaining more privileges

---
base-commit: ceb977bfe9e8715e6cd3a4785c7aab8ea5cd2b77
change-id: 20260221-landlock-docs-add-tsync-example-e8fd5c64a366

Best regards,
-- 
Panagiotis "Ivory" Vasilopoulos <git@n0toose.net>

