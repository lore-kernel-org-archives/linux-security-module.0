Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF524472797
	for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685558; cv=none; b=heFDUZtg7LzLeiuUgLcLlOqBbOXaXmdS9X4WsVYFiiXKTJn1oA7B6BFim6UlBCk/mcMssZr4I/6rL4YtWpQWI7qqV3AzmpOXbA5i60GGHCIhsoSOPxnhYvaVNDshc/io/mzWFSGQA2Hx90Y5tHGpsYv20cbkm8DbdwO/9RqjNPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685558; c=relaxed/simple;
	bh=F2TFb4Z42bx5xaV7l9uHeBfZgp9K7v67oCblzjTp5aM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qlTCq6wrDUrhzsl+CFm4yxeqTKzHWpoNbkUsQ3p8Vz5J2IZ2BsZQOW6wDtp3IJUmvOmDr8Hyc7QMWqXJo+CHmuS9trWbpZ8PCp9phgng3jNTVA+dVvprixuDbR8F7u/NPj9lhqCwAvtRe9XSYquKk4EfbCv2MV4YbA/L26NPY3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=oj2expOS; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="oj2expOS"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gFxvN63KWzrdk;
	Wed, 13 May 2026 17:19:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1778685552;
	bh=kw6g95iI3Skj55YIFmqak/gFqvDfPK0OOJbem/UFILU=;
	h=From:To:Cc:Subject:Date:From;
	b=oj2expOSjWRohAZ4PvvAsy4nZQNqgLa3BzIA+jPFALXL7wDdO0X3Gdk/KmrunEaqs
	 Xsyezpou2Bt+9Sj7v5BVLkwzmCHJ2H6tmnAQJQzJ5M+YsVfuN37APvtJ1+v1tL10+d
	 JQSNjF2VnoABZWTZ+ZsE+ZGGgZ3YN2r/wxmWZYho=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gFxvN1Xyyz36n;
	Wed, 13 May 2026 17:19:12 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	Tingmao Wang <m@maowtm.org>
Subject: [PATCH v1] landlock: Demonstrate best-effort allowed_access filtering
Date: Wed, 13 May 2026 17:18:53 +0200
Message-ID: <20260513151856.148423-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Landlock provides best-effort sandboxing across ABI versions:
applications request the rights they need, and on older kernels the
unsupported rights are silently dropped from handled_access_* by the
documented compatibility switch.  The recommended pattern for
landlock_add_rule(2) calls is to mirror this filtering at the rule
level, which wasn't explicitly described in the exemple.

Show the pattern explicitly in the filesystem and network rule examples
by masking each rule's allowed_access against the ruleset's
handled_access_* and adding the rule only when at least one bit remains
set.  This makes the recommended best-effort pattern self-documenting.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 Documentation/userspace-api/landlock.rst | 48 +++++++++++++-----------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index fd8b78c31f2f..45861fa75685 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: March 2026
+:Date: May 2026
 
 The goal of Landlock is to enable restriction of ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
@@ -155,7 +155,7 @@ this file descriptor.
 
 .. code-block:: c
 
-    int err;
+    int err = 0;
     struct landlock_path_beneath_attr path_beneath = {
         .allowed_access =
             LANDLOCK_ACCESS_FS_EXECUTE |
@@ -163,25 +163,29 @@ this file descriptor.
             LANDLOCK_ACCESS_FS_READ_DIR,
     };
 
-    path_beneath.parent_fd = open("/usr", O_PATH | O_CLOEXEC);
-    if (path_beneath.parent_fd < 0) {
-        perror("Failed to open file");
-        close(ruleset_fd);
-        return 1;
-    }
-    err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-                            &path_beneath, 0);
-    close(path_beneath.parent_fd);
-    if (err) {
-        perror("Failed to update ruleset");
-        close(ruleset_fd);
-        return 1;
+    path_beneath.allowed_access &= ruleset_attr.handled_access_fs;
+    if (path_beneath.allowed_access) {
+        path_beneath.parent_fd = open("/usr", O_PATH | O_CLOEXEC);
+        if (path_beneath.parent_fd < 0) {
+            perror("Failed to open file");
+            close(ruleset_fd);
+            return 1;
+        }
+        err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+                                &path_beneath, 0);
+        close(path_beneath.parent_fd);
+        if (err) {
+            perror("Failed to update ruleset");
+            close(ruleset_fd);
+            return 1;
+        }
     }
 
-It may also be required to create rules following the same logic as explained
-for the ruleset creation, by filtering access rights according to the Landlock
-ABI version.  In this example, this is not required because all of the requested
-``allowed_access`` rights are already available in ABI 1.
+As shown above, masking the rule's ``allowed_access`` against the ruleset's
+``handled_access_*`` is the recommended best-effort pattern: rights the running
+kernel does not support are dropped (the compatibility switch above already
+cleared them in ``handled_access_*``), and the rule is skipped if no supported
+right remains.
 
 For network access-control, we can add a set of rules that allow to use a port
 number for a specific action: HTTPS connections.
@@ -193,8 +197,10 @@ number for a specific action: HTTPS connections.
         .port = 443,
     };
 
-    err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-                            &net_port, 0);
+    net_port.allowed_access &= ruleset_attr.handled_access_net;
+    if (net_port.allowed_access)
+        err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+                                &net_port, 0);
 
 When passing a non-zero ``flags`` argument to ``landlock_restrict_self()``, a
 similar backwards compatibility check is needed for the restrict flags
-- 
2.54.0

