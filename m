Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E444C25B04
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Dec 2022 16:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiLIQFF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Dec 2022 11:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiLIQFD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Dec 2022 11:05:03 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832EF532C5
        for <linux-security-module@vger.kernel.org>; Fri,  9 Dec 2022 08:05:02 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id n3so3991252pfq.10
        for <linux-security-module@vger.kernel.org>; Fri, 09 Dec 2022 08:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFajmLWzEheOspCEYhY0eo6ZhecGZeOzelViubfUiKU=;
        b=dptKtOCdTYDRw1zV2LczU6Mn1xxfY3K7c4rFaFud5vbOoJLbaV53h863pAiKxktADU
         hrt1ext9eD2TGdU12+Ynlfi3y5U15x8duzI8R0NoHOvfww3B8KJhixGy5q8AKCjevVIp
         bMEZAl3CbIzNJxQFT7JG1kmnsDBR/bSc/JGm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFajmLWzEheOspCEYhY0eo6ZhecGZeOzelViubfUiKU=;
        b=Y3OeMTuh//Uaw1IzJx5ENzekYiWrip+O5kn+RRmOwqPalmOnHbB5PC5EkzH17u9Hgk
         wwNnZIvQeQndQSHp3PmeFwBK1squdm8CS7vBbCcoCTi6MrYoFLJSJ2O+tks9Vm68hCrv
         GSYz1t0ZML4vSRyhkzvA+XzqKcK+fQvg6P1ermlGZSgzdoAbOdXBuX6jES0aJk4ubhFp
         CK3dmk/DH6hTd1lkwa4r8GzP59SUBnKD/wUqA3fRVRkdlXoGr/lNYki61TCA16I2420E
         ORK7SCbnPNMMikQuX1AeUigj5KRRS9kCyjG53ySr4KvawjhE+adhgKFoTJHbx+I7Sdou
         ZDrQ==
X-Gm-Message-State: ANoB5pnt1COkTeeQUMU8Itj59UFkgGXVOczFxsOgN2qgpaZOChDj6bgn
        3o862tos/zVmvn+0P2YjMonxvQ==
X-Google-Smtp-Source: AA0mqf5RSyeDowJvRrBf4iGaBhxxnFa7YM+HB+hTS4k6TzbwOhELOjd9m1isGHeLLyQPZk1DCB/BOQ==
X-Received: by 2002:a05:6a00:1d14:b0:578:1708:6416 with SMTP id a20-20020a056a001d1400b0057817086416mr113562pfx.11.1670601901687;
        Fri, 09 Dec 2022 08:05:01 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id a15-20020aa795af000000b00576670cc170sm1460504pfk.93.2022.12.09.08.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 08:05:01 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v7 2/6] selftests/memfd: add tests for F_SEAL_EXEC
Date:   Fri,  9 Dec 2022 16:04:49 +0000
Message-Id: <20221209160453.3246150-3-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221209160453.3246150-1-jeffxu@google.com>
References: <20221209160453.3246150-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Daniel Verkamp <dverkamp@chromium.org>

Basic tests to ensure that user/group/other execute bits cannot be
changed after applying F_SEAL_EXEC to a memfd.

Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
Co-developed-by: Jeff Xu <jeffxu@google.com>
Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 123 ++++++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 94df2692e6e4..f18a15a1f275 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -28,12 +28,38 @@
 #define MFD_DEF_SIZE 8192
 #define STACK_SIZE 65536
 
+#define F_SEAL_EXEC	0x0020
+
 /*
  * Default is not to test hugetlbfs
  */
 static size_t mfd_def_size = MFD_DEF_SIZE;
 static const char *memfd_str = MEMFD_STR;
 
