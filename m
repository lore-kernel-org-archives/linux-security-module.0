Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AE0C54EBE
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Jan 2023 05:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjAMFJb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 Jan 2023 00:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjAMFIu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Jan 2023 00:08:50 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D7A5BA29
        for <linux-security-module@vger.kernel.org>; Thu, 12 Jan 2023 21:08:09 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o13so17822311pjg.2
        for <linux-security-module@vger.kernel.org>; Thu, 12 Jan 2023 21:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6cTFT+WvwMyynynie1nGezFiYG1nu1/Yg3TS1yFMDs=;
        b=TNBZm9X93ft9Jgo2C71uSDx71WX6CFslHbtHCszW2cY1Nin/P4s47mj+E85EGE4G7s
         KxhafkMgif2yxlJj+B2a0ZHeVuc0SG1Bx4iPNmied4bQ6o6/oQ32TGAFw1oI5ufBdZ2A
         2jXm2UbsJ5FOe90SSOU0PHruO5/p+s7U6fers=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6cTFT+WvwMyynynie1nGezFiYG1nu1/Yg3TS1yFMDs=;
        b=JZ4qCO4uOa0Lc4L/GahvDqBd7XaPoC5hgMzymrNZl5ZddKXsuZikh/PSh3yyNCZr7v
         uuIgNNn2HWF9pgk6lutBivl1XyuQgitgdS5J90Aawl9JlE/8yhkJHwgS/wrBKEreQ1G5
         ERU6m/JeSSMpVm5y1vXpmkZ8LvSMFpWzmeWndgetXe924WbCW+UIkNyPlMjMCz2pwGAY
         HdQj263GQdnQu8MIV/y4gwaeh39ysaarM3jECQvuWaybacqgzXjbNIH+RCWCGO8FFrTO
         H9EhLBeUuSc/389Z1XUJg5RbUstIGZotpzUsqbeVy2zlDgD77fuRWJxbxHkBbR/cQKK0
         nqqA==
X-Gm-Message-State: AFqh2krM03AL9SaQi7689eQ/2KwPUnY0yMXRSQNB4z4dKVQyzsKhxCnQ
        Sox5o77Pbpgcz4Ba+nD62FZ0FA==
X-Google-Smtp-Source: AMrXdXtk0fmkaxoEQaSTYBbkjXbYgwWO8SzcGmie4GSAjhSuWmYnM/rWZMHZsrUTWzWHg4nibfqP7w==
X-Received: by 2002:a17:903:2781:b0:194:62d9:9a86 with SMTP id jw1-20020a170903278100b0019462d99a86mr3966507plb.59.1673586488728;
        Thu, 12 Jan 2023 21:08:08 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b00192849e1d0asm12995350plk.116.2023.01.12.21.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 21:08:08 -0800 (PST)
From:   jeffxu@chromium.org
To:     mic@digikod.net
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
Subject: [PATCH v5 1/1] selftests/landlock: skip ptrace_test according to YAMA
Date:   Fri, 13 Jan 2023 05:07:55 +0000
Message-Id: <20230113050755.1277736-2-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230113050755.1277736-1-jeffxu@google.com>
References: <20230113050755.1277736-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

Add check for yama setting for ptrace_test.

Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 .../testing/selftests/landlock/ptrace_test.c  | 82 +++++++++++++++++--
 1 file changed, 76 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index c28ef98ff3ac..c9d9f3001d0f 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -19,6 +19,12 @@
 
 #include "common.h"
 
+/* copy from yama_lsm.c */
+#define YAMA_SCOPE_DISABLED 0
+#define YAMA_SCOPE_RELATIONAL 1
+#define YAMA_SCOPE_CAPABILITY 2
+#define YAMA_SCOPE_NO_ATTACH 3
+
 static void create_domain(struct __test_metadata *const _metadata)
 {
 	int ruleset_fd;
@@ -60,6 +66,25 @@ static int test_ptrace_read(const pid_t pid)
 	return 0;
 }
 
+static int get_yama_ptrace_scope(void)
+{
+	int ret;
+	char buf[2] = {};
+	int fd = open("/proc/sys/kernel/yama/ptrace_scope", O_RDONLY);
+
+	if (fd < 0)
+		return 0;
+
+	if (read(fd, buf, 1) < 0) {
+		close(fd);
+		return -1;
+	}
+
+	ret = atoi(buf);
+	close(fd);
+	return ret;
+}
+
 /* clang-format off */
 FIXTURE(hierarchy) {};
 /* clang-format on */
@@ -232,8 +257,49 @@ TEST_F(hierarchy, trace)
 	pid_t child, parent;
 	int status, err_proc_read;
 	int pipe_child[2], pipe_parent[2];
