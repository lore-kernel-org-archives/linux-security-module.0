Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B899BC43217
	for <linux-security-module@archiver.kernel.org>; Fri,  6 May 2022 16:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443562AbiEFQO6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 6 May 2022 12:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443671AbiEFQNc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 May 2022 12:13:32 -0400
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7E96EB07
        for <linux-security-module@vger.kernel.org>; Fri,  6 May 2022 09:09:46 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwWF19pTzMqTZL;
        Fri,  6 May 2022 18:09:45 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwWD6HB4zlhMCN;
        Fri,  6 May 2022 18:09:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853385;
        bh=ljovP71bccFdIQBtI9sMUdEAuBH4+SXJzMjB1yNMBwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uz9RZ3eCGwGmMzuEoGv34Ydf4g1cdG4CK8yUwnerI+GS0q3GPFcUarBzILvsLm9I1
         Zu2vERsO6qDlmohE5nz0XvkCjqtt20N029DRXvw5caW3n6/BO9V5BoHGrH1rlCu8p2
         iFoFpSTTzcNF5Fxle2TCCQwzwwqu/C0wlDw9LtEA=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v3 09/12] samples/landlock: Add support for file reparenting
Date:   Fri,  6 May 2022 18:10:59 +0200
Message-Id: <20220506161102.525323-10-mic@digikod.net>
In-Reply-To: <20220506161102.525323-1-mic@digikod.net>
References: <20220506161102.525323-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add LANDLOCK_ACCESS_FS_REFER to the "roughly write" access rights and
leverage the Landlock ABI version to only try to enforce it if it is
supported by the running kernel.

Reviewed-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506161102.525323-10-mic@digikod.net
---

Changes since v2:
* Format with clang-format and rebase.

Changes since v1:
* Add Reviewed-by: Paul Moore.
---
 samples/landlock/sandboxer.c | 40 ++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index c089e9cdaf32..3e404e51ec64 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -159,7 +159,11 @@ static int populate_ruleset(const char *const env_var, const int ruleset_fd,
 	LANDLOCK_ACCESS_FS_MAKE_SOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
-	LANDLOCK_ACCESS_FS_MAKE_SYM)
+	LANDLOCK_ACCESS_FS_MAKE_SYM | \
+	LANDLOCK_ACCESS_FS_REFER)
+
+#define ACCESS_ABI_2 ( \
+	LANDLOCK_ACCESS_FS_REFER)
 
 /* clang-format on */
 
@@ -167,10 +171,11 @@ int main(const int argc, char *const argv[], char *const *const envp)
 {
 	const char *cmd_path;
 	char *const *cmd_argv;
-	int ruleset_fd;
+	int ruleset_fd, abi;
+	__u64 access_fs_ro = ACCESS_FS_ROUGHLY_READ,
+	      access_fs_rw = ACCESS_FS_ROUGHLY_READ | ACCESS_FS_ROUGHLY_WRITE;
 	struct landlock_ruleset_attr ruleset_attr = {
-		.handled_access_fs = ACCESS_FS_ROUGHLY_READ |
-				     ACCESS_FS_ROUGHLY_WRITE,
+		.handled_access_fs = access_fs_rw,
 	};
 
 	if (argc < 2) {
@@ -196,12 +201,11 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		return 1;
 	}
 
-	ruleset_fd =
-		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
-	if (ruleset_fd < 0) {
+	abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
+	if (abi < 0) {
 		const int err = errno;
 
-		perror("Failed to create a ruleset");
+		perror("Failed to check Landlock compatibility");
 		switch (err) {
 		case ENOSYS:
 			fprintf(stderr,
@@ -221,13 +225,23 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		}
 		return 1;
 	}
-	if (populate_ruleset(ENV_FS_RO_NAME, ruleset_fd,
-			     ACCESS_FS_ROUGHLY_READ)) {
+	/* Best-effort security. */
+	if (abi < 2) {
+		ruleset_attr.handled_access_fs &= ~ACCESS_ABI_2;
+		access_fs_ro &= ~ACCESS_ABI_2;
+		access_fs_rw &= ~ACCESS_ABI_2;
+	}
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	if (ruleset_fd < 0) {
+		perror("Failed to create a ruleset");
+		return 1;
+	}
+	if (populate_ruleset(ENV_FS_RO_NAME, ruleset_fd, access_fs_ro)) {
 		goto err_close_ruleset;
 	}
-	if (populate_ruleset(ENV_FS_RW_NAME, ruleset_fd,
-			     ACCESS_FS_ROUGHLY_READ |
-				     ACCESS_FS_ROUGHLY_WRITE)) {
+	if (populate_ruleset(ENV_FS_RW_NAME, ruleset_fd, access_fs_rw)) {
 		goto err_close_ruleset;
 	}
 	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
-- 
2.35.1

