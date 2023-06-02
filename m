Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523DBC7EE29
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Jun 2023 15:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbjFBPCD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 2 Jun 2023 11:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbjFBPBZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 2 Jun 2023 11:01:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD25110D0
        for <linux-security-module@vger.kernel.org>; Fri,  2 Jun 2023 08:01:18 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352BuSHF020100
        for <linux-security-module@vger.kernel.org>; Fri, 2 Jun 2023 08:01:18 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qxcvfnpj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Fri, 02 Jun 2023 08:01:01 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 08:00:24 -0700
Received: from twshared40933.03.prn6.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 08:00:23 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 3A31B31E04817; Fri,  2 Jun 2023 08:00:18 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>
Subject: [PATCH RESEND bpf-next 03/18] selftests/bpf: add BPF_TOKEN_CREATE test
Date:   Fri, 2 Jun 2023 07:59:56 -0700
Message-ID: <20230602150011.1657856-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602150011.1657856-1-andrii@kernel.org>
References: <20230602150011.1657856-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vO8Ey1xfI7qu2HOW2xEuEVlXmd9PzOGX
X-Proofpoint-GUID: vO8Ey1xfI7qu2HOW2xEuEVlXmd9PzOGX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_11,2023-06-02_02,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add a subtest validating BPF_TOKEN_CREATE command, pinning/getting BPF
token in/from BPF FS, and creating derived BPF tokens using token_fd
parameter.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
new file mode 100644
index 000000000000..fe78b558d697
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include "linux/bpf.h"
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "cap_helpers.h"
+
+static int drop_priv_caps(__u64 *old_caps)
+{
+	return cap_disable_effective((1ULL << CAP_BPF) |
+				     (1ULL << CAP_PERFMON) |
+				     (1ULL << CAP_NET_ADMIN) |
+				     (1ULL << CAP_SYS_ADMIN), old_caps);
+}
+
+static int restore_priv_caps(__u64 old_caps)
+{
+	return cap_enable_effective(old_caps, NULL);
+}
+
+#define TOKEN_PATH "/sys/fs/bpf/test_token"
+
+static void subtest_token_create(void)
+{
+	LIBBPF_OPTS(bpf_token_create_opts, opts);
+	int token_fd = 0, limited_token_fd = 0, tmp_fd = 0, err;
+	__u64 old_caps = 0;
+
+	/* create BPF token which allows creating derived BPF tokens */
+	opts.allowed_cmds = 1ULL << BPF_TOKEN_CREATE;
+	token_fd = bpf_token_create(&opts);
+	if (!ASSERT_GT(token_fd, 0, "token_create"))
+		return;
+
+	/* check that IGNORE_UNKNOWN_CMDS flag is respected */
+	opts.flags = BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS;
+	opts.allowed_cmds = ~0ULL; /* any current and future cmd is allowed */
+	tmp_fd = bpf_token_create(&opts);
+	if (!ASSERT_GT(token_fd, 0, "token_create_future_proof"))
+		return;
+	close(tmp_fd);
+	tmp_fd = 0;
+
+	/* validate pinning and getting works as expected */
+	err = bpf_obj_pin(token_fd, TOKEN_PATH);
+	if (!ASSERT_OK(err, "token_pin"))
+		goto cleanup;
+
+	tmp_fd = bpf_obj_get(TOKEN_PATH);
+	ASSERT_GT(tmp_fd, 0, "token_get");
+	close(tmp_fd);
+	tmp_fd = 0;
+	unlink(TOKEN_PATH);
+
+	/* drop privileges to test token_fd passing */
+	if (!ASSERT_OK(drop_priv_caps(&old_caps), "drop_caps"))
+		goto cleanup;
+
+	/* unprivileged BPF_TOKEN_CREATE should fail */
+	tmp_fd = bpf_token_create(NULL);
+	if (!ASSERT_LT(tmp_fd, 0, "token_create_unpriv_fail"))
+		goto cleanup;
+
+	/* unprivileged BPF_TOKEN_CREATE with associated BPF token succeeds */
+	opts.flags = 0;
+	opts.allowed_cmds = 0; /* ask for BPF token which doesn't allow new tokens */
+	opts.token_fd = token_fd;
+	limited_token_fd = bpf_token_create(&opts);
+	if (!ASSERT_GT(limited_token_fd, 0, "token_create_limited"))
+		goto cleanup;
+
+	/* creating yet another token using "limited" BPF token should fail */
+	opts.flags = 0;
+	opts.allowed_cmds = 0;
+	opts.token_fd = limited_token_fd;
+	tmp_fd = bpf_token_create(&opts);
+	if (!ASSERT_LT(tmp_fd, 0, "token_create_from_lim_fail"))
+		goto cleanup;
+
+cleanup:
+	if (tmp_fd)
+		close(tmp_fd);
+	if (token_fd)
+		close(token_fd);
+	if (limited_token_fd)
+		close(limited_token_fd);
+	if (old_caps)
+		ASSERT_OK(restore_priv_caps(old_caps), "restore_caps");
+}
+
+void test_token(void)
+{
+	if (test__start_subtest("token_create"))
+		subtest_token_create();
+}
-- 
2.34.1

