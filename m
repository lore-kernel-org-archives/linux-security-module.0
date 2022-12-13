Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC430C4332F
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Dec 2022 18:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbiLMS6e (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Dec 2022 13:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbiLMS6a (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Dec 2022 13:58:30 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07941BE9F
        for <linux-security-module@vger.kernel.org>; Tue, 13 Dec 2022 10:58:29 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u5so4363469pjy.5
        for <linux-security-module@vger.kernel.org>; Tue, 13 Dec 2022 10:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itSG+43z7AFx0VjpjH0sxVT9twkdoWutNAwIl7d0x3g=;
        b=HkwtdVPtX6noy8k/4RF2qsNDbp3xyK2b6NiQkTq5FWdr2pkp2jFYFQBpbZ/4ol4MBk
         1xZtq5nTrvW77FDRbbmg2Fd2Zlhy283rR60hxrjZklc8lkw6AfsYw0KmuM3BD8tmxqQE
         /B5QaVgeEIaIialoa0h04fsE+lravmO+tA0RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itSG+43z7AFx0VjpjH0sxVT9twkdoWutNAwIl7d0x3g=;
        b=jrg5AP1Hbp9wnw/BghvzzQnlAqyp9YOF2Js5xqqMr3A5qdjZIIyZir93C5LeLS926q
         S3bZE0HJkyK//22YFPHvDE0femL9WlaHipS7qogTGm/dpKOaVV0gZoys2eKQuxQ2C5U1
         Iq3sYSGZndcTleL/7ZaWSpIk/m9bgLqTbBs/nswbrnifbdb1GWf6Oy3W45706s6CBUMH
         yrHRWeK9ib2/hxifswkDKq2ZAsafbbPMBYtHK9uz9/agwx9T8ZnjqYRcUj1Tm3CgU7UJ
         pzJs/wuhhNu0nyjYS3NsMSVXJK9a7z2Fp5u4MZHyKKws1DzyX0qv3xVQDYg3FJQA5Q9J
         GU1g==
X-Gm-Message-State: ANoB5pk2V5HbKwnbTOpyPxVDnXRjYXQb0RbnxAEifikZAUdLmH91FBiI
        1+VFiBkEZWQTWkgGFAtlIIml0ZJQdwN3LKlL
X-Google-Smtp-Source: AA0mqf6K19jUVES5RjZZCL1EQI5JucMyW8xc9ifDU5EtaX4g1JWELzI655Vn9p9cp6m+eFxY1G15uQ==
X-Received: by 2002:a17:902:e743:b0:185:4880:91bc with SMTP id p3-20020a170902e74300b00185488091bcmr28006886plf.60.1670957909246;
        Tue, 13 Dec 2022 10:58:29 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001869ba04c83sm199970plf.245.2022.12.13.10.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 10:58:28 -0800 (PST)
From:   jeffxu@chromium.org
To:     mic@digikod.net
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        Jeff Xu <jeffxu@google.com>
Subject: [PATCH v2 1/1] selftests/landlock: skip ptrace_test according to YAMA
Date:   Tue, 13 Dec 2022 18:58:16 +0000
Message-Id: <20221213185816.3942853-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221213185816.3942853-1-jeffxu@chromium.org>
References: <20221213185816.3942853-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

Add check for yama setting for ptrace_test.

Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 .../testing/selftests/landlock/ptrace_test.c  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index c28ef98ff3ac..8565a25a9587 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -60,6 +60,24 @@ static int test_ptrace_read(const pid_t pid)
 	return 0;
 }
 
+static int get_ptrace_scope(void)
+{
+	int ret = -1;
+	char buf[2];
+	int fd = open("/proc/sys/kernel/yama/ptrace_scope", O_RDONLY);
+
+	if (fd < 0)
+		return 0;
+
+	if (read(fd, &buf, 1) < 0)
+		return -1;
+
+	buf[1] = '\0';
+	ret = atoi(buf);
+	close(fd);
+	return ret;
+}
+
 /* clang-format off */
 FIXTURE(hierarchy) {};
 /* clang-format on */
@@ -69,6 +87,7 @@ FIXTURE_VARIANT(hierarchy)
 	const bool domain_both;
 	const bool domain_parent;
 	const bool domain_child;
+	const int  yama_value;
 };
 
 /*
@@ -93,6 +112,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_without_domain) {
 	.domain_both = false,
 	.domain_parent = false,
 	.domain_child = false,
+	.yama_value = 0,
 };
 
 /*
@@ -110,6 +130,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_with_one_domain) {
 	.domain_both = false,
 	.domain_parent = false,
 	.domain_child = true,
+	.yama_value = 1,
 };
 
 /*
@@ -126,6 +147,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_parent_domain) {
 	.domain_both = false,
 	.domain_parent = true,
 	.domain_child = false,
+	.yama_value = 0,
 };
 
 /*
@@ -143,6 +165,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_sibling_domain) {
 	.domain_both = false,
 	.domain_parent = true,
 	.domain_child = true,
+	.yama_value = 2,
 };
 
 /*
@@ -160,6 +183,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_sibling_domain) {
 	.domain_both = true,
 	.domain_parent = false,
 	.domain_child = false,
+	.yama_value = 0,
 };
 
 /*
@@ -178,6 +202,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_with_nested_domain) {
 	.domain_both = true,
 	.domain_parent = false,
 	.domain_child = true,
+	.yama_value = 1,
 };
 
 /*
@@ -196,6 +221,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_nested_and_parent_domain) {
 	.domain_both = true,
 	.domain_parent = true,
 	.domain_child = false,
+	.yama_value = 0,
 };
 
 /*
@@ -216,6 +242,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_forked_domain) {
 	.domain_both = true,
 	.domain_parent = true,
 	.domain_child = true,
+	.yama_value = 2,
 };
 
 FIXTURE_SETUP(hierarchy)
@@ -232,9 +259,16 @@ TEST_F(hierarchy, trace)
 	pid_t child, parent;
 	int status, err_proc_read;
 	int pipe_child[2], pipe_parent[2];
+	int yama;
 	char buf_parent;
 	long ret;
 
+	yama = get_ptrace_scope();
+	ASSERT_LE(0, yama);
+
+	if (variant->yama_value < yama)
+		SKIP(return, "unsupported yama value %d", yama);
+
 	/*
 	 * Removes all effective and permitted capabilities to not interfere
 	 * with cap_ptrace_access_check() in case of PTRACE_MODE_FSCREDS.
-- 
2.39.0.rc1.256.g54fd8350bd-goog

