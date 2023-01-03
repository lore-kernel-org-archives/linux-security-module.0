Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE7FC4708D
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Jan 2023 19:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjACTDg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 3 Jan 2023 14:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238781AbjACTD0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Jan 2023 14:03:26 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A44B13D52
        for <linux-security-module@vger.kernel.org>; Tue,  3 Jan 2023 11:03:26 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id z7so15561120pfq.13
        for <linux-security-module@vger.kernel.org>; Tue, 03 Jan 2023 11:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Et02GGC5R6WbE5oX7m7ifSd19lcZLjHU93jfCYv8zSk=;
        b=IJdJEeYxmt4E1N92IHeTzDP1w9ph6XmdT2OsZXsJbiIOhRBO5XLgRM1MDJBWNOP5JR
         1KXDiBKMHsulK6eL8/hJRoNaKtr7geI2YP4E4nqMEpcduH1B4W5SAN+Dq7hV7xeRThXl
         w/6CPjhCy9qBEuqVgPjspBLxSJGC1Tk/daK/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Et02GGC5R6WbE5oX7m7ifSd19lcZLjHU93jfCYv8zSk=;
        b=RceOgWenTyTDr4/oZJ9ZhRneSzQC/AQimQvBcnn59AHipboWRr+PYetRdqSLPNUxYC
         j4SzjujBPMsQpXDThGCCpB+jf1CjrIoa3dXxRYYLOAlKcCWJvstvBZ5HP/23IsQe2ovq
         l6P1zwZ7zDaG6GK/jAwj4zlfhMK7Ck7Z+gEbTX+CWdbdEAv2dhoTFJek3mu927wCYYr6
         Hws/44ZZ1PLQ4g9oVmvDCLH/VtHWDeBUWZ5RwxwBvutU5Ud5VJAl5geB4XiQbH/4T2fD
         i9zkr+nPh8QIuOGpl0g2wp7nymPHhs04eFydzX0deyBT6de6RFvvtqm4M5w2HZKVSF7W
         bq8Q==
X-Gm-Message-State: AFqh2kqb5XB7QgjUHyjE69cwya4TjQ5kVpCi0FPrCmy16CUDY4d22lP2
        x64rclD7oBxdedEsb1SeX8F7bg==
X-Google-Smtp-Source: AMrXdXvYR2PS+PjrYRgR388C1mlmq8hlVLZ+83WruIEGwPej5K+pmhDFWSVrenuNLmR0lJ1vjmgO5Q==
X-Received: by 2002:a05:6a00:150c:b0:581:38df:f9f8 with SMTP id q12-20020a056a00150c00b0058138dff9f8mr36730893pfu.4.1672772605521;
        Tue, 03 Jan 2023 11:03:25 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id v189-20020a6261c6000000b00582b4617735sm2147787pfb.194.2023.01.03.11.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 11:03:25 -0800 (PST)
From:   jeffxu@chromium.org
To:     mic@digikod.net
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
Subject: [PATCH v4 1/1] selftests/landlock: skip ptrace_test according to YAMA
Date:   Tue,  3 Jan 2023 19:03:14 +0000
Message-Id: <20230103190314.3882177-2-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230103190314.3882177-1-jeffxu@google.com>
References: <20230103190314.3882177-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

Add check for yama setting for ptrace_test.

Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 .../testing/selftests/landlock/ptrace_test.c  | 48 ++++++++++++++++---
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index c28ef98ff3ac..379f5ddf6c3f 100644
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
@@ -232,8 +249,20 @@ TEST_F(hierarchy, trace)
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
+		SKIP(return, "Yama forbids any ptrace use (scope %d)",
+			   yama_ptrace_scope);
+
+	can_trace_child = !variant->domain_parent && (yama_ptrace_scope < 2);
+	can_trace_parent = !variant->domain_child && (yama_ptrace_scope < 1);
 
 	/*
 	 * Removes all effective and permitted capabilities to not interfere
@@ -258,6 +287,7 @@ TEST_F(hierarchy, trace)
 
 		ASSERT_EQ(0, close(pipe_parent[1]));
 		ASSERT_EQ(0, close(pipe_child[0]));
+
 		if (variant->domain_child)
 			create_domain(_metadata);
 
@@ -267,7 +297,7 @@ TEST_F(hierarchy, trace)
 		/* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent. */
 		err_proc_read = test_ptrace_read(parent);
 		ret = ptrace(PTRACE_ATTACH, parent, NULL, 0);
-		if (variant->domain_child) {
+		if (!can_trace_parent) {
 			EXPECT_EQ(-1, ret);
 			EXPECT_EQ(EPERM, errno);
 			EXPECT_EQ(EACCES, err_proc_read);
@@ -283,7 +313,7 @@ TEST_F(hierarchy, trace)
 
 		/* Tests child PTRACE_TRACEME. */
 		ret = ptrace(PTRACE_TRACEME);
-		if (variant->domain_parent) {
+		if (!can_trace_child) {
 			EXPECT_EQ(-1, ret);
 			EXPECT_EQ(EPERM, errno);
 		} else {
@@ -296,12 +326,12 @@ TEST_F(hierarchy, trace)
 		 */
 		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
 
-		if (!variant->domain_parent) {
+		if (can_trace_child)
 			ASSERT_EQ(0, raise(SIGSTOP));
-		}
 
 		/* Waits for the parent PTRACE_ATTACH test. */
 		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+
 		_exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
 		return;
 	}
@@ -321,7 +351,7 @@ TEST_F(hierarchy, trace)
 	ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
 
 	/* Tests child PTRACE_TRACEME. */
-	if (!variant->domain_parent) {
+	if (can_trace_child) {
 		ASSERT_EQ(child, waitpid(child, &status, 0));
 		ASSERT_EQ(1, WIFSTOPPED(status));
 		ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
@@ -334,7 +364,7 @@ TEST_F(hierarchy, trace)
 	/* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the child. */
 	err_proc_read = test_ptrace_read(child);
 	ret = ptrace(PTRACE_ATTACH, child, NULL, 0);
-	if (variant->domain_parent) {
+	if (!can_trace_child) {
 		EXPECT_EQ(-1, ret);
 		EXPECT_EQ(EPERM, errno);
 		EXPECT_EQ(EACCES, err_proc_read);
@@ -350,10 +380,16 @@ TEST_F(hierarchy, trace)
 
 	/* Signals that the parent PTRACE_ATTACH test is done. */
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
 	ASSERT_EQ(child, waitpid(child, &status, 0));
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