+static ssize_t fd2name(int fd, char *buf, size_t bufsize)
+{
+	char buf1[PATH_MAX];
+	int size;
+	ssize_t nbytes;
+
+	size = snprintf(buf1, PATH_MAX, "/proc/self/fd/%d", fd);
+	if (size < 0) {
+		printf("snprintf(%d) failed on %m\n", fd);
+		abort();
+	}
+
+	/*
+	 * reserver one byte for string termination.
+	 */
+	nbytes = readlink(buf1, buf, bufsize-1);
+	if (nbytes == -1) {
+		printf("readlink(%s) failed %m\n", buf1);
+		abort();
+	}
+	buf[nbytes] = '\0';
+	return nbytes;
+}
+
 static int mfd_assert_new(const char *name, loff_t sz, unsigned int flags)
 {
 	int r, fd;
@@ -98,11 +124,14 @@ static unsigned int mfd_assert_get_seals(int fd)
 
 static void mfd_assert_has_seals(int fd, unsigned int seals)
 {
+	char buf[PATH_MAX];
+	int nbytes;
 	unsigned int s;
+	fd2name(fd, buf, PATH_MAX);
 
 	s = mfd_assert_get_seals(fd);
 	if (s != seals) {
-		printf("%u != %u = GET_SEALS(%d)\n", seals, s, fd);
+		printf("%u != %u = GET_SEALS(%s)\n", seals, s, buf);
 		abort();
 	}
 }
@@ -594,6 +623,64 @@ static void mfd_fail_grow_write(int fd)
 	}
 }
 
+static void mfd_assert_mode(int fd, int mode)
+{
+	struct stat st;
+	char buf[PATH_MAX];
+	int nbytes;
+
+	fd2name(fd, buf, PATH_MAX);
+
+	if (fstat(fd, &st) < 0) {
+		printf("fstat(%s) failed: %m\n", buf);
+		abort();
+	}
+
+	if ((st.st_mode & 07777) != mode) {
+		printf("fstat(%s) wrong file mode 0%04o, but expected 0%04o\n",
+		       buf, (int)st.st_mode & 07777, mode);
+		abort();
+	}
+}
+
+static void mfd_assert_chmod(int fd, int mode)
+{
+	char buf[PATH_MAX];
+	int nbytes;
+
+	fd2name(fd, buf, PATH_MAX);
+
+	if (fchmod(fd, mode) < 0) {
+		printf("fchmod(%s, 0%04o) failed: %m\n", buf, mode);
+		abort();
+	}
+
+	mfd_assert_mode(fd, mode);
+}
+
+static void mfd_fail_chmod(int fd, int mode)
+{
+	struct stat st;
+	char buf[PATH_MAX];
+	int nbytes;
+
+	fd2name(fd, buf, PATH_MAX);
+
+	if (fstat(fd, &st) < 0) {
+		printf("fstat(%s) failed: %m\n", buf);
+		abort();
+	}
+
+	if (fchmod(fd, mode) == 0) {
+		printf("fchmod(%s, 0%04o) didn't fail as expected\n",
+		       buf, mode);
+		abort();
+	}
+
+	/* verify that file mode bits did not change */
+	mfd_assert_mode(fd, st.st_mode & 07777);
+}
+
 static int idle_thread_fn(void *arg)
 {
 	sigset_t set;
@@ -880,6 +967,39 @@ static void test_seal_resize(void)
 	close(fd);
 }
 
+/*
+ * Test SEAL_EXEC
+ * Test that chmod() cannot change x bits after sealing
+ */
+static void test_seal_exec(void)
+{
+	int fd;
+
+	printf("%s SEAL-EXEC\n", memfd_str);
+
+	fd = mfd_assert_new("kern_memfd_seal_exec",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	mfd_assert_mode(fd, 0777);
+
+	mfd_assert_chmod(fd, 0644);
+
+	mfd_assert_has_seals(fd, 0);
+	mfd_assert_add_seals(fd, F_SEAL_EXEC);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+
+	mfd_assert_chmod(fd, 0600);
+	mfd_fail_chmod(fd, 0777);
+	mfd_fail_chmod(fd, 0670);
+	mfd_fail_chmod(fd, 0605);
+	mfd_fail_chmod(fd, 0700);
+	mfd_fail_chmod(fd, 0100);
+	mfd_assert_chmod(fd, 0666);
+
+	close(fd);
+}
+
 /*
  * Test sharing via dup()
  * Test that seals are shared between dupped FDs and they're all equal.
@@ -1059,6 +1179,7 @@ int main(int argc, char **argv)
 	test_seal_shrink();
 	test_seal_grow();
 	test_seal_resize();
+	test_seal_exec();
 
 	test_share_dup("SHARE-DUP", "");
 	test_share_mmap("SHARE-MMAP", "");
-- 
2.39.0.rc1.256.g54fd8350bd-goog

