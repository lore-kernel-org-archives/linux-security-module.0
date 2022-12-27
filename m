Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9A1C4167B
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Dec 2022 14:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiL0ODB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Dec 2022 09:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiL0OC7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Dec 2022 09:02:59 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125865FF6
        for <linux-security-module@vger.kernel.org>; Tue, 27 Dec 2022 06:02:59 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 65so8909951pfx.9
        for <linux-security-module@vger.kernel.org>; Tue, 27 Dec 2022 06:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjYnIHfFPkUqlKUlRBbRz9We4Q+6NFiwaElQd9mxXFQ=;
        b=Jui54C3l0QLLzVAl75PU9jrPzl/7yftEOFFJzwb3PtJELVRyKsOTxAqlmn8FyE/meR
         ysWj0fLu/5MEjEaFZ9i5Pn3I5CwMBvZUEG5IqS0GsQY7UEQzZEYhBI3naJR2QsTGqWj4
         4VEcAW09kzJOOEO3aWOnb9jVjYO/rHLFpzLJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjYnIHfFPkUqlKUlRBbRz9We4Q+6NFiwaElQd9mxXFQ=;
        b=Lid6cvqrKWgQgCZf+Bnc3oSgJbCnPwNEOzJPK7kXQHIDgD+KrW2olZT4OP+3w5n/HJ
         75gRqL7jSX6Snm7aN5TwGrBL/th31DefRJBEzpU7anWkvc0T24cZV4PrMkPdKKlY0gY/
         qXlmh7N58oo4RI6CyITPY25UNu2A4O4LJAJYpPu3TKMw0TVAKY2uoGfrPlQ8hefqWw3w
         MjgldcJy6Q4DeTEhVT8Kvem8hSkBJBgSZ2tVRki6EVwouHPvGjuzevaOKOD2oORBN+7z
         shxoCNEjCTZbOlhZBNiwrCy2VUIs6sGd3DJZ+WBIGOzWTHIVgANg/JRSHZZqmsexnKRr
         c9EA==
X-Gm-Message-State: AFqh2kqH9wEsggZtU+04wqxUpcH7ZY9iK5FHe9/Afz3mZr+1s/bDFMpS
        rplgJrvVdTmwpfoDzzXQJ7yly5gAEUGAdLdy
X-Google-Smtp-Source: AMrXdXv0XhZpkALfP6NTcLltmXAKxz3DvgxBwad43kU7KAgRVcY0PqUxpEUZ74BmTXlSOzRaxqXNxA==
X-Received: by 2002:a05:6a00:400e:b0:577:9807:543b with SMTP id by14-20020a056a00400e00b005779807543bmr25547748pfb.16.1672149778500;
        Tue, 27 Dec 2022 06:02:58 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id y17-20020a626411000000b00575b6d7c458sm8674530pfb.21.2022.12.27.06.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 06:02:57 -0800 (PST)
From:   jeffxu@chromium.org
To:     mic@digikod.net
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
Subject: [PATCH v3 1/1] selftests/landlock: skip ptrace_test according to YAMA
Date:   Tue, 27 Dec 2022 14:02:44 +0000
Message-Id: <20221227140244.1041292-2-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221227140244.1041292-1-jeffxu@google.com>
References: <20221227140244.1041292-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

Add check for yama setting for ptrace_test.

Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 .../testing/selftests/landlock/ptrace_test.c  | 173 ++++++++++++------
 1 file changed, 112 insertions(+), 61 deletions(-)

diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index c28ef98ff3ac..0056815deef8 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -60,6 +60,23 @@ static int test_ptrace_read(const pid_t pid)
 	return 0;
 }
 
+static int get_yama_ptrace_scope(void)
+{
+	int ret = -1;
+	char buf[2] = {};
+	int fd = open("/proc/sys/kernel/yama/ptrace_scope", O_RDONLY);
+
+	if (fd < 0)
+		return 0;
+
+	if (read(fd, &buf, 1) < 0)
+		return -1;
+
+	ret = atoi(buf);
+	close(fd);
+	return ret;
+}
+
 /* clang-format off */
 FIXTURE(hierarchy) {};
 /* clang-format on */
@@ -69,6 +86,7 @@ FIXTURE_VARIANT(hierarchy)
 	const bool domain_both;
 	const bool domain_parent;
 	const bool domain_child;
