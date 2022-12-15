Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A73FC4332F
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Dec 2022 00:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiLOAOr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 14 Dec 2022 19:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiLOANq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Dec 2022 19:13:46 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9AC37218
        for <linux-security-module@vger.kernel.org>; Wed, 14 Dec 2022 16:12:19 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so1036342pjd.0
        for <linux-security-module@vger.kernel.org>; Wed, 14 Dec 2022 16:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wap6ucoC/WNJsFqIKWfaQDf7c8pQKriu9bpCkWTKgYw=;
        b=jrjMjhda4PybAUVjFY7IQKKupKhbGV+Mr9a0lFv3B35sRZPqco0xNPmAkFb+WHAFg7
         I9RucflGE1RXALl2sPWfUMgLRPERW8ynUHuM4CeSRxwbtCOFb0CeDVWn+kfFugc7kcVV
         aI+YohYNTtIqZ6VwI2BNdLYoh/3EFdcfO5Ouw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wap6ucoC/WNJsFqIKWfaQDf7c8pQKriu9bpCkWTKgYw=;
        b=dI/7xk1Oa46VxYqSje6T9fcFnrBTTq7aZ9BnnWHaiwmsWaoAELAKXUwwz1sIdiZGZb
         s2yy1+pqFJrzPdRUiM1tPJQ6bIcyq4jeCv+/T7jkL1BKRzalbKryu14so0DQnV7LHfEY
         uD9kuJzv7zRnhk29i3s2yewOR23Q/QNujs6Ezv/UFAoFH7oUeUIOKvwtUwjQq9UMkRDV
         tgv5opN3YnL/fC8/3/XOdMs3lTC0oEvSsF/6aoIlZYzM3qKI+DvScOcJtI9Y5U4nSrFA
         nNrc6FUTo3aIwaQdwaRe68BXpdKV2tgHBoxBD6jPvkg7m6f10xjMcSzfBKhTSsLFoGNI
         XRsg==
X-Gm-Message-State: ANoB5pnvEQ/7n+ui+WM3IKF0VoYKvRBZ9R8KUn0f/5RUyHQTVp6b/GQX
        MD19x2RWYgw7xGS7252U1hLGJw==
X-Google-Smtp-Source: AA0mqf5cZwYQAYuPApV9GBj1mQ1CYi6VGv1tzcvhwLtLDWN1jPWIpK9QDfSh5+tGbml7AZgIHJjXTQ==
X-Received: by 2002:a05:6a21:3a8d:b0:ad:2ae:bb6e with SMTP id zv13-20020a056a213a8d00b000ad02aebb6emr29116822pzb.55.1671063138943;
        Wed, 14 Dec 2022 16:12:18 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a08c300b0021937b2118bsm1845738pjn.54.2022.12.14.16.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 16:12:18 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v8 5/5] selftests/memfd: add tests for MFD_NOEXEC_SEAL MFD_EXEC
Date:   Thu, 15 Dec 2022 00:12:05 +0000
Message-Id: <20221215001205.51969-6-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221215001205.51969-1-jeffxu@google.com>
References: <20221215001205.51969-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

Tests to verify MFD_NOEXEC, MFD_EXEC and vm.memfd_noexec sysctl.

Signed-off-by: Jeff Xu <jeffxu@google.com>
Co-developed-by: Daniel Verkamp <dverkamp@chromium.org>
Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/memfd/fuse_test.c  |   1 +
 tools/testing/selftests/memfd/memfd_test.c | 228 ++++++++++++++++++++-
 2 files changed, 224 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/memfd/fuse_test.c b/tools/testing/selftests/memfd/fuse_test.c
index be675002f918..93798c8c5d54 100644
--- a/tools/testing/selftests/memfd/fuse_test.c
+++ b/tools/testing/selftests/memfd/fuse_test.c
@@ -22,6 +22,7 @@
 #include <linux/falloc.h>
 #include <fcntl.h>
 #include <linux/memfd.h>
+#include <linux/types.h>
 #include <sched.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index f18a15a1f275..ae71f15f790d 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -30,6 +30,14 @@
 
 #define F_SEAL_EXEC	0x0020
 
+#define F_WX_SEALS (F_SEAL_SHRINK | \
+		    F_SEAL_GROW | \
+		    F_SEAL_WRITE | \
+		    F_SEAL_FUTURE_WRITE | \
+		    F_SEAL_EXEC)
+
+#define MFD_NOEXEC_SEAL	0x0008U
+
 /*
  * Default is not to test hugetlbfs
  */
