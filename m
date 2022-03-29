Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F15C43219
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Mar 2022 12:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbiC2MxW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 29 Mar 2022 08:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237198AbiC2MxB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 Mar 2022 08:53:01 -0400
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02826297
        for <linux-security-module@vger.kernel.org>; Tue, 29 Mar 2022 05:51:07 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KSTvZ2H5jzMq17v;
        Tue, 29 Mar 2022 14:51:06 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KSTvX5pqLzlhSMW;
        Tue, 29 Mar 2022 14:51:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1648558266;
        bh=RKNGYAFAo3yZ4fLKZPqQ7CCdLKDqIyDN4+wRHaJ7huU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M5+zWNcyu5ps2IXlHGYpizZgwfwnTYNgX+8C7zqPUGxnn5D+JQ8h/NnzVI0FcReCb
         s1v79ni/TQzaCCfPsd93YiEGuf/DTrbPcLhq4QHvqZJ2gwzewHGT7jTryskZswRr1b
         +bENc+XOrrsYxUuL73XhyJndoVZLCab32oXt312U=
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
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v2 09/12] samples/landlock: Add support for file reparenting
Date:   Tue, 29 Mar 2022 14:51:14 +0200
Message-Id: <20220329125117.1393824-10-mic@digikod.net>
In-Reply-To: <20220329125117.1393824-1-mic@digikod.net>
References: <20220329125117.1393824-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Mickaël Salaün <mic@linux.microsoft.com>

Add LANDLOCK_ACCESS_FS_REFER to the "roughly write" access rights and
leverage the Landlock ABI version to only try to enforce it if it is
supported by the running kernel.

Reviewed-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20220329125117.1393824-10-mic@digikod.net
---

Changes since v1:
* Add Reviewed-by: Paul Moore.
---
 samples/landlock/sandboxer.c | 37 +++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 7a15910d2171..8509543fcbbb 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -153,16 +153,21 @@ static int populate_ruleset(
 	LANDLOCK_ACCESS_FS_MAKE_SOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
-	LANDLOCK_ACCESS_FS_MAKE_SYM)
+	LANDLOCK_ACCESS_FS_MAKE_SYM | \
+	LANDLOCK_ACCESS_FS_REFER)
+
+#define ACCESS_ABI_2 ( \
+	LANDLOCK_ACCESS_FS_REFER)
 
 int main(const int argc, char *const argv[], char *const *const envp)
 {
 	const char *cmd_path;
 	char *const *cmd_argv;
-	int ruleset_fd;
+	int ruleset_fd, abi;
+	__u64 access_fs_ro = ACCESS_FS_ROUGHLY_READ,
+	      access_fs_rw = ACCESS_FS_ROUGHLY_READ | ACCESS_FS_ROUGHLY_WRITE;
 	struct landlock_ruleset_attr ruleset_attr = {
-		.handled_access_fs = ACCESS_FS_ROUGHLY_READ |
-			ACCESS_FS_ROUGHLY_WRITE,
+		.handled_access_fs = access_fs_rw,
 	};
 
 	if (argc < 2) {
@@ -183,11 +188,11 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		return 1;
 	}
 
-	ruleset_fd = landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
-	if (ruleset_fd < 0) {
+	abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
+	if (abi < 0) {
 		const int err = errno;
 
-		perror("Failed to create a ruleset");
+		perror("Failed to check Landlock compatibility");
 		switch (err) {
 		case ENOSYS:
 			fprintf(stderr, "Hint: Landlock is not supported by the current kernel. "
@@ -205,12 +210,22 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		}
 		return 1;
 	}
-	if (populate_ruleset(ENV_FS_RO_NAME, ruleset_fd,
-				ACCESS_FS_ROUGHLY_READ)) {
+	/* Best-effort security. */
+	if (abi < 2) {
+		ruleset_attr.handled_access_fs &= ~ACCESS_ABI_2;
+		access_fs_ro &= ~ACCESS_ABI_2;
+		access_fs_rw &= ~ACCESS_ABI_2;
+	}
+
+	ruleset_fd = landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	if (ruleset_fd < 0) {
+		perror("Failed to create a ruleset");
+		return 1;
+	}
+	if (populate_ruleset(ENV_FS_RO_NAME, ruleset_fd, access_fs_ro)) {
 		goto err_close_ruleset;
 	}
-	if (populate_ruleset(ENV_FS_RW_NAME, ruleset_fd,
-				ACCESS_FS_ROUGHLY_READ | ACCESS_FS_ROUGHLY_WRITE)) {
+	if (populate_ruleset(ENV_FS_RW_NAME, ruleset_fd, access_fs_rw)) {
 		goto err_close_ruleset;
 	}
 	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
-- 
2.35.1