+	const int  yama_ptrace_scope_max_supported;
 };
 
 /*
@@ -93,6 +111,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_without_domain) {
 	.domain_both = false,
 	.domain_parent = false,
 	.domain_child = false,
+	.yama_ptrace_scope_max_supported = 0,
 };
 
 /*
@@ -110,6 +129,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_with_one_domain) {
 	.domain_both = false,
 	.domain_parent = false,
 	.domain_child = true,
+	.yama_ptrace_scope_max_supported = 1,
 };
 
 /*
@@ -126,6 +146,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_parent_domain) {
 	.domain_both = false,
 	.domain_parent = true,
 	.domain_child = false,
+	.yama_ptrace_scope_max_supported = 0,
 };
 
 /*
@@ -143,6 +164,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_sibling_domain) {
 	.domain_both = false,
 	.domain_parent = true,
 	.domain_child = true,
+	.yama_ptrace_scope_max_supported = 2,
 };
 
 /*
@@ -160,6 +182,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_sibling_domain) {
 	.domain_both = true,
 	.domain_parent = false,
 	.domain_child = false,
+	.yama_ptrace_scope_max_supported = 0,
 };
 
 /*
@@ -178,6 +201,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_with_nested_domain) {
 	.domain_both = true,
 	.domain_parent = false,
 	.domain_child = true,
+	.yama_ptrace_scope_max_supported = 1,
 };
 
 /*
@@ -196,6 +220,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_nested_and_parent_domain) {
 	.domain_both = true,
 	.domain_parent = true,
 	.domain_child = false,
+	.yama_ptrace_scope_max_supported = 0,
 };
 
 /*
@@ -216,6 +241,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_forked_domain) {
 	.domain_both = true,
 	.domain_parent = true,
 	.domain_child = true,
+	.yama_ptrace_scope_max_supported = 2,
 };
 
 FIXTURE_SETUP(hierarchy)
@@ -232,8 +258,20 @@ TEST_F(hierarchy, trace)
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
+	if (yama_ptrace_scope >= 3)
+		SKIP(return, "Yama forbids any ptrace use (scope %d)", yama_ptrace_scope);
+
+	can_trace_child = !variant->domain_parent && (yama_ptrace_scope < 2);
+	can_trace_parent = !variant->domain_child && (yama_ptrace_scope < 1);
+	TH_LOG("can_trace_child:%d, can_trace_parent:%d", can_trace_child, can_trace_parent);
 
 	/*
 	 * Removes all effective and permitted capabilities to not interfere
@@ -258,6 +296,7 @@ TEST_F(hierarchy, trace)
 
 		ASSERT_EQ(0, close(pipe_parent[1]));
 		ASSERT_EQ(0, close(pipe_child[0]));
+
 		if (variant->domain_child)
 			create_domain(_metadata);
 
@@ -265,43 +304,47 @@ TEST_F(hierarchy, trace)
 		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
 
 		/* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent. */