@@ -80,6 +88,37 @@ static int mfd_assert_new(const char *name, loff_t sz, unsigned int flags)
 	return fd;
 }
 
+static void sysctl_assert_write(const char *val)
+{
+	int fd = open("/proc/sys/vm/memfd_noexec", O_WRONLY | O_CLOEXEC);
+
+	if (fd < 0) {
+		printf("open sysctl failed\n");
+		abort();
+	}
+
+	if (write(fd, val, strlen(val)) < 0) {
+		printf("write sysctl failed\n");
+		abort();
+	}
+}
+
+static void sysctl_fail_write(const char *val)
+{
+	int fd = open("/proc/sys/vm/memfd_noexec", O_WRONLY | O_CLOEXEC);
+
+	if (fd < 0) {
+		printf("open sysctl failed\n");
+		abort();
+	}
+
+	if (write(fd, val, strlen(val)) >= 0) {
+		printf("write sysctl %s succeeded, but failure expected\n",
+				val);
+		abort();
+	}
+}
+
 static int mfd_assert_reopen_fd(int fd_in)
 {
 	int fd;
@@ -758,6 +797,9 @@ static void test_create(void)
 	mfd_fail_new("", ~0);
 	mfd_fail_new("", 0x80000000U);
 
+	/* verify EXEC and NOEXEC_SEAL can't both be set */
+	mfd_fail_new("", MFD_EXEC | MFD_NOEXEC_SEAL);
+
 	/* verify MFD_CLOEXEC is allowed */
 	fd = mfd_assert_new("", 0, MFD_CLOEXEC);
 	close(fd);
@@ -969,20 +1011,21 @@ static void test_seal_resize(void)
 
 /*
  * Test SEAL_EXEC
- * Test that chmod() cannot change x bits after sealing
+ * Test fd is created with exec and allow sealing.
+ * chmod() cannot change x bits after sealing.
  */
-static void test_seal_exec(void)
+static void test_exec_seal(void)
 {
 	int fd;
 
 	printf("%s SEAL-EXEC\n", memfd_str);
 
+	printf("%s	Apply SEAL_EXEC\n", memfd_str);
 	fd = mfd_assert_new("kern_memfd_seal_exec",
 			    mfd_def_size,
-			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_EXEC);
 
 	mfd_assert_mode(fd, 0777);
-
 	mfd_assert_chmod(fd, 0644);
 
 	mfd_assert_has_seals(fd, 0);
@@ -996,10 +1039,181 @@ static void test_seal_exec(void)
 	mfd_fail_chmod(fd, 0700);
 	mfd_fail_chmod(fd, 0100);
 	mfd_assert_chmod(fd, 0666);
+	mfd_assert_write(fd);
+	close(fd);
+
+	printf("%s	Apply ALL_SEALS\n", memfd_str);
+	fd = mfd_assert_new("kern_memfd_seal_exec",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_EXEC);
+
+	mfd_assert_mode(fd, 0777);
+	mfd_assert_chmod(fd, 0700);
+
+	mfd_assert_has_seals(fd, 0);
+	mfd_assert_add_seals(fd, F_SEAL_EXEC);
+	mfd_assert_has_seals(fd, F_WX_SEALS);
 
+	mfd_fail_chmod(fd, 0711);
+	mfd_fail_chmod(fd, 0600);
+	mfd_fail_write(fd);
+	close(fd);
+}
+
+/*
+ * Test EXEC_NO_SEAL
+ * Test fd is created with exec and not allow sealing.
+ */
+static void test_exec_no_seal(void)
+{
+	int fd;
+
+	printf("%s EXEC_NO_SEAL\n", memfd_str);
+
+	/* Create with EXEC but without ALLOW_SEALING */
+	fd = mfd_assert_new("kern_memfd_exec_no_sealing",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_EXEC);
+	mfd_assert_mode(fd, 0777);
+	mfd_assert_has_seals(fd, F_SEAL_SEAL);
+	mfd_assert_chmod(fd, 0666);
 	close(fd);
 }
 
+/*
+ * Test memfd_create with MFD_NOEXEC flag
+ */
+static void test_noexec_seal(void)
+{
+	int fd;
+
+	printf("%s NOEXEC_SEAL\n", memfd_str);
+
+	/* Create with NOEXEC and ALLOW_SEALING */
+	fd = mfd_assert_new("kern_memfd_noexec",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_NOEXEC_SEAL);
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+	mfd_fail_chmod(fd, 0777);
+	close(fd);
+
+	/* Create with NOEXEC but without ALLOW_SEALING */
+	fd = mfd_assert_new("kern_memfd_noexec",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_NOEXEC_SEAL);
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+	mfd_fail_chmod(fd, 0777);
+	close(fd);
+}
+
+static void test_sysctl_child(void)
+{
+	int fd;
+
+	printf("%s sysctl 0\n", memfd_str);
+	sysctl_assert_write("0");
+	fd = mfd_assert_new("kern_memfd_sysctl_0",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	mfd_assert_mode(fd, 0777);
+	mfd_assert_has_seals(fd, 0);
+	mfd_assert_chmod(fd, 0644);
+	close(fd);
+
+	printf("%s sysctl 1\n", memfd_str);
+	sysctl_assert_write("1");
+	fd = mfd_assert_new("kern_memfd_sysctl_1",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+	mfd_fail_chmod(fd, 0777);
+	sysctl_fail_write("0");
+	close(fd);
+
+	printf("%s sysctl 2\n", memfd_str);
+	sysctl_assert_write("2");
+	mfd_fail_new("kern_memfd_sysctl_2",
+		MFD_CLOEXEC | MFD_ALLOW_SEALING);
+	sysctl_fail_write("0");
+	sysctl_fail_write("1");
+}
+
+static int newpid_thread_fn(void *arg)
+{
+	test_sysctl_child();
+	return 0;
+}
+
+static void test_sysctl_child2(void)
+{
+	int fd;
+
+	sysctl_fail_write("0");
+	fd = mfd_assert_new("kern_memfd_sysctl_1",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+	mfd_fail_chmod(fd, 0777);
+	close(fd);
+}
+
+static int newpid_thread_fn2(void *arg)
+{
+	test_sysctl_child2();
+	return 0;
+}
+static pid_t spawn_newpid_thread(unsigned int flags, int (*fn)(void *))
+{
+	uint8_t *stack;
+	pid_t pid;
+
+	stack = malloc(STACK_SIZE);
+	if (!stack) {
+		printf("malloc(STACK_SIZE) failed: %m\n");
+		abort();
+	}
+
+	pid = clone(fn,
+		    stack + STACK_SIZE,
+		    SIGCHLD | flags,
+		    NULL);
+	if (pid < 0) {
+		printf("clone() failed: %m\n");
+		abort();
+	}
+
+	return pid;
+}
+
+static void join_newpid_thread(pid_t pid)
+{
+	waitpid(pid, NULL, 0);
+}
+
+/*
+ * Test sysctl
+ * A very basic sealing test to see whether setting/retrieving seals works.
+ */
+static void test_sysctl(void)
+{
+	int pid = spawn_newpid_thread(CLONE_NEWPID, newpid_thread_fn);
+
+	join_newpid_thread(pid);
+
+	printf("%s child ns\n", memfd_str);
+	sysctl_assert_write("1");
+
+	pid = spawn_newpid_thread(CLONE_NEWPID, newpid_thread_fn2);
+	join_newpid_thread(pid);
+}
+
 /*
  * Test sharing via dup()
  * Test that seals are shared between dupped FDs and they're all equal.
@@ -1173,13 +1387,15 @@ int main(int argc, char **argv)
 
 	test_create();
 	test_basic();
+	test_exec_seal();
+	test_exec_no_seal();
+	test_noexec_seal();
 
 	test_seal_write();
 	test_seal_future_write();
 	test_seal_shrink();
 	test_seal_grow();
 	test_seal_resize();
-	test_seal_exec();
 
 	test_share_dup("SHARE-DUP", "");
 	test_share_mmap("SHARE-MMAP", "");
@@ -1195,6 +1411,8 @@ int main(int argc, char **argv)
 	test_share_fork("SHARE-FORK", SHARED_FT_STR);
 	join_idle_thread(pid);
 
+	test_sysctl();
+
 	printf("memfd: DONE\n");
 
 	return 0;
-- 
2.39.0.rc1.256.g54fd8350bd-goog

