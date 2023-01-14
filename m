Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C261C54EBE
	for <linux-security-module@archiver.kernel.org>; Sat, 14 Jan 2023 02:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjANCDQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 Jan 2023 21:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjANCDP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Jan 2023 21:03:15 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7368B52D
        for <linux-security-module@vger.kernel.org>; Fri, 13 Jan 2023 18:03:14 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso26136350pjf.1
        for <linux-security-module@vger.kernel.org>; Fri, 13 Jan 2023 18:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ett+htX1yGz9n8aZaPRQ+Bpgc0Hh0la0lkQSj04Igpk=;
        b=bf7FOYMB3FKT6aUUjdrfyFLEpnx7qwJXWCfMAVCVC5ouI7Bpi0PA5jBDvYx9e9VVOB
         Uo4AEEWxdlS/RZ4XnlrHQ0t0NuFBVbek1j9L/9pyATHmbL9S5myv7/wRfxjLVG41hB8n
         LMP3rMqioi2wy9IReREQYgsRlp50BA/9I9qo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ett+htX1yGz9n8aZaPRQ+Bpgc0Hh0la0lkQSj04Igpk=;
        b=OWcMDnHQlygQTAnN9t7OpY9+baTFeaTNPQ9nVD3DBUcCXahnGu0OpUPUZPDP8sMqTb
         ZAA+Wnl3FKsAx31jukByiueeU3hErpUs0k68lCJGsL8fzMvPClKdbuhXurZfmPV5MOb5
         W8NiDDe9UxkMa9lTYyLbhdWg1uTx2S7UHn5tS1jjmTv54L2GHjoZfBNKdbuECm1nOxMY
         N0tvYBCQPeYhgjiy3BegjJqXJGDrnwGPbQUJpz6MNgfZMoCKCZdhafJcFKI1WxI1YMaY
         yTMuDHnL37ZoSgwN2jvrDtHvfafUbtBFkvuXJHiIKJf1TjsMBAsYVgDEf8EpgoGY5c+q
         +0XQ==
X-Gm-Message-State: AFqh2krq8N++9Cw3y3EKW8LFPlNeBPDUT9bzHhvEtQDOE2TwpHZggLKY
        VF1pgwff2rZQwesIKSSbBlKu2Q==
X-Google-Smtp-Source: AMrXdXuMWvoV0X9gmM/q7uwUcBsZPn0hc33I+56InNzzdvGVQeXceA5hzW8jmPQWrZpX9aMXmOJOnQ==
X-Received: by 2002:a05:6a21:3a45:b0:9d:efbe:e607 with SMTP id zu5-20020a056a213a4500b0009defbee607mr96200698pzb.35.1673661794166;
        Fri, 13 Jan 2023 18:03:14 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id l33-20020a635721000000b0047702d44861sm11882491pgb.18.2023.01.13.18.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 18:03:13 -0800 (PST)
From:   jeffxu@chromium.org
To:     mic@digikod.net
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
Subject: [PATCH v6 1/1] selftests/landlock: skip ptrace_test according to YAMA
Date:   Sat, 14 Jan 2023 02:03:06 +0000
Message-Id: <20230114020306.1407195-2-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230114020306.1407195-1-jeffxu@google.com>
References: <20230114020306.1407195-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

Add check for yama setting for ptrace_test.

Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 .../testing/selftests/landlock/ptrace_test.c  | 112 +++++++++++++++---
 1 file changed, 94 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index c28ef98ff3ac..4881fa428253 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -19,6 +19,12 @@
 
 #include "common.h"
 
+/* Copied from security/yama/yama_lsm.c */
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
+	const int fd = open("/proc/sys/kernel/yama/ptrace_scope", O_RDONLY);
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
@@ -232,8 +257,51 @@ TEST_F(hierarchy, trace)
 	pid_t child, parent;
 	int status, err_proc_read;
 	int pipe_child[2], pipe_parent[2];
+	int yama_ptrace_scope;
 	char buf_parent;
 	long ret;
