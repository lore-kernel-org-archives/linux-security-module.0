Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE67C7EE23
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Jun 2023 23:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjFGXyP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjFGXyN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Jun 2023 19:54:13 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30767212E
        for <linux-security-module@vger.kernel.org>; Wed,  7 Jun 2023 16:54:11 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 357H1Rxd017034
        for <linux-security-module@vger.kernel.org>; Wed, 7 Jun 2023 16:54:10 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3r2aabk0kw-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 07 Jun 2023 16:54:10 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 16:54:04 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 986BB32857D3E; Wed,  7 Jun 2023 16:53:59 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 03/18] selftests/bpf: add BPF_TOKEN_CREATE test
Date:   Wed, 7 Jun 2023 16:53:37 -0700
Message-ID: <20230607235352.1723243-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607235352.1723243-1-andrii@kernel.org>
References: <20230607235352.1723243-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 41U6S9J3LJC6AK9Fkv-IiNRBB2PT14vc
X-Proofpoint-GUID: 41U6S9J3LJC6AK9Fkv-IiNRBB2PT14vc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add a subtest validating BPF_TOKEN_CREATE command, pinning/getting BPF
token in/from BPF FS, and creating derived BPF tokens using token_fd
parameter.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
new file mode 100644
index 000000000000..cba84c480ac5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -0,0 +1,93 @@
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
+	/* check that any current and future cmd can be specified */
+	opts.allowed_cmds = ~0ULL;
+	token_fd = bpf_token_create(&opts);
+	if (!ASSERT_GT(token_fd, 0, "token_create_future_proof"))
+		return;
+	close(token_fd);
+
+	/* create BPF token which allows creating derived BPF tokens */
+	opts.allowed_cmds = 1ULL << BPF_TOKEN_CREATE;
+	token_fd = bpf_token_create(&opts);
+	if (!ASSERT_GT(token_fd, 0, "token_create"))
+		return;
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