-		err_proc_read = test_ptrace_read(parent);
-		ret = ptrace(PTRACE_ATTACH, parent, NULL, 0);
-		if (variant->domain_child) {
-			EXPECT_EQ(-1, ret);
-			EXPECT_EQ(EPERM, errno);
-			EXPECT_EQ(EACCES, err_proc_read);
-		} else {
-			EXPECT_EQ(0, ret);
-			EXPECT_EQ(0, err_proc_read);
-		}
-		if (ret == 0) {
-			ASSERT_EQ(parent, waitpid(parent, &status, 0));
-			ASSERT_EQ(1, WIFSTOPPED(status));
-			ASSERT_EQ(0, ptrace(PTRACE_DETACH, parent, NULL, 0));
+		if (can_trace_parent) {
+			err_proc_read = test_ptrace_read(parent);
+			ret = ptrace(PTRACE_ATTACH, parent, NULL, 0);
+			if (variant->domain_child) {
+				EXPECT_EQ(-1, ret);
+				EXPECT_EQ(EPERM, errno);
+				EXPECT_EQ(EACCES, err_proc_read);
+			} else {
+				EXPECT_EQ(0, ret);
+				EXPECT_EQ(0, err_proc_read);
+			}
+			if (ret == 0) {
+				ASSERT_EQ(parent, waitpid(parent, &status, 0));
+				ASSERT_EQ(1, WIFSTOPPED(status));
+				ASSERT_EQ(0, ptrace(PTRACE_DETACH, parent, NULL, 0));
+			}
 		}
 
 		/* Tests child PTRACE_TRACEME. */
-		ret = ptrace(PTRACE_TRACEME);
-		if (variant->domain_parent) {
-			EXPECT_EQ(-1, ret);
-			EXPECT_EQ(EPERM, errno);
-		} else {
-			EXPECT_EQ(0, ret);
+		if (can_trace_child) {
+			ret = ptrace(PTRACE_TRACEME);
+			if (variant->domain_parent) {
+				EXPECT_EQ(-1, ret);
+				EXPECT_EQ(EPERM, errno);
+			} else {
+				EXPECT_EQ(0, ret);
+			}
+
+			/*
+			 * Signals that the PTRACE_ATTACH test is done and the
+			 * PTRACE_TRACEME test is ongoing.
+			 */
+			ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+
+			if (!variant->domain_parent)
+				ASSERT_EQ(0, raise(SIGSTOP));
+
+			/* Waits for the parent PTRACE_ATTACH test. */
+			ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
 		}
 
-		/*
-		 * Signals that the PTRACE_ATTACH test is done and the
-		 * PTRACE_TRACEME test is ongoing.
-		 */
-		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
-
-		if (!variant->domain_parent) {
-			ASSERT_EQ(0, raise(SIGSTOP));
-		}
-
-		/* Waits for the parent PTRACE_ATTACH test. */
-		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
 		_exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
 		return;
 	}
@@ -318,42 +361,50 @@ TEST_F(hierarchy, trace)
 	 * Waits for the child to test PTRACE_ATTACH on the parent and start
 	 * testing PTRACE_TRACEME.
 	 */
-	ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
-
-	/* Tests child PTRACE_TRACEME. */
-	if (!variant->domain_parent) {
-		ASSERT_EQ(child, waitpid(child, &status, 0));
-		ASSERT_EQ(1, WIFSTOPPED(status));
-		ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
-	} else {
-		/* The child should not be traced by the parent. */
-		EXPECT_EQ(-1, ptrace(PTRACE_DETACH, child, NULL, 0));
-		EXPECT_EQ(ESRCH, errno);
-	}
+	if (can_trace_child) {
+		ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
 
-	/* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the child. */
-	err_proc_read = test_ptrace_read(child);
-	ret = ptrace(PTRACE_ATTACH, child, NULL, 0);
-	if (variant->domain_parent) {
-		EXPECT_EQ(-1, ret);
-		EXPECT_EQ(EPERM, errno);
-		EXPECT_EQ(EACCES, err_proc_read);
-	} else {
-		EXPECT_EQ(0, ret);
-		EXPECT_EQ(0, err_proc_read);
-	}
-	if (ret == 0) {
-		ASSERT_EQ(child, waitpid(child, &status, 0));
-		ASSERT_EQ(1, WIFSTOPPED(status));
-		ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
+		/* Tests child PTRACE_TRACEME. */
+		if (!variant->domain_parent) {
+			ASSERT_EQ(child, waitpid(child, &status, 0));
+			ASSERT_EQ(1, WIFSTOPPED(status));
+			ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
+		} else {
+			/* The child should not be traced by the parent. */
+			EXPECT_EQ(-1, ptrace(PTRACE_DETACH, child, NULL, 0));
+			EXPECT_EQ(ESRCH, errno);
+		}
+
+		/* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the child. */
+		err_proc_read = test_ptrace_read(child);
+		ret = ptrace(PTRACE_ATTACH, child, NULL, 0);
+		if (variant->domain_parent) {
+			EXPECT_EQ(-1, ret);
+			EXPECT_EQ(EPERM, errno);
+			EXPECT_EQ(EACCES, err_proc_read);
+		} else {
+			EXPECT_EQ(0, ret);
+			EXPECT_EQ(0, err_proc_read);
+		}
+		if (ret == 0) {
+			ASSERT_EQ(child, waitpid(child, &status, 0));
+			ASSERT_EQ(1, WIFSTOPPED(status));
+			ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
+		}
+
+		/* Signals that the parent PTRACE_ATTACH test is done. */
+		ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
 	}
 
-	/* Signals that the parent PTRACE_ATTACH test is done. */
-	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
 	    WEXITSTATUS(status) != EXIT_SUCCESS)
 		_metadata->passed = 0;
+
+	if (yama_ptrace_scope > 0)
+		SKIP(return, "Incomplete tests due to Yama restrictions (ptrace_scope:%d)",
+			yama_ptrace_scope);
+
 }
 
 TEST_HARNESS_MAIN
-- 
2.39.0.314.g84b9a713c41-goog

