Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83736C433FE
	for <linux-security-module@archiver.kernel.org>; Fri,  6 May 2022 16:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443372AbiEFQHt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 6 May 2022 12:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443364AbiEFQHo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 May 2022 12:07:44 -0400
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FC06D961
        for <linux-security-module@vger.kernel.org>; Fri,  6 May 2022 09:03:53 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwNS5RXBzMqK2B;
        Fri,  6 May 2022 18:03:52 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwNS3GG4zljsTZ;
        Fri,  6 May 2022 18:03:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853032;
        bh=6hAnHaatU+IsGyN1oUOhibXEVpIk8PFeXK1wgedN6G0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MxXoEevllYRsTJ700k/HQMwRwM2G+Z67GP2/rbRGLLDeq/YBfPbFxoShZj7XMcJuQ
         5+gUP7hLDI3YpcChxOgCerT0q/bO/V4BcKy2k49lDynFLeOR04oqLkTavG2QgTPMVs
         3+usG+gCHlfEoG4DUMlSucLnJo3RV9lX+JL6IZ5c=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v1 6/7] samples/landlock: Add clang-format exceptions
Date:   Fri,  6 May 2022 18:05:12 +0200
Message-Id: <20220506160513.523257-7-mic@digikod.net>
In-Reply-To: <20220506160513.523257-1-mic@digikod.net>
References: <20220506160513.523257-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In preparation to a following commit, add clang-format on and
clang-format off stanzas around constant definitions.  This enables to
keep aligned values, which is much more readable than packed
definitions.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506160513.523257-7-mic@digikod.net
---
 samples/landlock/sandboxer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 8859fc193542..5ce961b5bda7 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -70,11 +70,15 @@ static int parse_path(char *env_path, const char ***const path_list)
 	return num_paths;
 }
 
+/* clang-format off */
+
 #define ACCESS_FILE ( \
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE)
 
+/* clang-format on */
+
 static int populate_ruleset(
 		const char *const env_var, const int ruleset_fd,
 		const __u64 allowed_access)
@@ -139,6 +143,8 @@ static int populate_ruleset(
 	return ret;
 }
 
+/* clang-format off */
+
 #define ACCESS_FS_ROUGHLY_READ ( \
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
@@ -156,6 +162,8 @@ static int populate_ruleset(
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM)
 
+/* clang-format on */
+
 int main(const int argc, char *const argv[], char *const *const envp)
 {
 	const char *cmd_path;
-- 
2.35.1

