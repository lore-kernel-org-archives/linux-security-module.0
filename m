Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A340C4708D
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Dec 2022 00:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiLOAOV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 14 Dec 2022 19:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiLOANm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Dec 2022 19:13:42 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423CE46659
        for <linux-security-module@vger.kernel.org>; Wed, 14 Dec 2022 16:12:16 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a9so5126608pld.7
        for <linux-security-module@vger.kernel.org>; Wed, 14 Dec 2022 16:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfROb3ZkcZ7Ac7CKaQoVSCHLc1zwDwCheELrvNAzva4=;
        b=EEBsbANJ5rVxA3zNQWjC0OwYANmCqoR2KQqQ6RbXOFYUIhlWxdJeMRwj9ifXy3gRpA
         bV3fXAoCNZ0OVZV99aDQcbltEdQYi4nYBWh5mT8wpvJr5QdHxBaF4+Od8j4v1tCYrKBB
         xIK3hSfSZ7PNnJc9ZYeZQ6xIHca1IYtzMhWgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfROb3ZkcZ7Ac7CKaQoVSCHLc1zwDwCheELrvNAzva4=;
        b=i+gHTsFnZFuakCwvqO6FS31r2IEmWcrAFcc+XTnei9zbTp0fQhmj1XrsUUDkwFfnp1
         oU1F+KfaKZGeZObwQ+Rne7G5JhJ28K1B3tkwvzsbkCZZh1FbczBzkt3cexlUuofnuo8Y
         G0Sjh8a8KwZqLNIEDlJAa6rtwKennM6PG/nhk8LWXfy9dYtRBiL+fj4p1uCsdWZ2gXOh
         jbMDLNjIvZNtgFopYQXsVwdLhX4JYkv5dbUM+uTrHPzg/WKw4U4JHXlCDJe5QPrxD5EH
         WmyDdpp6QPAUUPuucwl3IMN/1PbSOLSEshfdKMvIBVii898X8FRvz/PQx/3iWCRkmz51
         IaCg==
X-Gm-Message-State: ANoB5pkUS6DpBo7RCuu1ngibR7jCw+/7WXn4UuiSREZdG4dkamugSDjn
        LgRbgoIAIYho6fOyLrIQLOPYGA==
X-Google-Smtp-Source: AA0mqf5FkGT3aKj+Iri+fkdEapJVxPOjm37Mu3bRXj+pTnXCNATSsFbSxU7zW7UjlccSkGKowjUlRg==
X-Received: by 2002:a17:90a:9704:b0:21d:4b50:23b1 with SMTP id x4-20020a17090a970400b0021d4b5023b1mr29685502pjo.5.1671063135792;
        Wed, 14 Dec 2022 16:12:15 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a08c300b0021937b2118bsm1845738pjn.54.2022.12.14.16.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 16:12:15 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v8 2/5] selftests/memfd: add tests for F_SEAL_EXEC
Date:   Thu, 15 Dec 2022 00:12:02 +0000
Message-Id: <20221215001205.51969-3-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221215001205.51969-1-jeffxu@google.com>
References: <20221215001205.51969-1-jeffxu@google.com>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
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