+	bool can_read_child, can_trace_child, can_read_parent, can_trace_parent;
+
+	yama_ptrace_scope = get_yama_ptrace_scope();
+	ASSERT_LE(0, yama_ptrace_scope);
+
+	if (yama_ptrace_scope > YAMA_SCOPE_DISABLED)
+		TH_LOG("Incomplete tests due to Yama restrictions (scope %d)",
+		       yama_ptrace_scope);
+
+	/*
+	 * can_read_child is true if a parent process can read its child
+	 * process, which is only the case when the parent process is not
+	 * isolated from the child with a dedicated Landlock domain.
+	 */
+	can_read_child = !variant->domain_parent;
+
+	/*
+	 * can_trace_child is true if a parent process can trace its child
+	 * process.  This depends on two conditions:
+	 * - The parent process is not isolated from the child with a dedicated
+	 *   Landlock domain.
+	 * - Yama allows tracing children (up to YAMA_SCOPE_RELATIONAL).
+	 */
+	can_trace_child = can_read_child &&
+			  yama_ptrace_scope <= YAMA_SCOPE_RELATIONAL;
+
+	/*
+	 * can_read_parent is true if a child process can read its parent
+	 * process, which is only the case when the child process is not
+	 * isolated from the parent with a dedicated Landlock domain.
+	 */
+	can_read_parent = !variant->domain_child;
+
+	/*
+	 * can_trace_parent is true if a child process can trace its parent
+	 * process.  This depends on two conditions:
+	 * - The child process is not isolated from the parent with a dedicated
+	 *   Landlock domain.
+	 * - Yama is disabled (YAMA_SCOPE_DISABLED).
+	 */
+	can_trace_parent = can_read_parent &&
+			   yama_ptrace_scope <= YAMA_SCOPE_DISABLED;
 
 	/*
 	 * Removes all effective and permitted capabilities to not interfere
@@ -264,16 +332,20 @@ TEST_F(hierarchy, trace)
 		/* Waits for the parent to be in a domain, if any. */
 		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
 
-		/* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent. */
+		/* Tests PTRACE_MODE_READ on the parent. */
 		err_proc_read = test_ptrace_read(parent);
+		if (can_read_parent)
+			EXPECT_EQ(0, err_proc_read);
+		else
+			EXPECT_EQ(EACCES, err_proc_read);
+
+		/* Tests PTRACE_ATTACH on the parent. */
 		ret = ptrace(PTRACE_ATTACH, parent, NULL, 0);
-		if (variant->domain_child) {
+		if (can_trace_parent) {
+			EXPECT_EQ(0, ret);
+		} else {
 			EXPECT_EQ(-1, ret);
 			EXPECT_EQ(EPERM, errno);
-			EXPECT_EQ(EACCES, err_proc_read);
-		} else {
-			EXPECT_EQ(0, ret);
-			EXPECT_EQ(0, err_proc_read);
 		}
 		if (ret == 0) {
 			ASSERT_EQ(parent, waitpid(parent, &status, 0));
@@ -283,11 +355,11 @@ TEST_F(hierarchy, trace)
 
 		/* Tests child PTRACE_TRACEME. */
 		ret = ptrace(PTRACE_TRACEME);
-		if (variant->domain_parent) {
+		if (can_trace_child) {
+			EXPECT_EQ(0, ret);
+		} else {
 			EXPECT_EQ(-1, ret);
 			EXPECT_EQ(EPERM, errno);
-		} else {
-			EXPECT_EQ(0, ret);
 		}
 
 		/*
@@ -296,9 +368,8 @@ TEST_F(hierarchy, trace)
 		 */
 		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
 
-		if (!variant->domain_parent) {
+		if (can_trace_child)
 			ASSERT_EQ(0, raise(SIGSTOP));
-		}
 
 		/* Waits for the parent PTRACE_ATTACH test. */
 		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
@@ -321,7 +392,7 @@ TEST_F(hierarchy, trace)
 	ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
 
 	/* Tests child PTRACE_TRACEME. */
-	if (!variant->domain_parent) {
+	if (can_trace_child) {
 		ASSERT_EQ(child, waitpid(child, &status, 0));
 		ASSERT_EQ(1, WIFSTOPPED(status));
 		ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
@@ -331,17 +402,22 @@ TEST_F(hierarchy, trace)
 		EXPECT_EQ(ESRCH, errno);
 	}
 
-	/* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the child. */
+	/* Tests PTRACE_MODE_READ on the child. */
 	err_proc_read = test_ptrace_read(child);
+	if (can_read_child)
+		EXPECT_EQ(0, err_proc_read);
+	else
+		EXPECT_EQ(EACCES, err_proc_read);
+
+	/* Tests PTRACE_ATTACH on the child. */
 	ret = ptrace(PTRACE_ATTACH, child, NULL, 0);
-	if (variant->domain_parent) {
+	if (can_trace_child) {
+		EXPECT_EQ(0, ret);
+	} else {
 		EXPECT_EQ(-1, ret);
 		EXPECT_EQ(EPERM, errno);
-		EXPECT_EQ(EACCES, err_proc_read);
-	} else {
-		EXPECT_EQ(0, ret);
-		EXPECT_EQ(0, err_proc_read);
 	}
+
 	if (ret == 0) {
 		ASSERT_EQ(child, waitpid(child, &status, 0));
 		ASSERT_EQ(1, WIFSTOPPED(status));
-- 
2.39.0.314.g84b9a713c41-goog