+	int yama_ptrace_scope;
 	char buf_parent;
 	long ret;
+	bool can_trace_child, can_trace_parent;
+
+	yama_ptrace_scope = get_yama_ptrace_scope();
+	ASSERT_LE(0, yama_ptrace_scope);
+
+	if (yama_ptrace_scope >= YAMA_SCOPE_NO_ATTACH)
+		SKIP(return, "Yama forbids any ptrace use (scope %d)",
+			   yama_ptrace_scope);
+
+	/*
+	 * can_trace_child: if a parent process can trace its child process.
+	 *
+	 * There are two conditions concerning landlock:
+	 * 1> the parent and child processes are in the same landlock domain or
+	 *	one beneath it (case: domain_both = true).
+	 * 2> yama allows tracing children (up to YAMA_SCOPE_RELATIONAL).
+	 * Both 1 and 2 need to be met for can_trace_child to be true.
+	 *
+	 * If a parent process has its own domain not shared with the child
+	 * process (case:domain_parent = true), then the parent can't trace the
+	 * child.
+	 */
+	can_trace_child = !variant->domain_parent &&
+			  yama_ptrace_scope < YAMA_SCOPE_CAPABILITY;
+
+	/*
+	 * can_trace_parent: if a child process can trace its parent process.
+	 *
+	 * There are two conditions concerning landlock:
+	 * 1> the parent and child process are in the same landlock domain or
+	 *	one beneath it.(case: domain_both = true).
+	 * 2> yama is disabled (YAMA_SCOPE_DISABLED).
+	 * Both 1 and 2 need to be met for can_trace_parent to be true.
+	 *
+	 * If a child process has its own domain not shared with the parent
+	 * process (case:domain_child = true, then the child can't trace the
+	 * parent.
+	 */
+	can_trace_parent = !variant->domain_child &&
+			   yama_ptrace_scope < YAMA_SCOPE_RELATIONAL;
 
 	/*
 	 * Removes all effective and permitted capabilities to not interfere
@@ -267,7 +333,7 @@ TEST_F(hierarchy, trace)
 		/* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent. */
 		err_proc_read = test_ptrace_read(parent);
 		ret = ptrace(PTRACE_ATTACH, parent, NULL, 0);
-		if (variant->domain_child) {
+		if (!can_trace_parent) {
 			EXPECT_EQ(-1, ret);
 			EXPECT_EQ(EPERM, errno);
 			EXPECT_EQ(EACCES, err_proc_read);
@@ -283,7 +349,7 @@ TEST_F(hierarchy, trace)
 
 		/* Tests child PTRACE_TRACEME. */
 		ret = ptrace(PTRACE_TRACEME);
-		if (variant->domain_parent) {
+		if (!can_trace_child) {
 			EXPECT_EQ(-1, ret);
 			EXPECT_EQ(EPERM, errno);
 		} else {
@@ -296,9 +362,8 @@ TEST_F(hierarchy, trace)
 		 */
 		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
 
-		if (!variant->domain_parent) {
+		if (can_trace_child)
 			ASSERT_EQ(0, raise(SIGSTOP));
-		}
 
 		/* Waits for the parent PTRACE_ATTACH test. */
 		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
@@ -321,7 +386,7 @@ TEST_F(hierarchy, trace)
 	ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
 
 	/* Tests child PTRACE_TRACEME. */
-	if (!variant->domain_parent) {
+	if (can_trace_child) {
 		ASSERT_EQ(child, waitpid(child, &status, 0));
 		ASSERT_EQ(1, WIFSTOPPED(status));
 		ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
@@ -334,7 +399,7 @@ TEST_F(hierarchy, trace)
 	/* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the child. */
 	err_proc_read = test_ptrace_read(child);
 	ret = ptrace(PTRACE_ATTACH, child, NULL, 0);
-	if (variant->domain_parent) {
+	if (!can_trace_child) {
 		EXPECT_EQ(-1, ret);
 		EXPECT_EQ(EPERM, errno);
 		EXPECT_EQ(EACCES, err_proc_read);
@@ -354,6 +419,11 @@ TEST_F(hierarchy, trace)
 	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
 	    WEXITSTATUS(status) != EXIT_SUCCESS)
 		_metadata->passed = 0;
+
+	if (yama_ptrace_scope > 0)
+		SKIP(return,
+			   "Incomplete tests due to Yama restrictions (scope %d)",
+			   yama_ptrace_scope);
 }
 
 TEST_HARNESS_MAIN
-- 
2.39.0.314.g84b9a713c41-goog

