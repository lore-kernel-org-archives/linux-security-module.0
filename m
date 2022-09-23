Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4281C6FA90
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Sep 2022 15:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiIWPnn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Sep 2022 11:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiIWPnN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Sep 2022 11:43:13 -0400
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F85EF1871
        for <linux-security-module@vger.kernel.org>; Fri, 23 Sep 2022 08:42:43 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MYxHP3L6dzMrD39;
        Fri, 23 Sep 2022 17:42:41 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MYxHM65QHzww;
        Fri, 23 Sep 2022 17:42:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1663947761;
        bh=zASGhdPmXjHrL9dTu6mYWI6wkoUc6YPq69t54Mg0IlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TeZdHk+kvVSHqp+NZ0eOMdi01Wxb26cTF/m6WbCPE1UryXGcLSgqc8VbBwJyJCiKm
         LiaTcoQa/wa3VXo0MIfk+qdvGLiGN9mNWFZjtRptbo94Mu6jkqweoGjm4Adbj3/B6p
         ZYbeDNBhRY+ZkozpXGWcMQfkPJlQmLIexiknllWo=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v1 1/3] samples/landlock: Print hints about ABI versions
Date:   Fri, 23 Sep 2022 17:42:05 +0200
Message-Id: <20220923154207.3311629-2-mic@digikod.net>
In-Reply-To: <20220923154207.3311629-1-mic@digikod.net>
References: <20220923154207.3311629-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Extend the help with the latest Landlock ABI version supported by the
sandboxer.

Inform users about the sandboxer or the kernel not being up-to-date.

Make the version check code easier to update and harder to misuse.

Cc: Günther Noack <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220923154207.3311629-2-mic@digikod.net
---
 samples/landlock/sandboxer.c | 37 ++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 3e404e51ec64..f29bb3c72230 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -162,11 +162,10 @@ static int populate_ruleset(const char *const env_var, const int ruleset_fd,
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
 	LANDLOCK_ACCESS_FS_REFER)
 
-#define ACCESS_ABI_2 ( \
-	LANDLOCK_ACCESS_FS_REFER)
-
 /* clang-format on */
 
+#define LANDLOCK_ABI_LAST 2
+
 int main(const int argc, char *const argv[], char *const *const envp)
 {
 	const char *cmd_path;
@@ -196,8 +195,12 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			"\nexample:\n"
 			"%s=\"/bin:/lib:/usr:/proc:/etc:/dev/urandom\" "
 			"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
-			"%s bash -i\n",
+			"%s bash -i\n\n",
 			ENV_FS_RO_NAME, ENV_FS_RW_NAME, argv[0]);
+		fprintf(stderr,
+			"This sandboxer can use Landlock features "
+			"up to ABI version %d.\n",
+			LANDLOCK_ABI_LAST);
 		return 1;
 	}
 
@@ -225,12 +228,30 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		}
 		return 1;
 	}
+
 	/* Best-effort security. */
-	if (abi < 2) {
-		ruleset_attr.handled_access_fs &= ~ACCESS_ABI_2;
-		access_fs_ro &= ~ACCESS_ABI_2;
-		access_fs_rw &= ~ACCESS_ABI_2;
+	switch (abi) {
+	case 1:
+		/* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
+		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
+
+		fprintf(stderr,
+			"Hint: You should update the running kernel "
+			"to leverage Landlock features "
+			"provided by ABI version %d (instead of %d).\n",
+			LANDLOCK_ABI_LAST, abi);
+		__attribute__((fallthrough));
+	case LANDLOCK_ABI_LAST:
+		break;
+	default:
+		fprintf(stderr,
+			"Hint: You should update this sandboxer "
+			"to leverage Landlock features "
+			"provided by ABI version %d (instead of %d).\n",
+			abi, LANDLOCK_ABI_LAST);
 	}
+	access_fs_ro &= ruleset_attr.handled_access_fs;
+	access_fs_rw &= ruleset_attr.handled_access_fs;
 
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
-- 
2.37.2

